<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>
<section id="section">
    	<h1 style="text-align: center;">비밀번호 찾기</h1>
	</section>
<section id="section" class="login">
	<table>
		<tr>
			<th colspan="2" style="text-align:center; color:orange;">임시 비밀번호 : ${foundUserPw}</th>
			<th></th>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;">  ${foundUserPwMessage} </td>
			<td></td>
		</tr>
	</table>
	
</section>
<section id="section">
	<table>
		<tr>
			<td style="text-align:center;">
				<a class="hoverOrange" href="/login/findUserId"> 아이디 찾기 </a>
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
<%@ include file="../include/footer2.jsp"%>