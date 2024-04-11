package com.red.boot.controller;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.red.boot.service.MemberService;

@Controller
public class FindUserPwController {

   @Autowired
   private MemberService memberService;

   @GetMapping("/login/findUserPw")
   public String showFindUserIdForm() {
      // 아이디 찾기 폼을 표시하는 뷰로 이동
      return "/login/findUserPw";
   }

   @PostMapping("/login/findUserPw")
   public String findUserId(@RequestParam("userId") String userId, @RequestParam("userName") String userName,
         @RequestParam("userPhoneNum") String userPhoneNum, Model model) {
      // 아이디, 이름, 전화번호가 DB에 일치하는 데이터를 찾아서 비밀번호를 반환
      String findUserPw = memberService.findUserPw(userId, userName, userPhoneNum);

      if (findUserPw != null) {// 아이디를 찾았을 때

         char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E',
               'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

         String str = "";
         int idx = 0;

         for (int i = 0; i < 10; i++) {
            idx = (int) (charSet.length * Math.random());
            str += charSet[idx];
         }
         // 랜덤 난수로 임시 비밀번호보여주기
         String userSecurityPassword = str;
         String userPw = BCrypt.hashpw(str, BCrypt.gensalt());

         memberService.updateChangeUserPw(userPw, userId);
         model.addAttribute("foundUserPw", userSecurityPassword);
         model.addAttribute("foundUserPwMessage", "로그인 후 우측 상단 마이페이지 → 개인 정보 수정으로 가셔서 비밀번호 변경 바랍니다.");
      } else {
         // 아이디를 찾지 못했을 때
         model.addAttribute("foundUserPw", "입력값이 잘못되었습니다.");
         model.addAttribute("foundUserPwMessage", "다시 입력해주세요.");
      }

      return "/login/foundUserPw";
   }
}