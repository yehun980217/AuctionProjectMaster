package com.red.boot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.red.boot.domain.AnnouncementVo;
import com.red.boot.domain.PageInfo;
import com.red.boot.domain.QaVo;

@Mapper
public interface QaMapper {

	public List<QaVo> getQaList() ;
	
	
	
	//qa 하나 받기
	public QaVo getQaOne(Long qaNumber);
	
	//qa 삭제하기
	public int deleteQa(Long qaNumber);
	
	//qa 변경하기
	public int updateQa(QaVo qaVo);
	
	//qa 추가하기
	public int insertQa(QaVo qaVo);
	
	//qa 각 카테고리에 맞춰서 나오게 하기
	public List<QaVo> getListByType(String qaType) ;
	
	//qa 총 갯수
	public int getTotalCount(PageInfo pi);
}
