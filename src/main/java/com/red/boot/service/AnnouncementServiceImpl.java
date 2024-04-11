package com.red.boot.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.red.boot.domain.AnnouncementVo;
import com.red.boot.domain.PageInfo;
import com.red.boot.mapper.AnnouncementMapper;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Service
@AllArgsConstructor
@ToString
public class AnnouncementServiceImpl implements AnnouncementService {
	
	AnnouncementMapper mapper ;
	
	@Override
	public List<AnnouncementVo> getList() {
		return mapper.getAnnouncementList() ;
	}
	
	@Override
	public AnnouncementVo get(Long announcementNumber) {
		return mapper.getAnnouncementOne(announcementNumber);
	}
	

	@Override
	public int register(AnnouncementVo announcement) {
		return mapper.insertAnnouncement(announcement);
		
	}

	@Override
	public int modify(AnnouncementVo announcement) {
		return mapper.updateAnnouncement(announcement);
	}

	@Override
	public int remove(Long announcementNumber) {
		return mapper.deleteAnnouncement(announcementNumber);
	}

	@Override
	public List<AnnouncementVo> getList(PageInfo pi) {
		return mapper.getListWithPaging(pi) ;
	}

	@Override
	public int getTotal(PageInfo pi) {
		return mapper.getTotalCount(pi);
	}

}
