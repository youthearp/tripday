package com.gb.trip.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.gb.trip.model.UserRegistration;
import com.gb.trip.service.UserService;

@Controller
public class UserController {

	@Autowired
	UserService userService;

	@GetMapping("/register")
	public String register(Model model) {
		model.addAttribute(new UserRegistration());
		return "user/register";
	}

	@PostMapping("/register")
	public String register(Model model, @Valid UserRegistration userRegistration, BindingResult bindingResult) {
		if (userService.hasErrors(userRegistration, bindingResult)) {
			return "user/register";
		}
		userService.save(userRegistration);
		return "redirect:login";
	}

	@GetMapping("/login")
	public String login(Model model, HttpServletRequest request) {
		// 이전페이지 URL 추출
		String referrer = request.getHeader("Referer")==null?"http://localhost:8085/":request.getHeader("Referer");
		if(referrer.equals("http://localhost:8085/register"))
			referrer = "http://localhost:8085/";
		request.getSession().setAttribute("prevPage", referrer);
		return "user/login"; 
	}

	@GetMapping("/user/updateUser")
	public String updateUser() {

		return "user/updateUser";
	}

	@GetMapping("/user/updateNick")
	public String updateNick() {
		return "user/updateNick";
	}
}