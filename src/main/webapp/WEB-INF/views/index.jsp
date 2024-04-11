<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="./include/header2.jsp"%>

<!--banner-->
<section id="banner" style="font-family:'MBC1961GulimM';">
   <div class="wrap" style="text-align:center;">
   
   <h1 style= "font-size:70px; font-family:'MBC1961GulimM'; margin:0 auto; padding: 0 50px;">
   &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp??</br>
   경&nbsp&nbsp&nbsp&nbsp&nbsp매&nbsp&nbsp&nbsp&nbsp&nbsp할&nbsp&nbsp&nbsp&nbsp&nbsp사&nbsp&nbsp&nbsp&nbsp&nbsp람</br>
   경&nbsp&nbsp&nbsp&nbsp&nbsp매&nbsp&nbsp&nbsp&nbsp&nbsp할&nbsp&nbsp&nbsp&nbsp&nbsp사&nbsp&nbsp&nbsp&nbsp&nbsp람</br>
   경&nbsp&nbsp&nbsp&nbsp&nbsp매&nbsp&nbsp&nbsp&nbsp&nbsp할&nbsp&nbsp&nbsp&nbsp&nbsp사&nbsp&nbsp&nbsp&nbsp&nbsp람</br>
   </br>
   </h1>

      <h2 style="text-align:center; letter-spacing:3px;">하기찌렁이와 함께 경매를 경험해보세요!!</h2>

      <div class="btn" style="display:flex; justify-content:center; align-items:center;">
         <a href="/trade/getListIng">경매참여</a><a href="/question/register">문의하기</a>
      </div>
      <!--btn END-->

   </div>
   <!--wrap END-->


<!--work-->
<section id="work">
   <div class="wrap">
   
        <div class="box">
        <b><a href="/announcement/getList"><img src="/img/notice.png" style="width:125px; height:125px;" alt="">
         <p>공지사항</p>
         <h3>Notice</h3>
         </a></b>
      </div>
      <div class="box">
        <b> <a href="/trade/getListIng"><img src="/img/active.png" style="width:125px; height:125px;" alt="">
         <p>진행경매</p>
         <h3>Current Auction</h3>
         </a></b>
      </div>
      <div class="box">
        <b> <a href="/trade/getListEnd"><img src="/img/past.png" style="width:125px; height:125px;" alt="">
         <p>이전경매</p>
           <h3>Previous Auction</h3>
           </a></b>
      </div>
      <div class="box">
        <b> <a href="/qa/getList"><img src="/img/qna.png" style="width:125px; height:125px;" alt="">
         <p>참여방법</p>
         <h3>How to Auction?</h3>
         </a></b>
      </div>
   </div>
   <!--wrap END-->
</section>

<section id="work">

       <div id="center">
          <h1 style="letter-spacing : 10px; margin-bottom:32px;">신규 경매 상품</h1>
      </div>
      <div id="center">
         <c:forEach items="${tradeList}" var="trade">
               <div class="box" style="width:400px; margin: 0 18px 100px 18px; font-weight:100" >
                  <a  class="move" href="${trade.tradeNumber}">
                     <img src="${trade.item.imageList.get(0).viewLoadName}" style="width:210px; height:240px;" alt="">
                     </a>
                    <h3>작품명 : ${trade.item.itemName}</h3>
                    <h3>종료시간 <br> ${trade.tradeEnd}</h3>
                    <c:if test="${trade.tradeIng eq 'N'}">
                    	<h3>종료된 경매입니다.</h3>
                    </c:if>
                 </div>
                 
         </c:forEach>
        </div>   
        <form id="tradeForm" action="trade/get" method="get" >
        	<input type="hidden" name="tradeNumber" id="tradeNumber" value="">
        </form> 

   <!--wrap END-->
</section>
</section>

<script type="text/javascript">
   $(".move").on("click", function(e){
       e.preventDefault();
       var tradeNumber = $(this).attr("href");
       $("#tradeNumber").val(tradeNumber);
       $("#tradeForm").submit();
    
   
   });   
</script>


<%@ include file="./include/footer2.jsp"%>