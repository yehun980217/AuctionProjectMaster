<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"  %>

	<form name="itemForm" id="itemForm" action="/item/getList" method="get">
		<table>
			<tr>
				<th>
					<label for="itemNumber">번호</label>
	 			</th>
	 			<th>
					<label for="itemName">상품명</label>
				</th>
			</tr>
			
			<tr>
				<th>
					<input type="text" class="form-control" id="itemNumber" 
	  		 				name="itemNumber" value="${item.itemNumber}" readonly>
	 			</th>
	 			<th>
	 				<input type="text" class="form-control" id="itemName" 
	  		 				name="itemName" value="${item.itemName}" readonly>
	 			</th>
			</tr>
	
			<tr>
				<td colspan="2">
					<textarea class="itemContent" 
							id="itemContent" rows="15" cols="75" readonly>${item.itemContent}</textarea>
	 			</td>
			</tr>
				
			<tr>
		
			<c:choose>
			    <c:when test="${images.size()!=0}">
			   		<c:forEach var="image" items="${images}" >
			   			<td>
			   				<img src="${image.viewLoadName}">
			   	   		</td>
			   	   	</c:forEach>
			    </c:when>
				    
				    <c:otherwise>
						<td>첨부파일 없음</td>
				    </c:otherwise>
			</c:choose> 
			</tr>	
		</table>	
		
		<input type="hidden" name="pageNo" value="${PageInfo.pageNo}">
	    <input type="hidden" name="amount" value="${PageInfo.amount}">
	    <input type="hidden" name="type" value="${PageInfo.type}">
	    <input type="hidden" name="keyword" value="${PageInfo.keyword}">
		
		<button type="button" class="btn btn-default modBtn"> 
           	수정/삭제
        </button>
        <button type="button" class="btn btn-default listBtn">
			리스트로 이동
		</button>
		
		
	</form>
	
	
	<script type="text/javascript">
		
			
		$(".modBtn").click(function(e){
			e.preventDefault();

			var itemForm = $("#itemForm");
	
			itemForm.attr("action", "/item/modify") ;
			itemForm.find("input[name='itemContent']").remove();
			itemForm.find("input[name='itemName']").remove();				
			itemForm.submit(); 
		});
		
		$(".listBtn").click(function(e){
			e.preventDefault();    
			var itemForm = $("#itemForm");
			itemForm.attr("action", "/item/getList") ;
			itemForm.find("input[name='itemContent']").remove();
			itemForm.find("input[name='itemName']").remove();				
			itemForm.submit(); 
		});
									
							
	</script> 
	
	
 
<%@ include file="../include/footer2.jsp"  %>
