package com.red.boot.service;

import java.util.List;

import com.red.boot.domain.PageInfo;
import com.red.boot.domain.UserBidHistoryVo;

public interface UserBidHistoryService {


	// 글 등록
	public int register(UserBidHistoryVo userBid);
	
	//낙찰 변경
	public int updateYn(long userBidNumber) ;
	
	
	//트레이드 당 낙찰리스트 불러오기
	public List<UserBidHistoryVo> getListByTradeNumber(long tradeNumber);
	
	//유저 당 낙찰리스트 전체 불러오기
	public List<UserBidHistoryVo> getListByUserNum(int userNum, PageInfo pi);
	
	//유저 낙찰 리스트 갯수
	public int getTotalByUserNum(int userNum);
	
}
