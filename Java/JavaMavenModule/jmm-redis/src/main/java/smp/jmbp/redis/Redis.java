package smp.jmbp.redis;

import java.util.concurrent.atomic.DoubleAdder;
import smp.jmbp.core.Const;

/**
 */
public class Redis {

	public void runRedis() throws InterruptedException {
		String module_name = Const.MODULE_NAME;
		System.out.println("Redis: " + module_name);

		DoubleAdder doubleAdder = new DoubleAdder();
		for (int i = 0; i < 1024; i++) {
			doubleAdder.add(i);
		}
		System.out.println("DoubleAdder的计算结果: " + doubleAdder.intValue());
	}

	public static void main(String[] args) {
		try {
			Redis app = new Redis();
			app.runRedis();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
	}
}
