package com.example.spring.config;

import com.example.spring.common.Result;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * @Description: 自定义用户未登录的处理（未携带token）
 * @Param:
 * @Return:
 */
@Component
public class AuthEntryPointHandler implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		String value = new ObjectMapper().writeValueAsString(Result.fail(401, "未携带token,请登录"));
		response.getWriter().write(value);
	}
}
