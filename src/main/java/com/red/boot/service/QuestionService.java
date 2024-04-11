package com.red.boot.service;

import java.util.List;

import com.red.boot.domain.MemberVO;
import com.red.boot.domain.PageInfo;
import com.red.boot.domain.QaVo;
import com.red.boot.domain.QuestionVO;

public interface QuestionService {

	// 페이징 처리한거 가져오기
	public List<QuestionVO> getList(PageInfo pi, int userNum);

	// 총 게시물 갯수
	public int getTotal(PageInfo pi, int userNum);

	// 게시물 등록
	public int insertQuestion(QuestionVO qVo);

	// 상세보기
	public QuestionVO get(int questionNumber);

	// 회원 문의 내역 조회(관리자)
	public List<QuestionVO> getListWithPagingAdmin(PageInfo pi);
	
	public List<QuestionVO> getCompleteList(PageInfo pi, int questionComplete);
	
	public int getTotlaComplete(PageInfo pi, int questionComplete);
	
	// 관리자 총 게시물 갯수
	public int getTotlaCountAdmin(PageInfo pi);
	
	// 관리자 상세보기
	public QuestionVO adminGetDetail(int questionNumber);
	
	// 상태 업데이트
	public int updateComplete(int questionNumber);
	
}