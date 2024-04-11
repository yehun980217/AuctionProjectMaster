package com.red.boot.mapper;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;

import com.red.boot.domain.MemberVO;
import com.red.boot.domain.PageInfo;

@Mapper
public interface MemberListMapper {

   //회원 전체목록 조회
   public List<MemberVO> getMemberList(PageInfo pi);
   
   public List<MemberVO> getMemberListAdmin(PageInfo pi);
   
   public void updateUserRole(int userNum, int userRole);
   
   public void deleteMemberByNum(String userNum);
   
   // 총 갯수
   public int getTotalCount(PageInfo pi);
   
   // 총 갯수
   public int getTotalCountAdmin(PageInfo pi);
}