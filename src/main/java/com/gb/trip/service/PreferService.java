package com.gb.trip.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gb.trip.model.Prefer;
import com.gb.trip.repository.PreferRepository;

@Service
public class PreferService {
	
	@Autowired
	private PreferRepository preferRepository;
	
	@Transactional
	public void save(Prefer prefer) {
		preferRepository.save(prefer);
	}
	
	@Transactional(readOnly = true)
	public List<Prefer> finByUserId(int userId, LocalDate s_date){
		return preferRepository.findByUserId(userId, s_date);
	};
	@Transactional(readOnly = true)
	public List<Prefer> findAllByUserId(int userId){
		return preferRepository.findAllByUserId(userId);
	}
	@Transactional
	public void delete(int id) {
		preferRepository.deleteById(id);
	}
	
}
