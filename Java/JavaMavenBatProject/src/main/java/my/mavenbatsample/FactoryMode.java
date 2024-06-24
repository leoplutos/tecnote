package my.mavenbatsample;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class FactoryMode {

	public static void main(String[] args) {

		// 最简单的工厂模式
		Fruit fruit = FruitFactory.createFruit("Apple");
		fruit.printName();
		fruit = FruitFactory.createFruit("Banana");
		fruit.printName();
		fruit = FruitFactory.createFruit("Orange");
		fruit.printName();

		System.out.println("---------------");

		// 从设定文件读取的工厂模式
		fruit = FruitFactory.createFruitBySetting("Apple");
		fruit.printName();
		fruit = FruitFactory.createFruitBySetting("Banana");
		fruit.printName();
		fruit = FruitFactory.createFruitBySetting("Orange");
		fruit.printName();

		System.out.println("---------------");

		// 使用Spring自带的Bean工厂，读取工程跟目录XML
		@SuppressWarnings("resource")
		BeanFactory factory = new ClassPathXmlApplicationContext("applicationContext.xml");
		fruit = (Fruit) factory.getBean("Apple");
		fruit.printName();
		fruit = (Fruit) factory.getBean("Banana");
		fruit.printName();
		fruit = (Fruit) factory.getBean("Orange");
		fruit.printName();
	}
}
