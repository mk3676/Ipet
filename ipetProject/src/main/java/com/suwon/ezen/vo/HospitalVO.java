package com.suwon.ezen.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class HospitalVO {
	private int hno;
	private String address;
	private String name;
	private String x_cor;
	private String y_cor;
}
