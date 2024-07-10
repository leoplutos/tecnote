package my.mavenbatsample;

import java.text.MessageFormat;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import my.mavenbatsample.http.TrustAllCertsX509TrustManager;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class SoapPingMain {

	// 这是一个访问 https://localhost/eAdaptorSoapWebService.svc 的示例
	// 使用 OkHttp 作为客户端
	// 不需要wsdl
	protected void runSample() throws Exception {

		String url = "https://localhost/eAdaptorSoapWebService.svc";

		// 设定request
		String requestBodyTemplate = """
				<soapenv:Envelope xmlns:ns="http://CargoWise.com/eHub/2010/06"
					xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
					<soapenv:Header>
						<wsse:Security soapenv:mustUnderstand="1"
							xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"
							xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
							<wsse:UsernameToken wsu:Id="UsernameToken-B13C6AE1A37D2625C717193200477081">
								<wsse:Username>{0}</wsse:Username>
								<wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">{1}</wsse:Password>
								<wsse:Nonce EncodingType="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary">O14gYliESniDSKfN+CzvkQ==</wsse:Nonce>
								<wsu:Created>2024-06-25T12:54:07.707Z</wsu:Created>
							</wsse:UsernameToken>
						</wsse:Security>
					</soapenv:Header>
					<soapenv:Body>
						<ns:Ping/>
					</soapenv:Body>
				</soapenv:Envelope>
				""";
		String requestBodyStr = MessageFormat.format(requestBodyTemplate, "abc", "pwd");
		MediaType mediaType = MediaType.parse("text/xml");
		RequestBody requestBody = RequestBody.create(requestBodyStr, mediaType);
		Request request = new Request.Builder()
				.url(url)
				.post(requestBody)
				.addHeader("SOAPAction", "http://CargoWise.com/eHub/2010/06/eAdapterStreamedService/Ping")
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

		// 发送http请求（同步）
		Response response = client.newCall(request).execute();
		if (response.isSuccessful()) {
			String xmlResult = response.body().string();
			System.out.println("SOAP请求成功,返回内容为: " + xmlResult);
		} else {
			System.out.println("SOAP请求失败,HTTP状态码为: " + response.code());
		}
	}

	public SSLSocketFactory createSocketFactory(TrustAllCertsX509TrustManager trustManager) throws Exception {
		SSLContext sslContext = SSLContext.getInstance("SSL");
		sslContext.init(null, new TrustManager[] { trustManager }, new java.security.SecureRandom());
		return sslContext.getSocketFactory();
	}

	public static void main(String[] args) throws Exception {
		SoapPingMain main = new SoapPingMain();
		main.runSample();
	}

}
