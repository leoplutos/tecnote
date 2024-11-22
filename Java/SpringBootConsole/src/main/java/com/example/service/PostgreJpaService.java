package com.example.service;

import com.example.dao.Login;
import com.example.dao.LoginRepository;
import com.fasterxml.uuid.Generators;
import java.util.NoSuchElementException;
import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// Spring Data JPA 示例
@Service
public class PostgreJpaService {

	// 需要1:pom.xml添加依赖
	// <dependency>
	// <groupId>org.postgresql</groupId>
	// <artifactId>postgresql</artifactId>
	// <version>42.7.4</version>
	// </dependency>
	// 需要2: docker run -p 5432:5432 --name postgre
	// -v $HOME/workspace/postgre_data/data:/var/lib/postgresql/data
	// -e POSTGRES_PASSWORD=123456 -d postgres:17.1-alpine3.20
	// 需要3: 建表
	/*
	 * CREATE TABLE t_login (
	 * tl_pk UUID NOT NULL UNIQUE,
	 * login_id TEXT NOT NULL,
	 * login_pwd TEXT NOT NULL,
	 * PRIMARY KEY(tl_pk)
	 * );
	 */
	// 更多看这里:
	// https://docs.spring.io/spring-data/jpa/reference/jpa/getting-started.html
	// 更多例子看这里:
	// https://github.com/spring-projects/spring-data-examples/tree/main/jpa

	// logback日志
	protected final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private LoginRepository repository;

	public void run() throws InterruptedException {

		// 插入t_login数据
		// 创建UUID v7版本的主键
		String uuidv7 = Generators.timeBasedEpochGenerator().generate().toString();
		UUID tl_pk = UUID.fromString(uuidv7);
		// 取得1到99的随机数
		int randomNumber = ThreadLocalRandom.current().nextInt(1, 100);
		String login_id = "jdbc" + randomNumber;
		String login_pwd = "pwd" + randomNumber;
		Login login = new Login();
		login.setTlpk(tl_pk);
		login.setLoginId(login_id);
		login.setLoginPwd(login_pwd);
		repository.save(login);
		log.info("t_login表插入成功, {}, {}, {}", uuidv7, login_id, login_pwd);

		// 查询t_login数据
		Login saved = repository.findByLoginId(login_id).orElseThrow(NoSuchElementException::new);
		log.info("t_login表查询成功, {}, {}, {}", saved.getTlpk().toString(), saved.getLoginId(), saved.getLoginPwd());
	}
}
