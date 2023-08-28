package com.suwon.ezen.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.suwon.ezen.vo.EmailAuthVO;
import com.suwon.ezen.vo.MemberVO;

public interface MemberMapper {
	public MemberVO checkIdDupli(String id);
	
	public int register(MemberVO vo);
 	// 이메일과 인증번호를 서버에 저장
	public void insertAuth(EmailAuthVO vo);
	
	// 이메일을 조건으로 하여 인증 번호를 가져온다.
	public String selectAuth(String email);
	
	// 이메일을 조건으로 하여 인증 번호를 삭제한다.
	public void deleteAuth(String email);
	
	//회원 목록 가져오기
	public List<MemberVO> getMemberList(@Param("offset")int offset);
	
	// 총 회원 수
	public int getMemberCount();
	// mno로 회원정보 가져오기
	public MemberVO getByMno(int mno);
	
	// 회원 정보 수정
	public int update(MemberVO vo);
	
	public int delete(int mno);
	
	public String getId(MemberVO vo);
	
	// 아이디와 이메일을 사용해 회원이 존재하는지 체크
	public MemberVO checkMember(MemberVO vo);
	
	// 아이디와 이메일을 체크후 비밀번호 변경
	public void updatePwd(MemberVO vo);
	
	public String searchAuth(String email);
	
	public List<Map<String,Object>> getCreateRate();
	
}
