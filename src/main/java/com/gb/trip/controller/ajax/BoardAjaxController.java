package com.gb.trip.controller.ajax;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.gb.trip.config.MyUserDetails;
import com.gb.trip.dto.ReplySaveRequestDto;
import com.gb.trip.dto.ResponseDto;
import com.gb.trip.model.Board;
import com.gb.trip.service.BoardService;

@RestController
public class BoardAjaxController {



	@Autowired
	private BoardService boardService;

	@PostMapping("/ajax/board")
	public ResponseDto<Integer> save(@RequestBody Board board, @AuthenticationPrincipal MyUserDetails myUserDetails) {
		boardService.writeBoard(board, myUserDetails.getUser());
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}

	@DeleteMapping("/ajax/board/{id}")
	public ResponseDto<Integer> deleteById(@PathVariable int id, @AuthenticationPrincipal MyUserDetails myUserDetails){

		boardService.deleteBoard(id, myUserDetails.getUser());
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}

	@PutMapping("/ajax/board/{id}")
	public ResponseDto<Integer> update(@PathVariable int id, @RequestBody Board board){
		boardService.updateBoard(id, board);
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}


	@PostMapping("/ajax/board/{boardId}/reply")
	public ResponseDto<Integer> replySave(@RequestBody ReplySaveRequestDto replySaveRequestDto) {
		boardService.writeReply(replySaveRequestDto);
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}

	@DeleteMapping("/ajax/board/{boardId}/reply/{replyId}")
	public ResponseDto<Integer> replyDelete(@PathVariable int replyId) {
		boardService.deleteReply(replyId);
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}
}
