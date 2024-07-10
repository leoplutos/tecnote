package my.mavenbatsample.soap;

import java.io.IOException;
import javax.xml.transform.TransformerException;
import org.springframework.ws.WebServiceMessage;
import org.springframework.ws.client.core.WebServiceMessageCallback;
import org.springframework.ws.soap.saaj.SaajSoapMessage;
import jakarta.xml.soap.Name;
import jakarta.xml.soap.SOAPElement;
import jakarta.xml.soap.SOAPEnvelope;
import jakarta.xml.soap.SOAPHeader;
import jakarta.xml.soap.SOAPHeaderElement;
import jakarta.xml.soap.SOAPMessage;
import jakarta.xml.soap.SOAPPart;

// 设定请求头
public class CustMessageCallback implements WebServiceMessageCallback {

	private String soapAction;
	private String username;
	private String password;

	public CustMessageCallback(String soapAction, String username, String password) {
		this.soapAction = soapAction;
		this.username = username;
		this.password = password;
	}

	// 设定请求头信息
	@Override
	public void doWithMessage(WebServiceMessage webServiceMessage) throws IOException, TransformerException {
		try {
			SaajSoapMessage saajSoapMessage = (SaajSoapMessage) webServiceMessage;
			// 设定 SOAPAction
			// SOAPAction: "http://CargoWise.com/eHub/2010/06/eAdapterStreamedService/Ping"
			saajSoapMessage.setSoapAction(this.soapAction);
			// 创建一个SOAP消息
			SOAPMessage soapMessage = saajSoapMessage.getSaajMessage();
			// 获取SOAP消息的SOAP部分
			SOAPPart soapPart = soapMessage.getSOAPPart();
			// 创建一个SOAP信封
			SOAPEnvelope soapEnvelope = soapPart.getEnvelope();
			SOAPHeader soapHeader = soapEnvelope.getHeader();
			// 设定 <wsse:Security>
			Name headerElementName = soapEnvelope.createName(
					"Security",
					"wsse",
					"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd");
			SOAPHeaderElement soapHeaderElement = soapHeader
					.addHeaderElement(headerElementName);
			// 设定 <wsse:UsernameToken>
			SOAPElement usernameTokenSOAPElement = soapHeaderElement
					.addChildElement("UsernameToken", "wsse");
			// 设定 Username
			SOAPElement userNameSOAPElement = usernameTokenSOAPElement.addChildElement(
					"Username",
					"wsse");
			userNameSOAPElement.addTextNode(this.username);
			// 设定 Password
			SOAPElement passwordSOAPElement = usernameTokenSOAPElement.addChildElement(
					"Password",
					"wsse");
			passwordSOAPElement.addTextNode(this.password);
			soapMessage.saveChanges();
			webServiceMessage.writeTo(System.out);
			System.out.flush();
			System.out.println("");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
