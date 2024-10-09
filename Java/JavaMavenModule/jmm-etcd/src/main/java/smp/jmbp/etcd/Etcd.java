package smp.jmbp.etcd;

import java.util.concurrent.atomic.LongAdder;
import smp.jmbp.core.Const;

/**
 */
public class Etcd {

	public void runEtcd() throws InterruptedException {
		String module_name = Const.MODULE_NAME;
		System.out.println("Etcd: " + module_name);

		LongAdder longAdder = new LongAdder();
		for (int i = 0; i < 1024; i++) {
			longAdder.add(1);
		}
		System.out.println("LongAdder的计算结果: " + longAdder.intValue());
	}

	public static void main(String[] args) {
		try {
			Etcd app = new Etcd();
			app.runEtcd();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
	}
}
