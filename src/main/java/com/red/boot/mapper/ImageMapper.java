package com.red.boot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.red.boot.domain.ImageVo;

@Mapper
public interface ImageMapper {
	
	//첨부 이미지 추가
	public int insert(ImageVo image);
	
	//첨부 이미지 삭제
	public int delete(String fileName);
	
	//해당 상품에 대한 첨부이미지 삭제
	public void deleteAll(Long itemNumber);
	
	//해당 상품에 대한 첨부 이미지 확인
	public List<ImageVo> findByItemNum(Long itemNumber);
	
	//해당 상품에 대한 썸네일  이미지 확인
	public ImageVo findByItemNumOne(Long itemNumber);
	
	//이미지명으로 이미지 하나 조회.
	public ImageVo findByFileNameOne(String fileName);
	
	//해당 상품에 대한 이미지 추가
	public int insertByNum(ImageVo image);
}
