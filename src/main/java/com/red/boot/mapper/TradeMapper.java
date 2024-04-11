package com.red.boot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.red.boot.domain.ItemVo;
import com.red.boot.domain.PageInfo;
import com.red.boot.domain.TradeVo;

@Mapper
public interface TradeMapper {

   //경매 상품 추가하기
   public int insertTrade(TradeVo trade);
   
   //경매 진행 상태 나오게 하기
   public List<TradeVo> getListByIng(PageInfo pi) ;
   
   //경매  진행 상태에 대한 총 갯수
   public int getTotalCountByIng(PageInfo pi);
   
   //경매 종료 상태 나오게 하기
   public List<TradeVo> getListByEnd(PageInfo pi) ;
   
   //경매  종료 상태에 대한 총 갯수
   public int getTotalCountByEnd(PageInfo pi);
   
   //경매 삭제하기
   public int deleteTrade(Long tradeNumber);
   
   //경매 번호로 조회 
   public TradeVo getTradeOne(Long tradeNumber); 
   
   //경매 변경 변경하기
   public int updateTrade(TradeVo trade);
   
   //경매가 진행중인지 변경
   public int updateTradeIng(Long tradeNumber, String tradeIng);
   
   public List<TradeVo> getList() ;
}