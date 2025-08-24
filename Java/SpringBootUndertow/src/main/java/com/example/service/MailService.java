package com.example.service;

/**
 * メール送信 サービスインターフェース
 */
public interface MailService {

	public void sendSimpleMail(String from, String to, String subject, String text);
}
