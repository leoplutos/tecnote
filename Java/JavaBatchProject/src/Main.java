import org.apache.log4j.Logger;

import my.sample.Sub1;
import my.sample.Sub2;

public class Main {
	protected static final Logger log = Logger.getLogger(Main.class);

	public static void main(String[] args) throws Exception {
		String str1 = "Hello!こんにちは!你好!안녕하세요!";
		String str2 = "日本語テストです";
		String str3 = "这是1段中文";
		log.debug(str1);
		log.debug(str2);
		log.debug(str3);
		// System.out.printf("[DEBUG] - str1:[%s] \n", str1);
		// System.out.printf("[DEBUG] - str2:[%s] \n", str2);
		// System.err.printf("[DEBUG] - str3:[%s] \n", str3);
		log.debug("sub1开始。");
		Sub1 s1 = new Sub1();
		int i_retCode = s1.sub1();
		log.debug("sub1结束。结果 i_retCode:" + i_retCode);
		log.debug("sub2开始。");
		Sub2 s2 = new Sub2();
		i_retCode = s2.sub2();
		log.debug("sub2结束。结果 i_retCode:" + i_retCode);
	}
}
