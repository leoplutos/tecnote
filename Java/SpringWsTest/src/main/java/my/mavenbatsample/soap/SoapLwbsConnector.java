package my.mavenbatsample.soap;

import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import org.springframework.ws.client.core.WebServiceMessageCallback;
import org.springframework.ws.client.core.support.WebServiceGatewaySupport;

// https://apps.learnwebservices.com/services/hello 的访问器
public class SoapLwbsConnector extends WebServiceGatewaySupport {

	// 默认URI
	public String getLwbsUri() {
		String uri = "https://apps.learnwebservices.com/services/hello";
		return uri;
	}

	public Object callWebService(Object request) {
		return getWebServiceTemplate().marshalSendAndReceive(request);
	}

	public Object callWebService(String url, Object request) {
		return getWebServiceTemplate().marshalSendAndReceive(url, request);
	}

	public Object callWebService(String url, Object request, WebServiceMessageCallback requestCallback) {
		return getWebServiceTemplate().marshalSendAndReceive(url, request, requestCallback);
	}

	public Object callWebService(Object request, WebServiceMessageCallback requestCallback) {
		return getWebServiceTemplate().marshalSendAndReceive(request, requestCallback);
	}

	public Jaxb2Marshaller getLwbsMarshaller() {
		Jaxb2Marshaller marshaller = new Jaxb2Marshaller();
		// 写HelloRequest的包名
		marshaller.setContextPath("com.learnwebservices.services.hello");
		return marshaller;
	}
}
