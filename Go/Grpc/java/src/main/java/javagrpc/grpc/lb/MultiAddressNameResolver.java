package javagrpc.grpc.lb;

import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.net.URI;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.google.common.collect.ImmutableMap;

import io.grpc.EquivalentAddressGroup;
import io.grpc.NameResolver;
import io.grpc.Status;

/*
 * NameResolver 里面重写了 start 和 refresh 方法，这两个方法都调用一个 resolve 方法做服务发现
 * resovle 方法内部通过服务名从注册中心拉取服务实例列表，然后调用 Listener 的 onResult方法，将实例列表传递给 LoadBalancer，
 * 完成服务解析在服务运行期间，因为实例可能会发生变化，所以可以通过定时执行触发服务解析；如果注册中心支持，也可以通过回调触发
 */
public class MultiAddressNameResolver extends NameResolver {

	private final URI uri;
	private final Map<String, List<InetSocketAddress>> addrStore;
	private Listener2 listener;

	public MultiAddressNameResolver(URI targetUri) {
		// 注册服务到127.0.0.1
		// 端口从 50051 开始，有 4 台
		this.uri = targetUri;
		addrStore = ImmutableMap.<String, List<InetSocketAddress>>builder()
				.put(MultiAddressNameResolverProvider.MultiAddressServiceName,
						Stream.iterate(MultiAddressNameResolverProvider.startPort, p -> p + 1)
								.limit(MultiAddressNameResolverProvider.serverCount)
								.map(port -> new InetSocketAddress("127.0.0.1", port))
								.collect(Collectors.toList()))
				.build();
	}

	@Override
	public String getServiceAuthority() {
		// Be consistent with behavior in grpc-go, authority is saved in Host field of
		// URI.
		if (uri.getHost() != null) {
			return uri.getHost();
		}
		return "no host";
	}

	@Override
	public void shutdown() {
	}

	@Override
	public void start(Listener2 listener) {
		this.listener = listener;
		this.resolve();
	}

	@Override
	public void refresh() {
		this.resolve();
	}

	private void resolve() {
		List<InetSocketAddress> addresses = addrStore.get(uri.getPath().substring(1));
		try {
			List<EquivalentAddressGroup> equivalentAddressGroup = addresses.stream()
					// convert to socket address
					.map(this::toSocketAddress)
					// every socket address is a single EquivalentAddressGroup, so they can be
					// accessed randomly
					.map(Arrays::asList)
					.map(this::addrToEquivalentAddressGroup)
					.collect(Collectors.toList());

			ResolutionResult resolutionResult = ResolutionResult.newBuilder()
					.setAddresses(equivalentAddressGroup)
					.build();

			this.listener.onResult(resolutionResult);

		} catch (Exception e) {
			// when error occurs, notify listener
			this.listener.onError(Status.UNAVAILABLE.withDescription("Unable to resolve host ").withCause(e));
		}
	}

	private SocketAddress toSocketAddress(InetSocketAddress address) {
		return new InetSocketAddress(address.getHostName(), address.getPort());
	}

	private EquivalentAddressGroup addrToEquivalentAddressGroup(List<SocketAddress> addrList) {
		return new EquivalentAddressGroup(addrList);
	}

}
