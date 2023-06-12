package my.sample;

import org.apache.log4j.Logger;

public class Sub2 {
	protected final Logger log = Logger.getLogger(this.getClass());

	public int sub2() {
		log.debug("sub2 function is run.");
		log.debug("sub2 函数运行");
		log.debug("sub2 関数実行");
		return 2;
	}
}
