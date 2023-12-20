package com.example.spring.common;

//统一封装类
public class Result<T> {

	private int code;
	private String message;
	private T data;

	public Result(int code, String message) {
		this.code = code;
		this.message = message;
		this.data = null;
	}

	public Result(int code, String message, T data) {
		this.code = code;
		this.message = message;
		this.data = data;
	}

	public Result(T data) {
		this.code = 200;
		this.message = "success";
		this.data = data;
	}

	public static <T> Result<T> success(String message) {
		return new Result<>(200, message);
	}

	public static <T> Result<T> success(String message, T data) {
		return new Result<>(200, message, data);
	}

	public static <T> Result<T> fail(String message) {
		return new Result<>(500, message);
	}

	public static <T> Result<T> fail(int code, String message) {
		return new Result<>(code, message);
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}
}
