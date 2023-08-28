package com.suwon.ezen.mapper;

import java.util.List;

import com.suwon.ezen.vo.BoardVO;
import com.suwon.ezen.vo.ReplyVO;

public interface BoardMapper {
	// 전체 목록 가져오기
	public List<BoardVO> getAllContent(int offset);
	
	// 새 글 하나 추가하기
	public void insertContent(BoardVO vo);
	
	// 글 하나 가져오기
	public BoardVO getOneContent(int bno);
	
	// 글 수정하기
	public void modifyContent(BoardVO vo);
	
	// 글 삭제하기
	public void deleteContent(int bno);
	
	// 댓글 모두 삭제하기(key: bno)
	public void deleteAllReplyByBno(int bno);
	
	public int getCount();
	
	// 댓글 추가하기
	public int insertReply(ReplyVO vo);
	
	// 댓글 모두 가져오기(key: bno)
	public List<ReplyVO> getAllReply(int bno);
	
	// 댓글 하나 가져오기 
	public ReplyVO getOneReply(int rno);
	
	// 댓글 수정하기
	public void modifyReply(ReplyVO vo);
	
	// 댓글 삭제하기
	public void deleteReply(int rno);

	// 검색하기
	public List<BoardVO> searchList(BoardVO vo);
	
	// 검색 조건에 맞는 게시물의 갯수 구하기
	public int searchListCount(BoardVO vo);
}
