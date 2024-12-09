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
public class EmployeeDao {

	// Spring Boot 框架会自动发现 application.properties 中的 DB 连接属性
	// 并在应用启动时创建 JdbcClient Bean。之后，JdbcClient Bean 可以在任何类中注入、使用
	// spring.datasource.url
	// spring.datasource.username
	// spring.datasource.password
	@Autowired
	private JdbcClient jdbcClient;

	// 查询所有
	public List<Employee> findAll() {
		String sql = "SELECT * FROM t_employee";
		// List<Employee> result = jdbcClient.sql(sql).query(Employee.class).list();
		List<Employee> result = jdbcClient.sql(sql)
				// 通过 RowMapper 转换结果
				.query(new EmployeeRowMapper())
				// 在调用 list() 方法之前，不会检索到任何结果。
				// 还支持其他获取结果的操作，如 optional()、set()、single() 和 stream()
				.list();
		return result;
	}

	// 使用 EmployeeId 查询
	public Optional<Employee> findByEmployeeId(String employeeId) {
		String sql = "SELECT * FROM t_employee WHERE employee_id = ?";
		Optional<Employee> result = jdbcClient.sql(sql)
				.param(employeeId)
				.query(new EmployeeRowMapper())
				.optional();
		return result;
	}

	// 插入数据
	public Integer insert(Employee employee) {
		String sql = "INSERT INTO t_employee (te_pk, employee_id, employe_name, employe_status) VALUES (?, ?, ?, ?)";
		Integer noOfrowsAffected = this.jdbcClient.sql(sql)
				// 隐式位置方式
				// .param(employee.getTepk())
				.param(1, employee.getTepk(), Types.OTHER)
				.param(2, employee.getEmployeeId(), Types.VARCHAR)
				.param(3, employee.getEmployeName(), Types.VARCHAR)
				.param(4, employee.getEmployeStatus(), Types.INTEGER)
				.update();
		return noOfrowsAffected;
	}

	// 更新数据
	public Integer updateByTlpk(Employee employee) {
		String sql = "UPDATE t_employee SET employe_email = ? WHERE te_pk = ?";
		Integer noOfrowsAffected = this.jdbcClient.sql(sql)
				.param(1, employee.getEmployeEmail(), Types.VARCHAR)
				.param(2, employee.getTepk(), Types.OTHER)
				.update();
		return noOfrowsAffected;
	}

	// 删除数据
	public Integer deleteByEmployeeId(String employeeId) {
		String sql = "DELETE FROM t_employee WHERE employee_id = ?";
		Integer noOfrowsAffected = this.jdbcClient.sql(sql)
				.param(employeeId)
				.update();
		return noOfrowsAffected;
	}

	// 自定义字段映射，因为有UUID类型，这里需要转换下
	public class EmployeeRowMapper implements RowMapper<Employee> {
		@Override
		public Employee mapRow(@SuppressWarnings("null") ResultSet rs, int rowNum) throws SQLException {
			String uuidv7 = rs.getString(1);
			UUID te_pk = UUID.fromString(uuidv7);
			String employeeId = rs.getString(2);
			String employeName = rs.getString(3);
			String employeEmail = rs.getString("employe_email");
			if (rs.wasNull()) {
				employeEmail = "N/A";
			}
			int employeStatus = rs.getInt(5);
			Employee employee = new Employee(te_pk, employeeId, employeName, employeEmail, employeStatus);
			return employee;
		}
	}
}
