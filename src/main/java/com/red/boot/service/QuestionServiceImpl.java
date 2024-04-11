package com.red.boot.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.red.boot.domain.PageInfo;
import com.red.boot.domain.QaVo;
import com.red.boot.domain.QuestionVO;
import com.red.boot.mapper.QuestionMapper;

import lombok.AllArgsConstructor;
import lombok.ToString;

@Service
@AllArgsConstructor
@ToString
public class QuestionServiceImpl implements QuestionService {

	QuestionMapper mapper;

	// 자기 문의 내역
	@Override
	public List<QuestionVO> getList(PageInfo pi, int userNum) {
		return mapper.getListWithPaging(pi ,userNum);
	}

	// 페이징 관련
	@Override
	public int getTotal(PageInfo pi,  int userNum) {
		return mapper.getTotalCount(pi, userNum);
	}

	// 게시글 등록
	@Override
	public int insertQuestion(QuestionVO qVo) {
		return mapper.insertQuestion(qVo);
	}

	// 상세보기
	@Override
	public QuestionVO get(int questionNumber) {
		return mapper.getQuestionOne(questionNumber);
	}

	// 회원 문의 내역 조회(관리자)
	@Override
	public List<QuestionVO> getListWithPagingAdmin(PageInfo pi) {
		return mapper.getListWithPagingAdmin(pi);
	}
	
	@Override
	public List<QuestionVO> getCompleteList(PageInfo pi, int questionComplete){
		return mapper.getCompleteList(pi, questionComplete);
	}
	
	@Override
	public int getTotlaCountAdmin(PageInfo pi) {
		return mapper.getTotlaCountAdmin(pi);
	}
	
	@Override
	public int getTotlaComplete(PageInfo pi, int questionComplete) {
		return mapper.getTotlaComplete(pi, questionComplete);
	}

	// 관리자 상세보기
	@Override
	public QuestionVO adminGetDetail(int questionNumber) {
		return mapper.adminGetDetail(questionNumber);
	}

	
	@Override
	public int updateComplete(int questionNumber) {
		return mapper.updateComplete(questionNumber);
	}



}