<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header2.jsp"%>
	<form class="listForm">
		<table class="listRegisterTable">
			<tr>
				<th><label for="questionTitle">문의 제목</label></th>
			</tr>
			<tr>
				<th><input type="text" id="questionTitle" name="questionTitle"
					value="${question.questionTitle}" readonly></th>
			</tr>
			<tr>
				<th><label for="userId">문의자</label></th>
			</tr>
			<tr>
				<th><input type="text" id="userId" name="userId"
					value="${question.userId}" readonly></th>
			</tr>
			<tr>
				<td><textarea id="questionContent" name="questionContent"
						readonly rows="15" cols="75" placeholder="문의내용">${question.questionContent }</textarea></td>
			</tr>
		</table>
		<div id="center">
		<c:if test="${question.questionComplete eq 0}">
		
			<a href="mailto:${question.userId}"><button type="button">${question.userId}님에게
					답변 보내기</button></a>
		</c:if>
		</div>
		<hr style="margin:10px 0;">
		<div id="center">
		<button type="button" class="listBtn"
			onclick="window.location.href='/question/adminGetList'">문의 목록</button>
			</div>
			<div id="center">
		<c:if test="${question.questionComplete eq 0}">
			<button type="button" class="listBtn"
				onclick="window.location.href='/question/updateComplete?questionNumber=${question.questionNumber}'">답변
				완료</button>
		</c:if> 
		</div>
	</form>
<%@ include file="../include/footer2.jsp"%>