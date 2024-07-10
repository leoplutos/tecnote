package my.mavenbatsample;

import javax.net.ssl.TrustManager;
import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import org.springframework.ws.transport.http.HttpsUrlConnectionMessageSender;
import com.cargowise.ehub._2010._06.ObjectFactory;
import com.cargowise.ehub._2010._06.Ping;
import com.cargowise.ehub._2010._06.PingResponse;
import my.mavenbatsample.soap.CustMessageCallback;
import my.mavenbatsample.soap.SoapCustConnector;
import my.mavenbatsample.soap.UnTrustworthyTrustManager;

// 这是一个访问 https://mico-2020jebyhu/eAdaptorSoapWebService.svc 的示例
// 使用 spring-ws 作为客户端
// 需要下载wsdl文件放到 /src/main/resources/wsdl
public class PingMain {

	public static void main(String[] args) {
		// 创建Soap访问器
		SoapCustConnector client = new SoapCustConnector();
		client.setDefaultUri(client.getCustUri());
		Jaxb2Marshaller marshaller = client.getCustMarshaller();
		client.setMarshaller(marshaller);
		client.setUnmarshaller(marshaller);
		// client.setInterceptors(new ClientInterceptor[] { client.securityInterceptor()
		// });

		// SSL证书
		HttpsUrlConnectionMessageSender sender = new HttpsUrlConnectionMessageSender();
		sender.setTrustManagers(new TrustManager[] { new UnTrustworthyTrustManager() });
		client.setMessageSender(sender);

		// 设定request
		ObjectFactory factory = new ObjectFactory();
		Ping ping = factory.createPing();

		// 设定请求头信息
		String soapAction = "http://CargoWise.com/eHub/2010/06/eAdapterStreamedService/Ping";
		String username = "aaa";
		String password = "bbb";
		// 设定请求头
		CustMessageCallback callback = new CustMessageCallback(soapAction, username, password);

		// 进行Soap通信
		PingResponse response = (PingResponse) client.callWebService(ping, callback);

		System.out.println("PingResponse: " + response.isPingResult());
	}

}
