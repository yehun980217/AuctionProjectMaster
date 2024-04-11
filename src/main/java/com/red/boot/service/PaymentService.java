package com.red.boot.service;

import com.red.boot.domain.MemberVO;

public interface PaymentService {

	public int updateUserPayment(MemberVO member);
	
	public String showUserCash(String userId);
}
