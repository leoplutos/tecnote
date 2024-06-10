package javagrpc;

import java.net.URI;

import io.grpc.NameResolver;
import io.grpc.NameResolverProvider;

/*
 * NameResolverProvider 主要用于注册 NameResolver，可以设置默认的协议，是否可用，优先级等
 */
public class MultiAddressNameResolverProvider extends NameResolverProvider {

    public static final String MultiAddressScheme = "example";
    public static final String MultiAddressServiceName = "lb.example.grpc.io";
    static public final int startPort = 50051;
    static public final int serverCount = 4;

    @Override
    public NameResolver newNameResolver(URI targetUri, NameResolver.Args args) {
        return new MultiAddressNameResolver(targetUri);
    }

    @Override
    protected boolean isAvailable() {
        return true;
    }

    @Override
    protected int priority() {
        return 5;
    }

    @Override
    // gRPC choose the first NameResolverProvider that supports the target URI
    // scheme.
    public String getDefaultScheme() {
        return MultiAddressScheme;
    }
}