package my.mavenbatsample;

import org.apache.log4j.Logger;

/**
 * Hello world!
 *
 */
public class App {
	protected static final Logger log = Logger.getLogger(App.class);

	public static void main(String[] args) {
		System.out.println("Hello World!");
		String str1 = "Hello!こんにちは!你好!안녕하세요!";
		String str2 = "日本語テストです";
		String str3 = "这是1段中文";
		log.debug(str1);
		log.debug(str2);
		log.debug(str3);
	}
}
