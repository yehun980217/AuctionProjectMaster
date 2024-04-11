package com.red.boot.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.red.boot.domain.MemberVO;
import com.red.boot.mapper.SignupMapper;

@Service
public class SignupService {
    @Autowired
    private SignupMapper signupMapper;
    
    public void signupMember(MemberVO mVo) {
    	signupMapper.insertMember(mVo);
    }
    public MemberVO findMemberByEmail(String userId) {
    	return signupMapper.findByEmail(userId);
    }
}

