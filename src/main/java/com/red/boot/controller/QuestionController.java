package com.red.boot.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.red.boot.domain.MemberVO;
import com.red.boot.domain.PageDTO;
import com.red.boot.domain.PageInfo;
import com.red.boot.domain.QuestionVO;
import com.red.boot.service.QuestionService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/question/*")
@AllArgsConstructor
@Log4j2
public class QuestionController {

	private QuestionService service;

	// 전체보기
	@GetMapping("/getList")
	public String list(PageInfo pi, Model model, HttpSession session) {

		MemberVO user = (MemberVO) session.getAttribute("user");
		pi.setAmount(20);

		if (user != null) {
			int userNum = user.getUserNum();
			model.addAttribute("list", service.getList(pi, userNum));
			model.addAttribute("pageDTO", new PageDTO(pi, service.getTotal(pi, userNum)));

			return "/question/getList";
		} else {
			return "/login/getLogin";
		}
	}

	// 문의하기 클릭 시 문의 폼으로 이동
	@GetMapping("/register")
	public String resuster(HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user != null) {
			return "/question/register";
		} else {
			return "/login/getLogin";
		}
	}

	// insert
	@PostMapping("/register")
	public String register(QuestionVO qVo, Model model, RedirectAttributes rttr, PageInfo pi) {
		
		service.insertQuestion(qVo);

		int userNum = qVo.getUserNum();

		model.addAttribute("list", service.getList(pi, userNum));

		return "redirect:/question/getList";

	}

	// 제목 클릭 시 상세보기
	@GetMapping("/get")
	public void get(int questionNumber, Model model, PageInfo pi) {
		model.addAttribute("question", service.get(questionNumber));
		model.addAttribute("PageInfo", pi);
	}

	// 회원 문의 내역 조회 (관리자)
	/*
	 * @GetMapping("/getAllList") public String getAllList(PageInfo pi, Model model,
	 * HttpSession session) { pi.setAmount(10); MemberVO user = (MemberVO)
	 * session.getAttribute("user"); int userRole = user.getUserRole();
	 * 
	 * if (user != null && userRole >= 8) { model.addAttribute("list",
	 * service.getAllList(pi)); model.addAttribute("pageDTO", new PageDTO(pi,
	 * service.getTotal(pi)));
	 * 
	 * return "/question/getAllList"; } else { return "/login/getLogin"; }
	 * 
	 * 
	 * }
	 */

	// 회원 문의 내역 조회(관리자)
	@GetMapping("/adminGetList")
	public String adminGetList(PageInfo pi, Model model, HttpSession session) {
		pi.setAmount(20);
		MemberVO user = (MemberVO) session.getAttribute("user");
		int userRole = 0;
		if (user != null) {
			userRole = user.getUserRole();
			if (userRole >= 8) {
				model.addAttribute("list", service.getListWithPagingAdmin(pi));
				model.addAttribute("pageDTO", new PageDTO(pi, service.getTotlaCountAdmin(pi)));
				return "/question/adminGetList";
			} else {
				return "redirect:/"; // 회원의 등급이 8보다 작으면 리다이렉트로 index로 보냄
			}
		} else {
			return "/login/getLogin";
		}
	}

	@GetMapping("/adminGetDetail")
	public void adminGetDetail(int questionNumber, Model model, PageInfo pi) {
		model.addAttribute("question", service.adminGetDetail(questionNumber));
		model.addAttribute("PageInfo", pi);
	}

	@GetMapping("/updateComplete")
	public String updateComplete(int questionNumber) {

		service.updateComplete(questionNumber);
		return "redirect:/question/adminGetList";
	}

	@GetMapping("/CompleteList")
	public String CompleteList(PageInfo pi, Model model, HttpSession session, int questionComplete) {
		pi.setAmount(20);
		MemberVO user = (MemberVO) session.getAttribute("user");
		List<QuestionVO> list = service.getCompleteList(pi, questionComplete);
		
		int userRole = 0;
		if (user != null) {
			userRole = user.getUserRole();
			if (userRole >= 8) {
				model.addAttribute("list", list);
				model.addAttribute("pageDTO", new PageDTO(pi, service.getTotlaComplete(pi, questionComplete)));
				model.addAttribute("complete", questionComplete);
				return "/question/CompleteList";
			} else {
				return "redirect:/";
			}
		} else {
			return "/login/getLogin";
		}
	}

	/*
	 * @GetMapping("/updateComplete") public String updateComplete(int
	 * questionNumber, Model model) { // 컨트롤러 코드는 이전과 동일하게 유지
	 * log.info(questionNumber);
	 * 
	 * model.addAttribute("questionNumber", service.updateComplete(questionNumber));
	 * 
	 * log.info(questionNumber);
	 * 
	 * return "redirect:/question/adminGetList"; }
	 */

	/*
	 * @GetMapping("/updateComplete") public String updateComplete(QuestionVO qVo) {
	 * 
	 * int questionNumber = qVo.getQuestionNumber();
	 * service.updateComplete(questionNumber);
	 * 
	 * return "redirect:/question/adminGetList";
	 * 
	 * }
	 */

}