package com.suwon.ezen.vo;

import lombok.Data;

@Data
public class Paging {
	
	private Integer pageNum;
	private int total;
	private int amount=15;
	private Integer startNum;
	private int lastNum;
	private boolean next;
	private boolean prev;
	private int offset;
	
	
	public Paging(int total,Integer pageNum) {
		this.pageNum = pageNum;
		this.total = total;
		
		this.lastNum =(int)(Math.ceil(total/(double)this.amount));
		
		if(pageNum == null) this.startNum=1;
		else this.startNum = (int)((this.pageNum*0.1)-0.1)*10+1;
			
		if(this.startNum > 10) this.prev=true;
		else this.prev=false;

		if((lastNum-startNum)>=10) {
			this.next=true;
		}
		if(this.pageNum==null) this.offset=0 ;
		else this.offset = (this.pageNum-1)*this.amount;
		
		
	}

	
}