package com.red.boot.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.red.boot.domain.MemberVO;
import com.red.boot.domain.PageDTO;
import com.red.boot.domain.PageInfo;
import com.red.boot.service.MemberListService;

@Controller

public class MemberListController {

   private static final Logger log = LoggerFactory.getLogger(MemberListController.class);

   // DI 의존성 주입 생성자 메서드 주입방식 (bean으로 등록되어있기 때문에 가능하다)
   @Autowired
   private MemberListService memberListService;

   public MemberListController(MemberListService memberListService) {
      this.memberListService = memberListService;

   }

   // log.info("마스터 회원목록요청"); // 로그
   @GetMapping("member/memberList")
   public String getMemberList(Model model, PageInfo pi) {

      log.info("마스터 회원목록요청"); // 로그

      List<MemberVO> memberList = memberListService.getMemberList(pi);

      model.addAttribute("title", "회원목록조회");
      model.addAttribute("memberList", memberList);
      model.addAttribute("pageDTO", new PageDTO(pi, memberListService.getTotalCount(pi)));

      return "member/memberList";

   }

   // log.info("관리자 회원목록요청"); // 로그
   @GetMapping("member/memberListAdmin")
   public String getMemberListAdmin(Model model, PageInfo pi) {

      log.info("관리자 회원목록요청"); // 로그

      List<MemberVO> memberList = memberListService.getMemberListAdmin(pi);

      model.addAttribute("title", "회원목록조회");
      model.addAttribute("memberList", memberList);
      model.addAttribute("pageDTO", new PageDTO(pi, memberListService.getTotalCountAdmin(pi)));
      return "member/memberListAdmin";

   }

   // log.info("등급수정[마스터]");
   @PostMapping("/updateUserRole")
   public String updateUserRole(@RequestParam Map<String, String> params, Model model, PageInfo pi) {
      for (String key : params.keySet()) {
         if (key.startsWith("userRole_")) {
            int userNum = Integer.parseInt(key.replace("userRole_", ""));
            int userRole = Integer.parseInt(params.get(key));

            // 여기서 userNum과 userRole을 사용하여 데이터베이스 업데이트 수행
            memberListService.updateUserRole(userNum, userRole);
         }
      }

      List<MemberVO> memberList = memberListService.getMemberList(pi);
      model.addAttribute("title", "회원목록조회");
      model.addAttribute("memberList", memberList);
      model.addAttribute("pageDTO", new PageDTO(pi, memberListService.getTotalCount(pi)));


      log.info("등급수정[마스터]");

      return "member/memberList"; // 업데이트 후 돌아갈 페이지
   }

   // log.info("등급수정[관리자]");
   @PostMapping("/updateUserRoleAdmin")
   public String updateUserRoleAdmin(@RequestParam Map<String, String> params, Model model, PageInfo pi) {
      for (String key : params.keySet()) {
         if (key.startsWith("userRole_")) {
            int userNum = Integer.parseInt(key.replace("userRole_", ""));
            int userRole = Integer.parseInt(params.get(key));

            // 여기서 userNum과 userRole을 사용하여 데이터베이스 업데이트 수행
            memberListService.updateUserRole(userNum, userRole);
         }
      }

      List<MemberVO> memberList = memberListService.getMemberListAdmin(pi);
      model.addAttribute("title", "회원목록조회");
      model.addAttribute("memberList", memberList);
      model.addAttribute("pageDTO", new PageDTO(pi, memberListService.getTotalCountAdmin(pi)));


      log.info("등급수정[관리자]");

      return "member/memberListAdmin"; // 업데이트 후 돌아갈 페이지
   }

   @PostMapping("/deleteMemberByNum")
   public String deleteMemberByNum(HttpServletRequest request, RedirectAttributes rttr, PageInfo pi) {

      String userNum = request.getParameter("userNum");
      
      log.info("삭제 회원번호 : " + request.getParameter("userNum"));
      
      int adminRole =  Integer.parseInt(request.getParameter("sessionUserRole"));
      
      log.info("관리자 등급 : " + request.getParameter("sessionUserRole"));
      
      if (userNum != null) {
         memberListService.deleteMemberByNum(userNum);
      }
      
      rttr.addAttribute("pageNo", pi.getPageNo());
      rttr.addAttribute("amount", pi.getAmount());
      rttr.addAttribute("keyword", pi.getKeyword());
      rttr.addAttribute("type", pi.getType());
      
      if (adminRole == 9) {
         return "redirect:/member/memberList";
      }
      return "redirect:/member/memberListAdmin";
   }
}