package com.red.boot.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.red.boot.domain.MemberVO;

@Mapper
public interface PaymentMapper {

	public int updateUserPayment(MemberVO member);
	
	public String showUserCash(String userId);
}
