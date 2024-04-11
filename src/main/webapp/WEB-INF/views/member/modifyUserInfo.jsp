<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header2.jsp"%>

	<section id="section">
		<h1>개인 정보 수정</h1>
	</section>
	
	<div id="center" style="padding:20px 0;">

	<form name="modifyInfoForm" action="/member/modifyUserInfo"
		method="post" style="margin: auto;">
		<table>
			<tr>
				<td><label for="userId">아이디(Email):</label></td>
				<td><input style="background-color:#f6f6f6; border:none;" type="email" id="userId" name="userId"
					value="${user.userId}" readonly></td>
			</tr>
			<tr>
				<td><label for="userPw">비밀번호:</label></td>
				<td><input type="password" id="userSecurityPassword" oninput="checkUserPwValidity(this)"
					name="userSecurityPassword" value="${user.userSecurityPassword}"></br> 
					<input type="hidden" id="userPw" name="userPw" value="${user.userPw}"></td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="userPwMessage" class="error-message"></div>
				</td>
			</tr>

			<!-- 비밀번호 확인 필드 -->
			<tr>
				<td><label for="confirmPassword">비밀번호 확인:</label></td>
				<td><input type="password" id="confirmPassword"
					name="confirmPassword" value="${user.userSecurityPassword}"></td>
				<td><button style="height:40px; margin:0 10px; margin-bottom: 5px; padding:0 5px;"
				 id="button" type="button" onclick="pwCheck()">일치확인</button>
				 <!--  <span style="font-size: 14px; height: 40px;" id="userPwChkMessage" class="chk-error-message" /></td> -->
			</tr>
			<tr>
				<td colspan="2"></td>
				<td style="text-align:center;"><span style="font-size: 14px; height: 40px;" id="userPwChkMessage" class="chk-error-message" /></td>
				
			</tr>

			<tr>
				<td><label for="userName">이름:</label></td>
				<td><input type="text" id="userName" name="userName"
					value="${user.userName }" oninput="checkUserNameValidity(this)"> <br></td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="userNameMessage" class="error-message"></div>
				</td>
			</tr>

			<tr>
				<td><label for="userPhoneNum">휴대폰번호:</label></td>
				<td><input style="background-color:#f6f6f6; border:none;" type="text" id="userPhoneNum" name="userPhoneNum"
					value="${user.userPhoneNum }" readonly> </br></td>
			</tr>

			<tr>
				<td><label for="userAddress">우편번호:</label></td>
				<td><input type="text" id="sample6_postcode" name="userAddress"
					onkeypress="return event.keyCode !== 13;" readonly style="background-color:#f6f6f6; border:none;"></td>
				<td><input id="button" style="height:40px; margin:0 10px; margin-bottom: 5px; padding:0 5px;"
					type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기"><br></td>
			</tr>
			<tr>
				<td><label for="userAddress">주소 :</label></td>
				<td><input type="text" id="sample6_address" name="userAddress" style="background-color:#f6f6f6; border:none;"
					onkeypress="return event.keyCode !== 13;" readonly></td>
			</tr>
			<tr>
				<td><label for="userAddress">상세주소 :</label></td>
				<td><input type="text" style="width: 248px;"
					id="sample6_detailAddress" name="userAddress"
					onkeypress="return event.keyCode !== 13;"> <input
					type="text" style="width: 248px; background-color:#f6f6f6; border:none;" id="sample6_extraAddress"
					name="userAddress" onkeypress="return event.keyCode !== 13;"
					placeholder="참고항목" readonly></td>
			</tr>
			<tr>
			<td colspan="2" style="text-align:center;"><button style="width: 200px; height: 40px;" id="infoModifyBtn" 
			type="button" onclick="infoModify()">개인 정보 변경하기</button><td>

		</table>

		
	</form>
</div>

<!-- 주소찾기 카카오 API -->
<script>
	var userAddress = "${user.userAddress }";
	var addressParts = userAddress.split(',');

	// 첫 번째 주소 부분을 가져와서 설정
	if (addressParts.length > 0) {
		document.getElementById("sample6_postcode").value = addressParts[0];
	}

	if (addressParts.length > 1) {
		document.getElementById("sample6_address").value = addressParts[1];
	}

	if (addressParts.length > 2) {
		document.getElementById("sample6_detailAddress").value = addressParts[2];
	}
</script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample6_extraAddress").value = extraAddr;

						} else {
							document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
	}
</script>

<script type="text/javascript">
	var isPasswordConfirmed = false;
	
	// 비밀번호 정규식 확인
	function checkUserPwValidity(input) {
		var userPw = input.value;
		var userPwRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!])[A-Za-z\d@#$%^&+=!]{4,16}$/;
		var userPwMessage = document.getElementById("userPwMessage");

		if (!userPwRegex.test(userPw)) {
			userPwMessage.innerHTML = "비밀번호 형식이 올바르지 않습니다.";
			isPasswordConfirmed = false;
		} else {
			userPwMessage.innerHTML = "";
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
	
	function pwCheck() {
		
		var userSecurityPassword = document.forms["modifyInfoForm"]["userSecurityPassword"].value;
		var userPwInput = document.getElementById("userSecurityPassword"); // userIdInput 변수에 input 요소를 가져옴
		var confirmPassword = document.forms["modifyInfoForm"]["confirmPassword"].value;
		var userPwChkInput = document.getElementById("confirmPassword"); 
		var userPwRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!])[A-Za-z\d@#$%^&+=!]{4,16}$/;
		var userPwChkMessage = document.getElementById("userPwChkMessage");

		if (!userPwRegex.test(userSecurityPassword)) {
			alert("비밀번호 형식이 올바르지 않거나 공백입니다.");
			userPwInput.focus();
			return false;
		}

		if (userSecurityPassword != confirmPassword) {
			alert("비밀번호가 일치하지 않습니다.");
			userPwChkMessage.innerHTML = "확인필요";
			isPasswordConfirmed = false;
			return false;
			
		} else if (userSecurityPassword == "" || confirmPassword == ""
				|| userSecurityPassword === null || confirmPassword === null) {
			alert("비밀번호 또는 비밀번호 확인을 입력해주세요.");
			userPwChkMessage.innerHTML = "입력필수";
			isPasswordConfirmed = false;
			return false;
			
		} else {
			alert("비밀번호가 일치합니다.");
			userPwChkMessage.innerHTML = "일치확인";
			$("#pwOk").val("success");
			isPasswordConfirmed = true;
		}

		userPwInput.oninput = function() {
			userPwChkMessage.innerHTML = "확인필요";
			isPasswordConfirmed = false; // 사용자가 비밀번호를 변경했으므로 다시 확인 필요로 설정
		};
		
		userPwChkInput.oninput = function() {
			userPwChkMessage.innerHTML = "확인필요";
			isPasswordConfirmed = false; // 사용자가 비밀번호를 변경했으므로 다시 확인 필요로 설정
		};

		return true;
	}

	function infoModify() {

		if (isPasswordConfirmed == true) {
			alert("변경되었습니다.");
			infoModifyBtn.type = "submit";
		} else {
			alert("비밀번호 일치확인이 필요합니다.");
		}

	}
</script>
<%@ include file="../include/footer2.jsp"%>