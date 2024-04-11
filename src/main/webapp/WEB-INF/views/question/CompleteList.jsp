<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header2.jsp"%>
	<section id="section">
	 <h1>문의사항내역</h1>
	</section>
	
	<div id="center" style="margin-top:20px;">
	<button style="margin: 0 20px;" type="button" onclick="listAll()"class="listBtn">전체 문의 내역</button>
	<button style="margin: 0 20px;" type="button" onclick="checking()"class="listBtn">처리 중인 문의 내역</button>
	<button style="margin: 0 20px;" type="button" onclick="complete()"class="listBtn">답변 완료한 문의 내역</button>
	</div>
	<!-- 
	<button type="button"
		onclick="window.location.href='/question/CompleteList'">답변 완료
		내역</button>
	 -->
	<div id="center">
	<table class="listTable">
		<thead>
			<tr>
				<th scope="col">No</th>
				<th scope="col">문의 제목</th>
				<th scope="col">문의 일자</th>
				<th scope="col">처리상태</th>
				<!-- <th scope="col">문의자</th> -->
			</tr>
		</thead>
		<tbody>
			<c:forEach var="question" items="${list}" varStatus="status">
					<tr>
						<th scope="row">${question.rno}</th>
						<td><a class="move" href="${question.questionNumber}">${question.questionTitle}</a></td>
						<td><fmt:formatDate value="${question.questionRegDate}"
								pattern="yyyy-MM-dd" /></td>
						<td>${question.questionComplete==0?"확인 중":"답변 완료" }</td>
						<%-- <td>${question.userId}</td> --%>
					</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	<ul class="listPagination">
		<c:if test="${pageDTO.preView}">
			<li class="page-item"><a class="page-link"
				href="${pageDTO.startPage-1}">이전으로</a></li>
		</c:if>
		<c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}"
			var="pageNo">
			<li class="page-item"><a class="page-link" href="${pageNo}">${pageNo}</a>
			</li>
		</c:forEach>
	
		<c:if test="${pageMaker.next}">
			<li class="page-item"><a class="page-link"
				href="${pageMaker.endPage+1}">다음으로</a></li>
		</c:if>
	</ul>
	
	<form id="questionForm" action="/question/adminGetList" method="get">
		<input type="hidden" name="pageNo" value="${pageDTO.pi.pageNo}">
		<input type="hidden" name="amount" value="${pageDTO.pi.amount}">
		<input type="hidden" name="type" value="${pageDTO.pi.type}"> 
		<input type="hidden" name="keyword" value="${pageDTO.pi.keyword}">
		<input type="hidden" name="questionNumber" id="questionNumber" value="">
	</form>
	
	
	
	<div id="myModal" class="myModal">
		<div class="modal-body">
			<p>Modal body text goes here.</p>
		</div>
		<div class="modal-footer">
			<button id="close-modal" class="close-modal">닫기</button>
		</div>
	</div>
	
	
	
	<script type="text/javascript">
		var questionForm = $('#questionForm');
	
		$(".page-link").on("click", function(e) {
			e.preventDefault();
	
			var targetPage = $(this).attr("href");
	
			questionForm.find("input[name='pageNo']").val(targetPage);
			questionForm.submit();
		});
	
		//get 보내기
		$(".move")
				.on(
						"click",
						function(e) {
							e.preventDefault();
	
							var questionNumber = $(this).attr("href");
	
							$("#questionNumber").val(questionNumber);
							questionForm.attr("action", "/question/adminGetDetail");
							questionForm.submit();
	
						});
	
		function listAll() {
			location.href = "/question/adminGetList"
		}
	
	
		function checking() {
			location.href = "/question/CompleteList?questionComplete=0"
		}
		
			function complete() {
			location.href = "/question/CompleteList?questionComplete=1"
		}
	
	</script>
	
	



<%@ include file="../include/footer2.jsp"%>
