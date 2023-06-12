package my.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

//按F5开始调试
//http://localhost:8081/JavaWebProject/HelloServlet
@WebServlet(name = "HelloServlet", urlPatterns = { "/HelloServlet" })
// @WebInitParam 该注解通常不单独使用，而是配合 @WebServlet 或者 @WebFilter 使用。它的作用是为 Servlet
// 或者过滤器指定初始化参数，这等价于 web.xml 中 <servlet> 和 <filter> 的 <init-param> 子标签。
// @WebFilter 用于将一个类声明为过滤器
// @WebListener 用于将类声明为监听器
// @MultipartConfig 提供的对上传文件的支持，该注解标注在 Servlet 上面，以表示该 Servlet 希望处理的请求的 MIME 类型是
// multipart/form-data。
public class HelloServlet extends HttpServlet {

	protected final Logger log = Logger.getLogger(this.getClass());

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("HelloServlet is start");
		log.debug("Hello!こんにちは!你好!안녕하세요!");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<html><head></head><body>");
		out.println("<p>JavaWebProject</p>");
		out.println("<p>HelloServlet!</p>");
		out.println("</body></html>");
		log.debug("HelloServlet is end");
	}
}