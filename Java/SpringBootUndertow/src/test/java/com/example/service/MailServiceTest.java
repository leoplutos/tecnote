package com.example.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class MailServiceTest {

	@Autowired
	private MailService mailService;

	@Test
	void testSendSimpleMail() {
		// 要运行这个需要
		// docker run -d -p 9580:1080 -p 1025:1025 --name maildev maildev/maildev
		mailService.sendSimpleMail(
				"from@example.com",
				"user@example.com",
				"测试普通邮件",
				"这是一封单元测试发送的普通文本邮件");
	}

}
