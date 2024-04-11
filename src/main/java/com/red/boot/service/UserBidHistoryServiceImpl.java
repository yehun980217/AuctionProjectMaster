package com.red.boot.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.red.boot.domain.AnnouncementVo;
import com.red.boot.domain.PageInfo;
import com.red.boot.domain.UserBidHistoryVo;
import com.red.boot.mapper.AnnouncementMapper;
import com.red.boot.mapper.UserBidHistoryMapper;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Service
@AllArgsConstructor
@ToString
public class UserBidHistoryServiceImpl implements UserBidHistoryService {
	
	UserBidHistoryMapper mapper ;
	

	@Override
	public int register(UserBidHistoryVo userBid) {
		return mapper.insertUserBid(userBid) ;	
	}


	@Override
	public int updateYn(long userBidNumber) {
		return mapper.updateUserBidYN(userBidNumber);
	}


	@Override
	public List<UserBidHistoryVo> getListByTradeNumber(long tradeNumber) {
		return mapper.getUserBidListByTradeNumber(tradeNumber);
	}


	@Override
	public List<UserBidHistoryVo> getListByUserNum(int userNum, PageInfo pi) {
		return mapper.getUserBidListByUserNum(userNum, pi);
	}


	@Override
	public int getTotalByUserNum(int userNum) {
		return mapper.getUserBidListByUserNumCount(userNum) ;
	}





}
