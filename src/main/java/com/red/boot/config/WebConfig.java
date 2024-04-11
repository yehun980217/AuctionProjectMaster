package com.red.boot.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.red.boot.intercepter.AuthorizationInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
    	String[] patterns = new String[]{
                "/admin/**",
                "/announcement/register",
                "/announcement/modify",
                "/email/verification_result",
                "/item/**",
                "/member/memberList",
                "/member/memberListAdmin",
				/* "/member/deleteUser", */
				/* "/member/modifyCertification", */
				/* "/member/modifyUserInfo", */
                "/payment/updateUserPayment",
                "/qa/modify",
                "/qa/register",
                "/question/adminGetDetail",
                "/question/adminGetList",
                "/question/CompleteList",
                /*"/question/register",*/
            };
    	
    	 registry.addInterceptor(new AuthorizationInterceptor()).addPathPatterns(patterns);
    }
}
