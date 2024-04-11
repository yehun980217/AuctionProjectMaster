<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>
<section id="section">
   <h1>문의사항내역</h1>
</section>
<div id="center">
<h2 style="margin-top:20px; font-size:24px;">
<span style="font-size:24px; color:red;">답변</span>은 
<span style="font-size:24px; color:red;">아이디(Email)</span>로 발송됩니다.</h2>
</div>
<div id="center">
<table class="listTable">
	<thead>
		<tr>
			<th scope="col">No</th>
			<th scope="col">제목</th>
			<th scope="col">문의일</th>
			<th scope="col">처리상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="question" items="${list}" varStatus="status">
			<tr>
				<th scope="row">${question.rno}</th>
				<td><a class="move" href="${question.questionNumber}">${question.questionTitle}</a></td>
				<td><fmt:formatDate value="${question.questionRegDate}" pattern="yyyy-MM-dd" /></td>
				<td>${question.questionComplete==0?"확인 중":"답변 완료" }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>

<ul class="listPagination">
	<c:if test="${pageDTO.preView}">
		<li class="page-item"><a class="page-link" href="?pageNo=${pageDTO.startPage-1}">이전으로</a></li>
	</c:if>
	<c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="pageNo">
		<li class="page-item"><a class="page-link" href="${pageNo}">${pageNo}</a></li>
	</c:forEach>
	<c:if test="${pageMaker.next}">
		<li class="page-item"><a class="page-link" href="${pageMaker.endPage+1}">다음으로</a></li>
	</c:if>
</ul>

<div id="center">
	<button type="button" class="listBtn" onclick="window.location.href='/question/register'">문의하기</button>
</div>

<form id="questionForm" action="/question/getList" method="get">
	<input type="hidden" name="pageNo" value="${pageDTO.pi.pageNo}">
	<input type="hidden" name="amount" value="${pageDTO.pi.amount}">
	<input type="hidden" name="type" value="${pageDTO.pi.type}">
	<input type="hidden" name="keyword" value="${pageDTO.pi.keyword}">
	<input type="hidden" name="questionNumber" id="questionNumber" value="">
</form>




<script type="text/javascript">
	var questionForm = $('#questionForm');

	$(".page-link").on("click", function(e) {
		e.preventDefault();
		var targetPage = $(this).attr("href");
		questionForm.find("input[name='pageNo']").val(targetPage);
		questionForm.submit();
	});

	$(".move").on("click", function(e) {
		e.preventDefault();
		var questionNumber = $(this).attr("href");
		$("#questionNumber").val(questionNumber);
		questionForm.attr("action", "/question/get");
		questionForm.submit();

	});
</script>

<%@ include file="../include/footer2.jsp"%>