package my.mavenbatsample;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.function.BiConsumer;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class AsyncExample {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// 异步函数-无返回值
	public static CompletableFuture<Void> showVoidAsync(int value) {
		// runAsync 接受一个Runnable函数接口，不返回任何结果
		return CompletableFuture.runAsync(() -> {
			log.debug("showVoidAsync -> {}", value);
		});
	}

	// 异步函数-有返回值
	public static CompletableFuture<String> showStringAsync(int value) {
		// supplyAsync需要一个Supplier函数接口，通常用于执行异步计算
		return CompletableFuture.supplyAsync(() -> {
			String result = String.valueOf(value);
			log.debug("showStringAsync -> {}", result);
			return result;
		});
	}

	// 异步函数-发生异常
	public static CompletableFuture<Integer> showExceptionAsync(int value) {
		// runAsync 接受一个Runnable函数接口，不返回任何结果
		return CompletableFuture.supplyAsync(() -> {
			int zero = 0;
			int result = value / zero;
			// return Integer.valueOf(result);
			log.debug("showExceptionAsync -> {}", result);
			return result;
		});
	}

	// 异步函数-指定执行器
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

		// 堵塞调用异步函数
		showVoidAsync(10).get();
		log.info("调用showVoidAsync完成");
		String resultStr = showStringAsync(10).get();
		log.info("调用showStringAsync完成, 返回值:{}", resultStr);
		// 外部的try catch会捕获异步函数内的异常，如何希望捕获异常后设定默认值，可以使用exceptionally的方式
		try {
			int resultInt = showExceptionAsync(10)
			//.exceptionally((e) -> {
			//	log.error(e);
			//	return 0;
			//})
			.get();
			log.info("调用showExceptionAsync完成, 返回值:{}", resultInt);
		} catch (Exception e) {
			log.error(e);
		}

		// 定长10线程池
		// 默认情况下，通过静态方法runAsync()、supplyAsync()创建的CompletableFuture任务会使用公共的ForkJoinPool线程池，默认的线程数是CPU的核数。
		// 如果所有CompletableFuture共享一个线程池，那么一旦有任务执行一些很慢的IO操作，就会导致线程池中的所有线程都阻塞在IO操作上，造成线程饥饿，进而影响整个系统的性能。
		// 所以，强烈建议根据不同的业务类型创建不同的线程池，以避免相互干扰。
		// ExecutorService executor = Executors.newFixedThreadPool(10);

		// 定义虚拟线程池
		ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor();
		try {

			log.info("Main Start!!");
			// 不堵塞，不等待结果直接继续运行（多次循环调用）
			List<CompletableFuture<String>> taskList = new CopyOnWriteArrayList<CompletableFuture<String>>();
			for (int i = 0; i < 5; i++) {
				// 有返回值的异步调用
				CompletableFuture<String> task = doSomethingAsync(i, executor);
				// 异步操作完成时调用的回调方法
				task.whenComplete(new BiConsumer<String, Throwable>() {
					@Override
					public void accept(String result, Throwable throwable) {
						boolean isVirtual = Thread.currentThread().isVirtual();
						// 处理结果
						log.info("callback:{}    isVirtual:{}", result, isVirtual);
					}
				});
				taskList.add(task);
			}
			log.info("Main End!!");
			// 只有一个task时使用get来等待子线程结束
			// task.get();
			// 有多个task时使用allOf(completableFutures).join()来等待所有子线程结束
			CompletableFuture.allOf(taskList.toArray(CompletableFuture[]::new))
					// .whenComplete((v, th) -> {System.out.println("所有子任务执行完成!!!");})
					.join();

			// 单次调用例子
			String result = doSomethingAsync(100, executor).get();
			log.info("Once Call Rusult: {}", result);

		} catch (Exception e) {
			log.error(e);
		} finally {
			// 关闭线程池
			if (executor != null) {
				executor.shutdown();
				executor.awaitTermination(5, TimeUnit.SECONDS);
			}
			// 因为使用了异步日志，要在这里关闭
			LogManager.shutdown();
		}
	}

	public static void sleepSecond(int t) {
		try {
			TimeUnit.SECONDS.sleep(t);
		} catch (Exception e) {
			log.error(e);
		}
	}

}
