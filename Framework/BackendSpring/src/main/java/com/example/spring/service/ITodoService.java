package com.example.spring.service;

import com.example.spring.common.Result;
import com.example.spring.entity.Todo;
import java.util.List;

public interface ITodoService {
	public Result<List<Todo>> getAll();
}
