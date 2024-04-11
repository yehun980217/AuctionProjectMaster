package com.red.boot.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Controller
@RequestMapping("/auth/*")
public class LoginController {
	//redirect 경로 mapping
    @RequestMapping("/kakao/callback")
    public @ResponseBody String kakaoCallBack(String code){
        RestTemplate rt = new RestTemplate();
        
        HttpHeaders headers = new HttpHeaders();
        headers.add("content-type", "application/x-www-form-urlencoded;charset=utf-8");

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", "122ddfe0818d5ce934de3456c118b83b");
        params.add("redirect_uri", "http://localhost:8989/auth/kakao/callback");
        params.add("code", code);
        
        HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest =
        		 new HttpEntity<>(params, headers);
        
        ResponseEntity<String> response = rt.exchange("https://kauth.kakao.com/oauth/token", 
        											HttpMethod.POST, kakaoTokenRequest, String.class);
        
        return "카카오 인증완료" + response;
    }
}
