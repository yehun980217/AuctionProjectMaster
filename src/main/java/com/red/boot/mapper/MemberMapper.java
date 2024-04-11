package com.red.boot.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.red.boot.domain.MemberVO;

@Mapper
public interface MemberMapper {
    MemberVO findByUserIdAndPassword(String userId, String userPw);
    
    MemberVO findByUserId(String userId);

    
    String findByUserNum(int userNum);
    
    public int updateEmailRole(String userId);
    
    int updateUserCashPlus(MemberVO member);
    
    int updateUserCashMinus(MemberVO member);
    
    String findUserId(String userName, String userPhoneNum);
    
    String findUserPw(String userId, String userName, String userPhoneNum);
    
	public void deleteUser(String userId, String userPw);
	    
    public void modifyUserInfo(String userId, String userPw, String userName, String userAddress);
    
    public void updateChangeUserPw(String userPw, String userId);
}
