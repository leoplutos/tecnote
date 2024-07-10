package my.mavenbatsample;

import com.squareup.moshi.JsonAdapter;
import com.squareup.moshi.Moshi;

import my.mavenbatsample.pojo.HttpBinResponse;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class HttpJsonPostMain {

	// 这是一个访问 https://httpbin.org/post 的示例
	// 使用 OkHttp 作为客户端
	// 使用 Moshi 进行 POJO 和 json 的转换
	// 使用 VSCode 的 [json to java] 插件，进行制作Java POJO
	protected void runSample() throws Exception {

		String url = "https://httpbin.org/post";

		// 设定request
		String requestBodyStr = """
				{
					"param1": "张三"
				}
					""";
		MediaType mediaType = MediaType.parse("application/json; charset=utf-8");
		RequestBody requestBody = RequestBody.create(requestBodyStr, mediaType);
		Request request = new Request.Builder()
				.url(url)
				.post(requestBody)
				.build();

		// http客户端
		OkHttpClient client = new OkHttpClient();
		// moshi转换数据
		Moshi moshi = new Moshi.Builder().build();
		JsonAdapter<HttpBinResponse> respJsonAdapter = moshi.adapter(HttpBinResponse.class);
		// 发送http请求（同步）
		Response response = client.newCall(request).execute();
		if (response.isSuccessful()) {
			String jsonResult = response.body().string();
			// 打印字符串
			System.out.println("HTTP请求成功,返回内容为: " + jsonResult);
			System.out.println("---------------------");
			// json -> POJO
			HttpBinResponse pojo = respJsonAdapter.fromJson(jsonResult);
			System.out.println("Java POJO内容 data: " + pojo.getData());
			System.out.println("Java POJO内容 headers: " + pojo.getHeaders().toString());
			System.out.println("Java POJO内容 origin: " + pojo.getOrigin());
			System.out.println("Java POJO内容 url: " + pojo.getUrl());
		} else {
			System.out.println("HTTP请求失败,HTTP状态码为: " + response.code());
		}
	}

	public static void main(String[] args) throws Exception {
		HttpJsonPostMain main = new HttpJsonPostMain();
		main.runSample();
	}
}
