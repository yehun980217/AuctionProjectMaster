<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>
	<section id="section">
	   <h1> 관리자 메뉴 </h1>
	</section>
	<div class="adminPageContainer">
	
	   <div class="adminPageIconLink">
	      <a href="/item/register">
	         <img src="/images/adminInsertArtIcon.png" class="adminPageIcon">상품등록 
	      </a>
	   </div>
	   
	   <div class="adminPageIconLink">
	      <a href="/question/adminGetList">
	         <img src="/images/adminQuestionListIcon.png" class="adminPageIcon">문의내역조회 
	      </a>
	   </div>
	
	   <c:choose>
	      <c:when test="${sessionScope.user.userRole eq 8}">
	            <div class="adminPageIconLink">
	               <a href="/member/memberListAdmin">
	                  <img src="/images/adminMemberListAicon.png" class="adminPageIcon">회원목록조회 
	               </a>
	         </div>   
	      </c:when>
	      <c:when test="${sessionScope.user.userRole eq 9}">
	             <div class="adminPageIconLink">
	               <a href="/member/memberList">
	                  <img src="/images/adminMemberListAicon.png" class="adminPageIcon">회원목록조회 
	             </a>
	         </div>   
	      </c:when>
	   </c:choose>
	   <div class="adminPageIconLink">
	         <a href="/payment/updateUserPayment">
	           <img src="/images/adminUpdateUserCashIcon.png" class="adminPageIcon">충전하기
	       </a>
	   </div>   
	</div>

<%@ include file="../include/footer2.jsp"%>