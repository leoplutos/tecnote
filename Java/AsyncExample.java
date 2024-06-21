package my.test;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.function.BiConsumer;

public class AsyncExample {

	// 异步函数
	public static CompletableFuture<String> doSomethingAsync(int value, ExecutorService executor) {
		// 创建一个无消耗值(无输入值)、无返回值的异步子任务
		// CompletableFuture<Void> future = CompletableFuture.runAsync(() -> {});
		// 创建一个无消耗值(无输入值)、有返回值的异步子任务
		CompletableFuture<String> task = CompletableFuture.supplyAsync(() -> {
			// 模拟长时间运行的任务，例如网络请求或数据库查询
			sleepSecond(2);
			return "reult" + String.valueOf(value);
		}, executor);
		return task;
	}

	public static void main(String[] args) throws InterruptedException, ExecutionException {

		// 定长10线程池
		// 默认情况下，通过静态方法runAsync()、supplyAsync()创建的CompletableFuture任务会使用公共的ForkJoinPool线程池，默认的线程数是CPU的核数。
		// 如果所有CompletableFuture共享一个线程池，那么一旦有任务执行一些很慢的IO操作，就会导致线程池中的所有线程都阻塞在IO操作上，造成线程饥饿，进而影响整个系统的性能。
		// 所以，强烈建议根据不同的业务类型创建不同的线程池，以避免相互干扰。
		ExecutorService executor = Executors.newFixedThreadPool(10);

		System.out.println("Main Start!!");
		// 不堵塞，不等待结果直接继续运行（多次循环调用）
		List<CompletableFuture<String>> taskList = new ArrayList<CompletableFuture<String>>();
		for (int i = 0; i < 5; i++) {
			// 有返回值的异步调用
			CompletableFuture<String> task = doSomethingAsync(i, executor);
			// 异步操作完成时调用的回调方法
			task.whenComplete(new BiConsumer<String, Throwable>() {
				@Override
				public void accept(String result, Throwable throwable) {
					// 处理结果
					System.out.println("callback: " + result);
				}
			});
			taskList.add(task);
		}
		System.out.println("Main End!!");
		// 只有一个task时使用get来等待子线程结束
		// task.get();
		// 有多个task时使用allOf(completableFutures).join()来等待所有子线程结束
		CompletableFuture.allOf(taskList.toArray(CompletableFuture[]::new))
				// .whenComplete((v, th) -> {System.out.println("所有子任务执行完成!!!");})
				.join();

		// 关闭线程池
		if (executor != null) {
			executor.shutdown();
			executor.awaitTermination(5, TimeUnit.SECONDS);
		}
	}

	public static void sleepSecond(int t) {
		try {
			TimeUnit.SECONDS.sleep(t);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
