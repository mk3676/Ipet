package com.suwon.ezen.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.suwon.ezen.service.BoardService;
import com.suwon.ezen.vo.BoardVO;
import com.suwon.ezen.vo.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/community/*")
@Log4j
public class CommunityController {
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	// 게시글 추가 화면으로 이동
	@GetMapping("insert")
	public ModelAndView startInsertion() {
		ModelAndView model = new ModelAndView();
		model.setViewName("/board/insert");
		
		return model;
	}
	
	// 무작위의 n자리 숫자 생성
	public String generateRandNumber(int n) {
		String randNumber = "";
		
		for (int i=0;i<n;i++)
			randNumber += (int)(Math.random()*10);
		
		return randNumber;
	}
	
	// 게시글 추가 화면에서 DB에 데이터 추가하기
	@PostMapping("/insert")
	public ResponseEntity<HashMap<String, String>> insertContent(@ModelAttribute BoardVO vo) {
		System.out.println("게시글 추가: 들어오니?");
		System.out.println("게시글 vo: " + vo);

		String uploadFolder = "C:\\Users\\upload\\boardImage\\";
		String uploadFileNameList = "";
		
		System.out.println(vo.getImgList());
		
		if (vo.getImgList() != null) {
			for (MultipartFile file: vo.getImgList()) {
				if (file.getOriginalFilename() != null && !file.getOriginalFilename().isEmpty()) {
					File uploadPath = new File(uploadFolder);
					
					String uploadFileName = file.getOriginalFilename();
					uploadFileName = vo.getWriter() + generateRandNumber(6) + uploadFileName;
					uploadFileNameList += uploadFileName + "#";
					
					File saveFile = new File(uploadPath, uploadFileName);
					
					try {
						file.transferTo(saveFile); 
					} catch (Exception e) {
						System.out.println("업로드 실패 => " + uploadFileName + ": " + e.getMessage());
					}
				}
			}
			
			vo.setImagePath(uploadFolder);
			vo.setImageName(uploadFileNameList);
		}

		
		service.insertContent(vo);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("text", "추가되었습니다.");
		return new ResponseEntity<HashMap<String, String>>(map, HttpStatus.OK);
	}

	// 게시글 읽기 화면으로 이동
	@GetMapping("/read")
    public ModelAndView readContent(@RequestParam("bno") int bno) {
		System.out.println("게시글 읽기: " + bno);
		ModelAndView model = new ModelAndView();
		model.setViewName("/board/read");
		// 나중에 서비스 정리하기
		model.addObject("data", service.getOneContent(bno));
		
		// 모든 댓글 가져오기
		// 나중에 서비스 정리하기
		List<ReplyVO> replyList = service.getAllReply(bno);
		model.addObject("replyList", replyList);
		
		
		return model;
	}
	
	// 게시글 수정 화면으로 이동
	@GetMapping("/modify")
	public ModelAndView toModifyContent(@RequestParam("bno") int bno) {
		ModelAndView model = new ModelAndView();
		model.setViewName("/board/modifyContent");
		model.addObject("data", service.getOneContent(bno));
		
		return model;
	}
	
	// 게시글 수정하기
	@PostMapping("/modify")
	public ResponseEntity<HashMap<String, String>> modifyContent(@ModelAttribute BoardVO vo) throws Exception {
		System.out.println("게시글 수정하기: " + vo);
		// DB에서 기존 게시글 가져오기
		BoardVO pastVO = service.getOneContent(vo.getBno());
		
		String uploadFileNameList = "";
		String uploadFolder = "C:\\Users\\upload\\boardImage\\";
    	
		// 이미지 수정: 이미지 파일을 받아 로컬 파일에 저장하고 DB의 데이터를 교체한다.
		// 수정 페이지에서 추가한 이미지가 존재하는 경우: 
		if (vo.getImgList() != null) {
			for (MultipartFile file: vo.getImgList()) {
				if (file.getOriginalFilename() != null && !file.getOriginalFilename().isEmpty()) {
					File uploadPath = new File(uploadFolder);
					
					String uploadFileName = file.getOriginalFilename();
					uploadFileName = vo.getWriter() + generateRandNumber(6) + uploadFileName;
					uploadFileNameList += uploadFileName + "#";
					
					File saveFile = new File(uploadPath, uploadFileName);
					
					try {
						file.transferTo(saveFile); 
						
			    		// 기존 댓글에 이미지가 있다면 파일 시스템에서 이미지를 삭제
			    		if (pastVO.getImageName() != null) {
			    			String[] pastImgList = pastVO.getImageName().split("#");
			    			
			    			for (String pastImg: pastImgList) {
			    				File pastFile = new File(pastVO.getImagePath() + pastImg);
			    				pastFile.delete();
			    			}					
			    		}
					} catch (Exception e) {
						System.out.println("업로드 실패 => " + uploadFileName + ": " + e.getMessage());
					}
					
					vo.setImagePath(uploadFolder);
					vo.setImageName(uploadFileNameList);
				}

			}
		}
		else {
			vo.setImageName(pastVO.getImageName());
		}
		
		    	
		service.modifyContent(vo);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("text", "수정되었습니다.");
		return new ResponseEntity<HashMap<String, String>>(map, HttpStatus.OK);
	}
	
	// 게시글 삭제하기
	@DeleteMapping("/delete")
	public ResponseEntity<HashMap<String, String>> deleteContent(@RequestBody int bno) {
		System.out.println("게시글 삭제하기: " + bno);
		
		// 이미지 삭제: 파일 시스템에서 이미지 파일 삭제하기
		BoardVO boardVO = service.getOneContent(bno);
		
		if (boardVO.getImageName() != null) {
			File file = new File(boardVO.getImagePath() + boardVO.getImageName()); 
			file.delete(); 
		}
	
		// 게시글 삭제
		service.deleteContent(bno);
		// 댓글 삭제
		service.deleteAllReplyByBno(bno);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("text", "삭제하였습니다.");
		return new ResponseEntity<HashMap<String, String>>(map, HttpStatus.OK);
	}
	
	// 게시글 이미지 보여주기
	@GetMapping("/displayContent")
	public ResponseEntity<byte[]> getContentFile(String imageName) { 
		log.info("upload controller file display: " + imageName);
		File file = new File("C:\\Users\\upload\\boardImage\\" + imageName);
		log.info("file 객체 : "+ file);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 댓글 이미지 보여주기
	@GetMapping("/displayReply")
	public ResponseEntity<byte[]> getReplyFile(String imageName) { 
		log.info("upload controller file display: " + imageName);
		File file = new File("C:\\Users\\upload\\replyImage\\" + imageName);
		log.info("file 객체 : "+ file);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 댓글 추가
	@PostMapping("/insertReply")
	public ResponseEntity<HashMap<String, String>> insertReply(@ModelAttribute ReplyVO vo) {
		System.out.println("댓글 추가: 들어오니?");
		System.out.println("댓글 vo: " + vo);

		String uploadFolder = "C:\\Users\\upload\\replyImage\\";
		String uploadFileNameList = "";
	
		if (vo.getImgList() != null) {
			for (MultipartFile file: vo.getImgList()) {
				if (file.getOriginalFilename() != null && !file.getOriginalFilename().isEmpty()) {
					File uploadPath = new File(uploadFolder);
					
					String uploadFileName = file.getOriginalFilename();
					uploadFileName = vo.getId() + generateRandNumber(6) + uploadFileName;
					uploadFileNameList += uploadFileName + "#";
					
					File saveFile = new File(uploadPath, uploadFileName);
					
					try {
						file.transferTo(saveFile); 
					} catch (Exception e) {
						System.out.println("업로드 실패 => " + uploadFileName + ": " + e.getMessage());
					}
				}
			}
			
			vo.setImagePath(uploadFolder);
			vo.setImageName(uploadFileNameList);
		}
		    
	    // Reply DB에 저장
	    service.insertReply(vo);

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("text", "전송 완료");
		return new ResponseEntity<HashMap<String, String>>(map, HttpStatus.OK);
	}
		    
	// 댓글 수정을 위해 해당 댓글을 새 창에 보여줌
	@GetMapping("/modifyReply")
	public ModelAndView modifyReply(@RequestParam("rno") int rno, @RequestParam("bno") int bno) {
		ModelAndView model = new ModelAndView();
		model.setViewName("/board/modifyReply");
		// 댓글을 ModelAndView에 저장
		model.addObject("reply", service.getOneReply(rno));
		
		return model;
	}
		
	// 댓글 수정
	@PostMapping(value = "/modifyReply")
	public ResponseEntity<HashMap<String, String>> modifyAndReloadReply(@ModelAttribute ReplyVO vo) {
		System.out.println("댓글 수정: " + vo);
		// DB에서 기존 댓글 가져오기
		ReplyVO pastVO = service.getOneReply(vo.getRno());
		
		String uploadFileNameList = "";
		String uploadFolder = "C:\\Users\\upload\\replyImage\\";
		 
		// 이미지 수정: 이미지 파일을 받아 로컬 파일에 저장하고 DB의 데이터를 교체한다.
		// 수정 페이지에서 추가한 이미지가 존재하는 경우: 
		if (vo.getImgList() != null) {
			for (MultipartFile file: vo.getImgList()) {
				if (file.getOriginalFilename() != null && !file.getOriginalFilename().isEmpty()) {
					File uploadPath = new File(uploadFolder);
					
					String uploadFileName = file.getOriginalFilename();
					uploadFileName = vo.getId() + generateRandNumber(6) + uploadFileName;
					uploadFileNameList += uploadFileName + "#";
					
					File saveFile = new File(uploadPath, uploadFileName);
					
					try {
						file.transferTo(saveFile); 
						
			    		// 기존 댓글에 이미지가 있다면 파일 시스템에서 이미지를 삭제
			    		if (pastVO.getImageName() != null) {
			    			String[] pastImgList = pastVO.getImageName().split("#");
			    			
			    			for (String pastImg: pastImgList) {
			    				File pastFile = new File(pastVO.getImagePath() + pastImg);
			    				pastFile.delete();
			    			}					
			    		}
					} catch (Exception e) {
						System.out.println("업로드 실패 => " + uploadFileName + ": " + e.getMessage());
					}
					
					vo.setImagePath(uploadFolder);
					vo.setImageName(uploadFileNameList);
				}
			}
		}	
		// 게시글을 추가할 떄 이미지를 넣었지만 게시글을 수정하면서 이미지를 넣지 않았을 경우:
		else {
			vo.setImageName(pastVO.getImageName());
		}

	    // Reply DB에 저장
		 service.modifyReply(vo);
			
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("text", "수정되었습니다");
		return new ResponseEntity<HashMap<String, String>>(map, HttpStatus.OK);
	}
		
	// 댓글 삭제
	@DeleteMapping(value = "/deleteReply")
	public ResponseEntity<HashMap<String, String>> deleteReply(@RequestBody int rno) {		
					
		System.out.println("rno값: " + rno );
		// 이미지 삭제: 파일 시스템에서 이미지 파일 삭제하기
		ReplyVO replyVO = service.getOneReply(rno);
		
		if (replyVO.getImageName() != null) {
			File file = new File(replyVO.getImagePath() + replyVO.getImageName()); 
			file.delete(); 
		}

		// 댓글 삭제 
		service.deleteReply(rno);
		 
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("text", "삭제되었습니다");
		return new ResponseEntity<HashMap<String, String>>(map, HttpStatus.OK);
	}
	
}
