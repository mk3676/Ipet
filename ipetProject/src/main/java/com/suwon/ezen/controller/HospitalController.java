package com.suwon.ezen.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.suwon.ezen.service.HospitalService;
import com.suwon.ezen.vo.HospitalVO;
import com.suwon.ezen.vo.Paging;

import lombok.Setter;

@RestController
@RequestMapping("/hospital/*")
public class HospitalController {
	@Setter
	(onMethod_ =@Autowired )
	private HospitalService service;
	
	// 검색하려는 동물병원 이름과 주소가 없으면 N 값 으로 넘어옴
	// 만약 병원 이름과 주소중 한쪽에만 N가 있다면 다른 한쪽을 검색하는것으로 판단하여 해당 지역과 검색하려는 검색어를 가져와 jsp로 출력
	@GetMapping(value = "check_hos")
	public ModelAndView getList(ModelAndView mnv, @Param("address")String address,@Param("pageNum")Integer pageNum,
			@Param("searchName")String searchName,@Param("searchAddress")String searchAddress){
		
		ModelAndView model = new ModelAndView();
		if(!searchAddress.equals("N")) {
			Paging paging = new Paging(service.countBysearchAddress(address,searchAddress),pageNum);
			List<HospitalVO> voList = service.getBysearchAddressPaging(address, searchAddress,paging.getOffset());
			model.addObject("voList",voList );
			model.addObject("paging",paging);
		}if(!searchName.equals("N")) {
			Paging paging = new Paging(service.countBysearchName(address,searchName),pageNum);
			List<HospitalVO> voList = service.getBysearchNamePaging(address, searchName,paging.getOffset());
			model.addObject("voList",voList );
			model.addObject("paging",paging);
		}
		if(searchAddress.equals("N") && searchName.equals("N")){
			Paging paging = new Paging(service.getCount(address), pageNum);
			List<HospitalVO> voList = service.getListPagin(address, paging.getOffset());
			model.addObject("voList",voList );
			model.addObject("paging",paging);
		}
		model.setViewName("hospital");
		model.addObject("index", 3);
		model.addObject("address", address);
		model.addObject("searchName",searchName);
		model.addObject("searchAddress", searchAddress);
		return model;
	}
}
