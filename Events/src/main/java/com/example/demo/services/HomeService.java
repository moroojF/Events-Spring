package com.example.demo.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.example.demo.models.Event;
import com.example.demo.models.Message;
import com.example.demo.models.User;
import com.example.demo.repositories.EventRepository;
import com.example.demo.repositories.MessageRepository;
import com.example.demo.repositories.UserRepository;

@Service
public class HomeService {
	@Autowired
	private EventRepository eventRepo;
	@Autowired
	private UserRepository userRepo;
	@Autowired
	private MessageRepository mesRepo;

	public List<Event> eventsInLoc(String loc) {
		return this.eventRepo.findAllByLocation(loc);
	}
	
	public List<Event> eventsNotInLoc(String loc) {
		return this.eventRepo.findByLocationNotContains(loc);
	}
	
	public Event planEvent(Event newEvent, BindingResult result) {
		if (result.hasErrors()) {
			return null;
		}
		return eventRepo.save(newEvent);
	}
	
	public Event findEvent(Long id) {
		return eventRepo.findById(id).orElse(null);
	}
	
	public List<Message> allMessages(Long id) {
		return mesRepo.findAll();
	}
	
	public Message addMessage(Message newMessage, BindingResult result) {
		if (result.hasErrors()) {
			return null;
		}
		return mesRepo.save(newMessage);
	}
	
	public void joinTrip(Long event_id, Long user_id) {
		User u = userRepo.findById(user_id).orElse(null);
		Event e = findEvent(event_id);
		List<User> attendance = e.getAttendance();
		attendance.add(u);
		e.setAttendance(attendance);
		eventRepo.save(e);
	}
	
	public void leaveTrip(Long event_id, Long user_id) {
		User u = userRepo.findById(user_id).orElse(null);
		Event e = findEvent(event_id);
		List<User> attendance = e.getAttendance();
		attendance.remove(u);
		e.setAttendance(attendance);
		eventRepo.save(e);
	}
}
