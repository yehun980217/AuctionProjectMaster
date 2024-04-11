package com.red.boot.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.javassist.compiler.ast.Member;

import com.red.boot.domain.MemberVO;

@Mapper
public interface SignupMapper {
	
	    MemberVO findByEmail(String userId);
	    void insertMember(MemberVO mVo);
	    
	}
  


