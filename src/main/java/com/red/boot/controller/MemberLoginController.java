package com.red.boot.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.red.boot.domain.ItemVo;
import com.red.boot.domain.MemberVO;
import com.red.boot.domain.TradeVo;
import com.red.boot.service.ImageService;
import com.red.boot.service.ItemService;
import com.red.boot.service.MemberService;
import com.red.boot.service.TradeService;

@Controller
@RequestMapping("/login/*")
public class MemberLoginController {

   @Autowired
   TradeService tradeService;

   @Autowired
   ItemService itemService;

   @Autowired
   ImageService imageService;

   @Autowired
   private MemberService memberService;
   @Autowired
   private BCryptPasswordEncoder passwordEncoder;

   @GetMapping("/getLogin")
   public String showLoginForm(HttpSession session, Model model) {

      MemberVO user = (MemberVO) session.getAttribute("user");
      List<TradeVo> tradeList = tradeService.getList();

      if (tradeList.size() > 2) {
         for (int i = 0; i < 3; i++) {
            ItemVo item = itemService.get(tradeList.get(i).getItemNumber());
            item.setImageList(imageService.getList(item.getItemNumber()));
            tradeList.get(i).setItem(item);
         }
      }

      tradeList = tradeList.subList(0, 3);

      model.addAttribute("tradeList", tradeList);
      
      
      
      if (user != null) { // 로그인 되어 있는 상태라면
         return "/index";
      } else {
         return "/login/getLogin";
      }
   }

   @PostMapping("/getLogin")
   public String processLogin(MemberVO member, Model model, HttpSession session, @RequestParam String userId,
         @RequestParam String userPw) {

      MemberVO mVo = memberService.getUserInfoByUserId(userId); // DB에 있는 있는 아이디인지 확인

      if (mVo != null) { // DB에 있는 아이디라면 ~

//                로그인 폼에서 입력한 비밀번호 1234qwer!
         String enteredPassword = userPw;

//               DB에 저장된 암호화된 비밀번호
         String storedPlainPassword = mVo.getUserPw();

         if (passwordEncoder.matches(enteredPassword, storedPlainPassword)) {
            // 사용자가 입력하는 비밀번호(1234qwer!)도 session에 넣어주기 위함(개인정보 수정 등에 필요)
            mVo.setUserSecurityPassword(enteredPassword);

            session.setAttribute("user", mVo);
            session.setAttribute("userRole", mVo.getUserRole());

            List<TradeVo> tradeList = tradeService.getList();

            if (tradeList.size() > 2) {
               for (int i = 0; i < 3; i++) {
                  ItemVo item = itemService.get(tradeList.get(i).getItemNumber());
                  item.setImageList(imageService.getList(item.getItemNumber()));
                  tradeList.get(i).setItem(item);
               }
            }

            tradeList = tradeList.subList(0, 3);

            model.addAttribute("tradeList", tradeList);

            return "/index";
         }
      }

      // 로그인 실패
      return "/login/noExistMember";
   }

}