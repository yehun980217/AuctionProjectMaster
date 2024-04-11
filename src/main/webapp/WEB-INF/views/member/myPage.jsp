<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>
   <div class="superContainer">
      <div class="myPageContent">
         <div class="myPageBanner"></div>
         <form class="myPageForm">
            <div id="center">
               <strong>${user.userName}님</strong>, 환영합니다. [${userRoleLabel}]
            </div>
            <button type="button" onclick="logout()">로그아웃</button>
   
            <c:choose>
               <c:when test="${sessionScope.user.userRole eq 0}">
                  <c:set var="userRoleLabel" value="준회원" />
               </c:when>
               <c:when test="${sessionScope.user.userRole eq 1}">
                  <c:set var="userRoleLabel" value="정회원" />
               </c:when>
               <c:when test="${sessionScope.user.userRole eq 8}">
                  <c:set var="userRoleLabel" value="관리자" />
               </c:when>
               <c:when test="${sessionScope.user.userRole eq 9}">
                  <c:set var="userRoleLabel" value="마스터" />
               </c:when>
               <c:otherwise>
                  <c:set var="userRoleLabel" value="알 수 없음" />
               </c:otherwise>
            </c:choose>
   
            <hr style="border: 1px solid #333;">
            <button type="button" onclick="window.location.href='/question/getList?userNum=${user.userNum}'">문의내역 확인하기</button>
            <button type="button" onclick="window.location.href='/member/myAuction?userNum=${user.userNum}'">경매내역 확인하기</button>
            <button type="button" onclick="window.location.href='/member/modifyCertification'">개인정보 수정하기</button>
            <button type="button" onclick="window.location.href='/payment/userWallet'">보유금 확인 / 금액충전</button>
            <button type="button" onclick="window.location.href='/member/deleteUser'">회원 탈퇴</button>
         </form>
      </div>
   </div>
   
<script>
   function logout() {
      alert("로그아웃 되었습니다.");
      location.href = "/logout";
   }
</script>
<%@ include file="../include/footer2.jsp"%>