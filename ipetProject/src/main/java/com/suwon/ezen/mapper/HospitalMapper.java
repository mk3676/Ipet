package com.suwon.ezen.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.suwon.ezen.vo.HospitalVO;

public interface HospitalMapper {
	public List<HospitalVO> getAll();
	public List<HospitalVO> getByAddress(String address);
	public int countByAddress(String address);
	public List<HospitalVO> getByAddressPaging(@Param("address")String address, @Param("offset")int offset);
	public List<HospitalVO> getBysearchAddressPaging(@Param("address")String address,@Param("searchAddress")String searchAddress ,@Param("offset")int offset);
	public int countBysearchAddress(@Param("address")String address, @Param("searchAddress")String searchAddress);
	public List<HospitalVO> getBysearchNamePaging(@Param("address")String address,@Param("searchName")String searchName ,@Param("offset")int offset);
	public int countBysearchName(@Param("address")String address, @Param("searchName")String searchName);
}
