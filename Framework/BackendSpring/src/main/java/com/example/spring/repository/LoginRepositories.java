package com.example.spring.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.spring.entity.Login;

public interface LoginRepositories extends JpaRepository<Login, Long> {

	Login findByUserId(String userId);

	Login findByUserIdAndPassword(String userId, String password);
}
