package my.mavenbatsample;

import java.io.StringReader;
import java.io.StringWriter;
import java.math.BigDecimal;
import com.myexample.employee.Employee;
import jakarta.xml.bind.JAXB;

public class JAXBMain {

	protected void runSample() throws Exception {

		// 使用[Employee.xsd]文件生成的Java类型
		com.myexample.employee.ObjectFactory empFactory = new com.myexample.employee.ObjectFactory();
		Employee employee = empFactory.createEmployee();
		employee.setName("abc");
		employee.setAge(18);
		employee.setOrganization("none");
		employee.setSalary(new BigDecimal("3000"));

		// 转换为xml
		StringWriter sw = new StringWriter();
		// JAXB.marshal(hoge, System.out);
		JAXB.marshal(employee, sw);
		String xml = sw.toString();
		System.out.println(xml);

		System.out.println("---------------------");

		// 从xml转换为Java对象
		Employee obj = JAXB.unmarshal(new StringReader(xml), Employee.class);
		System.out.println(obj);
	}

	public static void main(String[] args) throws Exception {
		JAXBMain main = new JAXBMain();
		main.runSample();
	}

}
