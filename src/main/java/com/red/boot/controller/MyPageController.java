package com.red.boot.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.red.boot.domain.ItemVo;
import com.red.boot.domain.MemberVO;
import com.red.boot.domain.PageDTO;
import com.red.boot.domain.PageInfo;
import com.red.boot.domain.UserBidHistoryVo;
import com.red.boot.service.ImageService;
import com.red.boot.service.ItemService;
import com.red.boot.service.MemberService;
import com.red.boot.service.UserBidHistoryService;

@Controller
public class MyPageController {

   @Autowired
   UserBidHistoryService ubhService;
   @Autowired
   ItemService itemService;
   @Autowired
   ImageService imageService;
   @Autowired
   MemberService memberService;
   @Autowired
   private BCryptPasswordEncoder passwordEncoder;

   @GetMapping("/member/myPage")
   public String showMyPage(HttpSession session) {
      MemberVO user = (MemberVO) session.getAttribute("user");

      if (user != null) {
         return "/member/myPage";
      } else {
         return "/login/getLogin";
      }
   }

   @GetMapping("/member/myAuction")
   public void showMyAuction(HttpSession session, Model model, PageInfo pi) {

      MemberVO user = (MemberVO) session.getAttribute("user");

      List<UserBidHistoryVo> myAuctionList = ubhService.getListByUserNum(user.getUserNum(), pi);
      /*
       * System.out.println(myAuctionList.get(0).getItemNumber());
       * System.out.println(myAuctionList.get(0).getItemNumber());
       * System.out.println(myAuctionList.get(0).getItemNumber());
       */

      if (myAuctionList.isEmpty()) {
         model.addAttribute("myAuctionList", myAuctionList);
         model.addAttribute("pageDTO", new PageDTO(pi, ubhService.getTotalByUserNum(user.getUserNum())));
         return;
      } else {
         for (UserBidHistoryVo u : myAuctionList) {
            ItemVo item = itemService.get(u.getItemNumber());
            u.setItemName(item.getItemName());
            if (!imageService.getList(item.getItemNumber()).isEmpty()) {
               u.setImage(imageService.getList(item.getItemNumber()).get(0));
            }

         }
      }

      model.addAttribute("myAuctionList", myAuctionList);
      model.addAttribute("pageDTO", new PageDTO(pi, ubhService.getTotalByUserNum(user.getUserNum())));
   }

   @GetMapping("/member/deleteUser")
   public String deleteUser(HttpSession session) {
      MemberVO user = (MemberVO) session.getAttribute("user");

      if (user != null) {
         return "/member/deleteUser";
      } else {
         return "/login/getLogin";
      }
   }

   @PostMapping("/member/deleteUser")
   public String deleteUser(MemberVO member, HttpSession session) {

      MemberVO user = (MemberVO) session.getAttribute("user");
      String userId = user.getUserId();
      String userPw = user.getUserPw();
      
      
      if (member == null) {
         return "/login/getLogin";
      }
      
      memberService.deleteUser(userId, userPw);
      session.invalidate();
      return "index";
   }

   @GetMapping("/member/modifyCertification")
   public String getModifyCertificationUser(HttpSession session) {
      MemberVO user = (MemberVO) session.getAttribute("user");

      if (user != null) {
         return "/member/modifyCertification";
      } else {
         return "/login/getLogin";
      }

   }

   @PostMapping("/member/modifyCertification")
   public String claerModifyCertificationUser(HttpSession session) {
      MemberVO user = (MemberVO) session.getAttribute("user");

      if (user != null) {
         return "/member/modifyUserInfo";
      } else {
         return "/login/getLogin";
      }

   }
   
   @GetMapping("/member/modifyUserInfo")
   public String showModifyUserInfo(HttpSession session) {
      MemberVO user = (MemberVO) session.getAttribute("user");
      
      if (user != null) {
         return "/member/modifyUserInfo";
      } else {
         return "/login/getLogin";
      }
   }

   @PostMapping("/member/modifyUserInfo")
   public String modifyUserInfo(String userId, String userPw, String userName, String userPhoneNum, String userAddress,
         String userSecurityPassword, HttpSession session) {
      MemberVO user = (MemberVO) session.getAttribute("user");
      System.err.println(user);
      System.err.println(user);
      System.err.println(user);
      
      if (user != null) {

         String plainPassword = userSecurityPassword; // 사용자가 입력한 비밀번호를 plainPassword에 담고
         userPw = BCrypt.hashpw(plainPassword, BCrypt.gensalt()); // plainPassword를 암호화해서 userPw에 넣어줌

         memberService.modifyUserInfo(userId, userPw, userName, userAddress); // insert쿼리문으로
                                                               // id,name,address,pw(암호화된)를
                                                               // insert해준다
         user = memberService.getUserInfoByUserId(userId); // 다시 select해서 session 최신화
         user.setUserSecurityPassword(userSecurityPassword);
         session.setAttribute("user", user);

         return "/member/myPage";
      } else {
         return "/login/getLogin";
      }

   }

}