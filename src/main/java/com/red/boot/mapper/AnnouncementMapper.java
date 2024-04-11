package com.red.boot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.red.boot.domain.AnnouncementVo;
import com.red.boot.domain.PageInfo;

@Mapper
public interface AnnouncementMapper {

	public List<AnnouncementVo> getAnnouncementList() ;
	
	//공지사항 하나 받기
	public AnnouncementVo getAnnouncementOne(Long announcementNumber);
	
	//공지사항 삭제하기
	public int deleteAnnouncement(Long announcementNumber);
	
	//공지사항 변경하기
	public int updateAnnouncement(AnnouncementVo announcement);
	
	//공지사항 추가하기
	public int insertAnnouncement(AnnouncementVo announcement);
	
	//공지사항 페이지에 나오게 할 거.
	public List<AnnouncementVo> getListWithPaging(PageInfo pi) ;
	
	//공지사항 총 갯수
	public int getTotalCount(PageInfo pi);
	
	
	
	
	
}
