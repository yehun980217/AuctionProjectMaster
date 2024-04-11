package com.red.boot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.red.boot.domain.MemberVO;
import com.red.boot.mapper.PaymentMapper;

import lombok.AllArgsConstructor;
import lombok.ToString;

@Service
@AllArgsConstructor
@ToString
public class PaymentServiceImpl implements PaymentService {

   @Autowired
   PaymentMapper mapper;
   
   /*
    * @Override public int updateUserPayment(String userId, int userCash) { return
    * mapper.updateUserPayment(userId, userCash); }
    */

   @Override
   public int updateUserPayment(MemberVO member) {
      return mapper.updateUserPayment(member);
   }
   
   @Override
   public String showUserCash(String userId) {
      return mapper.showUserCash(userId);
   }
   
}