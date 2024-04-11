<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"  %>
	<
	
	
	<form name="qaForm" id="qaForm"  action="/qa/modify" method="post">
		<table>
			<tr>
				<th><label for="qaNumber">번호</label></th>
				<th><label for="qaType">종류</label></th>
			</tr>
			
			<tr>
				<th>
					<input type="number" class="form-control" id="qaNumber" 
	  		 				name="qaNumber" value="${qa.qaNumber}" readonly>
	 			</th>
				<th>
					<select id="qaType" name="qaType">
						<option value="info" ${qa.qaType eq 'info' ? "selected":""}>회원정보관련</option>
						<option value="auction" ${qa.qaType eq 'auction' ? "selected":""}>경매관련</option>
						<option value="pay" ${qa.qaType eq 'pay'  ?"selected":""}>결제및입금관련</option>
						<option value="etc" ${qa.qaType eq 'etc' ?"selected":""}>기타</option>
					</select>
	 			</th>
			</tr>
			<tr>
				<th colspan="2">
					<label for="qaTitle">공지제목</label>
				</th>	
			</tr>
			<tr>
				<th colspan="2">
					<input type="text" class="form-control" id="qaTitle" 
	  		 				name="qaTitle" value="${qa.qaTitle}" required >
	 			</th>
			</tr>
			<tr>
				<td colspan="2">
					<textarea class="qaContent" name="qaContent"
							id="qaContent" rows="20" cols="100" required >${qa.qaContent}</textarea>
	 			</td>
			</tr>
		</table>	
		
		
		<input type="hidden" name="type" id="type" value="${type}">
		<button type="button" class="btn btn-default modBtn">수정하기</button>
        <button type="button" class="btn btn-default delBtn">삭제하기</button>
           
		<button type="button" class="btn btn-default listBtn">리스트로 이동	</button>
           
	</form>
	
	
	
	
	
	<script type="text/javascript">
		
		$(".modBtn").click(function(e){
			var qaForm = $("#qaForm");
			e.preventDefault();
			
			qaForm.submit();
			
		});
		
		$(".delBtn").click(function(e){
			var qaForm = $("#qaForm");
		
			e.preventDefault();
			qaForm.attr("action", "/qa/remove") ;

			if(confirm("삭제하시겠습니까?")){
				qaForm.submit();
			}
			
		});
		
		$(".listBtn").click(function(e){
			var qaForm = $("#qaForm");
			var type = $("#type").val() ;
			qaForm.attr("method", "get") ;
			e.preventDefault();
			
			if(type==null||type==""){
				qaForm.attr("action", "/qa/getList").submit() ;
				
			}else {
				qaForm.attr("action", "/qa/getListByType?qaType="+type).submit() ;
			}
			
		});			
	</script> 



<%@ include file="../include/footer2.jsp"  %>




</body>
</html>