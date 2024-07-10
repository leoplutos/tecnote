package my.mavenbatsample;

import java.io.IOException;
import java.io.StringWriter;
import java.util.UUID;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import org.oasis_open.docs.wss._2004._01.oasis_200401_wss_wssecurity_secext_1_0.Security;
import org.xmlsoap.schemas.soap.envelope.Envelope;
import com.cargowise.ehub._2010._06.SendStreamRequest;
import jakarta.xml.bind.JAXB;
import my.mavenbatsample.http.TrustAllCertsX509TrustManager;
import my.mavenbatsample.util.StreamUtil;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.Headers;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.ResponseBody;

public class SoapSendStreamMain {

	// 这是一个访问 https://localhost/eAdaptorSoapWebService.svc 的示例
	// 使用 OkHttp 作为客户端
	// 不需要wsdl
	protected void runSample() throws Exception {

		System.out.println("runSample Start");

		String url = "https://localhost/eAdaptorSoapWebService.svc";

		String applicationCode = "UDM";
		String clientID = "WTGCWISYD";
		UUID uuid = UUID.randomUUID();
		// String trackingIDStr = "5c2643ed-6ae7-4cbe-bf35-8db3c875aea2";
		String trackingID = uuid.toString();
		String schemaName = "http://www.cargowise.com/Schemas/Universal/2011/11#UniversalInterchange";
		String schemaType = "Xml";
		String emailSubject = "fromJavaClient";
		String fileName = "fromOkHttp";
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
		// 将xml 内容 gzip压缩 + Base64编码
		String encodeStr = StreamUtil.compressAndEncode(messageStr);

		// 设定request
		// String requestBodyTemplate = """
		// <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
		// xmlns:ns="http://CargoWise.com/eHub/2010/06"
		// xmlns:car="http://schemas.datacontract.org/2004/07/CargoWise.eHub.Common"
		// xmlns:sys="http://schemas.datacontract.org/2004/07/System">
		// <soapenv:Header>
		// <wsse:Security soapenv:mustUnderstand="1"
		// xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"
		// xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
		// <wsse:UsernameToken wsu:Id="UsernameToken-B13C6AE1A37D2625C717193200477081">
		// <wsse:Username>{0}</wsse:Username>
		// <wsse:Password
		// Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">{1}</wsse:Password>
		// <wsse:Nonce
		// EncodingType="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary">O14gYliESniDSKfN+CzvkQ==</wsse:Nonce>
		// <wsu:Created>2024-06-25T12:54:07.707Z</wsu:Created>
		// </wsse:UsernameToken>
		// </wsse:Security>
		// </soapenv:Header>
		// <soapenv:Body>
		// <ns:SendStreamRequest>
		// <Payload>
		// <Message
		// ApplicationCode="{2}"
		// ClientID="{3}"
		// TrackingID="{4}"
		// SchemaName="{5}"
		// SchemaType="{6}"
		// EmailSubject="{7}"
		// FileName="{8}">{9}</Message>
		// </Payload>
		// </ns:SendStreamRequest>
		// </soapenv:Body>
		// </soapenv:Envelope>
		// """;

		// String requestBodyStr = MessageFormat.format(requestBodyTemplate, "abc",
		// "pwd", applicationCode, clientID,
		// trackingID, schemaName, schemaType, emailSubject, fileName, encodeStr);

		// 不使用字符串而使用[SendStream.xsd]生成的java代码来制作请求信息
		org.xmlsoap.schemas.soap.envelope.ObjectFactory soapenvFactory = new org.xmlsoap.schemas.soap.envelope.ObjectFactory();
		// 请求头
		Envelope.Header soapHeader = soapenvFactory.createEnvelopeHeader();
		// 请求头内的认证部分
		org.oasis_open.docs.wss._2004._01.oasis_200401_wss_wssecurity_secext_1_0.ObjectFactory securityFactory = new org.oasis_open.docs.wss._2004._01.oasis_200401_wss_wssecurity_secext_1_0.ObjectFactory();
		Security.UsernameToken token = securityFactory.createSecurityUsernameToken();
		token.setUsername("abc");
		token.setPassword("pwd");
		Security security = securityFactory.createSecurity();
		security.setUsernameToken(token);
		soapHeader.setSecurity(security);
		// 请求体
		Envelope.Body soapBody = soapenvFactory.createEnvelopeBody();
		// 请求详细
		com.cargowise.ehub._2010._06.ObjectFactory sendFactory = new com.cargowise.ehub._2010._06.ObjectFactory();
		SendStreamRequest.Payload.Message message = sendFactory.createSendStreamRequestPayloadMessage();
		message.setApplicationCode(applicationCode);
		message.setClientID(clientID);
		message.setTrackingID(trackingID);
		message.setSchemaName(schemaName);
		message.setSchemaType(schemaType);
		message.setEmailSubject(emailSubject);
		message.setFileName(fileName);
		message.setValue(encodeStr);
		SendStreamRequest.Payload payload = sendFactory.createSendStreamRequestPayload();
		payload.setMessage(message);
		SendStreamRequest sendStreamRequest = sendFactory.createSendStreamRequest();
		sendStreamRequest.setPayload(payload);
		soapBody.setSendStreamRequest(sendStreamRequest);
		// 最终请求
		Envelope envelope = soapenvFactory.createEnvelope();
		envelope.setHeader(soapHeader);
		envelope.setBody(soapBody);
		// 转换为xml
		StringWriter sw = new StringWriter();
		// JAXB.marshal(hoge, System.out);
		JAXB.marshal(envelope, sw);
		String requestBodyStr = sw.toString();
		System.out.println(requestBodyStr);
		System.out.println("---------------------");

		MediaType mediaType = MediaType.parse("text/xml");
		RequestBody requestBody = RequestBody.create(requestBodyStr, mediaType);
		Request request = new Request.Builder()
				.url(url)
				.post(requestBody)
				.addHeader("SOAPAction", "http://CargoWise.com/eHub/2010/06/eAdapterStreamedService/SendStream")
				.addHeader("Content-Type", "application/xml; charset=utf-8")
				.build();

		// SSL证书
		TrustAllCertsX509TrustManager trustManager = new TrustAllCertsX509TrustManager();
		SSLSocketFactory sslSocketFactory = createSocketFactory(trustManager);

		// http客户端
		OkHttpClient.Builder builder = new OkHttpClient.Builder();
		builder.sslSocketFactory(sslSocketFactory, trustManager);
		// 如果你需要，也可以设置hostnameVerifier，比如信任所有hostname
		builder.hostnameVerifier((hostname, session) -> true);
		OkHttpClient client = builder.build();

		// 发送http请求（异步）
		client.newCall(request).enqueue(new Callback() {
			@Override
			public void onFailure(Call call, IOException e) {
				e.printStackTrace();
			}

			@Override
			public void onResponse(Call call, Response response) throws IOException {
				try (ResponseBody responseBody = response.body()) {
					if (!response.isSuccessful()) {
						throw new IOException("Unexpected code " + response);
					}

					Headers responseHeaders = response.headers();
					for (int i = 0, size = responseHeaders.size(); i < size; i++) {
						System.out.println(responseHeaders.name(i) + ": " + responseHeaders.value(i));
					}
					String responseBodyString = response.body().string();
					System.out.println(responseBodyString);

					// OkHttp的线程是一直在Dispatcher中直接控制，如果线程和连接保持空闲状态，它们将被自动释放。
					// 这个示例程序为了让主线程马上停止，所以积极释放了线程池，请根据需要选择
					client.dispatcher().executorService().shutdown();
				}
			}
		});

		System.out.println("runSample End");
	}

	public SSLSocketFactory createSocketFactory(TrustAllCertsX509TrustManager trustManager) throws Exception {
		SSLContext sslContext = SSLContext.getInstance("SSL");
		sslContext.init(null, new TrustManager[] { trustManager }, new java.security.SecureRandom());
		return sslContext.getSocketFactory();
	}

	public static void main(String[] args) throws Exception {
		SoapSendStreamMain main = new SoapSendStreamMain();
		main.runSample();
	}

}
