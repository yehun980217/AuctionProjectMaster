package com.red.boot.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.red.boot.domain.PageInfo;
import com.red.boot.domain.TradeVo;
import com.red.boot.mapper.TradeMapper;

import lombok.AllArgsConstructor;
import lombok.ToString;

@Service
@AllArgsConstructor
@ToString
public class TradeServiceImpl implements TradeService {
   
   TradeMapper mapper ;

   @Override
   public int register(TradeVo trade) {
      return mapper.insertTrade(trade);
   }

   @Override
   public int getTotalIng(PageInfo pi) {
      return mapper.getTotalCountByIng(pi) ;
   }

   @Override
   public List<TradeVo> getListIng(PageInfo pi) {
      return mapper.getListByIng(pi) ;
   }
   
   @Override
   public int getTotalEnd(PageInfo pi) {
      return mapper.getTotalCountByEnd(pi) ;
   }

   @Override
   public List<TradeVo> getListEnd(PageInfo pi) {
      return mapper.getListByEnd(pi) ;
   }

   @Override
   public int remove(Long tradeNumber) {
      return mapper.deleteTrade(tradeNumber) ;
   }

   @Override
   public TradeVo get(Long tradeNumber) {
      return mapper.getTradeOne(tradeNumber) ;
   }

   @Override
   public int modify(TradeVo trade) {
      return mapper.updateTrade(trade) ;
   }

   @Override
   public int modifyTrade(Long tradeNumber, String tradeIng) {
      return mapper.updateTradeIng(tradeNumber, tradeIng) ;
   }

   @Override
   public List<TradeVo> getList() {
      return mapper.getList() ;
   }





   





}