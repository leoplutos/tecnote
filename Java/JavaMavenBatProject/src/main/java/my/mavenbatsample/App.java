package my.mavenbatsample;

import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import java.util.stream.Stream;

/**
 * 虚拟线程示例
 */
public class App {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// say hello
	private void hello() {
		System.out.println("Hello World - 日本語!");
		String str1 = "Hello!こんにちは!你好!안녕하세요!";
		String str2 = "日本語テストです";
		String str3 = "这是1段中文";
		log.debug(str1);
		log.debug(str2);
		log.debug(str3);
	}

	// Streams API (流式API) 示例
	private void streamsApi() {

		// 示例1：找到大于18岁的学生
		List<Student> students = Arrays.asList(new Student(10, "张三"), new Student(20, "李四"), new Student(30, "王二麻子"));
		// 普通写法
		List<Student> sdResult = new ArrayList<>();
		for (Student student : students) {
			if (student.getAge() > 18) {
				sdResult.add(student);
			}
		}
		log.info("普通写法结果  sdResult:{}", sdResult);
		// 流式API写法
		sdResult = students
				// 使用stream()获得流
				.stream()
				// 过滤（大于18岁）
				.filter(student -> student.getAge() > 18)
				// 归并到容器中
				.collect(Collectors.toList());
		log.info("流式API写法结果  sdResult:{}", sdResult);

		// 示例2：找到字母a开头的水果并且转大写
		List<String> fruits = Arrays.asList("apple", "banana", "avocado", "orange");
		List<String> frResult = fruits
				// 使用stream()获得流
				.stream()
				// 过滤（字母a开头）
				.filter(fruit -> fruit.startsWith("a"))
				// 映射（调用String.toUpperCase()来转大写）
				.map(String::toUpperCase)
				// 归并到容器中
				.collect(Collectors.toList());
		log.info("流式API写法结果  frResult:{}", frResult);

		// 示例3：得到InetSocketAddress 从 127.0.0.1:50051 -> 127.0.0.1:50060
		List<InetSocketAddress> addresses =
				// 生成从初始元素到常量的流
				Stream.iterate(50051, port -> port + 1)
						// 裁剪10个
						.limit(10)
						// 映射（用每个元素来创建InetSocketAddress）
						.map(port -> new InetSocketAddress("127.0.0.1", port))
						// 归并到容器中
						.collect(Collectors.toList());
		log.info("流式API写法结果  addresses:{}", addresses);
	}

	// 虚拟线程示例
	private void virtualThread() throws InterruptedException {
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
		for (int i = 0; i < 5; i++) {
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
	}

	public static void main(String[] args) {
		App app = new App();
		try {
			// say hello
			app.hello();
			// Streams API (流式API) 示例
			app.streamsApi();
			// 虚拟线程示例
			app.virtualThread();

		} catch (Exception e) {
			log.error(e);
		} finally {
			// 因为使用了异步日志，要在这里关闭
			LogManager.shutdown();
		}
	}

	@SuppressWarnings("unused")
	private class Student {
		private int age;
		private String name;

		public Student(int age, String name) {
			this.age = age;
			this.name = name;
		}

		public int getAge() {
			return age;
		}

		public void setAge(int age) {
			this.age = age;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		@Override
		public String toString() {
			return "{ age=" + age + ", name=" + name + "}";
		}
	}
}
