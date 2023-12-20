package com.example.spring.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
//import jakarta.persistence.GeneratedValue;
//import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "login")
public class Login {

	@Id
	@Column(name = "userid")
	private String userId;

	@Column(name = "password")
	private String password;

	public Login() {
	}

	public Login(String userId, String password) {
		this.userId = userId;
		this.password = password;
	}

	@Override
	public String toString() {
		return "Todo [userId=" + userId + ", password=" + password + "]";
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
