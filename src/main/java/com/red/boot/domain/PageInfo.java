package com.red.boot.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PageInfo {
	private int pageNo;	//현재 페이지 정보
	private int amount;	//한 페이지에 들어갈 양
	private String type;	//글의 종류 (판매중, 판매완료) 한글자로 받아서 활용 
	private String keyword;	//검색했을 때 
	
	public PageInfo() {
		this(1, 10);
	}

	public PageInfo(int pageNo, int amount) {
		this.pageNo = pageNo;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type==null? new String[] {} : type.split("");
	}
	
}
