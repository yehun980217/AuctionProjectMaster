package com.red.boot.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.red.boot.domain.ImageVo;
import com.red.boot.domain.ItemVo;

public interface ImageService {
	
	// 이미지 등록
	public int register(ImageVo image, MultipartFile file);
		
	//이미지 하나 삭제하기
	public int remove(String loadFileRootName);
	
	//해당 아이템의 이미지 전체 삭제하기
	public void removeAll(Long itemNum);
	
	//해당 아이템의  이미지 전체 가져오기
	public List<ImageVo> getList(Long itemNum);
	
	//해당 아이템의 썸네일 이미지 가져오기 (첫번째 이미지)
	public ImageVo getListOne(Long itemNum);

	//해당번호 이미지 등록
	public int registerByNum(ImageVo image, 
			MultipartFile file, ItemVo item);
	
}
