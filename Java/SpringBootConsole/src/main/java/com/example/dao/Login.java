package com.example.dao;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.util.UUID;

// record是一种特殊的类型声明，从 Java 14 开始引入
// 它主要用于创建不可变的数据类，用于存储和传递数据
// record在功能上类似于一个只包含最终（final）字段、构造函数、访问器方法（getter）和一些标准方法（如equals、hashCode和toString）的类
//public record Login(UUID tlpk, String loginId, String loginPwd) {
//}
@Entity
@Table(name = "t_login")
public class Login {

	@Id
	@Column(name = "tl_pk")
	private UUID tlpk;

	@Column(name = "login_id")
	private String loginId;

	@Column(name = "login_pwd")
	private String loginPwd;

	public Login() {
	}

	public Login(UUID tlpk, String loginId, String loginPwd) {
		this.tlpk = tlpk;
		this.loginId = loginId;
		this.loginPwd = loginPwd;
	}

	@Override
	public String toString() {
		String uuid = "null";
		if (tlpk != null) {
			uuid = tlpk.toString();
		}
		String result = String.format("Login [tl_pk=%s, login_id=%s, login_pwd=%s]", uuid, loginId, loginPwd);
		return result;
	}

	public UUID getTlpk() {
		return tlpk;
	}

	public void setTlpk(UUID tlpk) {
		this.tlpk = tlpk;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getLoginPwd() {
		return loginPwd;
	}

	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}
}
