package com.red.boot.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.red.boot.domain.ItemVo;
import com.red.boot.domain.MemberVO;
import com.red.boot.domain.PageDTO;
import com.red.boot.domain.PageInfo;
import com.red.boot.domain.TradeVo;
import com.red.boot.domain.UserBidHistoryVo;
import com.red.boot.service.EmailService;
import com.red.boot.service.ImageService;
import com.red.boot.service.ItemService;
import com.red.boot.service.MemberService;
import com.red.boot.service.TradeService;
import com.red.boot.service.UserBidHistoryService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/trade/*")
@AllArgsConstructor
@Log4j2
public class TradeController {

   @Autowired
   private ItemService itemService;
   
   @Autowired
   private TradeService tradeService;
   
   @Autowired
   private ImageService imageService;
   
   @Autowired
   private UserBidHistoryService userBidService;
   
   @Autowired
   private MemberService memberService;
   
   @Autowired
   private EmailService emailService;
   
   
   @PostMapping("/register")
   public String register(String tradeMinPrice, String tradeFinalPrice, 
         String tradeStart, String tradeEnd, long itemNumber, RedirectAttributes rttr) throws Exception {
      
      TradeVo trade = new TradeVo();
      
      trade.setItemNumber(itemNumber);
      trade.setTradeFinalPrice(Integer.parseInt(tradeFinalPrice));
      trade.setTradeMinPrice(Integer.parseInt(tradeMinPrice));
      trade.setTradeStart(tradeStart);
      trade.setTradeEnd(tradeEnd);
      
      tradeService.register(trade);
      itemService.modifyTrade(itemNumber, "Y");
      
      rttr.addAttribute("tradeIng", trade.getTradeIng());
      
      return "redirect:/trade/getListIng" ;

   }
   
   @GetMapping("/getListIng")
   public void listIng(PageInfo pi, Model model) {
      pi.setAmount(9);

      //트레이드 리스트를 받아옴
      List<TradeVo> tradeList = tradeService.getListIng(pi);
      List<ItemVo> itemList = null;
      
	 
      if(tradeList.size() != 0) {
	      for(TradeVo trade : tradeList) {
	         ItemVo item = itemService.get(trade.getItemNumber());
	         item.setImageList(imageService.getList(item.getItemNumber()));
	         trade.setItem(item);
		  }
      }    
      
      model.addAttribute("tradeList", tradeList);
      model.addAttribute("itemList", itemList);
      model.addAttribute("pageDTO", new PageDTO(pi, tradeService.getTotalIng(pi)));

      
   }

   @GetMapping("/getListEnd")
   public void listEnd(PageInfo pi, Model model) {
      pi.setAmount(9);

      //트레이드 리스트를 받아옴
      List<TradeVo> tradeList = tradeService.getListEnd(pi);
      System.out.println(tradeList);
      System.out.println(tradeList);
      System.out.println(tradeList);
      System.out.println(tradeList);
      List<ItemVo> itemList = null;
      
      for(TradeVo trade : tradeList) {
         ItemVo item = itemService.get(trade.getItemNumber());
         item.setImageList(imageService.getList(item.getItemNumber()));
         trade.setItem(item);
      }
      
      
      model.addAttribute("tradeList", tradeList);
      model.addAttribute("itemList", itemList);
      model.addAttribute("pageDTO", new PageDTO(pi, tradeService.getTotalEnd(pi)));
      
   }
   
   @GetMapping("/get")
   public void get(long tradeNumber, Model model, PageInfo pi, HttpSession session) {
      
      if(session.getAttribute("user")!=null) {
        //현재 로그인 유저
        MemberVO member = (MemberVO)session.getAttribute("user");
        
        long newCash = memberService.getUserInfoByUserId(member.getUserId()).getUserCash();
        member.setUserCash(newCash);
        session.setAttribute("user", member);
      }

      
      long itemNumber = tradeService.get(tradeNumber).getItemNumber();
      
      List<UserBidHistoryVo> userBids = userBidService.getListByTradeNumber(tradeNumber);
      
      for(UserBidHistoryVo u : userBids) {
         String userId = memberService.getUserId(u.getUserNum());
         
         for(int i=2; i<userId.length()-2; i++) {
            StringBuilder sb = new StringBuilder(userId);
       
              // 지정된 위치의 문자 교체
              sb.setCharAt(i, '*');
              userId = sb.toString();
               
         }
         
         u.setUserId(userId);
      }
      
         
      model.addAttribute("trade", tradeService.get(tradeNumber));
      model.addAttribute("item", itemService.get(itemNumber));
      model.addAttribute("images", imageService.getList(itemNumber)) ;
      model.addAttribute("userBids", userBids);

   }   
   
   
   
   @PostMapping("/remove")   
   public String delete(Long tradeNumber,  RedirectAttributes rttr,  PageInfo pi) {
      
         
      TradeVo trade = tradeService.get(tradeNumber);
      long itemNumber = trade.getItemNumber();
      
      itemService.modifyTrade(itemNumber, "N");
      int count = tradeService.remove(tradeNumber);
      
      if(count==1) {
         rttr.addFlashAttribute("result", "delSuccess"); 
         rttr.addAttribute("pageNo", pi.getPageNo());
         rttr.addAttribute("amount", pi.getAmount());
         rttr.addAttribute("keyword", pi.getKeyword());
         rttr.addAttribute("type", pi.getType());
      }
         
      return "redirect:/trade/getListIng" ;
   }

   
   
   @PostMapping("/tradeBid")
   public String tradeBid(String tradeBuyNowPrice, String tradeFinalPrice, long itemNumber, 
                     long tradeNumber, int userNum, String tradeOldPrice,  String tradeOldUserNum,
                     RedirectAttributes rttr, HttpSession session) throws Exception {
      
      //아이템은 보유상태가 아님
      itemService.modifyHave(itemNumber, 0);
      
      //트레이드 기록 갱신 (현재 마지막 입찰자 & 입찰가 변경)
      TradeVo newTrade = new TradeVo(); 
      newTrade.setTradeNumber(tradeNumber);
      newTrade.setUserNum(userNum);
      newTrade.setTradeBuyNowPrice(Integer.parseInt(tradeBuyNowPrice));
      tradeService.modify(newTrade) ;
      
      if(tradeOldUserNum!=null||tradeOldUserNum!="") {
         MemberVO oldMember = new MemberVO();
         oldMember.setUserCash(Integer.parseInt(tradeOldPrice));
         oldMember.setUserNum(Integer.parseInt(tradeOldUserNum));
         memberService.updateCashPlus(oldMember);
         
      }
      
      
      MemberVO newMember = new MemberVO();
      newMember.setUserCash(Integer.parseInt(tradeBuyNowPrice));
      newMember.setUserNum(userNum);
      
      memberService.updateCashMinus(newMember);
      
      //입찰 기록 갱신하기
      UserBidHistoryVo userBid = new UserBidHistoryVo();
      userBid.setItemNumber(itemNumber);
      userBid.setTradeNumber(tradeNumber);
      userBid.setUserNum(userNum);
      userBid.setUserBidPrice(Integer.parseInt(tradeBuyNowPrice));
      
      userBidService.register(userBid);
      
      if(tradeBuyNowPrice.equals(tradeFinalPrice)) {
         itemService.modifyTrade(itemNumber, "N");
         tradeService.modifyTrade(tradeNumber, "N") ; 
         long userBidNumber = userBidService.getListByTradeNumber(tradeNumber).get(0).getUserBidNumber();
         userBidService.updateYn(userBidNumber);
      
         //메일보내기 (님 낙찰이에요 낙찰자에게)
         sendTradeBidFinalEmail(tradeNumber) ;
         
         String userId = memberService.getUserId(userNum);
         MemberVO member = memberService.getUserInfoByUserId(userId);
         
         session.setAttribute("user", member);
         
         //여기 나의 입찰 내역으로 가고싶다.
         return "redirect:/trade/getListIng" ;
      }
      
      sendTradeBidEmail(tradeNumber) ;
      
      String userId = memberService.getUserId(userNum);
      MemberVO member = memberService.getUserInfoByUserId(userId);
      
      session.setAttribute("user", member);
      
      //여기 나의 입찰 내역으로 가고싶다.
      return "redirect:/trade/get?tradeNumber=" + tradeNumber ;
   }
   
   
   //경매가 종료된거
   @GetMapping("/endTrade")
   public String endTrade(PageInfo pi, Model model, long itemNumber, long tradeNumber) {
      
      
      itemService.modifyTrade(itemNumber, "N");
      tradeService.modifyTrade(tradeNumber, "N") ;
      
      //낙찰리스트가 있따면 맨 마지막 사람을 낙찰로 만들어 주기
      if(userBidService.getListByTradeNumber(tradeNumber).size() >0) {
    	  long userBidNumber = userBidService.getListByTradeNumber(tradeNumber).get(0).getUserBidNumber();
		  userBidService.updateYn(userBidNumber);
		  
		  //마지막 사람에게 메일로 낙찰 사실 알려주기
		  sendTradeBidEmail(tradeNumber) ;
      }
      pi.setAmount(9);
         
      List<TradeVo> tradeList = tradeService.getListIng(pi);
      List<ItemVo> itemList = null;
      
      for(TradeVo trade : tradeList) {
         ItemVo item = itemService.get(trade.getItemNumber());
         item.setImageList(imageService.getList(item.getItemNumber()));
         trade.setItem(item);
      }
      
      model.addAttribute("tradeList", tradeList);
      model.addAttribute("itemList", itemList);
      model.addAttribute("pageDTO", new PageDTO(pi, tradeService.getTotalIng(pi)));
      
      return "/trade/getListIng" ;
      
   }

   
   @ResponseBody
   @PostMapping("/getPresentPrice")
   public String getPresentPrice(
      @RequestParam("tradeNumber") Long tradeNumber)throws Exception{

      JSONObject jsonObject = new JSONObject();
      TradeVo vo = new TradeVo();
      vo = tradeService.get(tradeNumber);
      int nowPrice = vo.getTradeBuyNowPrice();
      jsonObject.put("data", nowPrice);
      return jsonObject.toString();
   }
   
   
    
   @ResponseBody
   @PostMapping(value="getBidsList") //ResponsBody와 produces는 쓰지 않는다 
   public List<UserBidHistoryVo> getBidsLists( Model model, @RequestParam(value="tradeNumber", required = false) 
   								Long tradeNumber) throws Exception { 

	   	List<UserBidHistoryVo> userBids = userBidService.getListByTradeNumber(tradeNumber);

	    for(UserBidHistoryVo u : userBids) {
	          String userId = memberService.getUserId(u.getUserNum());
	          
	          for(int i=2; i<userId.length()-2; i++) {
	             StringBuilder sb = new StringBuilder(userId);
	        
	               // 지정된 위치의 문자 교체
	               sb.setCharAt(i, '*');
	               userId = sb.toString();
	                
	          }
	          
	          u.setUserId(userId);
	    }
	   	
	   	return userBids ; 
   }
   

   public void sendTradeBidFinalEmail(long tradeNumber) {
	   
	   TradeVo tradeVo = tradeService.get(tradeNumber) ;	   

	   if(userBidService.getListByTradeNumber(tradeNumber).size() > 0) {
	   	   long userBidNumber = userBidService.getListByTradeNumber(tradeNumber).get(0).getUserBidNumber();
	   	   int userNum = userBidService.getListByTradeNumber(tradeNumber).get(0).getUserNum();
  
	   	   String to =  memberService.getUserId(userNum);

		   //마지막 사람에게 메일로 낙찰 사실 알려주기
	       emailService.sendEmailToHtmlFinal(to, "낙찰을 알려드립니다", tradeNumber);	  
	   }

   }
   
   public void sendTradeBidEmail(long tradeNumber) {
	   
	   TradeVo tradeVo = tradeService.get(tradeNumber) ;	   

	   if(userBidService.getListByTradeNumber(tradeNumber).size() > 0) {
	   	   long userBidNumber = userBidService.getListByTradeNumber(tradeNumber).get(0).getUserBidNumber();
	   	   int userNum = userBidService.getListByTradeNumber(tradeNumber).get(0).getUserNum();
  
	   	   String to =  memberService.getUserId(userNum);
	   	   MemberVO mvo =  memberService.getUserInfoByUserId(to) ;
	   	   UserBidHistoryVo ubVo = userBidService.getListByTradeNumber(tradeNumber).get(0) ;

		   
	       emailService.sendEmailToHtml(to, tradeNumber+" 번 상품에 응찰하셨습니다.", tradeNumber, mvo, ubVo);	  
	   }

   }
    
   
}