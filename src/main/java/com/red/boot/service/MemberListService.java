package com.red.boot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.red.boot.domain.MemberVO;
import com.red.boot.domain.PageInfo;
import com.red.boot.mapper.MemberListMapper;

@Service
@Transactional
public class MemberListService {
   
   // DI 의존성 주입 생성자 메서드 주입방식
   @Autowired
   private MemberListMapper memberListMapper;
   
   public MemberListService(MemberListMapper memberListMapper) {
      
      this.memberListMapper = memberListMapper;
   }
   
   public List<MemberVO> getMemberList(PageInfo pi) {
      List<MemberVO> memberList = memberListMapper.getMemberList(pi);
      
      return memberList;
   }
   
   public List<MemberVO> getMemberListAdmin(PageInfo pi) {
      List<MemberVO> memberListAdmin = memberListMapper.getMemberListAdmin(pi);
      
      return memberListAdmin;
   }
   
   public void updateUserRole(int userNum, int userRole) {

        memberListMapper.updateUserRole(userNum, userRole);
        
   }
   
   public void deleteMemberByNum(String userNum) {
      
        memberListMapper.deleteMemberByNum(userNum);
      
   }
   
   // 총 갯수
   public int getTotalCount(PageInfo pi) {
      return memberListMapper.getTotalCount(pi) ;
   }
   
   // 총 갯수(관리자 제외)
   public int getTotalCountAdmin(PageInfo pi) {
      return memberListMapper.getTotalCountAdmin(pi);
   }
   
}