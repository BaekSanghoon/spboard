package board.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import board.service.BoardService;
import board.vo.*;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	// 공지 목록
	public String boardList(Model model, @PathVariable(value = "") int currentPage){
		int rowPerPage = 10;
		
		List<Board> boardList = boardService.getBoardListByPage(currentPage, rowPerPage);
		System.out.println("Debug: " + boardList);
		
		int totalCount = boardService.getCountBoard();	
		int lastPage = totalCount / rowPerPage;	
		
		if (totalCount % rowPerPage != 0) {	
			lastPage += 1;
		}
		
		if (lastPage == 0) { 
			currentPage = 0;
		}
		model.addAttribute("boardList", boardList);
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", lastPage);	
			
		return "boardList";
	}
	// 게시판 입력 폼
	@GetMapping("/addBoard")
	public String addBoard() {
		return "addBoard";
	}
	// 게시판 입력 액션
	@PostMapping("/addBoard")
	public String addBoard(BoardForm boardForm) {
		boardService.addBoard(boardForm);
		return "redirect:/boardList/1";
	}
	// 게시판 상세 보기
	@GetMapping("/boardOne/{boardNo}")
	public String boardOne(Model model, @PathVariable(value = "boardNo") int boardNo) {
		Board board = boardService.getBoardOne(boardNo);
		model.addAttribute("board", board);
		return "boardOne";
	}
	// 게시판 삭제
	@GetMapping("/removeBoard/{boardNo}")
	public String removeBoard(@PathVariable(value = "boardNo") int boardNo) {
		boardService.removeBoard(boardNo);
		return "redirect:/boardList/1";
	}
	// 게시판 수정 
	@GetMapping("/modifyBoard/{boardNo}")
	public String modifyBoard(Model model, @PathVariable(value = "boardNo") int boardNo) {
		Board board =boardService.getBoardOne(boardNo);
		model.addAttribute("board", board);
		
		return "modifyBoard";
	}
	
	// 게시판 수정 액션
	@PostMapping("/modifyBoard")
	public String modifyBoard(BoardForm boardForm) {
		boardService.modifyBoard(boardForm);
		return "redirect:/boardList/1";
	}
}
