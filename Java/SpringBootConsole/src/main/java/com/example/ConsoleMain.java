package com.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.example.service.PostgreBaseService;
import com.example.service.PostgreJdbcClientService;
import com.example.service.PostgreJpaService;

// 这是一个基于SpringBoot的控制台程序
@SpringBootApplication
public class ConsoleMain implements CommandLineRunner {
	// logback日志
	protected static final Logger log = LoggerFactory.getLogger(ConsoleMain.class);

	@Autowired
	private PostgreBaseService baseService;

	@Autowired
	private PostgreJpaService jpaService;

	@Autowired
	private PostgreJdbcClientService jdbcClientService;

	public static void main(String[] args) {
		SpringApplication.run(ConsoleMain.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		log.info("开始运行PostgreBaseService, 基于JDBC");
		baseService.run();
		log.info("===================");
		log.info("开始运行PostgreJpaService, 基于Spring Data JPA");
		jpaService.run();
		log.info("===================");
		log.info("开始运行PostgreJdbcClientService, 基于Spring JdbcClient");
		jdbcClientService.run();
	}
}
