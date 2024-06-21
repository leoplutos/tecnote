package javagrpc.main;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.common.util.concurrent.FutureCallback;
import com.google.common.util.concurrent.Futures;
import com.google.common.util.concurrent.ListenableFuture;
import com.google.common.util.concurrent.MoreExecutors;
import com.google.protobuf.Empty;
import com.google.protobuf.Int32Value;

import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import io.grpc.Status;
import javagrpc.grpc.stub.StopServiceGrpc;

// 程序主入口，这里使用异步的方式调用
public class ServerStopMain {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// 远程连接管理器,管理连接的生命周期
	private final ManagedChannel channel;
	// 非阻塞异步存根（结果以回调的方式通知）
	private final StopServiceGrpc.StopServiceFutureStub stopFutureStub;
	// 线程池
	private ExecutorService executorService;

	public ServerStopMain(String host, int port) {

		// 对于回调，gRPC 使用缓存线程池，该线程池根据需要创建新线程，但在以前构建的线程可用时会重用它们。如果需要，可以将线程池作为
		executorService = Executors.newFixedThreadPool(10);
		// 没有负载均衡器的例子
		channel = ManagedChannelBuilder.forAddress(host, port)
				.executor(executorService)
				.usePlaintext()
				.build();

		// 业务请求客户端
		stopFutureStub = StopServiceGrpc.newFutureStub(channel);

		log.info("[Java][Client] Access server success. host: {}  port: {}", host, port);
	}

	public void shutdown() throws InterruptedException {
		// 关闭连接
		channel.shutdown().awaitTermination(5, TimeUnit.SECONDS);

		// 关闭线程池
		if (executorService != null) {
			executorService.shutdown();
			executorService.awaitTermination(5, TimeUnit.SECONDS);
		}
	}

	// 异步请求关闭服务端
	public ListenableFuture<Empty> stopServiceAsync() {
		// com.google.protobuf.Int32Value request =
		// Int32Value.newBuilder().setValue(1).build();
		Int32Value request = Int32Value.of(1);
		// 调用远程服务方法
		ListenableFuture<Empty> listenableFuture = stopFutureStub.stop(request);
		Futures.addCallback(listenableFuture, new FutureCallback<Empty>() {
			@Override
			@SuppressWarnings("null")
			public void onSuccess(Empty response) {
				// 成功时的处理逻辑
				log.info("[Java][Client] Stop Service success: {}", response);
			}

			@Override
			@SuppressWarnings("null")
			public void onFailure(Throwable t) {
				// 失败时的处理逻辑
				log.info("[Java][Client] Stop Service failed: {}", Status.fromThrowable(t));
			}
		}, MoreExecutors.directExecutor());

		return listenableFuture;
	}

	public static void main(String[] args) throws InterruptedException, ExecutionException {
		// 服务端口，如果参数传入则使用，默认127.0.0.1，50051
		String host = "127.0.0.1";
		int port = 50051;
		if (args.length > 0) {
			try {
				host = args[0];
				log.info("[Java][Client] host: {}", host);
				port = Integer.parseInt(args[1]);
				log.info("[Java][Client] port: {}", port);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		ServerStopMain client = new ServerStopMain(host, port);

		// 请求关闭服务端
		ListenableFuture<Empty> task = client.stopServiceAsync();

		// 使用get来等待子线程结束
		task.get();

		// 关闭连接
		client.shutdown();
	}
}
