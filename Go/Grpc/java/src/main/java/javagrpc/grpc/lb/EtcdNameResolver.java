package javagrpc.grpc.lb;

import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.net.URI;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import org.apache.commons.configuration2.Configuration;
import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import io.etcd.jetcd.ByteSequence;
import io.etcd.jetcd.Client;
import io.etcd.jetcd.KeyValue;
import io.etcd.jetcd.Watch;
import io.etcd.jetcd.kv.GetResponse;
import io.etcd.jetcd.options.GetOption;
import io.etcd.jetcd.options.WatchOption;
import io.grpc.EquivalentAddressGroup;
import io.grpc.NameResolver;
import io.grpc.Status;
import javagrpc.common.Const;
import javagrpc.util.Config;

/*
 * 基于Etcd的服务发现
 */
public class EtcdNameResolver extends NameResolver {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();
	// 储存发现的服务节点
	// Key: /service/grpc/uuid_a, Value: http://localhost:50052
	private final Map<String, URI> serviceUriMap;
	// 用于接收更新
	private Listener2 listener;
	// Etcd客户端
	private final Client etcd;
	// Key前缀（例：/service/grpc/ProductInfo）
	private final String prefixKey;

	public EtcdNameResolver(URI targetUri) {
		log.info("[Java][Client] Etcd服务发现 开始");
		// 服务发现的URI，比如：etcd:///service/grpc
		URI uri = targetUri;
		// String scheme = uri.getScheme(); // etcd
		// String authority = uri.getAuthority(); // null
		// String path = uri.getPath(); // /service/grpc
		// 服务发现的Endpoint，并且还是Etcd的Key前缀
		prefixKey = uri.getPath();

		// 储存发现的服务节点
		serviceUriMap = new ConcurrentHashMap<>();

		// 建立Etcd连接
		// 读取config.properties内容(会在classpath内寻找)
		String etcdEndpoints = "";
		try {
			// 读取 properties 和 环境变量
			Configuration config = Config.getInstance();
			etcdEndpoints = config.getString("etcd.endpoints.uri", "");
		} catch (ConfigurationException e) {
			log.error(e);
		}
		log.info("[Java][Client] 连接 Etcd Endpoints: {}", etcdEndpoints);

		this.etcd = Client.builder()
				.endpoints(etcdEndpoints)
				.build();

		// 监听Etcd
		Watch watch = etcd.getWatchClient();
		// 监听前缀
		WatchOption watchOption = WatchOption.builder().isPrefix(true).build();
		watch.watch(ByteSequence.from(prefixKey, Const.UTF_8), watchOption, watchResponse -> {
			watchResponse.getEvents().forEach(event -> {
				switch (event.getEventType()) {
					case DELETE:
						// 当KEY被删除触发
						String delKey = event.getKeyValue().getKey().toString();
						String delAddr = event.getKeyValue().getValue().toString();
						try {
							serviceUriMap.remove(delKey);
							log.info("服务节点下线:  Key={}  URI={}", delKey, delAddr);
						} catch (Exception e) {
							log.error("没有删除服务节点.  prefix={}  addr={}", prefixKey, delAddr);
							log.error(e);
						}
						break;
					case PUT:
						// 当key被创建或修改
						String addKey = event.getKeyValue().getKey().toString();
						String addAddr = event.getKeyValue().getValue().toString();
						try {
							URI addUri = URI.create(addAddr);
							serviceUriMap.put(addKey, addUri);
							log.info("服务节点上线:  Key={}  URI={}", addKey, addAddr);
						} catch (Exception e) {
							log.error("无法将转换服务地址.  prefix={}  addr={}", prefixKey, addAddr);
							log.error(e);
						}
						break;
					default:
						break;
				}
				// 更新Listener
				updateListener();
			});
		});
		log.info("[Java][Client] Etcd 监听 Key:{} 开始", prefixKey);
		log.info("[Java][Client] Etcd服务发现 结束");
	}

	@Override
	public String getServiceAuthority() {
		return "";
	}

	@Override
	public void shutdown() {
		etcd.close();
	}

	@Override
	public void start(Listener2 listener) {
		this.listener = listener;
		this.resolve();
	}

	@Override
	public void refresh() {
		log.info("[Java][Client] Etcd服务发现 refresh");
		this.resolve();
	}

	// 服务发现主逻辑
	private void resolve() {

		// 使用前缀查询当前Etcd可用的服务节点
		GetOption prefixOption = GetOption.builder().isPrefix(true).build();
		GetResponse getResponse;
		try {
			// 取得
			getResponse = etcd.getKVClient().get(ByteSequence.from(prefixKey, Const.UTF_8), prefixOption).get();
		} catch (Exception e) {
			log.error(e);
			throw new RuntimeException("无法连接Etcd服务器", e);
		}
		// 循环取得的服务Endpoints，设定到发现的服务列表
		for (KeyValue kv : getResponse.getKvs()) {
			log.info("取得Key成功.  key={}  value={}", kv.getKey().toString(), kv.getValue().toString());
			String addr = kv.getValue().toString();
			try {
				URI uri = URI.create(addr);
				// 将键值对储存
				serviceUriMap.put(kv.getKey().toString(), uri);
			} catch (Exception e) {
				log.error("无法将转换服务地址.  prefix={}  addr={}", prefixKey, addr);
				log.error(e);
			}
		}
		// 更新Listener
		updateListener();
	}

	// 监听到内容发现变化时
	// 更新Listener以更新
	private void updateListener() {
		log.info("更新服务Endpoints列表");
		try {
			List<EquivalentAddressGroup> equivalentAddressGroup = new CopyOnWriteArrayList<EquivalentAddressGroup>();
			for (Map.Entry<String, URI> entry : serviceUriMap.entrySet()) {
				String updateKey = entry.getKey();
				URI updateValue = entry.getValue();
				log.info("服务节点在线:  Key={}  URI={}", updateKey, updateValue);
				List<SocketAddress> addrList = new java.util.concurrent.CopyOnWriteArrayList<>();
				addrList.add(new InetSocketAddress(updateValue.getHost(), updateValue.getPort()));
				equivalentAddressGroup.add(new EquivalentAddressGroup(addrList));
			}
			if (equivalentAddressGroup.isEmpty()) {
				log.error("没有服务节点在线 prefix={}", prefixKey);
			} else {
				ResolutionResult resolutionResult = ResolutionResult.newBuilder()
						.setAddresses(equivalentAddressGroup)
						.build();
				// 将实例列表传递给 LoadBalancer，完成服务解析
				this.listener.onResult(resolutionResult);
			}
		} catch (Exception e) {
			this.listener.onError(Status.UNAVAILABLE.withDescription("无法解析主机").withCause(e));
			log.error(e);
		}
	}
}
