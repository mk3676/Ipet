package com.suwon.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suwon.ezen.mapper.BoardMapper;
import com.suwon.ezen.vo.BoardVO;
import com.suwon.ezen.vo.ReplyVO;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper bmapper;
	
	// 전체 목록 가져오기
	@Override
	public List<BoardVO> getAllContent(int offset) {
		List<BoardVO> boardList = bmapper.getAllContent(offset);
		
		return boardList;
	}

	// 새 글 추가하기
	@Override
	public void insertContent(BoardVO vo) {
		bmapper.insertContent(vo);
		
	}
	
	// 글 하나 가져오기
	@Override
	public BoardVO getOneContent(int bno) {
		BoardVO vo = bmapper.getOneContent(bno);
		
		return vo;
	}
	
	// 글 수정하기
	@Override
	public void modifyContent(BoardVO vo) {
		bmapper.modifyContent(vo);
	}
	
	// 글 삭제하기
	@Override
	public void deleteContent(int bno) {
		bmapper.deleteContent(bno);
	}

	// 댓글 모두 삭제하기(key: bno)
	@Override
	public void deleteAllReplyByBno(int bno) {
		bmapper.deleteAllReplyByBno(bno);
		
	}
	
	// 글 목록 갯수 가져오기
	@Override
	public int getCount() {
		return bmapper.getCount();
	}

	
	// 댓글 추가하기
	@Override
	public int insertReply(ReplyVO vo) {
		int result = bmapper.insertReply(vo);
		
		return result;
	}
		
	// 댓글 모두 가져오기(key: bno)
	@Override
	public List<ReplyVO> getAllReply(int bno) {
		List<ReplyVO> ReplyList = bmapper.getAllReply(bno);
			
		return ReplyList;
	}
	
	// 댓글 하나 가져오기 
	@Override
	public ReplyVO getOneReply(int rno) {
		ReplyVO vo = bmapper.getOneReply(rno);
		
		return vo;
	}

	// 댓글 수정하기
	@Override
	public void modifyReply(ReplyVO vo) {
		bmapper.modifyReply(vo);
	}
	
	// 댓글 삭제하기
	@Override
	public void deleteReply(int rno) {
		bmapper.deleteReply(rno);
	}

	// 검색하기
	@Override
	public List<BoardVO> searchList(BoardVO vo) {
		return bmapper.searchList(vo);
	}

	// 검색 조건에 맞는 게시물의 갯수 구하기
	@Override
	public int searchListCount(BoardVO vo) {
		return bmapper.searchListCount(vo);
	}

}
