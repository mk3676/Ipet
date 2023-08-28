package com.suwon.ezen.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PurchaseVO {
	private int purchaseNo;
	private int mno;
	private int pno;
	private String pname;
	private String price;
	private int amount;
	private int total;
	private String delivery;
	private String id;
	private String category;
	private Date paydate;
	private int offset;
}
