package com.red.boot.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.red.boot.domain.ImageVo;
import com.red.boot.domain.ItemVo;
import com.red.boot.mapper.ImageMapper;

import lombok.AllArgsConstructor;
import lombok.ToString;
import lombok.extern.log4j.Log4j2;

@Service
@AllArgsConstructor
@ToString
@Log4j2
public class ImageServiceImpl implements ImageService {
	
	ImageMapper mapper;
	
	@Override
	public int register(ImageVo image, MultipartFile file) {
			
		
			//폴더명 설정
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String fileLocation = sdf.format(new Date());
			
			//폴더 경로 설정
			String uploadPath = "C:\\springBoot\\AuctionProject\\src\\main\\resources\\static\\attImage\\" + fileLocation ;
			
			//폴더 만들기
			File folder = new File(uploadPath) ;
			if(!folder.exists()) {
				folder.mkdirs() ;
			}
			
			//파일명이 없으면 종료
			if( file.getOriginalFilename().length()==0) {
				return 0;
			}
			
			// 파일명 뽑아내기
			String fileRealName = file.getOriginalFilename(); //파일의 오리지널 이름
			UUID uuid = UUID.randomUUID();
			String uuidStr = uuid.toString().replaceAll("-", "");  //임의의 이름
			
			//파일 확장자 추출
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), 
														fileRealName.length());
			
			String fileName = uuidStr + fileExtension ; //저장되는 파일명 + 확장자
			String loadFileRootName =  uploadPath + "/" + fileName ; //저장되는 공간 + 파일 + 확장자
			
			String viewLoadName = "/attImage/"+fileLocation+"/"+fileName;
			
			File saveFile = new File(loadFileRootName) ; //경로 + 저장되는 파일명 + 확장자
			
			
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			image.setUploadPath(uploadPath);
			image.setFileName(fileName);
			image.setFileRealName(fileRealName);
			image.setLoadFileRootName(loadFileRootName);
			image.setViewLoadName(viewLoadName);
			
			return mapper.insert(image);

	}


	@Override
	public List<ImageVo> getList(Long itemNum) {
		
		return mapper.findByItemNum(itemNum) ;
	}

	@Override
	public ImageVo getListOne(Long itemNum) {
		return mapper.findByItemNumOne(itemNum) ;
	}
	
	@Override
	public int remove(String loadFileRootName) {
		//하나 파일 컬럼 가져오기
		//ImageVo image = mapper.findByFileNameOne(loadFileRootName);

		File file = new File(loadFileRootName);
		
		try {
			if( file.exists() ){
	    		if(file.delete()){
	    			System.out.println("파일삭제 성공");
	    		}else{https://chb2005.tistory.com/200#3.1.%20%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC%20%EC%B6%94%EA%B0%80%20(build.gradle)
	    			System.out.println("파일삭제 실패");
	    		}
	    	}else{
	    		System.out.println("파일이 존재하지 않습니다.");
	    	}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mapper.delete(loadFileRootName);

	}
	
	@Override
	public void removeAll(Long itemNumber) {
		
		List<ImageVo> imageList = mapper.findByItemNum(itemNumber);
		if(imageList.size()>0) {
			System.out.println(imageList.get(0).getLoadFileRootName());
		}else{
			System.out.println("이게 왜 없다고 할까?");
		}
		
		for(ImageVo image : imageList) {
			File file = new File(image.getLoadFileRootName());
			try {
				if( file.exists() ){
		    		if(file.delete()){
		    			System.out.println("파일삭제 성공");
		    		}else{
		    			System.out.println("파일삭제 실패");
		    		}
		    	}else{
		    		System.out.println("파일이 존재하지 않습니다.");
		    	}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		mapper.deleteAll(itemNumber);
	}


	@Override
	public int registerByNum(ImageVo image, 
			MultipartFile file, ItemVo item) {
		//폴더명 설정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String fileLocation = sdf.format(new Date());
		
		//폴더 경로 설정
		String uploadPath = "C:\\springBoot\\AuctionProject\\src\\main\\resources\\static\\attImage\\" + fileLocation ;
		
		//폴더 만들기
		File folder = new File(uploadPath) ;
		if(!folder.exists()) {
			folder.mkdirs() ;
		}
		
		//파일명이 없으면 종료
		if( file.getOriginalFilename().length()==0) {
			return 0;
		}
		
		// 파일명 뽑아내기
		String fileRealName = file.getOriginalFilename(); //파일의 오리지널 이름
		UUID uuid = UUID.randomUUID();
		String uuidStr = uuid.toString().replaceAll("-", "");  //임의의 이름
		
		//파일 확장자 추출
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), 
													fileRealName.length());
		
		String fileName = uuidStr + fileExtension ; //저장되는 파일명 + 확장자
		String loadFileRootName =  uploadPath + "/" + fileName ; //저장되는 공간 + 파일 + 확장자
		
		String viewLoadName = "/attImage/"+fileLocation+"/"+fileName;
		
		File saveFile = new File(loadFileRootName) ; //경로 + 저장되는 파일명 + 확장자
		
		
		try {
			file.transferTo(saveFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		image.setUploadPath(uploadPath);
		image.setFileName(fileName);
		image.setFileRealName(fileRealName);
		image.setLoadFileRootName(loadFileRootName);
		image.setViewLoadName(viewLoadName);
		image.setItemNumber(item.getItemNumber());
		
		return mapper.insertByNum(image);
	}
}
