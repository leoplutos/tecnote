package com.example.service;

import com.fasterxml.uuid.Generators;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.ThreadLocalRandom;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

// JDBC 基础示例
@Service
public class PostgreBaseService {

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
	// 更多看这里: https://jdbc.postgresql.org/documentation/use/

	// logback日志
	protected final Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${spring.datasource.url}")
	private String postgreUrl;

	@Value("${spring.datasource.username}")
	private String postgreUsername;

	@Value("${spring.datasource.password}")
	private String postgrePassword;

	public void run() throws SQLException {

		log.info("Postgre连接URL: {}", postgreUrl);
		Properties props = new Properties();
		props.setProperty("user", postgreUsername);
		props.setProperty("password", postgrePassword);
		// props.setProperty("ssl", "true");
		// props.setProperty("options", "-c search_path=test,public,pg_catalog -c
		// statement_timeout=90000");

		Connection conn = null;
		try {
			conn = DriverManager.getConnection(postgreUrl, props);
			log.info("Postgre连接成功");

			// 插入t_employee数据
			PreparedStatement insertSt = conn
					.prepareStatement(
							"INSERT INTO t_employee (te_pk, employee_id, employe_name, employe_status) VALUES (?, ?, ?, ?)");
			// 创建UUID v7版本的主键
			String uuidv7 = Generators.timeBasedEpochGenerator().generate().toString();
			UUID te_pk = UUID.fromString(uuidv7);
			// 取得1到99的随机数
			int randomNumber = ThreadLocalRandom.current().nextInt(1, 100);
			String employee_id = "java_base_id_" + randomNumber;
			String employe_name = "java_张大_" + randomNumber;
			int employe_status = 2;
			insertSt.setObject(1, te_pk);
			insertSt.setObject(2, employee_id);
			insertSt.setObject(3, employe_name);
			insertSt.setObject(4, employe_status);
			insertSt.executeUpdate();
			insertSt.close();
			log.info("t_employee表插入成功, {}, {}, {}, {}", uuidv7, employee_id, employe_name, employe_status);

			// 查询t_employee所有数据
			// 创建一个List，其中每个元素都是Map<String, String>类型
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM t_employee");
			List<Map<String, String>> results = new CopyOnWriteArrayList<>();
			while (rs.next()) {
				// 创建Map并添加到List中
				Map<String, String> record = new ConcurrentHashMap<>();
				record.put("te_pk", rs.getString(1));
				record.put("employee_id", rs.getString(2));
				record.put("employe_name", rs.getString(3));
				String employe_email = rs.getString("employe_email");
				if (rs.wasNull()) {
					employe_email = "N/A";
				}
				record.put("employe_email", employe_email);
				record.put("employe_status", String.valueOf(rs.getInt(5)));
				results.add(record);
			}
			rs.close();
			st.close();
			log.info("t_employee表查询成功");
			log.info("{}", results);
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
	}
}
