package my.mavenbatsample;

import java.util.UUID;
import javax.net.ssl.TrustManager;
import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import org.springframework.ws.client.support.interceptor.ClientInterceptor;
import org.springframework.ws.transport.http.HttpsUrlConnectionMessageSender;
import com.cargowise.ehub._2010._06.ObjectFactory;
import com.cargowise.ehub._2010._06.SendStreamRequest;
import my.mavenbatsample.soap.CustBodyMessageCallback;
import my.mavenbatsample.soap.HttpStatusCheckingInterceptor;
import my.mavenbatsample.soap.SoapCustConnector;
import my.mavenbatsample.soap.UnTrustworthyTrustManager;

// 这是一个访问 https://mico-2020jebyhu/eAdaptorSoapWebService.svc 的示例
// 使用 spring-ws 作为客户端
// 需要下载wsdl文件放到 /src/main/resources/wsdl
public class SendStreamMain {
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

		// 拦截器
		ClientInterceptor[] interceptors = { new HttpStatusCheckingInterceptor() };
		client.setInterceptors(interceptors);

		// 设定request
		ObjectFactory factory = new ObjectFactory();
		SendStreamRequest request = factory.createSendStreamRequest();

		// 设定详细信息（不可用）
		String applicationCodeStr = "UDM";
		String clientIDStr = "WTGCWISYD";
		UUID uuid = UUID.randomUUID();
		// String trackingIDStr = "5c2643ed-6ae7-4cbe-bf35-8db3c875aea2";
		String trackingIDStr = uuid.toString();
		String schemaNameStr = "http://www.cargowise.com/Schemas/Universal/2011/11#UniversalInterchange";
		String schemaTypeStr = "Xml";
		String emailSubjectStr = "fromJavaClient";
		String fileNameStr = "fromSpringWS";
		String messageStr = """
				<UniversalEvent xmlns="http://www.cargowise.com/Schemas/Universal/2011/11" version="1.1">
				  <Event>
				    <DataContext>
				      <DataTargetCollection>
				        <DataTarget>
				          <Type>ForwardingShipment</Type>
				          <Key>这里有中文和日本語こんにちは</Key>
				        </DataTarget>
				      </DataTargetCollection>
				      <EnterpriseID>WTG</EnterpriseID>
				      <ServerID>SYD</ServerID>
				      <Company>
				        <Code>CWI</Code>
				      </Company>
				    </DataContext>
				    <EventTime>2020-06-09T12:32:12.42</EventTime>
				    <EventType>ATH</EventType>
				  </Event>
				</UniversalEvent>""";

		// EHubGatewayMessage eHubGatewayMessage = new EHubGatewayMessage();
		// JAXBElement<String> applicationCode = new JAXBElement<>(new QName("",
		// "ApplicationCode"), String.class,
		// applicationCodeStr);
		// eHubGatewayMessage.setApplicationCode(applicationCode);
		// JAXBElement<String> clientID = new JAXBElement<>(new QName("", "ClientID"),
		// String.class, clientIDStr);
		// eHubGatewayMessage.setClientID(clientID);
		// UUID uuid = UUID.randomUUID();
		// eHubGatewayMessage.setMessageTrackingID(uuid.toString());
		// JAXBElement<String> schemaName = new JAXBElement<>(new QName("",
		// "SchemaName"), String.class, schemaNameStr);
		// eHubGatewayMessage.setSchemaName(schemaName);
		// eHubGatewayMessage.setSchemaType(MessageSchemaType.XML);
		// JAXBElement<String> emailSubject = new JAXBElement<>(new QName("",
		// "EmailSubject"), String.class,
		// emailSubjectStr);
		// eHubGatewayMessage.setEmailSubject(emailSubject);
		// JAXBElement<String> fileName = new JAXBElement<>(new QName("", "FileName"),
		// String.class, fileNameStr);
		// eHubGatewayMessage.setFileName(fileName);
		// Stream messageStrStream = new Stream();
		// messageStrStream.withIdentity(messageStr);
		// JAXBElement<Stream> messageStream = new JAXBElement<>(new QName("",
		// "MessageStream"), Stream.class,
		// messageStrStream);
		// eHubGatewayMessage.setMessageStream(messageStream);

		// ArrayOfeHubGatewayMessage messageList = new ArrayOfeHubGatewayMessage();
		// messageList.withEHubGatewayMessage(eHubGatewayMessage);
		// JAXBElement<ArrayOfeHubGatewayMessage> payload = new JAXBElement<>(new
		// QName("", "Payload"),
		// ArrayOfeHubGatewayMessage.class, messageList);
		// request.setMessages(payload);

		// 设定请求头信息
		String soapAction = "http://CargoWise.com/eHub/2010/06/eAdapterStreamedService/SendStream";
		String username = "aaa";
		String password = "bbb";
		// 设定请求头和自定义Body
		CustBodyMessageCallback callback = new CustBodyMessageCallback(soapAction, username, password,
				applicationCodeStr, clientIDStr, trackingIDStr, schemaNameStr, schemaTypeStr, emailSubjectStr,
				fileNameStr, messageStr);

		// 进行Soap通信
		var response = client.callWebService(request, callback);

		System.out.println(response);
	}
}
