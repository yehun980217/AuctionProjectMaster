package com.red.boot.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

public class AuthorizationInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(AuthorizationInterceptor.class);
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    
        int userRole = getUserRoleFromSession(request);
        logger.info("userRole 변수의 값: " + userRole);
                
        if (userRole >= 8) {
            return true; // 사용자 권한이 0 이상인 경우에만 true를 반환합니다.
        } else {
            response.sendRedirect("/"); // 인덱스 페이지로 리다이렉트
            return false;
        }
        
        
    }

    private int getUserRoleFromSession(HttpServletRequest request) {
    	
        Object userRoleObj = request.getSession().getAttribute("userRole");
        
        logger.info("userRoleObj 변수의 값: " + userRoleObj);
        
        if (userRoleObj != null && userRoleObj instanceof Integer && (Integer)userRoleObj >= 0) {
            return (Integer)userRoleObj;
        } else {
            return -1; // 사용자 권한을 가져오지 못한 경우에는 -1로 설정
        }
    }
}
