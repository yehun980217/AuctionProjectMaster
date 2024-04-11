package com.red.boot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.red.boot.domain.MemberVO;
import com.red.boot.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
   
   @Autowired
   private MemberMapper memberMapper;

   @Override
   public MemberVO findByUserIdAndPassword(MemberVO member) {
      return memberMapper.findByUserIdAndPassword(member.getUserId(),member.getUserPw());
   }
   
   @Override
    public MemberVO getUserInfoByUserId(String userId) {
        return memberMapper.findByUserId(userId);
    }

   @Override
   public String getUserId(int userNum) {
      return memberMapper.findByUserNum(userNum) ;
   }
   
   @Override
      public int updateEmailRole(String userId) {
         return memberMapper.updateEmailRole(userId);
      }

   @Override
   public int updateCashPlus(MemberVO member) {
      return memberMapper.updateUserCashPlus(member);
   }

   @Override
   public int updateCashMinus(MemberVO member) {
      // TODO Auto-generated method stub
      return memberMapper.updateUserCashMinus(member);
   }
   
   @Override
   public String findUserId(String userName, String userPhoneNum) {
      // TODO Auto-generated method stub
      return memberMapper.findUserId(userName, userPhoneNum );
   }
   
   @Override
   public String findUserPw(String userId, String userName, String userPhoneNum) {
      // TODO Auto-generated method stub
      return memberMapper.findUserPw(userId, userName, userPhoneNum);
   }
   
   @Override
   public void deleteUser(String userId, String userPw) {
       memberMapper.deleteUser(userId, userPw);
   }
      
   @Override
   public void modifyUserInfo(String userId, String userPw, String userName, String userAddress) {
       memberMapper.modifyUserInfo(userId, userPw, userName, userAddress);
      }
   @Override
      public void updateChangeUserPw(String userPw, String userId) {
         memberMapper.updateChangeUserPw(userPw, userId);
      }
}