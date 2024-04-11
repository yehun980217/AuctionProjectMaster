<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>
	<section id="section">
		<h1>보유금확인 / 금액충전</h1>
	</section>
	<div id="center" style="margin:20px 0; padding:20px 0;">
		<h1>${user.userName}님의 보유 금액은 <span style="color:red;"><fmt:formatNumber value="${user.userCash}" pattern="#,##0" /> &#8361; </span> 입니다.</h1>
	</div>
	
		<div id="center">
			<table>
			<tr>
				<th> <b> 계좌이체 ▽</b> </th>
				<th style="width:50px;"></th>
				<th> <b> 카카오페이 ▽</b> </th>
			</tr>
			<tr>
				<td>
					<a href="/payment/account"><img src="/images/cash_icon1.png" 
					alt="계좌이체" style="width:200px; height:200px; border-radius:5px;"></a>
				</td>
				<td style="width:50px;"></td>
				<td>
				<a href="javascript:openWindowPop('/payment/kakaoPay', 'popup');">
				<img src="/img/kakaoPay.png" style="width:200px; height:100px;" alt="카카오페이"></a>
			</td>
			</tr>
			
			</table>
		</div>
	
	<script>
		function openWindowPop(url, name){
		    var options = 'top=10, left=10, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no';
		    window.open(url, name, options);
		}
	</script>


<%@ include file="../include/footer2.jsp"%>
