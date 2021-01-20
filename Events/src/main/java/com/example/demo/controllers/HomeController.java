package com.example.demo.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.models.Event;
import com.example.demo.models.LoginUser;
import com.example.demo.models.Message;
import com.example.demo.models.User;
import com.example.demo.services.HomeService;
import com.example.demo.services.UserService;

@Controller
public class HomeController {

	@Autowired
	private UserService userServ;
	@Autowired
	private HomeService homeServ;

	@GetMapping("/")
	public String index(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());		
		return "index.jsp";
	}
	
	@PostMapping("/events")
	public String createEvent(@Valid @ModelAttribute("newEvent") Event newEvent, 
			BindingResult result, Model model, HttpSession session) {
		User loggedInUser = userServ.findOne( (Long) session.getAttribute("user_id") );
		if(loggedInUser == null) {
			return "redirect:/";
		}
		if(result.hasErrors()) {
			return "homePage.jsp";
		}
		newEvent.setPlanner(loggedInUser);
		homeServ.planEvent(newEvent, result);
		return "redirect:/home";
	}
	
	@PostMapping("/events/{id}/messages")
	public String createMessage(@Valid @ModelAttribute("newMessage") Message newMessage,
			BindingResult result, @PathVariable("id") Long id, Model model, HttpSession session) {
		User loggedInUser = userServ.findOne( (Long) session.getAttribute("user_id") );
		Event currentEvent = homeServ.findEvent(id);
		if(loggedInUser == null) {
			return "redirect:/";
		}
		if(result.hasErrors()) {
			return "show.jsp";
		}
		newMessage.setWriter(loggedInUser);
		newMessage.setEvent(currentEvent);
		homeServ.addMessage(newMessage, result);
		return "redirect:/events/"+currentEvent.getId();
	}
	
	@GetMapping("/events/{id}")
	public String showEvent(@PathVariable("id") Long id, Model model, HttpSession session) {
		User loggedInUser = userServ.findOne( (Long) session.getAttribute("user_id") );
		if(loggedInUser == null) {
			return "redirect:/";
		}
		model.addAttribute("event", homeServ.findEvent(id));
		model.addAttribute("messages", homeServ.allMessages(id));
		model.addAttribute("newMessage", new Message());
		return "show.jsp";
	}
	
	@GetMapping("/events/{id}/edit")
	public String eEvent(@PathVariable("id") Long id, Model model, HttpSession session) {
		User loggedInUser = userServ.findOne( (Long) session.getAttribute("user_id") );
		if(loggedInUser == null) {
			return "redirect:/";
		}
		model.addAttribute("event", homeServ.findEvent(id));
		return "edit.jsp";
	}

	@PostMapping("/events/{id}/edit")
	public String editEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, HttpSession session) {
		User loggedInUser = userServ.findOne( (Long) session.getAttribute("user_id") );
		if(loggedInUser == null) {
			return "redirect:/";
		}
		System.out.println(result.getAllErrors());
		if(result.hasErrors()) {
			return "edit.jsp";
			}
		homeServ.updateEvent(event,result);
		return "redirect:/events/"+event.getId();
	}
	
	@GetMapping("/events/{id}/join")
	public String joinEvent(@PathVariable("id") Long id, HttpSession session) {
		User loggedInUser = userServ.findOne( (Long) session.getAttribute("user_id") );
		if(loggedInUser == null) {
			return "redirect:/";
		}
		homeServ.joinTrip(id, loggedInUser.getId());
		return "redirect:/home";
	}
	
	@GetMapping("/events/{id}/leave")
	public String leaveEvent(@PathVariable("id") Long id, HttpSession session) {
		User loggedInUser = userServ.findOne( (Long) session.getAttribute("user_id") );
		if(loggedInUser == null) {
			return "redirect:/";
		}
		homeServ.leaveTrip(id, loggedInUser.getId());
		return "redirect:/home";
	}
	
	@GetMapping("/events/{id}/delete")
    public String delete(@PathVariable("id") Long id) {
		
		homeServ.remove(id);
    	return "redirect:/home";
    }
	
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, 
			BindingResult result, Model model, HttpSession session) {
		userServ.register(newUser, result);
		if(result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "index.jsp";
		} else {
			session.setAttribute("user_id", newUser.getId());
			return "redirect:/home";
		}
	}
	
	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, 
			BindingResult result, Model model, HttpSession session) {
		User u = userServ.login(newLogin, result);
		if(result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "index.jsp";
		}
		session.setAttribute("user_id", u.getId());
		return "redirect:/home";
	}
	
	@RequestMapping("/home")
    public String home(HttpSession session, Model model) {
		if (session.getAttribute("user_id") != null) {
			model.addAttribute("user", this.userServ.findOne((Long)session.getAttribute("user_id")));
			model.addAttribute("newEvent", new Event());
			model.addAttribute("inLocation", homeServ.eventsInLoc(this.userServ.findOne((Long)session.getAttribute("user_id")).getLocation()));
			model.addAttribute("notInLocation", homeServ.eventsNotInLoc(this.userServ.findOne((Long)session.getAttribute("user_id")).getLocation()));
			return "homePage.jsp";
		} 
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		model.addAttribute("error", "Please Register/Login First!");
		return "index.jsp";
    }
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("user_id");
		return "redirect:/";
	}
	
}
