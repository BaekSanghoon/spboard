package board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import board.vo.*;

@Mapper
public interface BoardMapper {	
	// 게시물 입력
	int insertBoard(Board board);
	
	//게시물 목록
	List<Board> selectboardList();
	
	// 페이징
	List<Board> selectBoardListByPage(Map<String, Integer> map);

	// 게시물 삭제
	int deleteBoard(int boardNo);
	
	// 게시물 수정
	int modifyBoard(Board board);	
	
	// 공지사항 상세보기
	Board selectBoardOne(int boardNo);	
	
	//게시물 갯수
	int selectBoardCount();

	

}
