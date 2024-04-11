package com.red.boot.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
	
	private int userNum;
	private String userId;
	private String userPw;
	private String userName;
	private String userPhoneNum;
	private int userRole;
	private Date userRegDate;
	private long userCash;
	private String userAddress;
	private String userSecurityPassword;
	
	private int rno;
}
