package com.red.boot.service;

import java.util.List;


import com.red.boot.domain.ItemVo;
import com.red.boot.domain.PageInfo;

public interface ItemService {
		
	// 글 가져오기
	public ItemVo get(Long itemNumber);
	
	// 글 등록
	public int register(ItemVo item);
	
	//글 수정
	public int modify(ItemVo item);
	
	//글 삭제하기
	public int remove(Long itemNumber);
	
	//페이징 처리한거 가져오기
	public List<ItemVo> getList(PageInfo pi);
	
	//총 게시물 갯수
	public int getTotal(PageInfo pi);
	
	//페이징 처리 및 보유 여부 확인 후 가져오기
	public List<ItemVo> getListHaving(PageInfo pi, int itemHave);

	//보유 여부 확인 후 총 갯수
	public int getTotalByHave(PageInfo pi, int itemHave);
	
	//트레이드 진행 중 확인
	public int modifyTrade(Long itemNumber, String tradeIng);
	
	//아이템 보유여부 변경
	public int modifyHave(Long itemNumber, int itemHave);
}

































