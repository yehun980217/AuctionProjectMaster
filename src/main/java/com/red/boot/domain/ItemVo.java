package com.red.boot.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ItemVo {
	
	long itemNumber ;
    String itemName ;
    String itemContent ;
    int itemHave;  
    int rno;
    String tradeIng;
    
    
    List<ImageVo> imageList; 

}
