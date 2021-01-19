package com.example.demo.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.models.Event;
@Repository
public interface EventRepository extends CrudRepository<Event, Long> {
	List<Event> findAllByLocation(String lication);
	List<Event> findByLocationNotContains(String lication);
}
