<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>
<section id="section">
	<h1>${announcement.announcementTitle}</h1>
</section>

<section id="section">
	<form name="announcementForm" id="announcementForm"
		action="/announcement/getList" method="get">
		<table>
			<tr>
				<th><label for="announcementNumber">번호</label></th>

				<th><label for="announcementDate">공지일</label></th>
			</tr>

			<tr>
				<td><input type="text" class="form-control"
					id="announcementNumber" name="announcementNumber" value="${announcement.announcementNumber}" readonly></td>
				
				<td><input type="text" class="form-control"
					id="announcementDate" name="announcementDate"
					value="<fmt:formatDate value="${announcement.announcementDate}" pattern="yyyy-MM-dd" />"
					readonly></td>
			</tr>
			<tr>
				<th colspan="2"><label for="announcementTitle">공지제목</label></th>
			</tr>
			<tr>
				<th colspan="2"><input type="text" class="form-control"
					id="announcementTitle" name="announcementTitle"
					value="${announcement.announcementTitle}" readonly></th>
			</tr>
			<tr>
				<td colspan="2"><textarea class="announcementContent" 
						id="announcementContent" rows="15" cols="75" readonly>${announcement.announcementContent}</textarea>
				</td>
			</tr>
		</table>

		<input type="hidden" name="pageNo" value="${PageInfo.pageNo}">
		<input type="hidden" name="amount" value="${PageInfo.amount}">
		<input type="hidden" name="type" value="${PageInfo.type}"> <input
			type="hidden" name="keyword" value="${PageInfo.keyword}">
		<div id="center">
			<c:if
				test="${sessionScope.user != null && sessionScope.user.userRole gt 7}">
				<button type="button" class="btn btn-default modBtn">수정/삭제</button>
			</c:if>


			<button type="button" class="btn btn-default itemlistBtn">리스트로
				이동</button>

		</div>
	</form>
</section>

<script type="text/javascript">
	$(".modBtn").click(function(e) {
		var announcementForm = $("#announcementForm");
		e.preventDefault();

		announcementForm.attr("action", "/announcement/modify");
		announcementForm.find("input[name='announcementDate']").remove();
		announcementForm.find("input[name='announcemenContent']").remove();
		announcementForm.find("input[name='announcementTitle']").remove();
		announcementForm.submit();
	});

	$(".itemlistBtn").click(function(e) {
		var announcementForm = $("#announcementForm");
		e.preventDefault();

		announcementForm.attr("action", "/announcement/getList");
		announcementForm.find("input[name='announcementDate']").remove();
		announcementForm.find("input[name='announcemenContent']").remove();
		announcementForm.find("input[name='announcementTitle']").remove();
		announcementForm.submit();
	});
</script>



<%@ include file="../include/footer2.jsp"%>