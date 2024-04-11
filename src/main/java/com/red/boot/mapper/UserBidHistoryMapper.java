package com.red.boot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.red.boot.domain.PageInfo;
import com.red.boot.domain.UserBidHistoryVo;

@Mapper
public interface UserBidHistoryMapper {

	//추가하기
	public int insertUserBid(UserBidHistoryVo userBid);
	
	//낙찰로 변경하기
	public int updateUserBidYN(long userBidNumber);
	
	//트레이드번호에 대한 히스토리
	public List<UserBidHistoryVo> getUserBidListByTradeNumber(long tradeNumber);
	
	
	//유저번호 대한 히스토리
	public List<UserBidHistoryVo> getUserBidListByUserNum(int userNum, PageInfo pi);
	
	public int getUserBidListByUserNumCount(int userNum) ;
	

}
