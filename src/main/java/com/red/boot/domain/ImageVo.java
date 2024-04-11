package com.red.boot.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ImageVo {
	private String fileRealName;
	private String uploadPath;
	private String fileName;
	private String loadFileRootName;
	private String viewLoadName;
	private long itemNumber ; 
	
}
