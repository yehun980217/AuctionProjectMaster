package com.red.boot.service;

import java.util.List;

import com.red.boot.domain.AnnouncementVo;
import com.red.boot.domain.PageInfo;

public interface AnnouncementService {
	
	//전체 가져오기
	public List<AnnouncementVo> getList();
	
	// 글 가져오기
	public AnnouncementVo get(Long announcementNumber);
	
	// 글 등록
	public int register(AnnouncementVo announcement);
	
	//글 수정
	public int modify(AnnouncementVo announcement);
	
	//글 삭제하기
	public int remove(Long announcementNumber);
	
	//페이징 처리한거 가져오기
	public List<AnnouncementVo> getList(PageInfo pi);
	
	//총 게시물 갯수
	public int getTotal(PageInfo pi);
	
	
}
