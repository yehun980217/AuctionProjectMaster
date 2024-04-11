<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ include file="../include/header2.jsp"%>
	<section id="section" style="padding:25px 0;">
	<h2 style="font-size:60px;">회원가입</h2>
	</section>
	<section id="section">
	<form name="signupForm" class="signup" action="/signup/signup" method="post"
		onsubmit="return signUp();">
		
		
		<table>
			<tr>
				<!-- 아이디 입력 필드 -->
				<td>
					<label for="userId">아이디(Email):</label>
				</td>
					<input type="hidden" id="idOk" value="">
				<td>
				
					<input type="email" id="userId" name="userId" oninput="checkUserIdValidity(this)" style="width:502px;"
						onkeypress="return event.keyCode !== 13;" placeholder="ex) lazy@lazyworm.com">
				</td>
				<td>
					<button class="checkEmailDuplicate" id="button" style="height:40px; margin:0 5px; padding:0; margin-bottom:5px;" 	
					type="button" onclick="checkEmailDuplicate()">중복확인</button> 
					<!-- <span style="font-size: 14px; height: 40px;" id="userIdChkMessage" class="chk-error-message" /> -->
				</td>
			</tr>
			
			<tr>
				<td colspan="2"><div id="userIdMessage" class="error-message"></div></td>
				<td style="text-align:center;">
					<span style="font-size: 14px; height: 40px;" id="userIdChkMessage" class="chk-error-message" />
				</td>
			</tr>

			<!-- 비밀번호 입력 필드 -->
			<tr>
				<td>
					<label for="userPw">비밀번호:</label>
				</td>
					<input type="hidden" id="pwOk" value=""> 
				<td>
					<input type="password" id="userPw" name="userPw" style="width:502px;"
					oninput="checkUserPwValidity(this)" onkeypress="return event.keyCode !== 13;"
					placeholder="숫자, 영문자, 특수문자 1글자이상 포함(4~16)">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="userPwMessage" class="error-message"></div>
				</td>
			</tr>

			<!-- 비밀번호 확인 필드 -->
			<tr>
				<td>
					<label for="confirmPassword">비밀번호 확인:</label>
				</td>
				<td>
					<input type="password" id="confirmPassword" style="width:502px;"
					onkeypress="return event.keyCode !== 13;" name="confirmPassword">
				</td>
				<td>
					<button id="button" style="height:40px; margin:0 5px; padding:0; margin-bottom:5px;"  
					class="pwCheck" type="button" onclick="pwCheck()">일치확인</button> 
					<!-- <span style="font-size: 14px; height: 40px;" id="userPwChkMessage" class="chk-error-message" /> -->
				</td>
			</tr>
			<tr>
				<td colspan="2"></td>
				<td style="text-align:center;">
					<span style="font-size: 14px; height: 40px;" id="userPwChkMessage" class="chk-error-message" />
				</td>
			</tr>
			<tr>
				<td>
					<label for="userName">이름:</label>
				</td>
				<td>
					<input type="text" id="userName" name="userName"
					oninput="checkUserNameValidity(this)" onkeypress="return event.keyCode !== 13;"
					placeholder="한글 : 두 글자 이상, 영어 : 두 스펠링 이상">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="userNameMessage" class="error-message"></div>
				</td>
			</tr>

			<tr>
				<td>
					<label for="userPhoneNum">휴대폰번호:</label>
				</td>
				<td>
					<input type="text" id="userPhoneNum" name="userPhoneNum"
					oninput="checkUserPhoneValidity(this)" onkeypress="return event.keyCode !== 13;"
					placeholder="ex) 01*-****-****">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="userPhoneMessage" class="error-message"></div>
				</td>
			</tr>

			<tr>
				<td>
					<label for="userAddress">우편번호:</label>
				</td>
				<td>
					<input type="text" id="sample6_postcode" name="userAddress"
					onkeypress="return event.keyCode !== 13;" placeholder="우편번호" readonly>
				</td>
				<td>
					<input id="button" style="height:40px; margin:0 5px; padding:0; margin-bottom:5px;" 
					class="addressFind" type="button" onclick="sample6_execDaumPostcode()" value="주소찾기">
				</td>
			</tr>
			
			<tr>
				<td>
					<label for="userAddress">주소 :</label>
				</td>
				<td>
					<input type="text" id="sample6_address" name="userAddress"
					onkeypress="return event.keyCode !== 13;" placeholder="주소" readonly>
				</td>
			</tr>
			<tr>
				<td>
					<label for="userAddress">상세주소 :</label>
				</td>
				<td>
					<input type="text" style="width: 248px;"
					id="sample6_detailAddress" name="userAddress"
					onkeypress="return event.keyCode !== 13;" placeholder="상세주소">
					<input type="text" style="width: 248px;" id="sample6_extraAddress"
					name="userAddress" onkeypress="return event.keyCode !== 13;"
					placeholder="참고항목" readonly>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
				
					<button id="button" style="width:502px; margin:8px 0;" type="submit">회원가입 완료</button>
				</td>
			</tr>
		</table>
	</form>
</section>

<!-- 주소찾기 카카오 API -->
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
<!-- ------------------------- JavaScript -------------------------- -->

<script type="text/javascript">
	// 중복확인 상태를 나타내는 변수
	var isEmailChecked = false;
	// 비밀번호 일치 상태를 나타내는 변수
	var isPasswordConfirmed = false;

	//-------- 아이디 중복확인 체크 ---------------------------------------

	function checkEmailDuplicate() {
		var userId = document.forms["signupForm"]["userId"].value;
		var userIdInput = document.getElementById("userId");
		var userIdRegex = /^[\w\.-]+@[\w\.-]+\.\w+$/;
		var userIdChkMessage = document.getElementById("userIdChkMessage");

		if (!userIdRegex.test(userId)) {
			alert("아이디 형식이 올바르지 않거나 공백입니다.");
			userIdInput.focus();
			return false;
		}

		// AJAX를 사용하여 중복 확인 컨트롤러에 요청을 보냅니다.
		$.ajax({
			type : "POST",
			url : "/checkEmailDuplicate",
			data : {
				userId : userId
			},
			success : function(response) {
				if (response === "duplicate") {
					alert("중복된 이메일 주소입니다.");
					userIdChkMessage.innerHTML = "중복임당";
					isEmailChecked = false;
					return false;
				} else if (response === "unique") {
					alert("사용 가능한 이메일 주소입니다.");
					userIdChkMessage.innerHTML = "사용가능";
					$("#idOk").val("success");
					isEmailChecked = true;
				}
			}
		});

		userIdInput.oninput = function() {
			userIdChkMessage.innerHTML = "확인필요";
			isEmailChecked = false; // 사용자가 아이디를 변경했으므로 다시 확인 필요로 설정
		};

		return true;
	}

	//-------- 비밀번호, 비밀번호 확인 input 크로스체크 ------------------------

	function pwCheck() {
		var userPw = document.forms["signupForm"]["userPw"].value;
		var userPwInput = document.getElementById("userPw"); // userIdInput 변수에 input 요소를 가져옴
		var confirmPassword = document.forms["signupForm"]["confirmPassword"].value;
		var userPwRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!])[A-Za-z\d@#$%^&+=!]{4,16}$/;
		var userPwChkMessage = document.getElementById("userPwChkMessage");

		if (!userPwRegex.test(userPw)) {
			alert("비밀번호 형식이 올바르지 않거나 공백입니다.");
			userPwInput.focus();
			return false;
		}

		if (userPw != confirmPassword) {
			alert("비밀번호가 일치하지 않습니다.");
			userPwChkMessage.innerHTML = "확인필요";
			isPasswordConfirmed = false;
			return false;
			
		} else if (userPw == "" || confirmPassword == "" || userPw === null
				|| confirmPassword === null) {
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

		return true;
	}
	// ---------------  정규식 확인 ------------------------------------------------ 

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

	// '회원가입 완료' 버튼 클릭 시 실행될 함수
	function signUp() {
		var userId = document.forms["signupForm"]["userId"].value;
		var userPw = document.forms["signupForm"]["userPw"].value;
		var confirmPassword = document.forms["signupForm"]["confirmPassword"].value;
		var userName = document.forms["signupForm"]["userName"].value;
		var userPhoneNum = document.forms["signupForm"]["userPhoneNum"].value;
		var userAddress = document.forms["signupForm"]["sample6_address"].value;
		var userIdRegex = /^[\w\.-]+@[\w\.-]+\.\w+$/;
		var userPwRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!])[A-Za-z\d@#$%^&+=!]{4,16}$/;
		var userNameRegex = /^[A-Za-z가-힣 ]{2,30}$/;
		var userPhoneRegex = /^01[0-9]-\d{4}-\d{4}$/;

		if (userId === "" || userPw === "" || confirmPassword === ""
				|| userName === "" || userPhoneNum === "" || userAddress === ""
				|| !isEmailChecked || // Check if email is not checked (not validated)
				!isPasswordConfirmed) {
			alert("확인하지 않은 부분이 있거나 공백이 존재합니다.");
			return false; // Prevent the form from being submitted.

		} else if (!userIdRegex.test(userId) || userId === "") {
			alert("아이디 형식이 올바르지 않거나 공백입니다.");
			return false;

		} else if (!userPwRegex.test(userPw) || userPw === "") {
			alert("비밀번호 형식이 올바르지 않거나 공백입니다.");
			return false;

		} else if (userPw !== confirmPassword) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;

		} else if (!userNameRegex.test(userName) || userName === "") {
			alert("이름 형식이 올바르지 않거나 공백입니다.");
			return false;

		} else if (!userPhoneRegex.test(userPhoneNum) || userPhoneNum === "") {
			alert("휴대폰번호 형식이 올바르지 않거나 공백입니다.");
			return false;

		} else if (userAddress === "") {
			alert("주소를 입력해주세요.");
			return false;

		} else {
			alert("★☆★☆가입을 환영합니다!★☆★☆");
		}

		return true;
	}

	/* 			        if (isEmailChecked == false) {
	 alert("아이디 중복 여부를 확인해주세요.");
	 valid = false;
	 return;
	 }
	
	 if (isPasswordConfirmed == false) {
	 alert("비밀번호 일치 여부를 확인해주세요.");
	 valid = false;
	 return;
	 }
	 */
	 
</script>
<%@ include file="../include/footer2.jsp"%>