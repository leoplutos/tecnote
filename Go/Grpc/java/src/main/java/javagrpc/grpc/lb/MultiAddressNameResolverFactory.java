package javagrpc.grpc.lb;

import java.net.SocketAddress;
import java.net.URI;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import io.grpc.Attributes;
import io.grpc.EquivalentAddressGroup;
import io.grpc.NameResolver;

/* 名称解析程序
   在开始与服务器交互之前，客户端需要使用名称解析器获取其所有 IP 地址
   默认情况下，gRPC 使用 DNS 作为其名称系统，即 DNS 条目的每个 A 记录都将用作可能的端点。
   但是，如果我们想使用服务注册表，例如 Eureka 或 Consul，或者自己指定多个地址，我们将需要实现自定义名称解析器。
   在此示例中，我们创建一个简单的名称解析器，该解析器将接受多个地址作为参数
*/
public class MultiAddressNameResolverFactory extends NameResolver.Factory {

	final List<EquivalentAddressGroup> addresses;

	MultiAddressNameResolverFactory(SocketAddress... addresses) {
		this.addresses = Arrays.stream(addresses)
				.map(EquivalentAddressGroup::new)
				.collect(Collectors.toList());
	}

	public NameResolver newNameResolver(URI notUsedUri, NameResolver.Args args) {
		return new NameResolver() {
			@Override
			public String getServiceAuthority() {
				return "fakeAuthority";
			}

			public void start(Listener2 listener) {
				listener.onResult(
						ResolutionResult.newBuilder().setAddresses(addresses).setAttributes(Attributes.EMPTY).build());
			}

			public void shutdown() {
			}
		};
	}

	@Override
	public String getDefaultScheme() {
		return "multiaddress";
	}
}
