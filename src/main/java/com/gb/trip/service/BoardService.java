package com.gb.trip.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gb.trip.dto.ReplySaveRequestDto;
import com.gb.trip.model.Board;
import com.gb.trip.model.Pagination;
import com.gb.trip.model.User;
import com.gb.trip.repository.BoardRepository;
import com.gb.trip.repository.ReplyRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardService {

	private final BoardRepository boardRepository;
	private final ReplyRepository replyRepository;

//	public BoardService(BoardRepository bRepo, ReplyRepository rRepo) {
//		this.boardRepository = bRepo;
//		this.replyRepository = rRepo;
//	}

	@Transactional
	public void writeBoard(Board board, User user) { // title, content
		board.setBoardCount(0);
		board.setUser(user);
		boardRepository.save(board);
	}

	@Transactional(readOnly = true)
	public List<Board> listBoard(Pagination pagination) {
		return boardRepository.findAll(pagination);
	}

	@Transactional
	public Board detailBoard(int id) {
		boardRepository.updateBoardCount(id);
		return boardRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("글 상세보기 실패 : 아이디를 찾을 수 없습니다.");
		});
	}

	@Transactional
	public List<Board> search(String keyword) {

		List<Board> boardList = boardRepository.findByTitleContainingOrderByIdDesc(keyword);

		return boardList;
	}

	@Transactional
	public void deleteBoard(int id,User user) {
	if(boardRepository.getById(id).getUser().getId() == user.getId()) {
		boardRepository.deleteById(id);
	} else {
		throw new IllegalArgumentException("삭제 실패 : 동일한 아이디가 아닙니다");
	}

	}

	@Transactional
	public void updateBoard(int id, Board requestBoard) {
		Board board = boardRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("글 찾기 실패 : 아이디를 찾을 수 없습니다.");
		}); // 영속화 완료
		board.setTitle(requestBoard.getTitle());
		board.setContent(requestBoard.getContent());
		// 해당 함수로 종료시(Service가 종료될 때) 트랜잭션이 종료됩니다. 이때 더티체킹 - 자동 업데이트가 됨. db flush
	}

	@Transactional
	public void writeReply(ReplySaveRequestDto replySaveRequestDto) {
		int result = replyRepository.mSave(replySaveRequestDto.getUserId(), replySaveRequestDto.getBoardId(),
				replySaveRequestDto.getContent());
		System.out.println("BoardService : " + result);
	}

	@Transactional
	public void deleteReply(int replyId) {
		replyRepository.deleteById(replyId);
	}
}