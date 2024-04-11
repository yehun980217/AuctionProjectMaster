<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>
<section id="section">
   <h1 letter-spacing: 10px;">진행중인경매</h1>
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
               <form name="searchForm" id="searchForm" action="/trade/getListIng" method="get">
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
      </div>
   </div>
<section id="section">
<form method="get" action="trade/getListIng" name="tradeGetForm" id="tradeGetForm">
   
   <c:if test="${tradeList.size() ne 0}">
       <c:forEach var="trade" items="${tradeList}" varStatus="status">
           <div class="tradeInfo" id="tradeInfo" style="width: 400px; height: 500px;">
               <p>상품번호 : ${trade.tradeNumber}</p>
               <div class="tradeImage">
                  <a class="move" href="${trade.tradeNumber}"> 
                  	<img src="${trade.item.imageList.get(0).viewLoadName}" style="width: 150px; height: 175px; border-raidus: 3px; outline:2px solid #000;">
                  </a>
            </div>
            <!--  <p><a class="move" href="${trade.tradeNumber}">${trade.item.itemName}</a></p> -->

            <div class="tradeDetail">

               <p>상품이름 : ${trade.item.itemName}</p>
               <p>시작시간 : ${trade.tradeStart}</p>
               <input type="hidden" name="tradeStart" id="tradeStart" class="starttime" value="${trade.tradeStart}">
               <p>종료시간 : ${trade.tradeEnd}</p>
               <input type="hidden" name="tradeEnd" id="tradeEnd"
                  value="${trade.tradeEnd}">
               <div class="date_dDay">
                  <div class="date_dDay${status.index}">
                     <input type="hidden" value="${trade.tradeEnd}" class="deadtime" name="deadtime" />
                     <p>
                        남은시간 : <span class="day"></span> 
			                     <span class="time"></span> 
			                     <span class="min"></span> 
			                     <span class="sec"></span>
                     </p>
                  </div>
             
             
                  <p>
                     시작가 :
                     <fmt:formatNumber value="${trade.tradeMinPrice}" pattern="#,###" /> &#8361;
                  </p>

               </div>
          
          
               <p style="color: red">
                  현재가 :
                  <fmt:formatNumber value="${trade.tradeBuyNowPrice}" pattern="#,###" /> &#8361;
               </p>
          
          
               <p>
                  즉구가 :
                  <fmt:formatNumber value="${trade.tradeFinalPrice}" pattern="#,###" /> &#8361;
               </p>
            
                  <a style="font-size: 30px; color: coral;" class="move" href="${trade.tradeNumber}">경매참여하러가기</a>
               </p>

            </div>
         </div>
         <input type="hidden" name="tradeNumber" value="${trade.tradeNumber}">
         <input type="hidden" name="itemNumber" value="${trade.itemNumber}">
      
       </c:forEach>
   
   </c:if>
   

   </form>
      
   
</section>

<ul id="itemListPagination" class="pagination">
   <c:if test="${pageDTO.preView}">
      <li class="page-item"><a class="page-link" href="${pageDTO.startPage-1}">이전으로</a></li>
   </c:if>
   <c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="pageNo">
      <li class="page-item"><a class="page-link" href="${pageNo}">${pageNo}</a> </li>
   </c:forEach>

   <c:if test="${pageMaker.next}">
      <li class="page-item"><a class="page-link"
         href="${pageMaker.endPage+1}">다음으로</a></li>
   </c:if>
</ul>



<!-- 페이지 번호를 클릭하면 form 태그를 submit시킨다. -->
<form id="tradeForm" action="/trade/get" method="get">
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
    
    
    $(document).ready(function () {
      let deadtimeValues = [];
      let deadtimeElements = document.querySelectorAll('.deadtime');
      deadtimeElements.forEach(function(element, index) {
         deadtimeValues.push(element.value);
      });
      
      let starttimeValues = [];
      let starttimeElements = document.querySelectorAll('.starttime');
      starttimeElements.forEach(function(element, index) {
         starttimeValues.push(element.value);
      });
      
      for(var i=0; i<deadtimeValues.length; i++){
         countDeadLine(deadtimeValues[i], starttimeValues[i], i);
      }
      
    })

    
    
   function countDeadLine(deadtime, starttime, index) {
      let countDownDate = new Date(deadtime + ":00").getTime();
      let startTimeDate = new Date(starttime + ":00").getTime();
      
      console.log(startTimeDate);
      
      let x = setInterval(function () {
         let now = new Date().getTime();

         let distance = countDownDate - now;

         let days = Math.floor(distance / (1000 * 60 * 60 * 24));
         let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
         let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
         let seconds = Math.floor((distance % (1000 * 60)) / 1000);
         let date_dDay = document.querySelector('.date_dDay' + index);
                  
         if(startTimeDate > now){
        	 date_dDay.querySelector('.day').innerText = "경매가 시작되기 전입니다.";
		     return;
         }
              
        
             date_dDay.querySelector('.day').innerText = days + "일 ";
             date_dDay.querySelector('.time').innerText = hours + "시간 ";
             date_dDay.querySelector('.min').innerText = minutes + "분 ";
             date_dDay.querySelector('.sec').innerText = seconds + "초 ";

         if (distance < 0) {
            clearInterval(x);
            date_dDay.innerText = "경매가 종료되었습니다.";
            
            let tradeGetForm = $("#tradeGetForm") ;
            tradeGetForm.attr("action", "/trade/endTrade");
            tradeGetForm.attr("method", "get");
            tradeGetForm.submit();
         }
      }, 1000);
    }
       
       
       
    /*    
       function dayCount() {
         var tradeitems = document.querySelectorAll("#tradeInfo");
          
         for (var i = 0; i < tradeitems.length; i++) {   
                var eYear = $(tradeitems[i]).children("#tradeEnd").val().substr(0, 4);
                   var eMonth = $(tradeitems[i]).children("#tradeEnd").val().substr(5, 2);
                   var eDay = $(tradeitems[i]).children("#tradeEnd").val().substr(8, 2);
                   var eHour = $(tradeitems[i]).children("#tradeEnd").val().substr(11, 2);
                   var eMinute = $(tradeitems[i]).children("#tradeEnd").val().substr(14, 2);
                
                 var remainDate = $(tradeitems[i]).find("#value_day"); 
                 var remainHour = $(tradeitems[i]).find("#value_hour"); 
                 var remainMinute = $(tradeitems[i]).find("#value_min"); 
                 var remainSecond = $(tradeitems[i]).find("#value_sec"); 
                       
                 var today = new Date();
                 
                   var dday  = new Date(parseInt(eYear), parseInt(eMonth)-1, 
                           parseInt(eDay), parseInt(eHour), parseInt(eMinute), 00);
   
   
                   var timeGap = dday.getTime() - today.getTime();
   
                  
                   // 남은 일수 카운트
                   var remainTime = Math.ceil(timeGap / (1000 * 60 * 60 * 24));
                   
                   // 남은 시간 카운트
                   var seconds = String(Math.floor(timeGap / 1000) % 60).padStart(2,'0'); // 초 단위 변환
                   var minutes = String(Math.floor(timeGap / (1000 * 60)) % 60).padStart(2,'0'); // 분 단위 변환
                   var hours = String(Math.floor(timeGap / (1000 * 60 * 60)) % 24).padStart(2,'0'); // 시 단위 변환
   
                   if (timeGap <= 0) {
                      clearInterval(countdownInterval);
                   }
                  
                  remainDate.innerText = remainTime;
                  remainHour.innerText = hours;
                  remainMinute.innerText = minutes;
                  remainSecond.innerText = seconds;
         }   
                
      } */
       
       
      
        
      $(document).ready(function(){
         let result = '<c:out value="${result}"/>' ;
         checkModal(result);
         
        // history.replaceState({}, null, null);
         
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
         
   
         var tradeForm = $('#tradeForm');
           
         
         $(".page-link").on("click", function(e){
             e.preventDefault();
              
             var targetPage = $(this).attr("href");
             tradeForm.attr("action", "/trade/getListIng");
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
          
         
          //삭제보내기
         $(".delBtn").on("click", function(e){
            e.preventDefault();
           
            var tradeNumber = $(this).attr("value");
             
            $("#tradeNumber").val(tradeNumber);
            tradeForm.attr("action", "/trade/remove");
            tradeForm.attr("method", "POST");
            tradeForm.submit();
         });     

          

          
      });
      


   </script>




<%@ include file="../include/footer2.jsp"%>