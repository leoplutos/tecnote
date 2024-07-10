package my.mavenbatsample.util;

import java.io.IOException;

import org.junit.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class StreamUtilTest extends TestCase {

	public StreamUtilTest(String testName) {
		super(testName);
	}

	public static junit.framework.Test suite() {
		return new TestSuite(StreamUtilTest.class);
	}

	@Test
	public void testCompressAndEncode() {
		String targetStr = "你好";
		String result = null;
		try {
			result = StreamUtil.compressAndEncode(targetStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
		assertEquals("H4sIAAAAAAAA/3uyd8HTpXsBQbiiUAYAAAA=", result);
	}

	@Test
	public void testDecompressAndDecode() {
		String targetStr = "H4sIAAAAAAAEAHuyd8HTpXsBQbiiUAYAAAA=";
		String result = null;
		try {
			result = StreamUtil.decompressAndDecode(targetStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
		assertEquals("你好", result);
	}

}
