package com.red.boot.controller;


import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.red.boot.domain.MemberVO;
import com.red.boot.service.SignupService;

@Controller
public class SignUpController {
	
    @Autowired
    private SignupService signupService;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

    @PostMapping("/checkEmailDuplicate")
    @ResponseBody
    public String checkEmailDuplicate(@RequestParam("userId") String userId) {
        MemberVO existingMember = signupService.findMemberByEmail(userId);
        if (existingMember != null) {
            return "duplicate";
        } else {
            return "unique";
        }
    }
    
    @GetMapping("/signup/signup")
    public String signupMember(HttpSession session) {
    	MemberVO user = (MemberVO) session.getAttribute("user");
    	
    	  if (user != null) { // 로그인 되어 있는 상태라면
    	         return "/index";
    	      } else {
    	         return "/signup/signup";
    	      }
    }
    
    @PostMapping("/signup/signup")
    public String signupForm(MemberVO mVo) {

       String plainPassword = mVo.getUserPw(); // 사용자가 입력한 암호를 plainPassword에 넣어줌
       // hashedPassword에 BCrypt.hashpw(plainPassword, BCrypt.gensalt()); 를 이용해서 사용자가 입력함 암호를 암호화
       String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
       mVo.setUserSecurityPassword(plainPassword); // 유저가 설정한 암호는 mVo에 userSecurityPassword에 저장(DB확인불가)
       mVo.setUserPw(hashedPassword); // 암호화된 암호는 userPw에 저장(db확인가능)

       signupService.signupMember(mVo); // insert

       return "redirect:/login/getLogin";
    }
//    // MemberVO 객체의 필드 중 하나라도 비어 있거나 null인 경우 true 반환
//    private boolean someFieldsAreNullOrEmpty(MemberVO mVo) {
//        return (mVo.getUserId() == null || mVo.getUserId().isEmpty()) ||
//               (mVo.getUserPw() == null || mVo.getUserPw().isEmpty()) ||
//               (mVo.getUserName() == null || mVo.getUserName().isEmpty()) ||
//               (mVo.getUserPhoneNum() == null || mVo.getUserPhoneNum().isEmpty()) ||
//               (mVo.getUserAddress() == null || mVo.getUserAddress().isEmpty());
//    }
}
