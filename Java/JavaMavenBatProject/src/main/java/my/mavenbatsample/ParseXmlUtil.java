package my.mavenbatsample;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.ErrorHandler;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.io.StringReader;

/**
 */
public class ParseXmlUtil {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// 查询价格大于80的书的标题的内容
	private static final String XPath_EXPRESSION = "//book[price>80]/title/text()";

	public static void main(String[] args) {

		try {
			DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
			// 开启验证：
			documentBuilderFactory.setValidating(true);
			documentBuilderFactory.setNamespaceAware(false);
			documentBuilderFactory.setIgnoringComments(true);
			documentBuilderFactory.setIgnoringElementContentWhitespace(true);
			documentBuilderFactory.setCoalescing(false);
			documentBuilderFactory.setExpandEntityReferences(true);
			DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
			// 设置异常处理：
			documentBuilder.setErrorHandler(new ErrorHandler() {
				@Override
				public void warning(SAXParseException exception) throws SAXException {
					System.out.println("warn:" + exception.getMessage());
				}

				@Override
				public void error(SAXParseException exception) throws SAXException {
					System.out.println("error:" + exception.getMessage());
				}

				@Override
				public void fatalError(SAXParseException exception) throws SAXException {
					System.out.println("fatalError:" + exception.getMessage());
				}
			});
			// 将inventory.xml加载到一个Document的对象中：
			// 方式1:读取绝对路径
			// String filePath = "D:\\src\\main\\resources\\inventory.xml";
			// Document document = documentBuilder.parse(new File(filePath));
			// 方式2:读取相对路径
			// InputStream in = ParseXmlUtil.class.getResourceAsStream("/inventory.xml");
			// Document document = documentBuilder.parse(in);
			// 方式3:读取XML字符串
			String xmlString = """
					<?xml version="1.0" encoding="UTF-8" ?>
					<!DOCTYPE inventory [
						<!ELEMENT inventory (book+)>
						<!ELEMENT book (title,author,dynasty,price)>
						<!ATTLIST book year CDATA #REQUIRED>
						<!ELEMENT title (#PCDATA)>
						<!ELEMENT author (#PCDATA)>
						<!ELEMENT dynasty (#PCDATA)>
						<!ELEMENT price (#PCDATA)>
					]>
					<inventory>
						<book year="2012">
							<title>菜根谭</title>
							<author>洪应明</author>
							<dynasty>明朝</dynasty>
							<price>38</price>
						</book>
						<book year="2013">
							<title>曾国藩家书</title>
							<author>曾国藩</author>
							<dynasty>清朝</dynasty>
							<price>70</price>
						</book>
						<book year="2014">
							<title>高等代数</title>
							<author>丘维声</author>
							<dynasty>中华人民共和国</dynasty>
							<price>86</price>
						</book>
					</inventory>
						""";
			Document document = documentBuilder.parse(new InputSource(new StringReader(xmlString)));

			// 根据表达式查询内容
			processParseXmlWithXpath(document, XPath_EXPRESSION);
		} catch (Exception e) {
			log.error(e);
		} finally {
			// 因为使用了异步日志，要在这里关闭
			LogManager.shutdown();
		}
	}

	private static void processParseXmlWithXpath(Document document, String xPathExpression) throws Exception {
		// 表达式可以参考：https://blog.csdn.net/zlj_blog/article/details/54092534
		xPathExpression = "/inventory/book/title";
		// 创建XPathFactory:
		XPathFactory xPathFactory = XPathFactory.newInstance();
		XPath xPath = xPathFactory.newXPath();
		NodeList nodeList = (NodeList) xPath.evaluate(xPathExpression, document, XPathConstants.NODESET);
		for (int i = 0; i < nodeList.getLength(); i++) {
			Node item = nodeList.item(i);
			System.out.println(item.getNodeName() + "=" + item.getTextContent());
		}
	}

	private static void processParseXmlWithXpathExpress(Document document, String xPathExpression) throws Exception {
		// 创建XPathFactory:
		XPathFactory xPathFactory = XPathFactory.newInstance();
		XPath xPath = xPathFactory.newXPath();
		XPathExpression expression = xPath.compile(xPathExpression);
		Object result = expression.evaluate(document, XPathConstants.NODESET);
		if (result instanceof NodeList) {
			NodeList nodes = (NodeList) result;
			for (int i = 0; i < nodes.getLength(); i++) {
				System.out.println(String.format("%s=%s", nodes.item(i).getNodeName(), nodes.item(i).getNodeValue()));
			}
		}
	}
}
