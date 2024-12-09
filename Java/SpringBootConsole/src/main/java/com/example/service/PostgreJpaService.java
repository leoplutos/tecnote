package com.example.service;

import com.example.dao.Employee;
import com.example.dao.EmployeeRepository;
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
	 * CREATE TABLE t_employee (
	 * te_pk UUID NOT NULL UNIQUE,
	 * employee_id TEXT NOT NULL,
	 * employe_name TEXT,
	 * employe_email TEXT,
	 * employe_status SMALLINT,
	 * PRIMARY KEY(te_pk)
	 * );
	 */
	// 更多看这里:
	// https://docs.spring.io/spring-data/jpa/reference/jpa/getting-started.html
	// 更多例子看这里:
	// https://github.com/spring-projects/spring-data-examples/tree/main/jpa

	// logback日志
	protected final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private EmployeeRepository repository;

	public void run() throws InterruptedException {

		// 插入t_employee数据
		// 创建UUID v7版本的主键
		String uuidv7 = Generators.timeBasedEpochGenerator().generate().toString();
		UUID te_pk = UUID.fromString(uuidv7);
		// 取得1到99的随机数
		int randomNumber = ThreadLocalRandom.current().nextInt(1, 100);
		String employee_id = "java_jpa_id_" + randomNumber;
		String employe_name = "java_张大_" + randomNumber;
		int employe_status = 2;
		Employee employee = new Employee();
		employee.setTepk(te_pk);
		employee.setEmployeeId(employee_id);
		employee.setEmployeName(employe_name);
		employee.setEmployeStatus(employe_status);
		repository.save(employee);
		log.info("t_employee表插入成功, {}", employee);

		// 查询t_employee数据
		Employee saved = repository.findByEmployeeId(employee_id).orElseThrow(NoSuchElementException::new);
		log.info("t_employee表查询成功, {}", saved);
	}
}
