<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>

	<section id="section" style="padding: 25px 0;">
		<h2 style="font-size: 60px;">로그인</h2>
	</section>
	
	<section id="section">
		<form method="post" action="/login/getLogin">
	
			<label for="userId">아이디</label> <input type="text" id="userId"
				name="userId" placeholder="아이디" style="text-indent: 10px;">
			<br> <label for="userPw">비밀번호</label> <input type="password"
				id="userPw" name="userPw" placeholder="비밀번호"
				style="width: 100%; height: 40px; margin-bottom: 5px; text-indent: 10px;">
			<br>
			<button type="button" id="loginBtn" onclick="checkLogin()"
				style="width: 100%; height: 40px; margin-top: 10px; font-size: 15px; font-weight: bold; background-color: orange;">로그인</button>
	
			<div id="find"
				style="display: flex; justify-content: center; align-items: center; margin-top: 10px;">
				<span class="hoverOrange" style="padding: 0 10px;"><a href="/login/findUserId">아이디찾기</a></span>
				<span class="hoverOrange" style="padding: 0 10px;"><a href="/login/findUserPw">비밀번호찾기</a></span>
				<span class="hoverOrange" style="padding: 0 10px;"><a href="/signup/signup">회원가입</a></span>
			</div>
		</form>
	</section>
	
	<script type="text/javascript">
	      function checkLogin(){
	         let userId = $("#userId").val();
	         let userPw = $("#userPw").val();
	         let loginBtn = document.getElementById("loginBtn");
	         
	         if(userId==null||userId==""){
	            alert("아이디 입력은 필수입니다.");
	            $("#userId").focus();
	            return;
	         } else if(userPw==null||userPw==""){
	            alert("비밀번호 입력은 필수입니다.");
	            $("#userPw").focus();
	            return;
	         } else {
	            loginBtn.type="submit";
	         }
	      }
	
	      
	      var userPw = document.getElementById("userPw");
	
	      userPw.addEventListener("keyup", function (event) {
		    	event.preventDefault();
		   		if (event.keyCode === 13) {
		    			$("#loginBtn").click();
	
		      	} 
		    });
	   </script>
	

<%@ include file="../include/footer2.jsp"%>