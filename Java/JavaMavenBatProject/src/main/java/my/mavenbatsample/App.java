package my.mavenbatsample;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Hello world!
 *
 */
public class App {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	public static void main(String[] args) {
		System.out.println("Hello World - 日本語!");
		String str1 = "Hello!こんにちは!你好!안녕하세요!";
		String str2 = "日本語テストです";
		String str3 = "这是1段中文";
		log.debug(str1);
		log.debug(str2);
		log.debug(str3);
	}
}
