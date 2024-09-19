package my.mavenbatsample;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import io.etcd.jetcd.ByteSequence;
import io.etcd.jetcd.Client;
import io.etcd.jetcd.KV;
import io.etcd.jetcd.KeyValue;
import io.etcd.jetcd.Lease;
import io.etcd.jetcd.Watch;
import io.etcd.jetcd.kv.GetResponse;
import io.etcd.jetcd.lease.LeaseKeepAliveResponse;
import io.etcd.jetcd.lock.LockResponse;
import io.etcd.jetcd.options.GetOption;
import io.etcd.jetcd.options.PutOption;
import io.grpc.stub.StreamObserver;

public class EtcdClientExample {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	public final Charset UTF_8 = StandardCharsets.UTF_8;
	private final String prefix = "/JavaKey";
	private boolean hasError = false;

	static {
		// 设定vertx的默认日志
		// System.setProperty("vertx.logger-delegate-factory-class-name",
		// "io.vertx.core.logging.Log4j2LogDelegateFactory");
		// 禁用vertx缓存目录，不然在Maven运行结束时会报错
		// https://github.com/vert-x3/issues/issues/288
		System.setProperty("vertx.disableFileCPResolving", "true");
		System.setProperty("vertx.disableFileCaching", "true");
	}

	public void etcdClient() throws Exception {

		// 连接参数
		String endpoint = "http://localhost:2379";
		int timeoutSec = 1;
		int retry = 0;
		// 建立连接
		// Client client = Client.builder().endpoints("http://etcd0:2379",
		// "http://etcd1:2379", "http://etcd2:2379").build();
		Client client = Client.builder()
				.endpoints(endpoint)
				.retryMaxAttempts(retry)
				.connectTimeout(Duration.ofSeconds(timeoutSec))
				.build();

		// 初始化CountDownLatch，设置计数值为1
		// 它允许一个或多个线程等待其他线程完成一组操作，当计数器的值减至零时，所有因调用 await() 方法而阻塞的线程都会被释放，继续执行
		CountDownLatch countDownLatch = new CountDownLatch(1);
		client.getMaintenanceClient().statusMember(endpoint)
				.orTimeout(timeoutSec, TimeUnit.SECONDS)
				.exceptionally(ex -> {
					log.error("Etcd连接失败", ex);
					hasError = true;
					countDownLatch.countDown();
					return null;
				})
				.whenComplete((response, throwable) -> {
					if (throwable != null) {
						log.error("Etcd连接失败", throwable);
					} else {
						log.info("Etcd连接成功  Version:{}", response.getVersion());
					}
					countDownLatch.countDown();
				});
		countDownLatch.await();
		if (hasError) {
			return;
		}

		// 设定Key
		String key1 = prefix + "/Key1";
		String key2 = prefix + "/Key2";
		String setValue1 = "使用Java客户端添加_" + UUID.randomUUID().toString();
		String setValue2 = "使用Java客户端添加_" + UUID.randomUUID().toString();
		client.getKVClient().put(ByteSequence.from(key1, UTF_8), ByteSequence.from(setValue1, UTF_8)).get();
		log.info("添加Key成功    key={}    value={}", key1, setValue1);
		client.getKVClient().put(ByteSequence.from(key2, UTF_8), ByteSequence.from(setValue2, UTF_8)).get();
		log.info("添加Key成功    key={}    value={}", key2, setValue2);

		// 取得Key
		GetResponse getResponse = client.getKVClient().get(ByteSequence.from(key1, UTF_8)).get();
		for (KeyValue kv : getResponse.getKvs()) {
			log.info("取得Key成功    key={}    value={}", kv.getKey().toString(), kv.getValue().toString());
		}

		// 取得Key（前缀机制）
		// 前缀查询
		GetOption prefixOption = GetOption.builder().isPrefix(true).build();
		getResponse = client.getKVClient().get(ByteSequence.from(prefix, UTF_8), prefixOption).get();
		log.info("取得前缀成功    prefix={}", prefix);
		for (KeyValue kv : getResponse.getKvs()) {
			log.info("key={}    value={}", kv.getKey().toString(), kv.getValue().toString());
		}

		// 分布式锁
		String lockKey = prefix + "/lock";
		// 先创建租约
		long ttl = 5;
		long leaseId = client.getLeaseClient().grant(ttl).get().getID();
		// 持续保活
		client.getLeaseClient().keepAlive(leaseId, new StreamObserver<LeaseKeepAliveResponse>() {
			@Override
			public void onCompleted() {
				// log.info("cluster node lease completed");
			}

			@Override
			public void onError(Throwable throwable) {
				log.error("cluster node lease keep alive failed. exception info: {}", throwable);
			}

			@Override
			public void onNext(LeaseKeepAliveResponse response) {
				// log.info("cluster node lease remaining ttl: {}, lease id: {}",
				// response.getTTL(), response.getID());
			}
		});
		// 加锁
		LockResponse lockResponse = client.getLockClient().lock(ByteSequence.from(lockKey, UTF_8), leaseId).get();
		String lockResKey = lockResponse.getKey().toString();
		log.info("[加锁]分布式锁成功    lockKey={}    lockResKey={}", lockKey, lockResKey);
		log.info("5秒后解锁,此期间运行 [etcdctl lock /JavaKey/lock] 会一直等待");
		Thread.sleep(Duration.ofSeconds(5));
		// 解锁（参数为加锁的返回值）
		client.getLockClient().unlock(ByteSequence.from(lockResKey, UTF_8)).get();
		log.info("[解锁]分布式锁成功    lockResKey={}", lockResKey);

		// 调用租约函数
		this.leaseRegister(client, prefix);

		// 调用监听函数
		this.watchService(client, prefix);

		// 在此堵塞线程
		Thread.sleep(Duration.ofSeconds(5000));

		// 关闭连接
		client.close();
		log.info("已断开Etcd连接");
	}

	// 租约函数
	private void leaseRegister(Client client, String prefix) throws Exception {
		// 创建租约
		Lease lease = client.getLeaseClient();
		String leaseKey = this.prefix + "/LsKey1";
		String leaseValue = "此Key会自动被删除";
		long ttl = 5;
		long leaseId = lease.grant(ttl).get().getID();
		log.info("创建租约(Lease)成功    leaseId={}", leaseId);
		// 写入key-value值时绑定一个租约，租约到期后，key会被删除
		KV kv = client.getKVClient();
		PutOption option = PutOption.builder().withLeaseId(leaseId).build();
		kv.put(ByteSequence.from(leaseKey, UTF_8), ByteSequence.from(leaseValue, UTF_8), option).get();
		log.info("添加租约Key成功    key={}    value={}    leaseId={}", leaseKey, leaseValue, leaseId);

		// 为租约续约一次
		// lease.keepAliveOnce(leaseId);

		// 持续续约，在租约的三分之一时间时，就会自动向etcd续约。相当于租约到期前会执行三次keepAliveOnce()
		// lease.keepAlive(leaseId, new
		// StreamObserver<LeaseKeepAliveResponse>() {
		// @Override
		// public void onCompleted() {
		// // log.info("cluster node lease completed");
		// }

		// @Override
		// public void onError(Throwable throwable) {
		// log.error("cluster node lease keep alive failed. exception info: {}",
		// throwable);
		// }

		// @Override
		// public void onNext(LeaseKeepAliveResponse response) {
		// // log.info("cluster node lease remaining ttl: {}, lease id: {}",
		// // response.getTTL(), response.getID());
		// }
		// });

		// 主动撤销租约
		// lease.revoke(leaseId);
	}

	// 监听函数
	private void watchService(Client client, String prefix) throws Exception {
		Watch watch = client.getWatchClient();
		String watchKey = prefix + "/LsKey1";
		watch.watch(ByteSequence.from(watchKey, UTF_8), watchResponse -> {
			watchResponse.getEvents().forEach(event -> {
				switch (event.getEventType()) {
					case DELETE:
						log.info("租约  key={} 到期，续租", event.getKeyValue().getKey().toString());
						// 使用runAsync方法异步执行无返回值的任务
						CompletableFuture.runAsync(() -> {
							try {
								this.leaseRegister(client, prefix);
							} catch (Exception e) {
								log.error(e);
							}
						});
						// 当KEY被删除触发
						break;
					case PUT:
						// 当key被创建或修改
						break;
					default:
						break;
				}
			});
		});
	}

	public static void main(String[] args) {
		try {
			EtcdClientExample example = new EtcdClientExample();
			example.etcdClient();
		} catch (Exception e) {
			log.error(e);
		} finally {
			// 因为使用了异步日志，要在这里关闭
			LogManager.shutdown();
		}
	}
}
