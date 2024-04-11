package com.red.boot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.red.boot.service.MemberService;

@Controller
public class FindUserIdController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/login/findUserId")
    public String showFindUserIdForm() {
        // 아이디 찾기 폼을 표시하는 뷰로 이동
        return "/login/findUserId";
    }

    @PostMapping("/login/findUserId")
    public String findUserId(@RequestParam("userName") String userName, @RequestParam("userPhoneNum") String userPhoneNum, Model model) {
        String foundUserId = memberService.findUserId(userName, userPhoneNum);

        if (foundUserId != null) {
            // 아이디를 찾았을 때
            model.addAttribute("foundUserId", foundUserId);
        } else {
            // 아이디를 찾지 못했을 때
            model.addAttribute("foundUserId", "존재하지 않습니다.");
        }

        return "/login/foundUserId";
    }
}