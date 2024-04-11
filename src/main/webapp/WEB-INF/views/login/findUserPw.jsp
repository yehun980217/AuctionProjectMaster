<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>

	<section id="section">
		<h1 style="text-align: center;">비밀번호 찾기</h1>
	</section>
	
	<section id="section" class="login">
		<div id="findUserId">
			<form name="findUserPw" action="/login/findUserPw" method="post">
				<table>
					<tr>
						<td><label for="userId">아이디(Email):</label></td>
						<td><input type="email" style="width: 300px;" id="userId"
							name="userId" oninput="checkUserIdValidity(this)"
							onkeypress="return event.keyCode !== 13;"
							placeholder="ex) lazy@lazyworm.com"></td>
					</tr>
					<tr>
						<td colspan="2"><div id="userIdMessage" class="error-message"></div></td>
					</tr>
	
					<tr>
						<td><label for="userName">이름:</label></td>
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
						<td><label for="userPhoneNum">휴대폰번호:</label></td>
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
							<button style="width:200px;" id="button" type="submit">비밀번호찾기</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	
	</section>
	<script>
		function checkUserIdValidity(input) {
			// 아이디 정규식 확인
			var userId = input.value;
			var userIdRegex = /^[\w\.-]+@[\w\.-]+\.\w+$/;
			var userIdMessage = document.getElementById("userIdMessage");
	
			if (!userIdRegex.test(userId)) {
				userIdMessage.innerHTML = "아이디 형식이 올바르지 않습니다.";
				isEmailChecked = false;
			} else {
				userIdMessage.innerHTML = "";
			}
		}
	
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