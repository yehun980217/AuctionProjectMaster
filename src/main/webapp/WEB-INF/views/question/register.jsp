<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header2.jsp"%>

<form action="/question/register" id="questionForm" class="listForm"
   method="post">
   <table class="listRegisterTable">
      <tr>
         <th><label for="questionNum">문의 제목</label></th>
      </tr>
      <tr>
         <th><input type="text" id="questionTitle" name="questionTitle" placeholder="제목"
            required></th>
      </tr>
      <tr>
      <th><label for="questionNum">문의 내용</label></th>
      </tr>
      <tr>
         <td><textarea id="questionContent" name="questionContent" style="text-indent:5px;"
               rows="15" cols="75" placeholder="문의내용" required></textarea></td>
      </tr>
   </table>

   <input type="hidden" name="userNum" value="${user.userNum}"> <input
      type="hidden" name="userId" value="${user.userId}">
      <div id="center">
   <button type="button" onclick="chkQuestion()">문의 등록</button>
   </div>
    <div id="center">
   <c:if test="${!empty sessionScope.user and sessionScope.user.userRole ge 8 }">
      <button type="button"
      onclick="window.location.href='/question/adminGetList'">문의 목록으로 이동</button>
      </c:if>
      <c:if test="${!empty sessionScope.user and sessionScope.user.userRole le 1 }">
      <button type="button"
      onclick="window.location.href='/question/getList'">문의 목록으로 이동</button>
      </c:if>
      </div>
</form>
<script>
   function chkQuestion() {

      if ($("#questionTitle").val() == ""
            || $("#questionTitle").val() == null) {
         alert("문의 제목을 입력해주세요");
         return;
      }
      if ($("#questionContent").val() == ""
            || $("#questionContent").val() == null) {
         alert("문의 내용을 입력해주세요");
         return;
      }

      alert("문의가 접수되었습니다. 답변은 이메일로 발송됩니다.");

      $("#questionForm").submit();

   };
</script>
<%@ include file="../include/footer2.jsp"%>