package com.example.demo.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.example.demo.models.Message;

public interface MessageRepository extends CrudRepository<Message, Long> {
	List<Message> findAll();
}
