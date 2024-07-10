package my.mavenbatsample.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

public class StreamUtil {

	// gzip压缩
	public static byte[] compress(String targetStr) throws IOException {
		if (targetStr == null || targetStr.length() == 0) {
			return new byte[0];
		}
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try (GZIPOutputStream gzos = new GZIPOutputStream(baos)) {
			gzos.write(targetStr.getBytes(StandardCharsets.UTF_8)); // 假设字符串是UTF-8编码
		}
		return baos.toByteArray();
	}

	// Base64编码
	public static String encode(byte[] targetBytes) {
		String encodedString = Base64.getEncoder().encodeToString(targetBytes);
		return encodedString;
	}

	// gzip压缩 + Base64编码
	public static String compressAndEncode(String targetStr) throws IOException {
		byte[] targetBytes = compress(targetStr);
		String encodedString = encode(targetBytes);
		return encodedString;
	}

	// gzip解压缩
	public static String decompress(byte[] targetBytes) throws IOException {
		if (targetBytes == null || targetBytes.length == 0) {
			return "";
		}

		// 使用ByteArrayInputStream包装gzippedBytes
		ByteArrayInputStream bais = new ByteArrayInputStream(targetBytes);
		// 使用GZIPInputStream来读取gzip格式的输入流
		GZIPInputStream gzis = new GZIPInputStream(bais);

		// 创建一个ByteArrayOutputStream来存储解压后的字节
		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		// 读取并解压gzip输入流，将解压后的字节写入baos
		byte[] buffer = new byte[1024];
		int len;
		while ((len = gzis.read(buffer)) > 0) {
			baos.write(buffer, 0, len);
		}

		// 关闭资源
		gzis.close();
		baos.close();

		// 将ByteArrayOutputStream转换为字符串（这里假设原始字符串是UTF-8编码）
		return baos.toString(StandardCharsets.UTF_8);
	}

	// Base64解码
	public static byte[] decode(String targetStr) {
		byte[] decodedBytes = Base64.getDecoder().decode(targetStr);
		return decodedBytes;
	}

	// Base64解码 + gzip解压缩
	public static String decompressAndDecode(String targetStr) throws IOException {
		byte[] decodedBytes = decode(targetStr);
		String resultString = decompress(decodedBytes);
		return resultString;
	}
}
