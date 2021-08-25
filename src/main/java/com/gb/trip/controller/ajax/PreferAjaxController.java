package com.gb.trip.controller.ajax;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gb.trip.config.MyUserDetails;
import com.gb.trip.dto.ResponseDto;
import com.gb.trip.model.Prefer;
import com.gb.trip.service.PreferService;

@RequestMapping("/user")
@RestController
public class PreferAjaxController {
	
	@Autowired
	private PreferService preferService;
	
	@PostMapping("/prefer")
	public ResponseDto<Integer> save(@RequestBody Prefer prefer,
			@AuthenticationPrincipal MyUserDetails myUserDetails){
		prefer.setUser(myUserDetails.getUser());
		System.out.println(prefer);
		
		preferService.save(prefer);
		
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}
	
	@GetMapping("/prefer/{userId}/{s_date}")
	public List<Prefer> list(@PathVariable @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate s_date,
			@PathVariable int userId){
		System.out.println("userid : "+userId);
		System.out.println("s_date : "+s_date);
				
		return preferService.finByUserId(userId, s_date);
	}
	@DeleteMapping("/prefer/{id}")
	public ResponseDto<Integer> delete(@PathVariable int id){
		System.out.println(id);
		preferService.delete(id);
		return new ResponseDto<Integer>(HttpStatus.OK.value(),1);
	}

}
