package com.red.boot.service;

import java.util.List;

import com.red.boot.domain.AnnouncementVo;
import com.red.boot.domain.PageInfo;
import com.red.boot.domain.QaVo;

public interface QaService {
	
	//전체 가져오기
	public List<QaVo> getList();
	
	// 글 가져오기
	public QaVo get(Long qaNumber);
	
	// 글 등록
	public int register(QaVo qaVo);
	
	//글 수정
	public int modify(QaVo qaVo);
	
	//글 삭제하기
	public int remove(Long qaNumber);
	
	//전체 가져오기
	public List<QaVo> getListByType(String qaType);
	
}
