// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: StopServer.proto

// Protobuf Java Version: 3.25.3
package javagrpc.grpc.stub;

public final class StopServerPb {
  private StopServerPb() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistryLite registry) {
  }

  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistry registry) {
    registerAllExtensions(
        (com.google.protobuf.ExtensionRegistryLite) registry);
  }

  public static com.google.protobuf.Descriptors.FileDescriptor
      getDescriptor() {
    return descriptor;
  }
  private static  com.google.protobuf.Descriptors.FileDescriptor
      descriptor;
  static {
    java.lang.String[] descriptorData = {
      "\n\020StopServer.proto\022\tgrpc_demo\032\033google/pr" +
      "otobuf/empty.proto\032\036google/protobuf/wrap" +
      "pers.proto2J\n\013StopService\022;\n\004stop\022\033.goog" +
      "le.protobuf.Int32Value\032\026.google.protobuf" +
      ".EmptyB0\n\022javagrpc.grpc.stubB\014StopServer" +
      "PbP\000Z\ngo/productb\006proto3"
    };
    descriptor = com.google.protobuf.Descriptors.FileDescriptor
      .internalBuildGeneratedFileFrom(descriptorData,
        new com.google.protobuf.Descriptors.FileDescriptor[] {
          com.google.protobuf.EmptyProto.getDescriptor(),
          com.google.protobuf.WrappersProto.getDescriptor(),
        });
    com.google.protobuf.EmptyProto.getDescriptor();
    com.google.protobuf.WrappersProto.getDescriptor();
  }

  // @@protoc_insertion_point(outer_class_scope)
}
