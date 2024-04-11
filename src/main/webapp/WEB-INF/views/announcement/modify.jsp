<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"  %>
	<section id="section">
		<h1> ${announcement.announcementTitle} </h1>
	</section>
	<section id="section">
	<form name="announcementForm" id="announcementForm"  
							action="/announcement/getList" method="post">
		<table>
			<tr>
				<th>
					<label for="announcementNumber">번호</label>
					<label style="margin-left:100px;"for="announcementUp">[최상위로올리기]</label>
					<input type="checkbox" name="announcementUp" 
					id="announcementUp" value='0' ${announcement.announcementUp==0?"":"checked"} />
				</th>
	 										
				<th>
					<label for="announcementDate">공지일</label>
				</th>
			</tr>
			
			<tr>
				<td>
					<input type="text" class="form-control" id="announcementNumber" 
	  		 				name="announcementNumber" value="${announcement.announcementNumber}" readonly>
	  		 	</td>
	 			
				<td>
					<input type="text" class="form-control" id="announcementDate" 
	  		 				value="<fmt:formatDate value="${announcement.announcementDate}" pattern="yyyy-MM-dd" />"readonly>
				</td>
			</tr>
			
			<tr>
				<th colspan="3">
					<label for="announcementTitle">공지제목</label>
				</th>	
			</tr>
			
			<tr>
				<td colspan="3">
					<input type="text" class="form-control" id="announcementTitle" 
	  		 				name="announcementTitle" value="${announcement.announcementTitle}" required >
	 			</td>
			</tr>
			<tr>
				<td colspan="3">
					<textarea class="announcementContent" name="announcementContent"
							id="announcementContent" rows="15" cols="75" required >${announcement.announcementContent}</textarea>
	 			</td>
			</tr>
		</table>	
		
		<input type="hidden" name="pageNo" value="${PageInfo.pageNo}">
	    <input type="hidden" name="amount" value="${PageInfo.amount}">
	    <input type="hidden" name="type" value="${PageInfo.type}">
	    <input type="hidden" name="keyword" value="${PageInfo.keyword}">
		<div id="center">
		<button type="button" class="btn btn-default modBtn">수정하기</button>
        <button type="button" class="btn btn-default delBtn">삭제하기</button>
           
		<button type="button" class="btn btn-default itemlistBtn">
			리스트로 이동
		</button>
		</div>
           
	</form>
	</section>
	
	<script type="text/javascript">
		
		$(".modBtn").click(function(e){
			var announcementForm = $("#announcementForm");
			e.preventDefault();

			announcementForm.attr("action", "/announcement/modify") ;
			announcementForm.attr("method", "post");
			
			if($(announcementUp).is(":checked")) {
	        	$("#announcementUp").val(1);
	        } else {
            	$("#announcementUp").val(0);
            }
			
			
			announcementForm.submit();
		});
		
		$(".delBtn").click(function(e){
			var announcementForm = $("#announcementForm");
		
			e.preventDefault();
			announcementForm.attr("action", "/announcement/remove") ;
			announcementForm.find("input[name='announcementDate']").remove();
			announcementForm.find("input[name='announcemenContent']").remove();
			announcementForm.find("input[name='announcementTitle']").remove();
			if(confirm("삭제하시겠습니까?")){
				announcementForm.submit();
			}
			
		});
			
		$(".itemlistBtn").click(function(e){
			var announcementForm = $("#announcementForm");
		
			e.preventDefault();
			announcementForm.attr("action", "/announcement/getList") ;
			announcementForm.attr("method", "get");

			if(confirm("리스트로 이동하시겠습니까?")){
				announcementForm.submit();
			}
			
			
		});	
				
							
	</script> 



<%@ include file="../include/footer2.jsp"  %>




</body>
</html>