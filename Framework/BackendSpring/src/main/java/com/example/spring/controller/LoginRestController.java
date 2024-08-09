package com.example.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.example.spring.common.JwtUtils;
import com.example.spring.common.Result;
import com.example.spring.entity.Login;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

@RestController
// 支持跨域的标注
// @CrossOrigin(origins = { "http://localhost:9500", "null" })
@CrossOrigin(origins = { "*" })
public class LoginRestController {

	@Autowired
	private AuthenticationManager authenticationManager;

	@Autowired
	private JwtUtils jwtUtils;

	// 同时支持POST和GET
	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public Result<String> login(@RequestBody Login login) {
		if (!StringUtils.hasLength(login.getUserId())) {
			return Result.fail(401, "账号不能为空");
		}
		if (!StringUtils.hasLength(login.getPassword())) {
			return Result.fail(401, "密码不能为空");
		}
		try {
			UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(
					login.getUserId(), login.getPassword());
			Authentication authentication = authenticationManager.authenticate(auth);
			SecurityContextHolder.getContext().setAuthentication(authentication);
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();

			// 获取用户权限信息
			String authorityString = "";
			Collection<? extends GrantedAuthority> authorities = userDetails.getAuthorities();
			for (GrantedAuthority authority : authorities) {
				authorityString = authority.getAuthority();
			}

			// 用户身份验证成功，生成并返回jwt令牌
			Map<String, Object> claims = new HashMap<>();
			claims.put("username", userDetails.getUsername());
			claims.put("authorityString", authorityString);
			String jwtToken = jwtUtils.getJwt(claims);
			return Result.success("登录成功", jwtToken);
		} catch (Exception ex) {
			// 默认情况下：用户名或者密码错误都会报 [BadCredentialsException: Bad credentials] 错误
			// ex.printStackTrace();
			// 用户身份验证失败，返回登陆失败提示
			return Result.fail(401, "用户名或密码错误！");
		}
	}
}
