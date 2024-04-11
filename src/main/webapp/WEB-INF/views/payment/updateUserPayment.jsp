<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>
<form action="/payment/updateUserPayment" id="paymentForm" method="post" class="paymentForm">
<strong>회원 보유금액 충전</strong>
<hr style="border:1px solid #333;">
	<table class="paymentTable">
		<tr>
			<th><label for="userId">아이디</label></th>
		</tr>
		<tr>
			<th><input type="text" id="userId" name="userId" required></th>
		</tr>
		<tr>
			<th><label for="userCash">충전 금액</label></th>
		</tr>
		<tr>
			<td><input type="text" id="userCash" name="userCash" required></td>
		</tr>
	</table>

	<button type="button" onclick="updateUserPayment()" class="paymentBtn">충전</button>
	<button type="button" onclick="window.location.href='/admin/adminPage'" class="paymentBtn">관리자
		페이지로 이동</button>
</form>

<script>
	function updateUserPayment() {
		var userIdValue = document.getElementById("userId").value;
		var userCashInput = document.getElementById("userCash");
		var userCashValue = userCashInput.value;

		if (userIdValue === "" || userIdValue === null) {
			alert("아이디를 입력해주세요");
			return;
		}
		if (userCashValue === "" || userCashValue === null) {
			alert("충전 금액을 입력해주세요");
			return;
		}

		// 콤마 제거 및 정수로 파싱
		var userCashInt = parseInt(userCashValue.replace(/,/g, ''), 10);

		alert("충전이 완료되었습니다.");

		// 파싱된 정수 값을 다시 입력 필드에 설정
		userCashInput.value = userCashInt;

		// 정수 값으로 폼을 제출
		var form = document.getElementById("paymentForm");
		form.submit();
	}

	const input = document.querySelector('#userCash');
	input.addEventListener('keyup', function(e) {
		let value = e.target.value;
		value = Number(value.replaceAll(',', ''));
		if (isNaN(value)) {
			input.value = 0;
		} else {
			const formatValue = value.toLocaleString('ko-KR');
			input.value = formatValue;
		}
	});
</script>
<%@ include file="../include/footer2.jsp"%>>
