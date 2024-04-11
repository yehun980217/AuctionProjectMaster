<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"  %>
	<section id="section">
   		<h1>질문등록</h1>	
	</section>
	<section id="section">
	<form name="qaForm" id="qaForm"  action="/qa/register" method="post">
		<table >
			<tr>
				<th>
					<label for="qaType" >카테고리</label>
				
					<select style="cursor:pointer;" id="qaType" name="qaType" >
						<option value="">선택하세요</option>
						<option value="info">회원정보관련</option>
						<option value="auction">경매관련</option>
						<option value="pay">결제및입금관련</option>
						<option value="etc">기타</option>
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
	  		 				name="qaTitle" required >
	 			</th>
			</tr>
			<tr>
				<td colspan="2">
					<textarea class="qaContent" name="qaContent"
							id="qaContent" rows="15" cols="75" required></textarea>
	 			</td>
			</tr>
		</table>	
		
		<div id="center">
		<button type="button" id="button" style="height:43.2px;"class="btn btn-default regBtn">등록하기</button>
           </div>
           <div id="center">
		<button type="button" class="btn btn-default itemlistBtn">
			<a href="/qa/getList">리스트로 이동</a>
		</button>
		</div>
           
	</form>
	</section>
	
	<script type="text/javascript">
		
		$(".regBtn").click(function(e){
			var qaForm = $("#qaForm");
			e.preventDefault();
			
			if($("#qaType").val()=="" || $("#qaType").val()==null){
				alert("종류를 선택해주세요");
				return;
			}	
			
			qaForm.submit();
		});
			
	</script> 
	
	
 
	<%@ include file="../include/footer2.jsp"  %>



