package com.example.spring.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
//import jakarta.persistence.GeneratedValue;
//import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "todo")
public class Todo {

	@Id
	// @GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "todoid")
	private int todoId;

	@Column(name = "todoname")
	private String todoName;

	@Column(name = "image")
	private String image;

	@Column(name = "studied")
	private boolean studied;

	public Todo() {
	}

	public Todo(String todoName, String image, boolean studied) {
		this.todoName = todoName;
		this.image = image;
		this.studied = studied;
	}

	public int getTodoId() {
		return todoId;
	}

	public void setTodoId(int todoId) {
		this.todoId = todoId;
	}

	public String getTodoName() {
		return todoName;
	}

	public void setTodoName(String todoName) {
		this.todoName = todoName;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public boolean isStudied() {
		return studied;
	}

	public void setStudied(boolean studied) {
		this.studied = studied;
	}

	@Override
	public String toString() {
		return "Todo [todoId=" + todoId + ", todoName=" + todoName + ", image=" + image + ", studied=" + studied + "]";
	}
}
