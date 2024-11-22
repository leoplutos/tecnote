package com.example.service;

import com.example.dao.Login;
import com.example.dao.LoginDao;
import com.fasterxml.uuid.Generators;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// Spring Boot JdbcClient 示例
@Service
public class PostgreJdbcClientService {

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
	// https://springdoc.cn/spring-6-jdbcclient-api/
	// 更多例子看这里:
	// https://github.com/spring-projects/spring-data-examples/tree/main/jdbc

	// logback日志
	protected final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private LoginDao dao;

	public void run() throws InterruptedException {

		String searchId = null;
		String deleteId = null;
		// 插入3条t_login数据
		for (int i = 0; i < 3; i++) {
			// 创建UUID v7版本的主键
			String uuidv7 = Generators.timeBasedEpochGenerator().generate().toString();
			UUID tl_pk = UUID.fromString(uuidv7);
			// 取得1到99的随机数
			int randomNumber = ThreadLocalRandom.current().nextInt(1, 100);
			String login_id = "jdbc" + randomNumber;
			String login_pwd = "pwd" + randomNumber;
			Login login = new Login(tl_pk, login_id, login_pwd);
			dao.insert(login);
			log.info("t_login表插入成功, {}, {}, {}", uuidv7, login_id, login_pwd);
			if (i == 0) {
				searchId = login_id;
			} else if (i == 1) {
				deleteId = login_id;
			}
		}

		// 查询数据
		Optional<Login> opLogin = dao.findByLoginId(searchId);
		Login login = null;
		if (opLogin.isPresent()) {
			login = opLogin.get();
			log.info("使用 loginId 查询成功, {}, {}, {}", login.getTlpk().toString(), login.getLoginId(),
					login.getLoginPwd());
			// 取得1到99的随机数
			int randomNumber = ThreadLocalRandom.current().nextInt(1, 100);
			login.setLoginPwd("changed" + randomNumber);
		} else {
			log.warn("没有结果");
			return;
		}
		// opLogin.ifPresent(data -> {
		// });

		// 更新数据
		dao.updateByTlpk(login);
		log.info("t_login表更新成功, {}, {}, {}", login.getTlpk().toString(), login.getLoginId(), login.getLoginPwd());

		// 删除数据
		dao.deleteByLoginId(deleteId);
		log.info("t_login表删除成功, {}", deleteId);

		// 查询全部数据
		List<Login> list = dao.findAll();
		log.info("{}", list);
	}
}
