package com.red.boot.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserBidHistoryVo {
   
   private long userBidNumber;
   private long userBidPrice;
   private Date userBidTime;
   private String userBidYn;
   private int userNum;
   private long itemNumber;
   private long tradeNumber;
   private String userId;
   
   private String itemName;
   
   private ImageVo image; 
   
   private int rno;
}