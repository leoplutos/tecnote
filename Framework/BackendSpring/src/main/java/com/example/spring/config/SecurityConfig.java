package com.example.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;
import com.example.spring.common.SpringContextUtils;
import com.example.spring.filter.JwtAuthenticationFilter;

/**
 * @Description: SpringSecurity配置类
 * @Param:
 * @Return:
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private UserDetailsService userDetailsService;

	/**
	 * 加载用户信息
	 */
	@Bean
	public UserDetailsService userDetailsService() {
		return userDetailsService;
	}

	/**
	 * 密码编码器
	 */
	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	/**
	 * 身份验证管理器
	 */
	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
		return configuration.getAuthenticationManager();
	}

	/**
	 * 处理身份验证
	 */
	@Bean
	public AuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider daoAuthenticationProvider = new DaoAuthenticationProvider();
		// 指定密码编辑器
		daoAuthenticationProvider.setPasswordEncoder(passwordEncoder());
		// 提供自定义loadUserByUsername
		daoAuthenticationProvider.setUserDetailsService(userDetailsService);
		return daoAuthenticationProvider;
	}

	/**
	 * @Description: 配置SecurityFilterChain过滤器链
	 * @Param: HttpSecurity
	 * @Return: SecurityFilterChain
	 */
	@Bean
	public SecurityFilterChain defaultSecurityFilterChain(HttpSecurity httpSecurity,
			HandlerMappingIntrospector introspector) throws Exception {
		// System.out.println("---------SecurityConfig");
		// h2控制台放行
		// 详见：https://github.com/spring-projects/spring-security/issues/12310
		// MvcRequestMatcher h2RequestMatcher = new MvcRequestMatcher(introspector,
		// "/**");
		// h2RequestMatcher.setServletPath("/h2-console");
		// 登录放行
		httpSecurity.authorizeHttpRequests(authorizeHttpRequests -> authorizeHttpRequests
				// 允许所有OPTIONS请求
				.requestMatchers(HttpMethod.OPTIONS, "/**").permitAll()
				// 登录页面放行
				.requestMatchers(HttpMethod.POST, "/login").permitAll()
				// 默认错误地址放行
				.requestMatchers("/error").permitAll()
				// h2控制台放行
				// .requestMatchers(h2RequestMatcher).permitAll()
				// .requestMatchers(PathRequest.toH2Console()).permitAll()
				// 除上面外的所有请求全部需要鉴权认证
				.anyRequest().authenticated());
		httpSecurity.authenticationProvider(authenticationProvider());

		// 前后端分离是无状态的，不需要session了，直接禁用
		httpSecurity.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS));

		// 禁用登录页面
		httpSecurity.formLogin(AbstractHttpConfigurer::disable);
		// 禁用登出页面
		httpSecurity.logout(AbstractHttpConfigurer::disable);
		// 禁用session
		httpSecurity.sessionManagement(AbstractHttpConfigurer::disable);
		// 禁用httpBasic
		httpSecurity.httpBasic(AbstractHttpConfigurer::disable);
		// 禁用csrf保护
		httpSecurity.csrf(AbstractHttpConfigurer::disable);

		// 将自定义token验证过滤器，添加到UsernamePasswordAuthenticationFilter前面
		// UsernamePasswordAuthenticationFilter实现了基于用户名和密码的认证逻辑，因为利用token进行身份验证，所以用不到这个过滤器
		// 通过上下文获取AuthenticationManager
		AuthenticationManager authenticationManager = SpringContextUtils.getBean("authenticationManager");
		// 添加自定义token验证过滤器
		httpSecurity.addFilterBefore(new JwtAuthenticationFilter(authenticationManager),
				UsernamePasswordAuthenticationFilter.class);

		// 自定义处理器
		httpSecurity.exceptionHandling(exceptionHandling -> exceptionHandling
				.accessDeniedHandler(new AuthAccessDeniedHandler()) // 处理用户权限不足
				.authenticationEntryPoint(new AuthEntryPointHandler()) // 处理用户未登录（未携带token）
		);

		return httpSecurity.build();
	}

	/**
	 * 静态资源放行
	 * 在被放行的资源，不需要经过 Spring Security 过滤器链
	 */
	@Bean
	public WebSecurityCustomizer webSecurityCustomizer() {
		// 在src/main/resources/static/下新建doc.html，即可被直接访问
		return (web) -> web.ignoring().requestMatchers(
				"/doc.html",
				"/doc.html/**",
				"/swagger-ui.html/**",
				"/swagger-resources",
				"/swagger-resources/**");
	}

}
