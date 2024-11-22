package com.example.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

// Spring Boot JdbcClient 的数据库操作
@Repository
public class LoginDao {

	// Spring Boot 框架会自动发现 application.properties 中的 DB 连接属性
	// 并在应用启动时创建 JdbcClient Bean。之后，JdbcClient Bean 可以在任何类中注入、使用
	// spring.datasource.url
	// spring.datasource.username
	// spring.datasource.password
	@Autowired
	private JdbcClient jdbcClient;

	// 查询所有
	public List<Login> findAll() {
		String sql = "SELECT * FROM t_login";
		// List<Login> result = jdbcClient.sql(sql).query(Login.class).list();
		List<Login> result = jdbcClient.sql(sql)
				// 通过 RowMapper 转换结果
				.query(new LoginRowMapper())
				// 在调用 list() 方法之前，不会检索到任何结果。
				// 还支持其他获取结果的操作，如 optional()、set()、single() 和 stream()
				.list();
		return result;
	}

	// 使用 loginId 查询
	public Optional<Login> findByLoginId(String loginId) {
		String sql = "SELECT * FROM t_login WHERE login_id = ?";
		Optional<Login> result = jdbcClient.sql(sql)
				.param(loginId)
				.query(new LoginRowMapper())
				.optional();
		return result;
	}

	// 插入数据
	public Integer insert(Login login) {
		String sql = "INSERT INTO t_login (tl_pk, login_id, login_pwd) VALUES (?, ?, ?)";
		Integer noOfrowsAffected = this.jdbcClient.sql(sql)
				// 隐式位置方式
				// .param(login.getTlpk())
				.param(1, login.getTlpk(), Types.OTHER)
				.param(2, login.getLoginId(), Types.VARCHAR)
				.param(3, login.getLoginPwd(), Types.VARCHAR)
				.update();
		return noOfrowsAffected;
	}

	// 更新数据
	public Integer updateByTlpk(Login login) {
		String sql = "UPDATE t_login SET login_id = ?, login_pwd = ? WHERE tl_pk = ?";
		Integer noOfrowsAffected = this.jdbcClient.sql(sql)
				.param(1, login.getLoginId(), Types.VARCHAR)
				.param(2, login.getLoginPwd(), Types.VARCHAR)
				.param(3, login.getTlpk(), Types.OTHER)
				.update();
		return noOfrowsAffected;
	}

	// 删除数据
	public Integer deleteByLoginId(String loginId) {
		String sql = "DELETE FROM t_login WHERE login_id = ?";
		Integer noOfrowsAffected = this.jdbcClient.sql(sql)
				.param(loginId)
				.update();
		return noOfrowsAffected;
	}

	// 自定义字段映射，因为有UUID类型，这里需要转换下
	public class LoginRowMapper implements RowMapper<Login> {
		@Override
		public Login mapRow(@SuppressWarnings("null") ResultSet rs, int rowNum) throws SQLException {
			String uuidv7 = rs.getString(1);
			UUID tl_pk = UUID.fromString(uuidv7);
			String login_id = rs.getString(2);
			String login_pwd = rs.getString(2);
			Login login = new Login();
			login.setTlpk(tl_pk);
			login.setLoginId(login_id);
			login.setLoginPwd(login_pwd);
			return login;
		}
	}
}
