package com.example.dao;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.util.UUID;

// record是一种特殊的类型声明，从 Java 14 开始引入
// 它主要用于创建不可变的数据类，用于存储和传递数据
// record在功能上类似于一个只包含最终（final）字段、构造函数、访问器方法（getter）和一些标准方法（如equals、hashCode和toString）的类
//public record Employee(UUID tepk, String employeeId, String employeName, String employeEmail, int employeStatus) {
//}
@Entity
@Table(name = "t_employee")
public class Employee {

	@Id
	@Column(name = "te_pk")
	private UUID tepk;

	@Column(name = "employee_id")
	private String employeeId;

	@Column(name = "employe_name")
	private String employeName;

	@Column(name = "employe_email")
	private String employeEmail;

	@Column(name = "employe_status")
	private int employeStatus;

	public Employee() {
	}

	public Employee(UUID tepk, String employeeId, String employeName, String employeEmail, int employeStatus) {
		this.tepk = tepk;
		this.employeeId = employeeId;
		this.employeName = employeName;
		this.employeEmail = employeEmail;
		this.employeStatus = employeStatus;
	}

	// 重写 toString() 方法, 以方便日志输出
	@Override
	public String toString() {
		String uuid = "N/A";
		if (tepk != null) {
			uuid = tepk.toString();
		}
		String result = String.format(
				"Employee [tepk=%s, employeeId=%s, employeName=%s,employeEmail=%s, employeStatus=%d]", uuid, employeeId,
				employeName, employeEmail, employeStatus);
		return result;
	}

	public UUID getTepk() {
		return tepk;
	}

	public void setTepk(UUID tepk) {
		this.tepk = tepk;
	}

	public String getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	public String getEmployeName() {
		return employeName;
	}

	public void setEmployeName(String employeName) {
		this.employeName = employeName;
	}

	public String getEmployeEmail() {
		return employeEmail;
	}

	public void setEmployeEmail(String employeEmail) {
		this.employeEmail = employeEmail;
	}

	public int getEmployeStatus() {
		return employeStatus;
	}

	public void setEmployeStatus(int employeStatus) {
		this.employeStatus = employeStatus;
	}
}
