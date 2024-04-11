<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>
<section id="section">
   <h1 style="font-family: 'MBC1961GulimM'; letter-spacing: 10px;">이전경매내역</h1>
</section>
<div id="itemButton" class="wrap">
   <c:if
      test="${sessionScope.user != null && sessionScope.user.userRole gt 7}">
      <button type="button">
         <a href="/item/getListHaving?itemHave=1">판매가능상품 확인</a>
      </button>
   </c:if>
</div>
      <div id="center">
            <div id="justify" style="width:1500px;">
                  <div></div>
                  <div>
                  <form name="searchForm" id="searchForm" action="/trade/getListEnd"
                     method="get">
                     <select id="type" name="type">
                        <option value="" ${pageDTO.pi.type==null?"selected":""}>선택하세요</option>
                        <option value="N" ${pageDTO.pi.type eq 'N'?"selected":""}>제목</option>
                        <option value="C" ${pageDTO.pi.type eq 'C' ?"selected":""}>내용</option>
                        <option value="A" ${pageDTO.pi.type eq 'A'?"selected":""}>제목or내용</option>
                     </select> <input type="text" name="keyword" id="keyword"
                        value="${pageDTO.pi.keyword}"> <input type="hidden"
                        name="pageNum" value="1"> <input type="hidden" name="amount"
                        value="${pageDTO.pi.amount}">
                     <button id="searchInput" style="width: 150px; padding:0 30px;" type="submit">검색</button>
                  </form>
                  </div>
            </div><!-- justify -->
      </div><!-- center -->

<section id="section">
   <form id="tradeGetForm">
      <c:forEach var="trade" items="${tradeList}" varStatus="status">
         <div class="tradeInfo" id="tradeInfo" style="width: 400px; height: 500px;">
            <p style="margin: 0 20px; margin-top: 20px; font-weight: bold;">${trade.rno}</p>
            <div class="tradeImage">
               <a class="move" href="${trade.tradeNumber}"> <img
                  src="${trade.item.imageList.get(0).viewLoadName}"
                  style="width: 150px; height: 175px; border-raidus: 3px; outline:2px solid #000;"></a>
            </div>
            <!--  <p><a class="move" href="${trade.tradeNumber}">${trade.item.itemName}</a></p> -->
            <div class="tradeDetail">
               <p>
                  상품이름 : ${trade.item.itemName}</a>
               </p>
               <p>시작시간 : ${trade.tradeStart}</p>
               <p>종료시간 : ${trade.tradeEnd}</p>
               <p>
                  시작가 :
                  <fmt:formatNumber value="${trade.tradeMinPrice}" pattern="#,###" />
               </p>
               <p style="color:red">
                  최종가 :
                  <fmt:formatNumber value="${trade.tradeBuyNowPrice}"
                     pattern="#,###" />
               </p>
               <p>
                  <a style="font-size:30px; color:coral;" class="move" href="${trade.tradeNumber}">경매내역보기</a>
               </p>
            </div>
         </div>
      </c:forEach>
   </form>
</section>

<ul id="itemListPagination" class="pagination">
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

<!-- 페이지 번호를 클릭하면 form 태그를 submit시킨다. -->
<form id="tradeForm" action="/trade/getListEnd" method="get">
   <input type="hidden" name="pageNo" value="${pageDTO.pi.pageNo}">
   <input type="hidden" name="amount" value="${pageDTO.pi.amount}">
   <input type="hidden" name="type" value="${pageDTO.pi.type}"> 
   <input type="hidden" name="keyword" value="${pageDTO.pi.keyword}">
   <input type="hidden" name="tradeNumber" id="tradeNumber" value="">
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

   var tradeForm = $('#tradeForm');
   
   
   $(".page-link").on("click", function(e){
       e.preventDefault();
        
       var targetPage = $(this).attr("href");
       tradeForm.attr("action", "/trade/getListEnd");
       tradeForm.find("input[name='pageNo']").val(targetPage) ;
       tradeForm.find("input[name='tradeNumber']").remove() ;
       tradeForm.submit();
   });
   
    //get 보내기
   $(".move").on("click", function(e){
      e.preventDefault();
      
      var tradeNumber = $(this).attr("href");
        
                   
      $("#tradeNumber").val(tradeNumber);
      tradeForm.attr("action", "/trade/get");
      tradeForm.submit();
      
   });   


</script>




<%@ include file="../include/footer2.jsp"%>