<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<link  rel="stylesheet" href="/css/paymentCss.css" type="text/css">
<title>Insert title here</title>
</head>
<body>
	<div class="kakaoPay" align="center" style="margin-top: 200px">
       <form method="post" action="/payment/kakaoPay" id="kp_form">
         
          <img class="card-img-top" src="/img/kakaoPay.png" alt="..." />
          <p style="font-weight: bold">카카오페이 현재 사용가능</p>
          <table>
          	<tr>
          		<td><label class="kakaoPay_input"><input type="radio" id="kp_amount" name="kp_amount" value="100000"><span>100,000원</span></label></td>
          		<td><label class="kakaoPay_input"><input type="radio" id="kp_amount" name="kp_amount" value="200000"><span>200,000원</span></label></td>
          		<td><label class="kakaoPay_input"><input type="radio" id="kp_amount" name="kp_amount" value="300000"><span>300,000원</span></label><br/></td>
          	</tr>
          	<tr>
          		<td><label class="kakaoPay_input"><input type="radio" id="kp_amount" name="kp_amount" value="400000"><span>400,000원</span></label></td>
          		<td><label class="kakaoPay_input"><input type="radio" id="kp_amount" name="kp_amount" value="500000"><span>500,000원</span></label></td>
          		<td><label class="kakaoPay_input"><input type="radio" id="kp_amount" name="kp_amount" value="1000000"><span>1,000,000원</span></label></td>
          	</tr>
          </table>
		  <input type="hidden" name="userId" id="userId" value="${user.userId}">
          <input type="hidden" name="userNum" id="userNum" value="${user.userNum}">	
          <button type="button" class="kp_button" id="charge_kakao" onclick="kakaoPay()">충전하기</button>
          
		</form>
	</div>

	<script type="text/javascript">

		function kakaoPay() {
			// 구매자 정보
			var userNum = $("#userNum").val();
			var userId = $("#userId").val();
			var kp_amount = $("input[name='kp_amount']:checked").val();
			console.log(userNum);
			console.log(userId);
			console.log(kp_amount);
			
			if(userNum==null||userNum==""||kp_amount==null||kp_amount==""){
				alert("다시 선택해주세요");
				return;
			}
			
			var IMP = window.IMP;
			IMP.init("imp75548776"); // 가맹점 식별코드
			
		    if (confirm("구매 하겠습니까?")) { // 구매 클릭시 한번 더 확인하기
		       IMP.request_pay({
		    	    pg : 'kakaopay.TC0ONETIME',
	                amount: kp_amount, // 가격
	                buyer_Id: userId,
	                buyer_Num: userNum,
	                name:'상품캐쉬결제'

	           }, function(rsp) {
	                if (rsp.success) { //결제 성공시
	                    console.log("111");
	                	var msg = "결제 완료되었습니다.";	
                    	
	                	$('#kp_form').submit();
	                	
	                }else {
	                    var msg = "결제실패되었습니다."
	                }
	                	alert(msg);
	                	window.opener.location.href="/member/myPage";

		    	});
	       } else {
		       return false;      
		   }
		}	
			
	</script>



</body>
</html>