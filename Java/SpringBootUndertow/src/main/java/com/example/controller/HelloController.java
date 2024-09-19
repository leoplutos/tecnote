package com.example.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HelloController {

	// logback日志
	protected final Logger log = LoggerFactory.getLogger(this.getClass());

	@GetMapping("/hello")
	public String hello(@RequestParam(name = "message", required = false, defaultValue = "World") String message,
			Model model) {
		boolean isVirtual = Thread.currentThread().isVirtual();
		log.info("hello开始. 是否虚拟线程: {}", isVirtual);
		model.addAttribute("title", "在HelloController设定的title");
		model.addAttribute("message", message);
		log.info("hello结束. 是否虚拟线程: {}", isVirtual);
		return "hello";
	}
}
