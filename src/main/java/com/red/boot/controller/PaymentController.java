package com.red.boot.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.red.boot.domain.MemberVO;
import com.red.boot.service.PaymentService;

@Controller
public class PaymentController {
   
   @Autowired
   private PaymentService service;
   
   @GetMapping("/payment/userWallet")
   public String userWallet(HttpSession session) {
      MemberVO user = (MemberVO) session.getAttribute("user");
      String userId = user.getUserId();
      
      if (user != null) {
         long userCash = Long.parseLong(service.showUserCash(userId));
         user.setUserCash(userCash);
         
         session.setAttribute("user", user);
         
         return "/payment/userWallet";
      
      } else {
         return "/login/getLogin";
      }
   }

   @GetMapping("/payment/account")
   public String account(HttpSession session) {
      MemberVO user = (MemberVO) session.getAttribute("user");

      if (user != null) {
         return "/payment/account";
      } else {
         return "/login/getLogin";
      }
   }

   @GetMapping("/payment/updateUserPayment")
   public String updateUserPayment(HttpSession session) {
      MemberVO user = (MemberVO) session.getAttribute("user");

      if (user != null) {
         return "/payment/updateUserPayment";
      } else {
         return "/login/getLogin";
      }
   }

   @PostMapping("/payment/updateUserPayment")
   public String updateUserPayment(@RequestParam("userId") String userId, @RequestParam("userCash") String cash) {
      
      long userCash = 0 ;
      
      if(cash != null && cash != "") {
         userCash = Long.parseLong(cash);
      }
      
      if (userId == null) {
         System.out.println("userId가 유효하지 않습니다.");
         // 예외 처리 또는 오류 메시지 표시
         return "error"; // 또는 다른 처리 방식을 선택
      } 
      
      
      MemberVO member = new MemberVO();
      member.setUserId(userId);
      member.setUserCash(userCash);
      
      service.updateUserPayment(member);
         
      return "redirect:/admin/adminPage";
   }
   
   
   
   @GetMapping("/payment/kakaoPay")
   public String goKakao(HttpSession session) {
      MemberVO user = (MemberVO) session.getAttribute("user");
      
      session.setAttribute("user", user);

      if (user != null) {
         return "/payment/kakaoPay";
      } else {
         return "/login/getLogin";
      }
   }
   


    @PostMapping("/payment/kakaoPay")
    public String getPresentPrice(@RequestParam("kp_amount") String kp_amount,
          @RequestParam("userId") String userId,    @RequestParam("userNum") String userNum)throws Exception{
       
       System.out.println(userId);
       System.out.println(userNum);
       System.out.println(kp_amount);
       
       MemberVO member = new MemberVO() ; 
       member.setUserCash(Long.parseLong(kp_amount));
       member.setUserId(userId);
       
       service.updateUserPayment(member) ;
      
      return "/payment/successPay" ;
        
   }
   
   
}
   /*
    * @PostMapping("/payment/updateUserPayment") public String
    * updateUserPayment(MemberVO member) {
    * 
    * service.updateUserPayment(member);
    * 
    * return "redirect:/admin/updateUserPayment"; }
    */

   /*
    * @PostMapping("/payment/updateUserPayment") public String
    * updateUserPayment(String userId, int userCash) {
    * 
    * MemberVO user = new MemberVO();
    * 
    * user.setUserId(userId); user.setUserCash(userCash);
    * 
    * service.updateUserPayment(userId, userCash);
    * 
    * return "redirect:/admin/adminPage"; }
    */


