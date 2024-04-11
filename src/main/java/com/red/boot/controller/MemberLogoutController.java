package com.red.boot.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.context.annotation.SessionScope;

@Controller
public class MemberLogoutController {

	@GetMapping("/logout")
	public String logout(HttpSession session) {
	//  session.removeAttribute("user");
		session.invalidate();
		
		return "redirect:/";
	}
}
