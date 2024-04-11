<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header2.jsp"%>

	<section id="section">
    <h1 style="text-align: center;">이메일 인증 결과</h1>
	</section>
	
   <section id="section" class="verification">
      <!-- 인증이메일 전송성공메세지 -->
      <p>${message}</p>
      
      <c:if test="${!empty sessionScope.user and sessionScope.user.userRole eq 1}">
         <table>
            <tr>
            	<td><b>${success}</b></td>
         	</tr>

         	<tr></tr>
         	
         	<tr>
	 			<td><a style="color: orange;" href="/trade/getListIng">경매참여하기 ㄴOㅇOㄱ</a></td>
         	</tr>
      	</table>      
      </c:if>
   </section>

   <%@ include file="../include/footer2.jsp"%>