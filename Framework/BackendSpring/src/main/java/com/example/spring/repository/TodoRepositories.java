package com.example.spring.repository;

import com.example.spring.entity.Todo;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface TodoRepositories extends JpaRepository<Todo, Long> {

	List<Todo> findByStudied(boolean studied);

	Todo findByTodoId(int todoId);
}
