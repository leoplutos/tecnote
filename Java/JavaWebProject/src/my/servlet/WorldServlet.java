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
//http://localhost:8081/JavaWebProject/WorldServlet
@WebServlet(name = "WorldServlet", urlPatterns = { "/WorldServlet" })
public class WorldServlet extends HttpServlet {

	protected final Logger log = Logger.getLogger(this.getClass());

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("WorldServlet is start");
		log.debug("World!こんにちは!你好!안녕하세요!");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<html><head></head><body>");
		out.println("<p>JavaWebProject</p>");
		out.println("<p>WorldServlet!</p>");
		out.println("</body></html>");
		log.debug("WorldServlet is end");
	}
}