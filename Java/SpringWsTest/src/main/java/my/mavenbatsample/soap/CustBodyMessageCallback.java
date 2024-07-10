package my.mavenbatsample.soap;

import java.io.IOException;

import javax.xml.namespace.QName;
import javax.xml.transform.TransformerException;
import org.springframework.ws.WebServiceMessage;
import org.springframework.ws.client.core.WebServiceMessageCallback;
import org.springframework.ws.soap.saaj.SaajSoapMessage;
import jakarta.xml.soap.Name;
import jakarta.xml.soap.SOAPBody;
import jakarta.xml.soap.SOAPBodyElement;
import jakarta.xml.soap.SOAPElement;
import jakarta.xml.soap.SOAPEnvelope;
import jakarta.xml.soap.SOAPHeader;
import jakarta.xml.soap.SOAPHeaderElement;
import jakarta.xml.soap.SOAPMessage;
import jakarta.xml.soap.SOAPPart;
import my.mavenbatsample.util.StreamUtil;

// 设定请求头
public class CustBodyMessageCallback implements WebServiceMessageCallback {

	private String soapAction;
	private String username;
	private String password;
	private String applicationCode;
	private String clientID;
	private String trackingID;
	private String schemaName;
	private String schemaType;
	private String emailSubject;
	private String fileName;
	private String message;

	public CustBodyMessageCallback(String soapAction, String username, String password, String applicationCode,
			String clientID, String trackingID, String schemaName, String schemaType, String emailSubject,
			String fileName, String message) {
		this.soapAction = soapAction;
		this.username = username;
		this.password = password;
		this.applicationCode = applicationCode;
		this.clientID = clientID;
		this.trackingID = trackingID;
		this.schemaName = schemaName;
		this.schemaType = schemaType;
		this.emailSubject = emailSubject;
		this.fileName = fileName;
		this.message = message;
	}

	// 自定义请求头和Body信息
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

			// 设定Body
			SOAPBody soapBody = soapEnvelope.getBody();
			// 把默认的节点都删除
			soapBody.removeChild(soapBody.getFirstChild());
			// 设定 <ns:SendStreamRequest>
			Name sendStreamRequest = soapEnvelope.createName(
					"SendStreamRequest",
					"ns",
					"http://CargoWise.com/eHub/2010/06");
			SOAPBodyElement sendStreamElement = soapBody
					.addBodyElement(sendStreamRequest);
			// 设定 Payload
			SOAPElement payloadElement = sendStreamElement.addChildElement("Payload", "ns");
			// 设定 Message
			SOAPElement messageElement = payloadElement.addChildElement("Message", "ns");
			messageElement.addAttribute(new QName("ApplicationCode"), this.applicationCode);
			messageElement.addAttribute(new QName("ClientID"), this.clientID);
			messageElement.addAttribute(new QName("TrackingID"), this.trackingID);
			messageElement.addAttribute(new QName("SchemaName"), this.schemaName);
			messageElement.addAttribute(new QName("SchemaType"), this.schemaType);
			messageElement.addAttribute(new QName("EmailSubject"), this.emailSubject);
			messageElement.addAttribute(new QName("FileName"), this.fileName);
			// 将xml 内容 gzip压缩 + Base64编码
			String encodeStr = StreamUtil.compressAndEncode(this.message);
			messageElement.addTextNode(encodeStr);

			soapMessage.saveChanges();
			webServiceMessage.writeTo(System.out);
			System.out.flush();
			System.out.println("");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
