<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>
	
	<section id="section">
    <h1 style="text-align: center;">아이디 찾기</h1>
	</section>

	<section id="section" class="login">
		<div id="findUserId">
				<form id="findUserId" name="findUserId"
				action="/login/findUserId" method="post">
					<table>
					<tr>
						<th><label for="userName">이름:</label></th>
						<td><input type="text" style="width: 300px;" id="userName"
							name="userName" oninput="checkUserNameValidity(this)"
							onkeypress="return event.keyCode !== 13;"
							placeholder="한글 : 두 글자 이상, 영어 : 두 스펠링 이상"> </br></td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="userNameMessage" class="error-message"></div>
						</td>
					</tr>
	
					<tr>
						<th><label for="userPhoneNum">휴대폰번호:</label></th>
						<td><input type="text" style="width: 300px;" id="userPhoneNum"
							name="userPhoneNum" oninput="checkUserPhoneValidity(this)"
							onkeypress="return event.keyCode !== 13;"
							placeholder="ex) 01*-****-****"> </br></td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="userPhoneMessage" class="error-message"></div>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align:center;">
							<button id="button" style="width:200px; "type="submit">아이디찾기</button>
						</td>
					</tr>
					</table>
				</form>
		</div>
	
	</section>
	<script>
		// 이름 정규식 확인
		function checkUserNameValidity(input) {
			var userName = input.value;
			var userNameRegex = /^[A-Za-z가-힣 ]{2,30}$/;
			var userNameMessage = document.getElementById("userNameMessage");
	
			if (!userNameRegex.test(userName)) {
				userNameMessage.innerHTML = "이름 형식이 올바르지 않습니다.";
			} else {
				userNameMessage.innerHTML = "";
			}
	
		}
		// 휴대폰 번호 정규식 확인
		function checkUserPhoneValidity(input) {
			var userPhone = input.value;
			var userPhoneRegex = /^01[0-9]-\d{4}-\d{4}$/;
			var userPhoneMessage = document.getElementById("userPhoneMessage");
	
			if (!userPhoneRegex.test(userPhone)) {
				userPhoneMessage.innerHTML = "휴대폰번호 형식이 올바르지 않습니다.";
			} else {
				userPhoneMessage.innerHTML = "";
			}
		}
	</script>
<%@ include file="../include/footer2.jsp"%>