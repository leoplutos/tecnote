package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HelloController {

	@GetMapping("/hello")
	public String hello(@RequestParam(name = "message", required = false, defaultValue = "World") String message,
			Model model) {
		model.addAttribute("title", "在HelloController设定的title");
		model.addAttribute("message", message);
		return "hello";
	}
}
