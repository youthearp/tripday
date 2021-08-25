package com.gb.trip.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.gb.trip.model.Prefer;

public interface PreferRepository extends JpaRepository<Prefer, Integer>{

	@Query(value = "SELECT * FROM prefer p WHERE userId = ?1 AND s_date = ?2", nativeQuery = true)
	List<Prefer> findByUserId(int userId, LocalDate s_date);
	
	@Query(value = "SELECT * FROM prefer p WHERE userId = ? ORDER BY id DESC", nativeQuery = true)
	List<Prefer> findAllByUserId(int userId);
	
	

}
