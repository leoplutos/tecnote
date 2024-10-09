package smp.jmbp.app;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import smp.jmbp.core.Const;

/**
 */
public class App {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	public void runApp() throws InterruptedException {
		String module_name = Const.MODULE_NAME;
		log.debug("App: " + module_name);

		AtomicInteger atomicInteger = new AtomicInteger();
		// 虚拟线程的执行器，这个执行器在每次提交一个新任务时，都会为这个任务创建一个新的虚拟线程来执行它
		// 虚拟线程属于非常轻量级的资源，因此，用时创建，用完就扔，不要池化虚拟线程
		ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor();
		for (int i = 0; i < 500; i++) {
			executor.submit(() -> {
				// 在Java语言中，++i和i++操作并不是线程安全的，在使用的时候，不可避免的会用到synchronized关键字。而AtomicInteger则通过一种线程安全的加减操作接口
				atomicInteger.addAndGet(1);
			});
		}
		// 关闭执行器，不接受新任务
		executor.shutdown();
		// 等待所有任务完成，或者直到超时
		try {
			if (!executor.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS)) {
				// 超时了，可能有些任务还在执行或者没有正确完成
				executor.shutdownNow(); // 尝试停止所有正在执行的任务
			}
		} catch (InterruptedException e) {
			log.error(e);
			// 当前线程在等待过程中被中断
			executor.shutdownNow(); // 尝试停止所有正在执行的任务
			Thread.currentThread().interrupt(); // 保持中断状态
		}

		log.info("AtomicInteger的计算结果: {}", atomicInteger.intValue());
	}

	public static void main(String[] args) {
		try {
			App app = new App();
			app.runApp();
		} catch (Exception e) {
			log.error(e);
		} finally {
			// 因为使用了异步日志，要在这里关闭
			LogManager.shutdown();
		}
	}
}
