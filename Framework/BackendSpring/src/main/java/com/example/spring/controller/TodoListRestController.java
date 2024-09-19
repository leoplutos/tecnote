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
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@RestController
@RequestMapping("/todo")
// 支持跨域的标注
// @CrossOrigin(origins = { "http://localhost:9500", "null" })
@CrossOrigin(origins = { "*" })
public class TodoListRestController {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	@Autowired
	private ITodoService service;

	// 同时支持POST和GET
	@RequestMapping(value = "/getAll", method = { RequestMethod.GET, RequestMethod.POST })
	public Result<List<Todo>> getAll() {
		boolean isVirtual = Thread.currentThread().isVirtual();
		log.info("取得TodoList开始. 是否虚拟线程: {}", isVirtual);
		Result<List<Todo>> result = service.getAll();
		log.info("取得TodoList结束. 是否虚拟线程: {}", isVirtual);
		return result;
	}
}
