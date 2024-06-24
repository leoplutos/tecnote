package my.mavenbatsample;

import java.io.InputStream;
import java.util.Properties;

public class FruitFactory {
	public static Fruit createFruit(String type) {
		Fruit result = null;
		if (type.equals("Apple")) {
			result = new Apple();
		} else if (type.equals("Orange")) {
			result = new Orange();
		} else if (type.equals("Banana")) {
			result = new Banana();
		} else {
			result = null;
		}
		return result;
	}

	public static Fruit createFruitBySetting(String type) {
		Fruit result = null;
		// 读取配置文件中的内容
		Properties prop = new Properties();
		InputStream in = FruitFactory.class.getResourceAsStream("/factoryConfig.properties");
		try {
			prop.load(in);
			String fruitClass = prop.getProperty(type).trim();
			// 用反射生成实体类
			// 1.9之前的用法
			// result = (Fruit) Class.forName(fruitClass).newInstance();
			// 1.9之后的用法
			result = (Fruit) Class.forName(fruitClass).getDeclaredConstructor().newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
