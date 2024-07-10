package my.mavenbatsample.soap;

import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import org.springframework.ws.client.core.WebServiceMessageCallback;
import org.springframework.ws.client.core.support.WebServiceGatewaySupport;

// https://mico-2020jebyhu/eAdaptorSoapWebService.svc 的访问器
public class SoapCustConnector extends WebServiceGatewaySupport {

	// 默认URI
	public String getCustUri() {
		String uri = "https://mico-2020jebyhu/eAdaptorSoapWebService.svc";
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

	// 没有作用
	// public Wss4jSecurityInterceptor securityInterceptor() {
	// Wss4jSecurityInterceptor security = new Wss4jSecurityInterceptor();
	// security.setSecurementActions(WSHandlerConstants.USERNAME_TOKEN);
	// security.setSecurementPasswordType(WSConstants.PW_DIGEST);
	// security.setSecurementUsername("abc");
	// security.setSecurementPassword("efg");
	// return security;
	// }

	public Jaxb2Marshaller getCustMarshaller() {
		Jaxb2Marshaller marshaller = new Jaxb2Marshaller();
		// 写Ping的包名
		marshaller.setContextPath("com.cargowise.ehub._2010._06");
		// marshaller.setClassesToBeBound(new Class[] {
		// com.cargowise.ehub._2010._06.Ping.class,
		// com.cargowise.ehub._2010._06.PingResponse.class,
		// });
		// marshaller.setPackagesToScan("com.cargowise.ehub._2010._06");
		return marshaller;
	}
}
