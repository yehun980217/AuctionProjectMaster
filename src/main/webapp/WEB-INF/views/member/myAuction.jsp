<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"  %>
   
    <section id="section">
		<h1>개인경매내역</h1>
    </section>
   
    <div id="center">
    <h3 style="font-size: 30px; margin-top: 15px;"> - 개인 입찰 / 낙찰 내역입니다. -</h3>
    </div>
    <div id="center">
        <table class="listTable">
            <thead>
                <tr>
            	    <th style="width:65px;">No.</th>
		            <th>상품이름</th>
		            <th>상품이미지</th>
		            <th>입찰시간</th>
		            <th>입찰금액</th>
		            <th>입찰여부</th>   
         		</tr>
      		</thead>
         	<c:forEach items="${myAuctionList}" var="auction" varStatus="status">
            	<tr>
               		<td>${auction.rno}</td>
               		<td>${auction.itemName}</td>
               		<td><img src="${auction.image.viewLoadName}" style="width:75px; height:75px; outline:1px solid #000;"
                        onerror="this.onerror=null; this.src='/img/imgNo.png';"></td>
               		<td><fmt:formatDate value="${auction.userBidTime}" pattern="yyyy-MM-dd hh:mm" /></td>
                	<td><fmt:formatNumber value="${Integer.parseInt(auction.userBidPrice)}" pattern="#,###" /> &#8361; </td> 
               		<c:if test="${'낙찰' eq auction.userBidYn}">
               			<td style="color:red">${auction.userBidYn}</td>
               		</c:if>
               		<c:if test="${'응찰' eq auction.userBidYn}">
               			<td>${auction.userBidYn}</td>
               		</c:if>
            	</tr>            
         	</c:forEach>
   	    </table>
   </div>
   <br><br>
   <div class="pageWrap">
		<ul class="listPagination">
			<c:if test="${pageDTO.preView}">
				<li class="page-item"><a class="page-link"
					href="?pageNo=${pageDTO.startPage-1}">이전으로</a></li>
			</c:if>
			<c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}"
				var="pageNo">
				<li class="page-item"><a class="page-link"
					href="${pageNo}">${pageNo}</a></li>
			</c:forEach>
		
			<c:if test="${pageMaker.next}">
				<li class="page-item"><a class="page-link"
					href="${pageMaker.endPage+1}">다음으로</a></li>
			</c:if>
		</ul>
  </div>
  
  
  <form id="auctionForm" action="/member/myAuction" method="get" >
      <input type="hidden" name="pageNo" value="${pageDTO.pi.pageNo}">
      <input type="hidden" name="amount" value="${pageDTO.pi.amount}">
  </form>   
  
  <script type="text/javascript">
	  $(".page-link").on("click", function(e){
	      
		  let auctionForm = $("#auctionForm") ;
		  
	      e.preventDefault();
	      
	      var targetPage = $(this).attr("href");
	       
	      auctionForm.find("input[name='pageNo']").val(targetPage) ;
	      auctionForm.submit();
	   });
  	
  </script>
   
<%@ include file="../include/footer2.jsp"  %>


















































