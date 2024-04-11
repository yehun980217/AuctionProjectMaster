package com.red.boot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.red.boot.domain.PageInfo;
import com.red.boot.domain.QuestionVO;

@Mapper
public interface QuestionMapper {
   // 페이징
   public List<QuestionVO> getListWithPaging(PageInfo pi, int userNum);

   // 페이징
   public int getTotalCount(PageInfo pi,  int userNum);
   
   // 등록
   public int insertQuestion(QuestionVO qVo);
   
   // 상세
   public QuestionVO getQuestionOne(int questionNumber);
   
   // 회원 문의 내역 조회 관리자
   public List<QuestionVO> getListWithPagingAdmin(PageInfo pi);
   
   public List<QuestionVO> getCompleteList(PageInfo pi, int questionComplete);
   
   public int getTotlaComplete(PageInfo pi, int questionComplete);
   
   public int getTotlaCountAdmin(PageInfo pi);
   
   //관리자 문의 상세
   public QuestionVO adminGetDetail(int questionNumber);
   
   public int updateComplete(int questionNumber);
}