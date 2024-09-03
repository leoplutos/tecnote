package javagrpc.grpc.lb;

import io.grpc.NameResolver;
import io.grpc.NameResolverProvider;
import javagrpc.common.Const;

import java.net.URI;

public class EtcdNameResolverProvider extends NameResolverProvider {

	@Override
	public NameResolver newNameResolver(URI targetUri, NameResolver.Args args) {
		return new EtcdNameResolver(targetUri);
	}

	@Override
	protected boolean isAvailable() {
		return true;
	}

	@Override
	protected int priority() {
		// gRPC 默认的 DnsNameResolver 优先级是5，所以自定义的优先级要大于5
		return 1;
	}

	@Override
	// 设置默认的协议
	public String getDefaultScheme() {
		return Const.ETCD_SCHEME;
	}
}
