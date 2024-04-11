package com.red.boot.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.red.boot.domain.AnnouncementVo;
import com.red.boot.domain.PageDTO;
import com.red.boot.domain.PageInfo;
import com.red.boot.service.AnnouncementService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/announcement/*")
@AllArgsConstructor
@Log4j2
public class AnnoucementController {
	
	private AnnouncementService service;
	
//	@GetMapping("/getList")
//	public void getList(Model model, String grade) {
//		log.info("리스트로 이동");
//		model.addAttribute("list", service.getList());
//	}
	
	@GetMapping("/getList")  
	public void list(PageInfo pi, Model model) {
		pi.setAmount(10);
		
		List<AnnouncementVo> anouncementList = service.getList(pi) ;
		
		int allLength = service.getTotal(pi);
		
		
		
		for(AnnouncementVo a : anouncementList) {
			int index = a.getRno();
			a.setRno(allLength-index+1) ;
		}
		
		
		model.addAttribute("list", anouncementList);
		model.addAttribute("pageDTO", new PageDTO(pi, service.getTotal(pi)));

	}
	
	@GetMapping({"/get", "/modify"})
	public void get(long announcementNumber, Model model, PageInfo pi) {
		
		model.addAttribute("announcement", service.get(announcementNumber)) ;
		model.addAttribute("PageInfo", pi) ; 
	}
	
	@PostMapping("/modify")
	public String modify(AnnouncementVo announcement, RedirectAttributes rttr, PageInfo pi) {
		
		int count = service.modify(announcement);
		
		if(count==1) {
			rttr.addFlashAttribute("result", "modSuccess"); 
			rttr.addAttribute("pageNo", pi.getPageNo());
			rttr.addAttribute("amount", pi.getAmount());
			rttr.addAttribute("keyword", pi.getKeyword());
			rttr.addAttribute("type", pi.getType());
		}

		return "redirect:/announcement/getList" ;
	}
	
	@PostMapping("/remove")	//커맨드 객체 > 자동으로 수집해준다. //Redirect를 위한 리다이렉트 객체
	public String delete(Long announcementNumber, RedirectAttributes rttr,  PageInfo pi) {
		
		int count = service.remove(announcementNumber);
		
		if(count==1) {
			rttr.addFlashAttribute("result", "delSuccess"); 
			rttr.addAttribute("pageNo", pi.getPageNo());
			rttr.addAttribute("amount", pi.getAmount());
			rttr.addAttribute("keyword", pi.getKeyword());
			rttr.addAttribute("type", pi.getType());
		}
				
		return "redirect:/announcement/getList" ;
	}
	
	@GetMapping({"/register"})
	public void register() {
		log.info("register 이동..");
	
	}
	
	@PostMapping("/register")	//커맨드 객체 > 자동으로 수집해준다. //Redirect를 위한 리다이렉트 객체
	public String register(AnnouncementVo announcement, RedirectAttributes rttr) {
		
		int count = service.register(announcement);
		log.info(count);
		
		if(count==1) {
			rttr.addFlashAttribute("result", "regSuccess"); 
		}
				
		return "redirect:/announcement/getList" ;
	}
}
