<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"  %>
		<section id="section">
			<h1>자주묻는질문</h1>
		</section>
		
		<div id="center">
			   <form name="byTypeQa" id="byTypeQa" action="/qa/getListByType" method="get" >
			      <button type="button" class="qaInfoAll">전체</button>
			      <button type="button" class="qaInfoBtn">회원정보</button>
			      <button type=button class="qaPayBtn">입금/결제관련</button>
			      <button type=button class="qaAuctionBtn">경매관련</button>
			      <button type=button class="qaEtcBtn">기타관련</button>   
			   </form>   
	    </div>
	   
	    <div id="center">
	  	 <ul class="qna">
		      <c:forEach items="${list}" var="qa" varStatus="status">
		          <li style="margin-top: 50px">
		            <input type="checkbox" id="qa_${status.count}">
		            
		            <label for="qa_${status.count}">${qa.qaTitle}</label>
		            
		            <div id="qaContent" >
		                  <p>${qa.qaContent}</p>
		                  <c:if test="${sessionScope.user != null && sessionScope.user.userRole gt 7}">
		                      <button style="height:40px;"type="button" id="button" onclick="location.href='/qa/modify?qaNumber=${qa.qaNumber}'">수정/삭제</button>
		                  </c:if>                
		                  
		               </div>
		          </li>       
		      </c:forEach>
		   </ul>            
	
	   <br>
	   <br>
	   <br>
	   </div>
	   <div id="center"> 
	   <c:if test="${sessionScope.user != null && sessionScope.user.userRole gt 7}">
	      <button type="button" class="faqbtn"><a href="/qa/register">QA등록하기</a></button>
	   </c:if>
	   </div>
	   <div id="myModal" class="myModal" >
	          <div class="modal-body">
	           <p>Modal body text goes here.</p>
	         </div>
	         <div class="modal-footer">
	              <button id="close-modal"  class="close-modal">닫기</button>
	         </div>
	   </div>                     
	
	   
	   
	    <script type="text/javascript">
	          
	      $(document).ready(function(){
	         let result = '<c:out value="${result}"/>' ;
	         checkModal(result);
	         
	         history.replaceState({}, null, null);
	         
	         function checkModal(result){
	            const myModal = document.getElementById("myModal");   
	            
	            if(result === '' || history.state){
	               return ;
	            }
	            
	            if(result == 'regSuccess'){
	               $(".modal-body").html("정상적으로 등록되었습니다.") ;
	            }else if(result == 'modSuccess'){
	               $(".modal-body").html("정상적으로 수정되었습니다.") ;
	            }else if(result == 'delSuccess'){
	               $(".modal-body").html("정상적으로 삭제되었습니다.") ;
	            }
	            
	            myModal.style.display = "block";
	            document.body.style.overflow = "hidden";
	
	         }
	         
	         
	         $(".close-modal").on("click", function(e){
	             const myModal = document.getElementById("myModal");    
	             myModal.style.display = "none";
	             document.body.style.overflow = "auto";
	         });
	         
	      
	         $(".qaInfoBtn").on("click", function(e){
	             var byTypeQa = $("#byTypeQa");
	               byTypeQa.append("<input type='hidden' name='qaType' value='info'>");
	               byTypeQa.submit();
	         });
	   
	         $(".qaPayBtn").on("click", function(e){
	             var byTypeQa = $("#byTypeQa");
	               byTypeQa.append("<input type='hidden' name='qaType' value='pay'>");
	               byTypeQa.submit();
	         });
	         
	         $(".qaAuctionBtn").on("click", function(e){
	             var byTypeQa = $("#byTypeQa");
	               byTypeQa.append("<input type='hidden' name='qaType' value='auction'>");
	               byTypeQa.submit();
	         });
	         
	         $(".qaEtcBtn").on("click", function(e){
	             var byTypeQa = $("#byTypeQa");
	               byTypeQa.append("<input type='hidden' name='qaType' value='etc'>");
	               byTypeQa.submit();
	         });
	         
	         $(".qaInfoAll").on("click", function(e){
	             var byTypeQa = $("#byTypeQa");
	             byTypeQa.attr("action", "/qa/getList").submit() ;
	         });
	         
	      });
	   
	   </script>
	   
    <%@ include file="../include/footer2.jsp"  %>