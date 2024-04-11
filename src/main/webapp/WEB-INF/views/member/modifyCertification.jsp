<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>

	<section id="section">
		<h1>회원 정보 수정</h1>
	</section>

	<section id="section">
		<form method="POST" action="/member/modifyCertification" name="modifyCertificationForm">
			<table>
			<tr>
		      <td> <label for="userPw">비밀번호 : </label> 
		 	  <td> <input type="password" id="userPassword" name="userPassword" placeholder="비밀번호를 입력해주세요."> </td> <br>
		    </tr>
		    <tr>
			  <td colspan="2" style="text-align:center;">
			   <button style="width:200px;" type="button" id="button" onclick="modifyUser()">인증하기</button> </td>
		    </tr>
		    
		      <input type="hidden" id="loginUserId" name="loginUserId" value="${user.userId}">
		      <input type="hidden" id="userSecurityPassword" name="userSecurityPassword" value="${user.userSecurityPassword}">
		      <input type="hidden" name="userPw" value="${user.userPw }">
		     </table>
		</form>
	</section>

	<script>
	   function modifyUser() {
	      let userPassword = $("#userPassword").val();
	      let userSecurityPassword = $("#userSecurityPassword").val();
	      let modifyBtn = document.getElementById("button");
	
	      if (userPassword == null || userPassword == "") {
	         alert("비밀번호를 입력해주세요.");
	         $("#userPw").focus();
	         return;
	      } else if (userPassword != userSecurityPassword) {
	         alert("비밀번호가 일치하지 않습니다.");
	         return;
	      } else {
	         alert("인증이 완료되었습니다.")
	         modifyBtn.type = "submit";
	      }
	   }
	</script>
	
<%@ include file="../include/footer2.jsp"%>