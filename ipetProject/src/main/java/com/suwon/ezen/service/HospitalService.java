package com.suwon.ezen.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.suwon.ezen.vo.HospitalVO;

public interface HospitalService {
	public List<HospitalVO> getList(String address);
	public int getCount(String address);
	public List<HospitalVO> getListPagin(String address, int offset);
	public List<HospitalVO> getBysearchAddressPaging(String address,String searchAddress ,int offset);
	public int countBysearchAddress(String address, String searchAddress);
	public List<HospitalVO> getBysearchNamePaging(String address,String searchName ,int offset);
	public int countBysearchName(String address, String searchName);
}
