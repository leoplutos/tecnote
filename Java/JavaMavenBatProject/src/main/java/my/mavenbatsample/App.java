package my.mavenbatsample;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * 虚拟线程示例
 */
public class App {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	public static void main(String[] args) {
		try {
			System.out.println("Hello World - 日本語!");
			String str1 = "Hello!こんにちは!你好!안녕하세요!";
			String str2 = "日本語テストです";
			String str3 = "这是1段中文";
			log.debug(str1);
			log.debug(str2);
			log.debug(str3);

			// 虚拟线程示例

			// Thread类
			Thread thread = Thread.ofVirtual().name("virtual-thread-class").start(() -> {
				String name = Thread.currentThread().getName();
				long id = Thread.currentThread().threadId();
				boolean isVirtual = Thread.currentThread().isVirtual();
				log.info("Thread类-虚拟线程,  Name:{},  ID:{},  isVirtual:{}", name, id, isVirtual);
			});
			thread.join();

			// Thread.Builder接口
			Thread.Builder builder = Thread.ofVirtual().name("worker-", 1);
			Runnable task = () -> {
				String name = Thread.currentThread().getName();
				long id = Thread.currentThread().threadId();
				boolean isVirtual = Thread.currentThread().isVirtual();
				log.info("Thread.Builder接口-虚拟线程,  Name:{},  ID:{},  isVirtual:{}", name, id, isVirtual);
			};
			// name "worker-0"
			Thread t1 = builder.start(task);
			t1.join();
			log.info("Thread.Builder接口-虚拟线程 [{}] 停止", t1.getName());
			// name "worker-1"
			Thread t2 = builder.start(task);
			t2.join();
			log.info("Thread.Builder接口-虚拟线程 [{}] 停止", t2.getName());

			// 虚拟线程的执行器，这个执行器在每次提交一个新任务时，都会为这个任务创建一个新的虚拟线程来执行它
			// 虚拟线程属于非常轻量级的资源，因此，用时创建，用完就扔，不要池化虚拟线程
			ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor();
			for (int i = 0; i < 10; i++) {
				executor.submit(() -> {
					String name = Thread.currentThread().getName();
					long id = Thread.currentThread().threadId();
					boolean isVirtual = Thread.currentThread().isVirtual();
					log.info("执行器-虚拟线程[{}][{}]-开始,  isVirtual:{}", name, id, isVirtual);
					try {
						TimeUnit.SECONDS.sleep(2);
					} catch (InterruptedException e) {
						log.error(e);
					}
					log.info("执行器-虚拟线程[{}][{}]-停止", name, id);
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
		} catch (Exception e) {
			log.error(e);
		} finally {
			// 因为使用了异步日志，要在这里关闭
			LogManager.shutdown();
		}
	}
}
