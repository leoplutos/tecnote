package my.mavenbatsample;

import java.text.MessageFormat;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class SoapHelloMain {

	// 这是一个访问 https://apps.learnwebservices.com/services/hello 的示例
	// 使用 OkHttp 作为客户端
	// 不需要wsdl
	protected void runSample() throws Exception {

		String url = "https://apps.learnwebservices.com/services/hello";

		// 设定request
		String requestBodyTemplate = """
				<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
					<soapenv:Header/>
					<soapenv:Body>
						<HelloRequest xmlns="http://learnwebservices.com/services/hello">
							<Name>{0}</Name>
						</HelloRequest>
					</soapenv:Body>
				</soapenv:Envelope>
								""";
		String requestBodyStr = MessageFormat.format(requestBodyTemplate, "我是闷Der密");
		MediaType mediaType = MediaType.parse("text/xml");
		RequestBody requestBody = RequestBody.create(requestBodyStr, mediaType);
		Request request = new Request.Builder()
				.url(url)
				.post(requestBody)
				.addHeader("Content-Type", "application/xml; charset=utf-8")
				.build();

		// http客户端
		OkHttpClient client = new OkHttpClient();
		// 发送http请求（同步）
		Response response = client.newCall(request).execute();
		if (response.isSuccessful()) {
			String xmlResult = response.body().string();
			System.out.println("SOAP请求成功,返回内容为: " + xmlResult);
		} else {
			System.out.println("SOAP请求失败,HTTP状态码为: " + response.code());
		}
	}

	public static void main(String[] args) throws Exception {
		SoapHelloMain main = new SoapHelloMain();
		main.runSample();
	}

}
