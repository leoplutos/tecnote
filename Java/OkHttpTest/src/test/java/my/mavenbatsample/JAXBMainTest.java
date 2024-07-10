package my.mavenbatsample;

import org.junit.Test;

import junit.framework.TestCase;
import junit.framework.TestSuite;

public class JAXBMainTest extends TestCase {

	public JAXBMainTest(String testName) {
		super(testName);
	}

	public static junit.framework.Test suite() {
		return new TestSuite(JAXBMainTest.class);
	}

	@Test
	public void testRunSample() {
		JAXBMain main = new JAXBMain();
		try {
			main.runSample();
			assertTrue("This case is OK", true);
		} catch (Exception e) {
			e.printStackTrace();
			assertFalse("This case is NG", false);
		}
	}
}
