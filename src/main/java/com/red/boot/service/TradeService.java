package com.red.boot.service;

import java.util.List;

import com.red.boot.domain.PageInfo;
import com.red.boot.domain.TradeVo;

public interface TradeService {
      
   //경매 등록
   public int register(TradeVo trade);
   
   //경매 진행 상태에 대한 갯수
   public int getTotalIng(PageInfo pi);
   
   //페이징 처리 및 진행 상태에 대한 리스트 가져오기
   public List<TradeVo> getListIng(PageInfo pi);

   int getTotalEnd(PageInfo pi);

   public List<TradeVo> getListEnd(PageInfo pi);

   //글 삭제하기
   public int remove(Long tradeNumber);
   
   // 글 가져오기
   public TradeVo get(Long tradeNumber);
   
   
   public int modify(TradeVo trade);
      
   public int modifyTrade(Long tradeNumber, String tradeIng);
   
   
   public List<TradeVo> getList();
}