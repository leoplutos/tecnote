package com.example.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.example.spring.common.Result;
import com.example.spring.entity.Todo;
import com.example.spring.service.ITodoService;
import java.util.List;

@RestController
@RequestMapping("/todo")
// 支持跨域的标注
@CrossOrigin(origins = { "http://localhost:9500", "null" })
public class TodoListRestController {

	@Autowired
	private ITodoService service;

	// 同时支持POST和GET
	@RequestMapping(value = "/getAll", method = { RequestMethod.GET, RequestMethod.POST })
	public Result<List<Todo>> getAll() {
		Result<List<Todo>> result = service.getAll();
		return result;
	}
}
