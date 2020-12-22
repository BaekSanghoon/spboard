package board.service;

import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import board.mapper.*;
import board.vo.Board;


@Service
@Transactional
public class BoardService {
	
	@Autowired private BoardMapper boardMapper;
	
	public List<Board> getBoardListByPage(int currentPage, int rowPerPage) {
		int beginRow = (currentPage - 1) * rowPerPage;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		List<Board> boardList = boardMapper.selectBoardListByPage(map);
		
		return boardList;
	}
	

	public Map<String, Object> getBoardAndInOutList() { 
		List<Board> boardList = boardMapper.boardList();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardList", boardList);
		// return list;
		return map;
	}
	
	public List<Board> getBoardList(){
		return boardMapper.boardList();
	}
	
	public void addBoard(Board board) {
		
		Board board = new Board();
		board.setBoardTitle(board.getBoardTitle());
		board.setBoardContent(board.getBoardContent());
		boardMapper.insertBoard(board); 
		
	}
	//삭제
	public void removeBoard(int boardNo) {
		boardMapper.deleteBoard(boardNo);
	}
	//수정
	public void modifyBoard(Board board) {
		Board board = new Board();
		board.setBoardNo(board.getBoardNo());
		board.setBoardTitle(board.getBoardTitle());
		board.setBoardContent(board.getBoardContent());
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