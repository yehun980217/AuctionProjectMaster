package com.red.boot.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PageDTO {
	private int startPage;
	private int endPage;
	private int total;
	
	private boolean preView;
	private boolean nextView;
	
	private PageInfo pi;
	
	public PageDTO(PageInfo pi, int total) {
		this.pi = pi;
		this.total = total;
		
		//현재 5번페이지일 때 마지막 페이지가 어디인지 ? 5/10.0 ?? 0.5 올리면 1 > 10
		//10페이지면 > 10/10.0 >> 1.0 올려 소수점에서 > 1 > 10
		//43번이야 >> 4.3 >> 5 > 50
		//97번이야 > 9.7 > 10 > 100
		this.endPage = (int)(Math.ceil(pi.getPageNo()/10.0)) * 10 ;
		this.startPage = endPage - 9;
		
		
		//실제끝나는 번호 
		//내가 글이 101번까지 있는데 11번 페이지를 갔을 때 ? 20번 페이지가 필요가 없어
		//101번이면 >> 11번까지만 있으면 돼
		//101.0 / 10(amount) // 10.10 //11.00 > 11 > realend
		int realEnd = (int)(Math.ceil((total * 1.0) / pi.getAmount()));
		
		if(endPage > realEnd) {
			endPage = realEnd;
		}
		
		this.preView = this.startPage > 1;
		this.nextView = endPage < realEnd; 
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
