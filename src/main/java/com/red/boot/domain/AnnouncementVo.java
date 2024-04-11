package com.red.boot.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AnnouncementVo {
	
	 long announcementNumber ;
	 String announcementTitle ;
	 String announcementContent ; 
	 Date announcementDate;
	 int announcementUp;
	 int rno;
}
