package com.example.service;

import com.example.dao.Employee;
import com.example.dao.EmployeeDao;
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
	// https://springdoc.cn/spring-6-jdbcclient-api/
	// 更多例子看这里:
	// https://github.com/spring-projects/spring-data-examples/tree/main/jdbc

	// logback日志
	protected final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private EmployeeDao dao;

	public void run() throws InterruptedException {

		String searchId = null;
		String deleteId = null;
		// 插入3条t_employee数据
		for (int i = 0; i < 3; i++) {
			// 创建UUID v7版本的主键
			String uuidv7 = Generators.timeBasedEpochGenerator().generate().toString();
			UUID te_pk = UUID.fromString(uuidv7);
			// 取得1到99的随机数
			int randomNumber = ThreadLocalRandom.current().nextInt(1, 100);
			String employee_id = "java_jdbcclient_id_" + randomNumber;
			String employe_name = "java_张大_" + randomNumber;
			int employe_status = 2;
			Employee employee = new Employee();
			employee.setTepk(te_pk);
			employee.setEmployeeId(employee_id);
			employee.setEmployeName(employe_name);
			employee.setEmployeStatus(employe_status);
			dao.insert(employee);
			log.info("t_employee表插入成功, {}", employee);
			if (i == 0) {
				searchId = employee_id;
			} else if (i == 1) {
				deleteId = employee_id;
			}
		}

		// 查询数据
		Optional<Employee> searchEmployee = dao.findByEmployeeId(searchId);
		Employee employee = null;
		if (searchEmployee.isPresent()) {
			employee = searchEmployee.get();
			log.info("使用 employeeId 查询成功, {}", employee);
			// 取得1到99的随机数
			int randomNumber = ThreadLocalRandom.current().nextInt(1, 100);
			String newEmail = String.format("changed_%d@exsample.com", randomNumber);
			employee.setEmployeEmail(newEmail);
		} else {
			log.warn("没有结果. searchId:{}", searchId);
			return;
		}
		// searchEmployee.ifPresent(data -> {
		// });

		// 更新数据
		dao.updateByTlpk(employee);
		log.info("t_employee表更新成功, {}", employee);

		// 删除数据
		dao.deleteByEmployeeId(deleteId);
		log.info("t_employee表删除成功, {}", deleteId);

		// 查询全部数据
		List<Employee> list = dao.findAll();
		log.info("{}", list);
	}
}
