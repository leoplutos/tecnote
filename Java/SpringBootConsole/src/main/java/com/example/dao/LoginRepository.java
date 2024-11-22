package com.example.dao;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

// Spring Data JPA 的数据库操作

// Spring Boot 框架会自动发现 application.properties 中的 DB 连接属性
// spring.datasource.url
// spring.datasource.username
// spring.datasource.password
public interface LoginRepository extends JpaRepository<Login, Long> {

	@SuppressWarnings({ "unchecked", "null" })
	Login save(Login login);

	Optional<Login> findByLoginId(String loginId);
}
