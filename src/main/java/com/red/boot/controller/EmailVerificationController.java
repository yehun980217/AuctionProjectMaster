package com.red.boot.controller;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.red.boot.domain.MemberVO;
import com.red.boot.service.EmailService;
import com.red.boot.service.EmailVerificationStore;
import com.red.boot.service.MemberService;

@Controller
public class EmailVerificationController {

   @Autowired
   private MemberService service;

   @Autowired
   private final EmailService emailService;
   
   @Autowired
   private final EmailVerificationStore verificationStore;

   public EmailVerificationController(EmailService emailService, EmailVerificationStore verificationStore) {
      this.emailService = emailService;
      this.verificationStore = verificationStore;
   }

   @GetMapping("email/verification_form")
   public String showVerificationForm() {
      return "email/verification_form";
   }

   @PostMapping("email/verification_form")
   public String sendVerificationEmail(HttpServletRequest request, Model model) {
      // 이메일 주소를 이곳에서 가져오는 로직 필요
      String email = request.getParameter("email");

      // 랜덤 인증 코드 생성
      String verificationCode = UUID.randomUUID().toString();

      // 생성된 코드를 저장
      verificationStore.storeCode(email, verificationCode);

      // 이메일 발송
      String verificationLink = "http://" + request.getServerName() + ":" + request.getServerPort()
            + request.getContextPath() + "/verify?code=" + verificationCode + "&userId=" + email;
     
      emailService.sendEmail(email, "이메일인증", verificationLink);

      model.addAttribute("message", "인증메일을 전송하였습니다");
      return "email/verification_result";
   }

   @GetMapping("/verify")
   public String verifyEmail(@RequestParam("code") String verificationCode, Model model, HttpSession session, String userId) {
	 
	  service.updateEmailRole(userId); //무조건 롤은 올려주자
	  
      MemberVO user = (MemberVO) session.getAttribute("user"); //세션에서 아이디 읽어온다
      
      if(user==null) {
    	  return "/index" ;
      } 
      
      if(userId.equals(user.getUserId())) {
    	  user = service.getUserInfoByUserId(userId);
    	  session.setAttribute("user", user);
    	  model.addAttribute("success", "이메일 인증이 완료되었습니다!") ;
    	  return "/email/verification_result";
      } else{
    	  session.setAttribute("user", user);
    	  return "/index";
      }
       	
      
   }
}