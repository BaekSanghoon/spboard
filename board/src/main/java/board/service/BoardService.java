package board.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import board.mapper.*;
import board.vo.Board;
import board.vo.BoardForm;


@Service //@Service (서비스 레이어, 내부에서 자바 로직을 처리함)
@Transactional //@Transactional 처리 도중 에러가 났을 때 이전에서 처리한 쿼리를 자동 rollback 해주기 위해 사용
public class BoardService {
	
	@Autowired private BoardMapper boardMapper; //@Autowired 각 상황의 타입에 맞는 loC컨테이너 안에 존재하는 Bean을 자동으로 주입해줌
	
	public List<Board> getBoardListByPage(int currentPage, int rowPerPage) {
		int beginRow = (currentPage - 1) * rowPerPage;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		List<Board> boardList = boardMapper.selectBoardListByPage(map);
		
		return boardList;
	}
	

	public Map<String, Object> getBoardAndInOutList() { 
		List<Board> boardList = boardMapper.selectboardList();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardList", boardList);
		// return list;
		return map;
	}
	
	public List<Board> getBoardList(){
		return boardMapper.selectboardList();
	}
	
	public void addBoard(BoardForm boardFrom) {
		
		Board board = new Board();
		board.setBoardPw(board.getBoardPw());
		board.setBoardTitle(board.getBoardTitle());
		board.setBoardContent(board.getBoardContent());
		board.setBoardUser(board.getBoardUser());
		boardMapper.insertBoard(board); 
		
	}
	
	//삭제
	public void removeBoard(int boardNo) {
		boardMapper.deleteBoard(boardNo);
	}
	
	//수정
	public void modifyBoard(BoardForm boardFrom) {
		Board board = new Board();
		board.setBoardNo(board.getBoardNo());
		board.setBoardTitle(board.getBoardTitle());
		board.setBoardContent(board.getBoardContent());
		board.setBoardUser(board.getBoardUser());
		boardMapper.modifyBoard(board);

	}

	public Board getBoardOne(int boardNo) {
		Board board = boardMapper.selectBoardOne(boardNo);
		return board;
	}
	public int getCountBoard() {
		return boardMapper.selectBoardCount();
	}
}