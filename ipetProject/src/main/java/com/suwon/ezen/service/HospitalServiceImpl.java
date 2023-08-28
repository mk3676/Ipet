package com.suwon.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suwon.ezen.mapper.HospitalMapper;
import com.suwon.ezen.vo.HospitalVO;

import lombok.Setter;

@Service
public class HospitalServiceImpl implements HospitalService {
	@Setter
	(onMethod_ =@Autowired )
	private HospitalMapper mapper;
	
	@Override
	public List<HospitalVO> getList(String address) {
		 List<HospitalVO> voList = mapper.getByAddress(address);
		return voList;
	}

	@Override
	public int getCount(String address) {
		
		return mapper.countByAddress(address);
	}

	@Override
	public List<HospitalVO> getListPagin(String address, int offset) {
		
		return mapper.getByAddressPaging(address, offset);
	}

	@Override
	public List<HospitalVO> getBysearchAddressPaging(String address, String searchAddress, int offset) {
		
		return mapper.getBysearchAddressPaging(address, searchAddress, offset);
	}

	@Override
	public int countBysearchAddress(String address, String searchAddress) {
		 
		return mapper.countBysearchAddress(address, searchAddress);
	}

	@Override
	public List<HospitalVO> getBysearchNamePaging(String address, String searchName, int offset) {
		 
		return mapper.getBysearchNamePaging(address, searchName, offset);
	}

	@Override
	public int countBysearchName(String address, String searchName) {
		 
		return mapper.countBysearchName(address, searchName);
	}

}
