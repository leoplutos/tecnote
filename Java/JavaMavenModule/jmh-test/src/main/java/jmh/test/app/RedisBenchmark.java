package jmh.test.app;

import java.util.concurrent.TimeUnit;
import org.openjdk.jmh.annotations.Benchmark;
import org.openjdk.jmh.annotations.BenchmarkMode;
import org.openjdk.jmh.annotations.Fork;
import org.openjdk.jmh.annotations.Level;
import org.openjdk.jmh.annotations.Measurement;
import org.openjdk.jmh.annotations.Mode;
import org.openjdk.jmh.annotations.OutputTimeUnit;
import org.openjdk.jmh.annotations.Scope;
import org.openjdk.jmh.annotations.Setup;
import org.openjdk.jmh.annotations.State;
import org.openjdk.jmh.annotations.TearDown;
import org.openjdk.jmh.annotations.Threads;
import org.openjdk.jmh.annotations.Warmup;
import org.openjdk.jmh.infra.Blackhole;
import org.openjdk.jmh.runner.Runner;
import org.openjdk.jmh.runner.RunnerException;
import org.openjdk.jmh.runner.options.Options;
import org.openjdk.jmh.runner.options.OptionsBuilder;
import smp.jmbp.redis.Redis;

@State(Scope.Thread) // 默认的State，每个测试线程分配一个实例
@BenchmarkMode(Mode.Throughput) // 整体吞吐量，每秒执行了多少次调用，单位为 ops/time
@Warmup(iterations = 1, time = 1, timeUnit = TimeUnit.SECONDS) // 预热 1 轮，每次 1s
@Measurement(iterations = 5, time = 5, timeUnit = TimeUnit.SECONDS) // 测试 5 轮，每次 5s
@Fork(1) // 指定fork出多少个子进程来执行同一基准测试方法
@Threads(5) // 指定使用多少个线程来执行基准测试方法
@OutputTimeUnit(TimeUnit.MILLISECONDS) // 输出的时间单位
public class RedisBenchmark {

	/**
	 * @Setup 用于基准测试前的初始化动作
	 *        Level.Trial：Benchmark级别
	 *        Level.Iteration：执行迭代级别
	 *        Level.Invocation：每次方法调用级别
	 */
	@Setup(Level.Invocation)
	public void setUp() {
		System.out.println("Redis 测试开始");
	}

	/**
	 * @TearDown 用于基准测试后执行，主要用于资源的回收
	 */
	@TearDown
	public void tearDown() {
		System.out.println("Redis 测试结束");
	}

	// testMethod 是一个 Benchmark 方法。我们可以直接在 testMethod 方法中编写测试代码，也可以调用父项目的方法
	@Benchmark
	public void redisTest(Blackhole blackhole) throws InterruptedException {
		Redis redis = new Redis();
		redis.runRedis();
	}

	// 运行方法有2种
	// 1. 使用 Debugger for Java 插件运行此类（注意不要用debug模式）
	// 2. 编译成jar使用
	// cd jmh-test
	// mvn clean verify
	// java -jar target/benchmarks.jar
	public static void main(String[] args) throws RunnerException {
		Options opt = new OptionsBuilder()
				.include(RedisBenchmark.class.getSimpleName())
				.forks(1)
				.build();

		new Runner(opt).run();
	}
}
