package com.red.boot.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@Data
@AllArgsConstructor
@NoArgsConstructor
public class TradeVo {
	private long tradeNumber ;
	private int tradeViewCount ;
	private int	tradeMinPrice;
	private int tradeBuyNowPrice;
	private int tradeFinalPrice;
	private String tradeStart;
	private String tradeEnd;
	private long itemNumber;
	private int userNum;
	private String tradeIng;
	
	
	
	private ItemVo item;
	private int rno;
}
