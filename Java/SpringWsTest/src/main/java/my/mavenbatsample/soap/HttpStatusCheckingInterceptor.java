package my.mavenbatsample.soap;

import org.springframework.ws.client.WebServiceClientException;
import org.springframework.ws.client.support.interceptor.ClientInterceptor;
import org.springframework.ws.context.MessageContext;

public class HttpStatusCheckingInterceptor implements ClientInterceptor {

	@Override
	public void afterCompletion(MessageContext messageContext, Exception ex) throws WebServiceClientException {
		// 清理资源
	}

	@Override
	public boolean handleFault(MessageContext messageContext) throws WebServiceClientException {
		// 处理错误情况
		System.out.println("ERROR!!!");
		return true;
	}

	@Override
	public boolean handleRequest(MessageContext messageContext) throws WebServiceClientException {
		// 在这里可以处理请求，但通常不需要处理HTTP状态码
		return true;
	}

	@Override
	public boolean handleResponse(MessageContext messageContext) throws WebServiceClientException {
		// 检查HTTP状态码
		// 注意：这取决于你如何配置WebServiceTemplate的底层HTTP客户端
		// 对于HttpURLConnection，你可能需要自定义WebServiceMessageCallback
		// 或者，如果你使用的是其他HTTP客户端（如Apache HttpClient），你可能需要不同的方法
		return true;
	}

}
