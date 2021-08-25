package com.gb.trip.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gb.trip.config.MyUserDetails;
import com.gb.trip.service.PreferService;

@Controller
public class PreferController {
	
	@Autowired
	private PreferService preferService;
	
	//즐겨찾기 페이지 시작시 모든 리스트 불러옴
	@GetMapping("user/prefer")
	public String prefer(@AuthenticationPrincipal MyUserDetails myUser, Model model) {
		model.addAttribute("prefers", preferService.findAllByUserId(myUser.getUser().getId()));
		return "user/prefer";
	}
}
