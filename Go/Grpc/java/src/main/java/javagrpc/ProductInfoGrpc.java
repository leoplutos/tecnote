package javagrpc;

import static io.grpc.MethodDescriptor.generateFullMethodName;

/**
 */
@javax.annotation.Generated(
    value = "by gRPC proto compiler (version 1.64.0)",
    comments = "Source: ProductInfo.proto")
@io.grpc.stub.annotations.GrpcGenerated
public final class ProductInfoGrpc {

  private ProductInfoGrpc() {}

  public static final java.lang.String SERVICE_NAME = "grpc_demo.ProductInfo";

  // Static method descriptors that strictly reflect the proto.
  private static volatile io.grpc.MethodDescriptor<javagrpc.ProductInfoPb.Product,
      javagrpc.ProductInfoPb.ProductId> getAddProductMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "addProduct",
      requestType = javagrpc.ProductInfoPb.Product.class,
      responseType = javagrpc.ProductInfoPb.ProductId.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<javagrpc.ProductInfoPb.Product,
      javagrpc.ProductInfoPb.ProductId> getAddProductMethod() {
    io.grpc.MethodDescriptor<javagrpc.ProductInfoPb.Product, javagrpc.ProductInfoPb.ProductId> getAddProductMethod;
    if ((getAddProductMethod = ProductInfoGrpc.getAddProductMethod) == null) {
      synchronized (ProductInfoGrpc.class) {
        if ((getAddProductMethod = ProductInfoGrpc.getAddProductMethod) == null) {
          ProductInfoGrpc.getAddProductMethod = getAddProductMethod =
              io.grpc.MethodDescriptor.<javagrpc.ProductInfoPb.Product, javagrpc.ProductInfoPb.ProductId>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "addProduct"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.ProtoUtils.marshaller(
                  javagrpc.ProductInfoPb.Product.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.ProtoUtils.marshaller(
                  javagrpc.ProductInfoPb.ProductId.getDefaultInstance()))
              .setSchemaDescriptor(new ProductInfoMethodDescriptorSupplier("addProduct"))
              .build();
        }
      }
    }
    return getAddProductMethod;
  }

  private static volatile io.grpc.MethodDescriptor<javagrpc.ProductInfoPb.ProductId,
      javagrpc.ProductInfoPb.Product> getGetProductMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "getProduct",
      requestType = javagrpc.ProductInfoPb.ProductId.class,
      responseType = javagrpc.ProductInfoPb.Product.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<javagrpc.ProductInfoPb.ProductId,
      javagrpc.ProductInfoPb.Product> getGetProductMethod() {
    io.grpc.MethodDescriptor<javagrpc.ProductInfoPb.ProductId, javagrpc.ProductInfoPb.Product> getGetProductMethod;
    if ((getGetProductMethod = ProductInfoGrpc.getGetProductMethod) == null) {
      synchronized (ProductInfoGrpc.class) {
        if ((getGetProductMethod = ProductInfoGrpc.getGetProductMethod) == null) {
          ProductInfoGrpc.getGetProductMethod = getGetProductMethod =
              io.grpc.MethodDescriptor.<javagrpc.ProductInfoPb.ProductId, javagrpc.ProductInfoPb.Product>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "getProduct"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.ProtoUtils.marshaller(
                  javagrpc.ProductInfoPb.ProductId.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.ProtoUtils.marshaller(
                  javagrpc.ProductInfoPb.Product.getDefaultInstance()))
              .setSchemaDescriptor(new ProductInfoMethodDescriptorSupplier("getProduct"))
              .build();
        }
      }
    }
    return getGetProductMethod;
  }

  /**
   * Creates a new async stub that supports all call types for the service
   */
  public static ProductInfoStub newStub(io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<ProductInfoStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<ProductInfoStub>() {
        @java.lang.Override
        public ProductInfoStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new ProductInfoStub(channel, callOptions);
        }
      };
    return ProductInfoStub.newStub(factory, channel);
  }

  /**
   * Creates a new blocking-style stub that supports unary and streaming output calls on the service
   */
  public static ProductInfoBlockingStub newBlockingStub(
      io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<ProductInfoBlockingStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<ProductInfoBlockingStub>() {
        @java.lang.Override
        public ProductInfoBlockingStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new ProductInfoBlockingStub(channel, callOptions);
        }
      };
    return ProductInfoBlockingStub.newStub(factory, channel);
  }

  /**
   * Creates a new ListenableFuture-style stub that supports unary calls on the service
   */
  public static ProductInfoFutureStub newFutureStub(
      io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<ProductInfoFutureStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<ProductInfoFutureStub>() {
        @java.lang.Override
        public ProductInfoFutureStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new ProductInfoFutureStub(channel, callOptions);
        }
      };
    return ProductInfoFutureStub.newStub(factory, channel);
  }

  /**
   */
  public interface AsyncService {

    /**
     * <pre>
     * 添加商品
     * </pre>
     */
    default void addProduct(javagrpc.ProductInfoPb.Product request,
        io.grpc.stub.StreamObserver<javagrpc.ProductInfoPb.ProductId> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getAddProductMethod(), responseObserver);
    }

    /**
     * <pre>
     * 获取商品
     * </pre>
     */
    default void getProduct(javagrpc.ProductInfoPb.ProductId request,
        io.grpc.stub.StreamObserver<javagrpc.ProductInfoPb.Product> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getGetProductMethod(), responseObserver);
    }
  }

  /**
   * Base class for the server implementation of the service ProductInfo.
   */
  public static abstract class ProductInfoImplBase
      implements io.grpc.BindableService, AsyncService {

    @java.lang.Override public final io.grpc.ServerServiceDefinition bindService() {
      return ProductInfoGrpc.bindService(this);
    }
  }

  /**
   * A stub to allow clients to do asynchronous rpc calls to service ProductInfo.
   */
  public static final class ProductInfoStub
      extends io.grpc.stub.AbstractAsyncStub<ProductInfoStub> {
    private ProductInfoStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected ProductInfoStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new ProductInfoStub(channel, callOptions);
    }

    /**
     * <pre>
     * 添加商品
     * </pre>
     */
    public void addProduct(javagrpc.ProductInfoPb.Product request,
        io.grpc.stub.StreamObserver<javagrpc.ProductInfoPb.ProductId> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getAddProductMethod(), getCallOptions()), request, responseObserver);
    }

    /**
     * <pre>
     * 获取商品
     * </pre>
     */
    public void getProduct(javagrpc.ProductInfoPb.ProductId request,
        io.grpc.stub.StreamObserver<javagrpc.ProductInfoPb.Product> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getGetProductMethod(), getCallOptions()), request, responseObserver);
    }
  }

  /**
   * A stub to allow clients to do synchronous rpc calls to service ProductInfo.
   */
  public static final class ProductInfoBlockingStub
      extends io.grpc.stub.AbstractBlockingStub<ProductInfoBlockingStub> {
    private ProductInfoBlockingStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected ProductInfoBlockingStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new ProductInfoBlockingStub(channel, callOptions);
    }

    /**
     * <pre>
     * 添加商品
     * </pre>
     */
    public javagrpc.ProductInfoPb.ProductId addProduct(javagrpc.ProductInfoPb.Product request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getAddProductMethod(), getCallOptions(), request);
    }

    /**
     * <pre>
     * 获取商品
     * </pre>
     */
    public javagrpc.ProductInfoPb.Product getProduct(javagrpc.ProductInfoPb.ProductId request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getGetProductMethod(), getCallOptions(), request);
    }
  }

  /**
   * A stub to allow clients to do ListenableFuture-style rpc calls to service ProductInfo.
   */
  public static final class ProductInfoFutureStub
      extends io.grpc.stub.AbstractFutureStub<ProductInfoFutureStub> {
    private ProductInfoFutureStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected ProductInfoFutureStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new ProductInfoFutureStub(channel, callOptions);
    }

    /**
     * <pre>
     * 添加商品
     * </pre>
     */
    public com.google.common.util.concurrent.ListenableFuture<javagrpc.ProductInfoPb.ProductId> addProduct(
        javagrpc.ProductInfoPb.Product request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getAddProductMethod(), getCallOptions()), request);
    }

    /**
     * <pre>
     * 获取商品
     * </pre>
     */
    public com.google.common.util.concurrent.ListenableFuture<javagrpc.ProductInfoPb.Product> getProduct(
        javagrpc.ProductInfoPb.ProductId request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getGetProductMethod(), getCallOptions()), request);
    }
  }

  private static final int METHODID_ADD_PRODUCT = 0;
  private static final int METHODID_GET_PRODUCT = 1;

  private static final class MethodHandlers<Req, Resp> implements
      io.grpc.stub.ServerCalls.UnaryMethod<Req, Resp>,
      io.grpc.stub.ServerCalls.ServerStreamingMethod<Req, Resp>,
      io.grpc.stub.ServerCalls.ClientStreamingMethod<Req, Resp>,
      io.grpc.stub.ServerCalls.BidiStreamingMethod<Req, Resp> {
    private final AsyncService serviceImpl;
    private final int methodId;

    MethodHandlers(AsyncService serviceImpl, int methodId) {
      this.serviceImpl = serviceImpl;
      this.methodId = methodId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("unchecked")
    public void invoke(Req request, io.grpc.stub.StreamObserver<Resp> responseObserver) {
      switch (methodId) {
        case METHODID_ADD_PRODUCT:
          serviceImpl.addProduct((javagrpc.ProductInfoPb.Product) request,
              (io.grpc.stub.StreamObserver<javagrpc.ProductInfoPb.ProductId>) responseObserver);
          break;
        case METHODID_GET_PRODUCT:
          serviceImpl.getProduct((javagrpc.ProductInfoPb.ProductId) request,
              (io.grpc.stub.StreamObserver<javagrpc.ProductInfoPb.Product>) responseObserver);
          break;
        default:
          throw new AssertionError();
      }
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("unchecked")
    public io.grpc.stub.StreamObserver<Req> invoke(
        io.grpc.stub.StreamObserver<Resp> responseObserver) {
      switch (methodId) {
        default:
          throw new AssertionError();
      }
    }
  }

  public static final io.grpc.ServerServiceDefinition bindService(AsyncService service) {
    return io.grpc.ServerServiceDefinition.builder(getServiceDescriptor())
        .addMethod(
          getAddProductMethod(),
          io.grpc.stub.ServerCalls.asyncUnaryCall(
            new MethodHandlers<
              javagrpc.ProductInfoPb.Product,
              javagrpc.ProductInfoPb.ProductId>(
                service, METHODID_ADD_PRODUCT)))
        .addMethod(
          getGetProductMethod(),
          io.grpc.stub.ServerCalls.asyncUnaryCall(
            new MethodHandlers<
              javagrpc.ProductInfoPb.ProductId,
              javagrpc.ProductInfoPb.Product>(
                service, METHODID_GET_PRODUCT)))
        .build();
  }

  private static abstract class ProductInfoBaseDescriptorSupplier
      implements io.grpc.protobuf.ProtoFileDescriptorSupplier, io.grpc.protobuf.ProtoServiceDescriptorSupplier {
    ProductInfoBaseDescriptorSupplier() {}

    @java.lang.Override
    public com.google.protobuf.Descriptors.FileDescriptor getFileDescriptor() {
      return javagrpc.ProductInfoPb.getDescriptor();
    }

    @java.lang.Override
    public com.google.protobuf.Descriptors.ServiceDescriptor getServiceDescriptor() {
      return getFileDescriptor().findServiceByName("ProductInfo");
    }
  }

  private static final class ProductInfoFileDescriptorSupplier
      extends ProductInfoBaseDescriptorSupplier {
    ProductInfoFileDescriptorSupplier() {}
  }

  private static final class ProductInfoMethodDescriptorSupplier
      extends ProductInfoBaseDescriptorSupplier
      implements io.grpc.protobuf.ProtoMethodDescriptorSupplier {
    private final java.lang.String methodName;

    ProductInfoMethodDescriptorSupplier(java.lang.String methodName) {
      this.methodName = methodName;
    }

    @java.lang.Override
    public com.google.protobuf.Descriptors.MethodDescriptor getMethodDescriptor() {
      return getServiceDescriptor().findMethodByName(methodName);
    }
  }

  private static volatile io.grpc.ServiceDescriptor serviceDescriptor;

  public static io.grpc.ServiceDescriptor getServiceDescriptor() {
    io.grpc.ServiceDescriptor result = serviceDescriptor;
    if (result == null) {
      synchronized (ProductInfoGrpc.class) {
        result = serviceDescriptor;
        if (result == null) {
          serviceDescriptor = result = io.grpc.ServiceDescriptor.newBuilder(SERVICE_NAME)
              .setSchemaDescriptor(new ProductInfoFileDescriptorSupplier())
              .addMethod(getAddProductMethod())
              .addMethod(getGetProductMethod())
              .build();
        }
      }
    }
    return result;
  }
}
