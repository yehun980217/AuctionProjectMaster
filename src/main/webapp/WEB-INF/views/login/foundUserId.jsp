<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@ include file="../include/header2.jsp"  %>
	<section id="section">
    	<h1 style="text-align: center;">아이디 찾기</h1>
	</section>
	
	<section id="section" class="login">

	<p style="color:orange;">당신의 아이디 : ${foundUserId}</p>
	
	</section>
	
<section id="section" class="login">
	<table>
		<tr>
			<td style="text-align:center;">
				<a class="hoverOrange" href="/login/findUserPw"> 비밀번호 찾기 </a>
			</td>
		</tr>
		
		<tr>
			<td>
				<a class="hoverOrange" href="/login/getLogin"> >> 로그인화면으로 돌아가기 << </a>
			</td>
		</tr>
		
		<tr>
			<td>
				<a class="hoverOrange" href="/"> >>> 메인화면으로 돌아가기 <<< </a>
			</td>
		</tr>
		
	</table>
</section>
	
<%@ include file="../include/footer2.jsp"  %>