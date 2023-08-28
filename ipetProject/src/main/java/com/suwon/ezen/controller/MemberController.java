package com.suwon.ezen.controller;

import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.suwon.ezen.service.MemberService;
import com.suwon.ezen.vo.CartVO;
import com.suwon.ezen.vo.EmailAuthVO;
import com.suwon.ezen.vo.MemberVO;
import com.suwon.ezen.vo.Paging;
import com.suwon.ezen.vo.ProductVO;
import com.suwon.ezen.vo.PurchaseVO;

import jnr.ffi.annotations.Delegate;
import lombok.Setter;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@Setter(onMethod_ =@Autowired )
	BCryptPasswordEncoder passEncoder;
	
	@Setter(onMethod_ = @Autowired)
	private JavaMailSenderImpl mailSender;
	
	
	@GetMapping(value = "login")
	public String loginPage(HttpSession session) {
		if(session.getAttribute("loginMember")!=null) return "redirect:/ipet/index";
		else return "/member/login";
	}
	
	//로그인 페이지 아이디 체크 및 비밀번호 체크
	@PostMapping(value = "login")
	public ResponseEntity login(HttpSession session, MemberVO vo) {
		MemberVO loginMember = service.login(vo);
		String message;
		if(loginMember == null) {
			Map<String, String> map = new HashMap();
			message ="존재하지 않는 id 입니다";
			map.put("message", message);
			session.removeAttribute("loginMember");
			return new ResponseEntity<Map>(map,HttpStatus.OK);
		}
		else if(loginMember.getId() != null && passEncoder.matches(vo.getPassword(), loginMember.getPassword()) ) {
			Map<String, String> map = new HashMap();
			map.put("message", "1");
			session.setAttribute("loginMember", loginMember);
			return new ResponseEntity<Map>(map,HttpStatus.OK);
		}
		else if(loginMember.getId() != null && !passEncoder.matches(vo.getPassword(), loginMember.getPassword())) {
			Map<String, String> map = new HashMap();
			message ="비밀번호가 틀렸습니다.";
			map.put("message", message);
			session.removeAttribute("loginMember");
			return new ResponseEntity<Map>(map,HttpStatus.OK);
		}
		else return new ResponseEntity<String>("페이지 오류",HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	//로그아웃 세션값 삭제
	@GetMapping(value = "logout")
	public String logout(HttpSession session) {
		
		session.removeAttribute("loginMember");
		return "redirect:/ipet/index";
	}
	
	@GetMapping(value = "register")
	public void register() {
		
	}
	// 중복 아이디 확인
	@PostMapping(value = "/checkId")
	public ResponseEntity<HashMap<String, String>> checkId(@RequestBody HashMap<String, String> map) {
		System.out.println("들어온 id값: " + map.get("id"));
		MemberVO result = service.checkIdDupli(map.get("id"));
	    System.out.println("결과: " + result);
	    if(result == null) {
	    	map.put("result", "사용가능한 아이디 입니다.");
	    	map.put("status", "0");
	    	}
	    else {
	    	map.put("result", "이미 사용중인 아이디 입니다.");
	    	map.put("status", "1");
	    }
        return new ResponseEntity<HashMap<String,String>>(map, HttpStatus.OK);
	    
	}
//	회원 등록
	@Transactional
	@PostMapping(value = "register")
	public String regist(MemberVO vo) {
		MemberVO mVo = vo;
		mVo.setPassword(passEncoder.encode(vo.getPassword()));
		service.regist(mVo);
		System.out.println(vo);
		return "redirect:/member/login";
	}
//	0510 민경 추가부분
	@PostMapping("/emailCheck")
	@ResponseBody
	public void emailCheck(@RequestBody HashMap<String, String> map) {
		String email = map.get("email");
		String auth = "";
		for (int i=0;i<8;i++) 
			auth += (int)(Math.random()*10);
		
		if (service.selectAuth(email) != null)
			service.deleteAuth(email);
		
		System.out.println("email: " + email + ", auth: " + auth);
		String mailContext = "i-Pet 인증번호 입니다. <br> 입력창에 인증번호 <b>" + auth + "</b> 을/를 입력해주세요.";
		
		try {
			MimeMessage mailMessage = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mailMessage, true, "utf-8");
			helper.setFrom("milkyway3676@gamil.com");
			helper.setTo(email);
			helper.setSubject("i-Pet 인증번호 발송");
			helper.setText(mailContext, true);
			mailSender.send(mailMessage);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		EmailAuthVO emailAuth = new EmailAuthVO();
		emailAuth.setAuth(auth);
		emailAuth.setEmail(email);
		
		service.insertAuth(emailAuth);
	}
	
//	이메일 인증 컨트롤러
	@PostMapping("/vaildAuth")
	@ResponseBody
	public ResponseEntity<HashMap<String, String>> vaildAuth(@RequestBody EmailAuthVO vo) {
		String authNum = vo.getAuth();
		String email = vo.getEmail();
		String auth = service.selectAuth(email);
		
		System.out.println("authNum: " + authNum + ", email: " + email + ", auth: " + auth);
		HashMap<String, String> map = new HashMap<String, String>();
		
		if (authNum.equals(auth)) {
			map.put("word", "인증되었습니다.");
			map.put("status", "1");
			service.deleteAuth(email);
		}
		else {
			map.put("word", "실패하였습니다. 다시 입력해주세요.");
	    	map.put("status", "0");
		}
		
		return new ResponseEntity<HashMap<String, String>>(map, HttpStatus.OK);
	}
	
//	id찾기 모달
	@RequestMapping(value = "/IdModal", method = RequestMethod.GET)
	public String findId(Model model) {
	    // 모델 데이터 처리
	    model.addAttribute("showModal", true); // showModal 속성 값 추가
	    return "/member/IdModal"; // IdModal 화면 JSP 파일 호출
	}
	
//	비밀번호 찾기 모달
	@RequestMapping(value = "/pwdModal", method = RequestMethod.GET)
	public String findpwd(Model model) {
	    // 모델 데이터 처리
	    model.addAttribute("showModal", true); // showModal 속성 값 추가
	    return "/member/pwdModal"; // pwdModal 화면 JSP 파일 호출
	}
	
//	아이디 찾기 정보 일치시 id 전송
	@GetMapping(value = "findId")
	public ResponseEntity<Map<String, String>> getId(MemberVO vo){
		String id = service.getId(vo);
		Map<String,String> map = new HashMap<>();
		if(id==null) map.put("msg", "정보가 일치하지 않습니다.");
		else {
			map.put("msg", "이메일로 아이디를 발송 했습니다.");
			String mailContext = "i-Pet 회원님의 아이디입니다. <br><b>" + id + "</b>";
			try {
				MimeMessage mailMessage = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(mailMessage, true, "utf-8");
				helper.setFrom("milkyway3676@gamil.com");
				helper.setTo(vo.getEmail());
				helper.setSubject("i-Pet 회원 아이디 발송.");
				helper.setText(mailContext, true);
				mailSender.send(mailMessage);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
//	비밀번호 찾기 정보 일치시 임시 비밀번호 전송 및 db 수정
	@GetMapping(value = "findPwd")
	public ResponseEntity<Map<String, String>> getPwd(MemberVO vo){
		MemberVO check = service.checkMember(vo); 
		System.out.println(check);
		Map<String,String> map = new HashMap<>();
		if(check==null) map.put("msg", "아이디 또는 이메일이 일치하지 않습니다.");
		else {
			String characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	        StringBuilder pwd = new StringBuilder(10);
	        Random random = new Random();
	        for (int i = 0; i < 10; i++) {
	            int randomIndex = random.nextInt(characters.length());
	            pwd.append(characters.charAt(randomIndex));
	        }
		    
			String mailContext = vo.getId()+" 회원님의 비밀번호 입니다. <br><b>" + pwd + "</b>";
			try {
				MimeMessage mailMessage = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(mailMessage, true, "utf-8");
				helper.setFrom("milkyway3676@gamil.com");
				helper.setTo(vo.getEmail());
				helper.setSubject("i-Pet 회원 비밀번호 발송.");
				helper.setText(mailContext, true);
				mailSender.send(mailMessage);
				
				vo.setPassword(passEncoder.encode(pwd.toString()));
			    service.updatePwd(vo);
			    
				map.put("msg", "이메일로 비밀번호를 발송 했습니다.");
				
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
	@GetMapping("/mypage")
	public void mypage() {
		
	}
	
//	회원 정보 수정(mypage)
	@PostMapping("/update")
	public String memberUpdate(MemberVO vo,HttpSession session,RedirectAttributes rttr) {
		MemberVO updateMember = (MemberVO) session.getAttribute("loginMember");
		updateMember.setName(vo.getName());
		updateMember.setPhone(vo.getPhone());
		updateMember.setAddress1(vo.getAddress1());
		updateMember.setAddress2(vo.getAddress2());
		int result = service.update(updateMember);
		if(result==1) {
			session.setAttribute("loginMember", updateMember);
			rttr.addFlashAttribute("msg","수정이 완료됐습니다.");
		}else {
			rttr.addFlashAttribute("msg","오류가 발생했습니다.");
		}
		return "redirect:/member/mypage";
	}
	@GetMapping("/modifyPw")
	public void modifyPw() {
		
	}
	
//	사용자의 기존 비밀번호 비교
	@PostMapping("/pwCheck")
	public ResponseEntity<Map<String,String>> pwCheck(@RequestBody Map<String,String> map,HttpSession session){
		if(passEncoder.matches(map.get("password"),((MemberVO) session.getAttribute("loginMember")).getPassword())) {
			map.put("result", "Y");
		}else {
			map.put("result", "N");
		}
		return new ResponseEntity<Map<String,String>>(map,HttpStatus.OK);
	}
	
//	비밀번호 변경
	@Transactional
	@PostMapping("modifyPw")
	public ResponseEntity<Map<String,String>> modifyPw(@RequestBody Map<String,String> map,HttpSession session){
		System.out.println(map.get("password"));
		MemberVO vo =(MemberVO) session.getAttribute("loginMember");
		String pw = passEncoder.encode(map.get("password"));
		vo.setPassword(pw);
		service.updatePwd(vo);
		map.put("result", "비밀번호가 변경 됐습니다.");
		return new ResponseEntity<Map<String,String>>(map,HttpStatus.OK);
	}
	
//	회원정보 삭제
	@Transactional
	@GetMapping("/delete")
	public ResponseEntity<String> delete(HttpSession session) {
		MemberVO vo =(MemberVO)session.getAttribute("loginMember");
		service.delete(vo.getMno());
		return new ResponseEntity<String>("성공",HttpStatus.OK);
	}
	
//	회원가입시 이메일 존재 여부 확인
	@GetMapping("/checkEmail")
	public ResponseEntity<Map<String,String>> checkEmail(@Param("email")String email){
		String auth = service.searchAuth(email);
		HashMap<String, String> map = new HashMap<String, String>();
		if(auth != null) {
			map.put("result", "N");
			System.out.println(auth);
		}else {
			map.put("result", "Y");
		}
		return new ResponseEntity<Map<String,String>>(map,HttpStatus.OK);
	}
	
	@Transactional
	@GetMapping(value = "/insertCart",produces = "application/text; charset=utf8")
	public ResponseEntity<String> insertCart(@Param("pno")int pno, HttpSession session){
		CartVO cartVO = new CartVO();
		MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
		ProductVO productVO = service.getProduct(pno);
		cartVO.setMno(memberVO.getMno());
		cartVO.setPno(productVO.getPno());
		cartVO.setId(memberVO.getId());
		cartVO.setPname(productVO.getPname());
		cartVO.setPrice(productVO.getPrice());
		cartVO.setImageName(productVO.getImageName());
		cartVO.setCategory(productVO.getCategory());
		String msg = "";
		String check  = service.checkCart(cartVO.getMno(), cartVO.getPno());
		System.out.println(check);
		if(check == null) {
			service.insertCart(cartVO);
		
			msg = "장바구니에 담겼습니다.";
		}
		else {	
			
			msg ="이미 장바구니에 있습니다.";
		}
		return new ResponseEntity<>(msg,HttpStatus.OK);
	}
	
	@GetMapping(value = "/cart")
	public void goCartList(Model model,HttpSession session,Integer pageNum) {
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		Paging paging = new Paging(service.getCountCart(vo.getMno()),pageNum);
		List<CartVO> cartList = service.getCartList(vo.getMno(),paging.getOffset());
		model.addAttribute("cartList", cartList);
		model.addAttribute("paging",paging);
	}
	
	@GetMapping(value = "/deleteCart",produces = "application/text; charset=utf8")
	public ResponseEntity<String> deleteCart(@Param("pno") int pno, @Param("mno") int mno) {
		String msg="";
		System.out.println("mno : "+mno+"pno : "+pno);
		try {
			service.deleteCartFromMno(mno, pno);
			msg="장바구니에서 삭제 됐습니다.";
		} catch (Exception e) {
			msg="오류가 발생했습니다";
			System.out.println(e.getMessage());
			}
		return new ResponseEntity<String>(msg,HttpStatus.OK);
	}
	@PostMapping(value = "/purchase")
	public ResponseEntity<String> purchase(PurchaseVO vo) {
		service.purchase(vo);
		System.out.println(vo);
		return new ResponseEntity<String>("success",HttpStatus.OK);
	}
	@GetMapping(value = "/deleteAllCart",produces = "application/text; charset=utf8")
	public ResponseEntity<String> deleteAllCart(@Param("mno") int mno) {
		String msg="";
		System.out.println("mno : "+mno);
		service.deleteCartAll(mno);
		return new ResponseEntity<String>(msg,HttpStatus.OK);
	}
	@GetMapping(value = "/history")
	public void getHistory(@Param("mno")int mno,@Param("pageNum")Integer pageNum,Model model) {
		Paging paging = new Paging(service.getCountPurchase(mno),pageNum);
		int offset = paging.getOffset();
		model.addAttribute("paging", paging);
		model.addAttribute("purchaseList", service.getPurchaseList(mno, offset));
	}
	@GetMapping("/chat")
	public void chat() {
		
	}
}
