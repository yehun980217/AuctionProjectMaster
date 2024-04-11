package com.red.boot.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QuestionVO {

	private int questionNumber;
	private String questionTitle;
	private String questionContent;
	private int questionComplete;
	private Date questionRegDate;
	private int userNum;
	private int rno;
	private String userId;

}
