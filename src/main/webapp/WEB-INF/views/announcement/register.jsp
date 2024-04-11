<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"  %>

<section id="section">
	<h1>공지사항 등록</h1>
</section>
<section id="section">
	<form name="announcementForm" id="announcementForm"  
							action="/announcement/register" method="post">
		<table>
			<tr>
				<th id="justify">
					<label for="announcementTitle">공지제목</label>
					<label style="margin-left:100px;"for="announcementUp">[최상위로올리기]  <input type="checkbox" name="announcementUp" id="announcementUp" value='0' /></label>
				</th>	
			</tr>
			<tr>
				<th>
					<input type="text" class="form-control" id="announcementTitle" 
	  		 				name="announcementTitle" required >
	 			</th>
			</tr>
			<tr>
				<th>
					<label for="announcementContent">공지내용</label>
				</th>
			</tr>
			<tr>
				<td>
					<textarea class="announcementContent" name="announcementContent"
							id="announcementContent" rows="15" cols="75" placeholder="공지사항을 기재해주세요." required="required" style="resize:none;"></textarea>
	 			</td>
			</tr>
		</table>	
		
		<button type="button" class="btn btn-default inputbtn">글 등록하기</button>

           
		<button type="button" class="btn btn-default itemlistBtn">
			<a href="/announcement/getList">리스트로 이동</a>
		</button>
           
	</form>
</section>	
	
	<script type="text/javascript">
		
	
	
		$(".inputbtn").click(function(e){
			var announcementForm = $("#announcementForm");
			e.preventDefault();

			announcementForm.attr("action", "/announcement/register") ;
			announcementForm.attr("method", "post");
			
			if($(announcementUp).is(":checked")) {
	        	$("#announcementUp").val(1);
	        } else {
            	$("#announcementUp").val(0);
            }
			
			
			announcementForm.submit();
		});
			
	
/* 	    var announcementContent = document.getElementById("announcemenTitle");

	    announcementContent.addEventListener("keyup", function (event) {
	    	event.preventDefault();
	    	if (event.keyCode === 13) {
	    		if(confirm("공지사항 등록 하겠습니까?")){
	    			$(".regBtn").click();
	    		}
	    		
	      	} 
	    }); */
	 
	</script> 
	
	
 
	<%@ include file="../include/footer2.jsp"  %>



