package com.red.boot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.red.boot.domain.ItemVo;
import com.red.boot.domain.MemberVO;
import com.red.boot.domain.TradeVo;
import com.red.boot.service.ImageService;
import com.red.boot.service.ItemService;
import com.red.boot.service.MemberService;
import com.red.boot.service.TradeService;

@Controller
public class MainController {

   @Autowired
   TradeService tradeService;
   
   @Autowired
   ItemService itemService;
   
   @Autowired
   ImageService imageService;
   
   @Autowired
   MemberService memberService;
   
   
   @GetMapping("/")
   public String startPage(Model model) throws NullPointerException{
      
      List<TradeVo> tradeList = tradeService.getList() ;

      if(tradeList.size()>2) {
         for(int i=0; i<3; i++) {
            ItemVo item = itemService.get(tradeList.get(i).getItemNumber());
            item.setImageList(imageService.getList(item.getItemNumber()));
            tradeList.get(i).setItem(item);            
         }
      }   
      
      tradeList = tradeList.subList(0, 3);
         
      model.addAttribute("tradeList", tradeList);

      
      return "/index" ;
   }
   
   
   @ResponseBody
   @PostMapping("/chkHaveCash")
   public String getPresentPrice(@RequestParam("userId") String userId)throws Exception{

      JSONObject jsonObject = new JSONObject();
      
      MemberVO member = memberService.getUserInfoByUserId(userId);

      long userHaveCash = member.getUserCash() ;
      
      jsonObject.put("data", userHaveCash);
      
      return jsonObject.toString();
   }
   
   @GetMapping("/intro/intro")
   public String introPage() {
      
      return "/intro/intro" ;
   }
   
   
   
}