package com.red.boot.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.red.boot.domain.ItemVo;
import com.red.boot.domain.PageInfo;
import com.red.boot.mapper.ItemMapper;

import lombok.AllArgsConstructor;
import lombok.ToString;

@Service
@AllArgsConstructor
@ToString
public class ItemServiceImpl implements ItemService {
	
	ItemMapper mapper ;
	

	@Override
	public ItemVo get(Long itemNum) {
		return mapper.getItemOne(itemNum);
	}
	

	@Override
	public int register(ItemVo item) {
		return mapper.insertItem(item);
		
	}

	@Override
	public int modify(ItemVo item) {
		return mapper.updateItem(item);
	}

	@Override
	public int remove(Long itemNumber) {
		return mapper.deleteItem(itemNumber);
	}

	@Override
	public List<ItemVo> getList(PageInfo pi) {
		return mapper.getListWithPaging(pi) ;
	}

	@Override
	public int getTotal(PageInfo pi) {
		return mapper.getTotalCount(pi);
	}


	@Override
	public List<ItemVo> getListHaving(PageInfo pi, int itemHave) {
		return mapper.getListByHave(pi, itemHave);
	}
	
	@Override
	public int getTotalByHave(PageInfo pi, int itemHave) {
		return mapper.getTotalCountByHave(pi, itemHave);
	}


	@Override
	public int modifyTrade(Long itemNumber, String tradeIng) {
		return mapper.updateTradeIng(itemNumber, tradeIng);
	}


	@Override
	public int modifyHave(Long itemNumber, int itemHave) {
		return mapper.updateItemHave(itemNumber, itemHave);
	}



}
