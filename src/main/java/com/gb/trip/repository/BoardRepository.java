package com.gb.trip.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.gb.trip.model.Board;
import com.gb.trip.model.Pagination;

public interface BoardRepository extends JpaRepository<Board, Integer>{

	List<Board> findByTitleContainingOrderByIdDesc(String searchText);

	Board findByUserId(int id);

    public default List<Board> findAll(Pagination pagination) {
        Page<Board> page = this.findAll(PageRequest.of(pagination.getPg() - 1, pagination.getSz(),
                                           Sort.Direction.DESC, "id"));
        pagination.setRecordCount((int)page.getTotalElements());

        return page.getContent();
    }

    @Modifying
    @Query("update Board b set b.boardCount = b.boardCount + 1 where b.id = :id")
    int updateBoardCount(int id);



}