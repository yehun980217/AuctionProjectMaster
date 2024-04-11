package com.red.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.red.boot.domain.AnnouncementVo;
import com.red.boot.domain.PageDTO;
import com.red.boot.domain.PageInfo;
import com.red.boot.domain.QaVo;
import com.red.boot.service.AnnouncementService;
import com.red.boot.service.QaService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Controller
@RequestMapping("/qa/*")
@RequiredArgsConstructor
@Log4j2
public class QaController {
	
	private final QaService service;
	
	@GetMapping("/getList")
	public void getList(Model model) {
	
		model.addAttribute("list", service.getList());
		
	}
	
	@GetMapping("/getListByType")
	public void getListByType(Model model, String qaType) {
	
		model.addAttribute("type", qaType);
		model.addAttribute("list", service.getListByType(qaType));
		
	}
	
	
	
	
	@GetMapping("/modify")
	public void modify(long qaNumber, Model model, String type) {
		QaVo qa = service.get(qaNumber);
		model.addAttribute("qa", qa);
		
		if(type!=null&&type!="") {
			model.addAttribute("type", type);
		}

	}
	

	@PostMapping("/modify")	//커맨드 객체 > 자동으로 수집해준다. //Redirect를 위한 리다이렉트 객체
	public String modify(QaVo qa, RedirectAttributes rttr, String type) {
		
		int count = service.modify(qa);
				
		if(count==1) {
			rttr.addFlashAttribute("result", "modSuccess"); 
		}
		
		if(type!=null&&type!="") {
			return "redirect:/qa/getListByType?qaType="+type ;
		}
		
		return "redirect:/qa/getList" ;
	}

	
	
	@PostMapping("/remove")	//커맨드 객체 > 자동으로 수집해준다. //Redirect를 위한 리다이렉트 객체
	public String delete(Long qaNumber, RedirectAttributes rttr, String type) {
		
		int count = service.remove(qaNumber);
		
		if(count==1) {
			rttr.addFlashAttribute("result", "delSuccess"); 
		}
				
		if(type!=null&&type!="") {
			return "redirect:/qa/getListByType?qaType="+type ;
		}
		
		return "redirect:/qa/getList" ;
	}

		
	@GetMapping({"/register"})
	public void register() {	}

	@PostMapping("/register")	//커맨드 객체 > 자동으로 수집해준다. //Redirect를 위한 리다이렉트 객체
	public String register(QaVo qa, RedirectAttributes rttr) {
		
		
		int count = service.register(qa);
		log.info(count);
		
		if(count==1) {
			rttr.addFlashAttribute("result", "regSuccess"); 
		}
				
		return "redirect:/qa/getList" ;
	}
}
