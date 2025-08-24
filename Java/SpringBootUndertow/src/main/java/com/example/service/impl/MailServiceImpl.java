package com.example.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import com.example.service.MailService;

/**
 * メール送信 サービス実装クラス
 */
@Service
public class MailServiceImpl implements MailService {

	@Autowired
	private JavaMailSender mailSender;

	/**
	 * メール送信
	 */
	@Override
	public void sendSimpleMail(String from, String to, String subject, String text) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom(from); // 送信者（From）
		message.setTo(to); // 受信者（To）
		message.setSubject(subject); // 件名
		message.setText(text); // 送信内容
		mailSender.send(message);
	}
}
