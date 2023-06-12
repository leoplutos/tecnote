package my.sample;

import org.apache.log4j.Logger;

public class Sub1 {
	protected final Logger log = Logger.getLogger(this.getClass());

	public int sub1() {
		log.debug("sub1 function is run.");
		log.debug("sub1 函数运行");
		log.debug("sub1 関数実行");
		return 1;
	}
}
