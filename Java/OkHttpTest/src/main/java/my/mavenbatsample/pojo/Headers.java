package my.mavenbatsample.pojo;

import com.squareup.moshi.Json;

public class Headers {

	@Json(name = "Accept-Encoding")
	private String acceptEncoding;

	@Json(name = "Content-Length")
	private String contentLength;

	@Json(name = "Content-Type")
	private String contentType;

	@Json(name = "Host")
	private String host;

	@Json(name = "User-Agent")
	private String userAgent;

	@Json(name = "X-Amzn-Trace-Id")
	private String xAmznTraceId;

	public Headers() {
	}

	public String getAcceptEncoding() {
		return acceptEncoding;
	}

	public void setAcceptEncoding(String acceptEncoding) {
		this.acceptEncoding = acceptEncoding;
	}

	public String getContentLength() {
		return contentLength;
	}

	public void setContentLength(String contentLength) {
		this.contentLength = contentLength;
	}

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getUserAgent() {
		return userAgent;
	}

	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}

	public String getxAmznTraceId() {
		return xAmznTraceId;
	}

	public void setxAmznTraceId(String xAmznTraceId) {
		this.xAmznTraceId = xAmznTraceId;
	}

	@Override
	public String toString() {
		return "Headers [acceptEncoding=" + acceptEncoding + ", contentLength=" + contentLength + ", contentType="
				+ contentType + ", host=" + host + ", userAgent=" + userAgent + ", xAmznTraceId=" + xAmznTraceId + "]";
	}
}
