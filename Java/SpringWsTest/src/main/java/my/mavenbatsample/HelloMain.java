package my.mavenbatsample;

import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import com.learnwebservices.services.hello.HelloRequest;
import com.learnwebservices.services.hello.HelloResponse;
import com.learnwebservices.services.hello.ObjectFactory;
import jakarta.xml.bind.JAXBElement;
import my.mavenbatsample.soap.SoapLwbsConnector;

public class HelloMain {

	// 这是一个访问 https://apps.learnwebservices.com/services/hello 的示例
	// 使用 spring-ws 作为客户端
	// 需要下载wsdl文件放到 /src/main/resources/wsdl
	public static void main(String[] args) {
		// 创建Soap访问器
		SoapLwbsConnector client = new SoapLwbsConnector();
		client.setDefaultUri(client.getLwbsUri());
		Jaxb2Marshaller marshaller = client.getLwbsMarshaller();
		client.setMarshaller(marshaller);
		client.setUnmarshaller(marshaller);

		// 设定request
		HelloRequest helloRequest = new HelloRequest();
		helloRequest.setName("闷得蜜abc");

		// 进行Soap通信
		@SuppressWarnings("unchecked")
		JAXBElement<HelloResponse> response = (JAXBElement<HelloResponse>) client
				.callWebService(new ObjectFactory().createHelloRequest(helloRequest));

		System.out.println("HelloResponse: " + response.getValue().getMessage());
	}
}
