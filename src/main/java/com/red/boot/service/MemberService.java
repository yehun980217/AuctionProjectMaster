package com.red.boot.service;

import com.red.boot.domain.MemberVO;

public interface MemberService {
	MemberVO findByUserIdAndPassword(MemberVO member);
	
	MemberVO getUserInfoByUserId(String userId);

	String getUserId(int userNum);
	
	public int updateEmailRole(String userId);
	
	public int updateCashPlus(MemberVO member);
	
	public int updateCashMinus(MemberVO member);
	
	public String findUserId(String userName, String userPhoneNum);
	
	public String findUserPw(String userId, String userName, String userPhoneNum);
	
	public void deleteUser(String userId, String userPw);
	   
	public void modifyUserInfo(String userId, String userPw, String userName, String userAddress);
	
	public void updateChangeUserPw(String userPw, String userId);
}
