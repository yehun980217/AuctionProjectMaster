<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>

<form class="listForm">
	<table class="listRegisterTable">
		<tr>
			<th><label for="questionNumber">문의 제목</label></th>
		</tr>
		<tr>
			<th><input type="text" id="questionTitle" name="questionTitle"
				value="${question.questionTitle}" readonly></th>
		</tr>
		<tr>
			<td><textarea id="questionContent" name="questionContent"
					readonly rows="20" cols="100" placeholder="문의내용">${question.questionContent }</textarea></td>
		</tr>
	</table>

	<button type="button"
		onclick="window.location.href='/question/getList'">문의 목록</button>
</form>

<%@ include file="../include/footer2.jsp"%>