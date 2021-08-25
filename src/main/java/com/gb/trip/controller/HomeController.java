package com.gb.trip.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping({"","/","/index"})
	public String index(HttpServletRequest request) {
		
		return "index";
	}
}
