package com.red.boot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.red.boot.domain.ImageVo;
import com.red.boot.domain.ItemVo;
import com.red.boot.domain.PageDTO;
import com.red.boot.domain.PageInfo;
import com.red.boot.service.ImageService;
import com.red.boot.service.ItemService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/item/*")
@AllArgsConstructor
@Log4j2
public class ItemController {

	@Autowired
	private ItemService itemService;
	@Autowired
	private ImageService imageService;
	
//	@GetMapping("/getList")
//	public void getList(Model model, String grade) {
//		log.info("리스트로 이동");
//		model.addAttribute("list", service.getList());
//	}
	
	@GetMapping("/getList")  
	public String list(PageInfo pi, Model model) {
		pi.setAmount(8);
		List<ItemVo> itemList = itemService.getList(pi);

		if(itemList.size()!=0){
			for(ItemVo item : itemList) {
				item.setImageList(imageService.getList(item.getItemNumber()));
			}
		}
		
		model.addAttribute("itemList", itemList);
		model.addAttribute("pageDTO", new PageDTO(pi, itemService.getTotal(pi)));
		
		return "/item/getList";
	}
	
	
	
	@GetMapping("/getListHaving")  
	public String listHaving(PageInfo pi, Model model, String itemHave) {
		pi.setAmount(8);
		
		List<ItemVo> itemList = itemService.getListHaving(pi, Integer.parseInt(itemHave));

		if(itemList.size()==0) {
			return "/item/getListHaving";
		}
		
		if(itemList.size()!=0){
			for(ItemVo item : itemList) {
				item.setImageList(imageService.getList(item.getItemNumber()));
			}
		}
		
		model.addAttribute("itemList", itemList);
		model.addAttribute("pageDTO", new PageDTO(pi, itemService.getTotalByHave(pi, Integer.parseInt(itemHave))));
		model.addAttribute("itemHave", itemHave);
		
		return "/item/getListHaving";
	}
	
	
	
	

	@GetMapping({"/register"})
	public void register() {
		log.info("register 이동..");
	}

	@PostMapping("/register")    //커맨드 객체 > 자동으로 수집해준다. //Redirect를 위한 리다이렉트 객체
	@ResponseBody
	public String registerAjax(String itemName
			, String itemContent
			, MultipartFile[] files) throws Exception{
		// @ResponseBody : ajax 비동기 사용할때 꼭 붙혀줘야함
		
		ItemVo itemVo = new ItemVo();
		itemVo.setItemName(itemName);
		itemVo.setItemContent(itemContent);
		itemService.register(itemVo);

		ImageVo image = new ImageVo();
		if(files!=null) {
			for(MultipartFile file : files) {
				imageService.register(image, file);
				log.info(image);
			}
		}
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", "S");
		
		return jsonObject.toString();
	}
	
	
	@GetMapping({"/get", "/modify"})
	public void get(long itemNumber, Model model, PageInfo pi, String itemHave) {
		
		
		model.addAttribute("item", itemService.get(itemNumber)) ;
		model.addAttribute("images", imageService.getList(itemNumber)) ;
		model.addAttribute("itemHave", itemHave) ;
		model.addAttribute("PageInfo", pi) ; 
		

	}
	
	
	@PostMapping("/modify")
	@ResponseBody
	public String modify(ItemVo item, RedirectAttributes rttr, 
			PageInfo pi, MultipartFile[] files, ImageVo image,
			@RequestParam(value="delFileName", required=false) List<String> loadFileRootNames) throws Exception {
				
		int count = itemService.modify(item);
				
		if(count==1) {
			rttr.addFlashAttribute("result", "modSuccess"); 
			rttr.addAttribute("pageNo", pi.getPageNo());
			rttr.addAttribute("amount", pi.getAmount());
			rttr.addAttribute("keyword", pi.getKeyword());
			rttr.addAttribute("type", pi.getType());
		}
		
		System.out.println(loadFileRootNames);
		
		if(loadFileRootNames != null) {
			for(String loadFileRootName : loadFileRootNames) {
				imageService.remove(loadFileRootName);
			}
		}

		if(files!=null) {
			for(MultipartFile file : files) {
				imageService.registerByNum(image, file, item);
			}
		}
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", "S");
		
		return jsonObject.toString() ;
		
	}

	
	@PostMapping("/remove")	//커맨드 객체 > 자동으로 수집해준다. //Redirect를 위한 리다이렉트 객체
	public String delete(Long itemNumber, RedirectAttributes rttr,  PageInfo pi, Integer itemHave) {
		
		imageService.removeAll(itemNumber);
		int count = itemService.remove(itemNumber);

		if(count==1) {
			rttr.addFlashAttribute("result", "delSuccess"); 
			rttr.addAttribute("pageNo", pi.getPageNo());
			rttr.addAttribute("amount", pi.getAmount());
			rttr.addAttribute("keyword", pi.getKeyword());
			rttr.addAttribute("type", pi.getType());
		}
		
		if(itemHave!=null) {
			return "redirect:/item/getListHaving?itemHave="+itemHave ;
		}
		
		return "redirect:/item/getList" ;
	}


}
