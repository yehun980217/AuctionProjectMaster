package com.red.boot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.red.boot.domain.ItemVo;
import com.red.boot.domain.PageInfo;
import com.red.boot.domain.QaVo;

@Mapper
public interface ItemMapper {


	
	//Item 하나 받기
	public ItemVo getItemOne(Long itemNumber);
	
	//Item 삭제하기
	public int deleteItem(Long itemNumber);
	
	//Item 변경하기
	public int updateItem(ItemVo itemVo);
	
	//Item 추가하기
	public int insertItem(ItemVo itemVo);
	
	//Item 페이지에 나오게 할 거.
	public List<ItemVo> getListWithPaging(PageInfo pi) ;
	
	//Item 총 갯수
	public int getTotalCount(PageInfo pi);
	
	//Item 각 카테고리에 맞춰서 나오게 하기
	public List<ItemVo> getListByHave(PageInfo pi, int itemHave) ;
	
	//Item 보유 여부에 대한 총 갯수
	public int getTotalCountByHave(PageInfo pi, int itemHave);
	
	//ITEM이 경매에 진행중인지
	public int updateTradeIng(Long itemNumber, String tradeIng);
	
	public int updateItemHave(Long itemNumber, int itemHave);
}
