package com.example.spring.service;

import com.example.spring.common.Result;
import com.example.spring.entity.Todo;
import com.example.spring.repository.TodoRepositories;
import jakarta.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Transactional
@Service
public class TodoServiceImpl implements ITodoService {

	@Autowired
	TodoRepositories repository;

	public Result<List<Todo>> getAll() {
		List<Todo> list = new ArrayList<Todo>();
		repository.findAll().forEach(list::add);
		return Result.success("", list);
	}
}
