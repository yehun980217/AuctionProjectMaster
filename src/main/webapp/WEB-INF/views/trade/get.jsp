<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@ include file="../include/header2.jsp"  %>
    <script type="text/javascript">
       
       $(document).ready(function () {
    	   
    	 $('.wrap-loading').hide();  
    	   
    	   
         let tradeEndValues = [];
         let tradeEndElements = document.querySelectorAll('.tradeEnd');
         tradeEndElements.forEach(function(element, index) {
            tradeEndValues.push(element.value);
         });
         
         let tradeStartValues = [];
         let tradeStartElements = document.querySelectorAll('.tradeStart');
         tradeStartElements.forEach(function(element, index) {
            tradeStartValues.push(element.value);
         });
         

         for(var i=0; i<tradeEndValues.length; i++){
            countDeadLine(tradeEndValues[i], tradeStartValues[i], i);
         }
                  

          //삭제보내기
          $("#delBtn").on("click", function(e){
             e.preventDefault();
             if($("#userPrice").val()>0){
                alert("입찰내역이 있는 상품은 삭제할 수 없습니다");
                return;
             }
             
            let tradeForm = $("#tradeForm");
              
              tradeForm.attr("action", "/trade/remove");
              tradeForm.attr("method", "POST");
              if(confirm("삭제하시겠습니까?"))
              tradeForm.submit(); 
            
          });   
          
          //리스트로 가기
          $("#listBtn").on("click", function(e){
             e.preventDefault();
      
             let tradeForm = $("#tradeForm");
              
             if($("#tradeIng").val()=='N'){
                tradeForm.attr("action", "/trade/getListEnd");
             } else {
                tradeForm.attr("action", "/trade/getListIng");
             }

             tradeForm.attr("method", "get");
             tradeForm.submit(); 
            
          });   

              
        });   
         
          

    
      function countDeadLine(timeEnd, timeStart, index) {
         let countDownDate = new Date(timeEnd + ":00").getTime();
         let timeStartDate = new Date(timeStart + ":00").getTime();
         
         let tradeIng = $("#tradeIng").val() ;
      
          let x = setInterval(function () {
             let now = new Date().getTime();
              let distance = countDownDate - now;
 
            let days = Math.floor(distance / (1000 * 60 * 60 * 24));
            let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            let seconds = Math.floor((distance % (1000 * 60)) / 1000);
            let date_dDay = document.querySelector('.date_dDay');

             if (timeStartDate > now) {
               date_dDay.querySelector('.day').innerText = "경매가 시작되기 전입니다..";
               date_dDay.style.color = "red";
               return;
            }
            
            date_dDay.style.color = "black";
            date_dDay.querySelector('.day').innerText = days + "일 ";
            date_dDay.querySelector('.time').innerText = hours + "시간 ";
            date_dDay.querySelector('.min').innerText = minutes + "분 ";
            date_dDay.querySelector('.sec').innerText = seconds + "초 ";

            fnGetPresentPrice();
            fnGetBidsList();
            
            if (distance < 0) {
               clearInterval(x);
               date_dDay.innerText = "경매가 종료되었습니다.";
               date_dDay.style.color = "red";
            }
             
            if(tradeIng=='N'){
                clearInterval(x);
                date_dDay.innerText = "경매가 종료되었습니다.";
                date_dDay.style.color = "red";
            }
             
          }, 1000);
       }
               

        function fnPriceUp1() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue + 10000;
            let maxValue = parseInt($("#tradeFinalPrice").val().replace(/,/g, ''));
            
            let showValue = formatNumberWithCommas(newValue);
            let showMaxValue = formatNumberWithCommas(maxValue);
           
            if (newValue > maxValue) {
                $(".userPrice").val(showMaxValue);
                return;
            }
            
            $(".userPrice").val(showValue);
        }

        function fnPriceDown1() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue - 10000;
            let showValue = formatNumberWithCommas(newValue);
            if (newValue < 0) {
                $(".userPrice").val(0);
                return;
            }
            $(".userPrice").val(showValue);
        }

        function fnPriceUp3() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue + 30000;
            let maxValue = parseInt($("#tradeFinalPrice").val().replace(/,/g, ''));
            
            let showValue = formatNumberWithCommas(newValue);
            let showMaxValue = formatNumberWithCommas(maxValue);
           
            if (newValue > maxValue) {
                $(".userPrice").val(showMaxValue);
                return;
            }
            
            $(".userPrice").val(showValue);
        }

        function fnPriceDown3() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue - 30000;
            let showValue = formatNumberWithCommas(newValue);
            if (newValue < 0) {
                $(".userPrice").val(0);
                return;
            }
            $(".userPrice").val(showValue);
        }
        
        function fnPriceUp5() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue + 50000;
            let maxValue = parseInt($("#tradeFinalPrice").val().replace(/,/g, ''));
            
            let showValue = formatNumberWithCommas(newValue);
            let showMaxValue = formatNumberWithCommas(maxValue);
           
            if (newValue > maxValue) {
                $(".userPrice").val(showMaxValue);
                return;
            }
            
            $(".userPrice").val(showValue);
        }

        function fnPriceDown5() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue - 50000;
            let showValue = formatNumberWithCommas(newValue);
            if (newValue < 0) {
                $(".userPrice").val(0);
                return;
            }
            $(".userPrice").val(showValue);
        }
        
        function fnPriceUp10() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue + 100000;
            let maxValue = parseInt($("#tradeFinalPrice").val().replace(/,/g, ''));
            
            let showValue = formatNumberWithCommas(newValue);
            let showMaxValue = formatNumberWithCommas(maxValue);
           
            if (newValue > maxValue) {
                $(".userPrice").val(showMaxValue);
                return;
            }
            
            $(".userPrice").val(showValue);
        }

        function fnPriceDown10() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue - 100000;
            let showValue = formatNumberWithCommas(newValue);
            if (newValue < 0) {
                $(".userPrice").val(0);
                return;
            }
            $(".userPrice").val(showValue);
        }
        

        function fnPriceUp50() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue + 500000;
            let maxValue = parseInt($("#tradeFinalPrice").val().replace(/,/g, ''));
            
            let showValue = formatNumberWithCommas(newValue);
            let showMaxValue = formatNumberWithCommas(maxValue);
           
            if (newValue > maxValue) {
                $(".userPrice").val(showMaxValue);
                return;
            }
            
            $(".userPrice").val(showValue);
        }

        function fnPriceDown50() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue - 500000;
            let showValue = formatNumberWithCommas(newValue);
            if (newValue < 0) {
                $(".userPrice").val(0);
                return;
            }
            $(".userPrice").val(showValue);
        }
        
        function fnPriceUp100() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue + 1000000;
            let maxValue = parseInt($("#tradeFinalPrice").val().replace(/,/g, ''));
            
            let showValue = formatNumberWithCommas(newValue);
            let showMaxValue = formatNumberWithCommas(maxValue);
           
            if (newValue > maxValue) {
                $(".userPrice").val(showMaxValue);
                return;
            }
            
            $(".userPrice").val(showValue);
        }

        function fnPriceDown100() {
            let currentValue = parseInt($(".userPrice").val().replace(/,/g, ''));
            let newValue = currentValue - 1000000;
            let showValue = formatNumberWithCommas(newValue);
            if (newValue < 0) {
                $(".userPrice").val(0);
                return;
            }
            $(".userPrice").val(showValue);
        }
        

        
        function formatNumberWithCommas(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        
        function dateFormat(date) {
            let month = date.getMonth() + 1;
            let day = date.getDate();
            let hour = date.getHours();
            let minute = date.getMinutes();


            month = month >= 10 ? month : '0' + month;
            day = day >= 10 ? day : '0' + day;
            hour = hour >= 10 ? hour : '0' + hour;
            minute = minute >= 10 ? minute : '0' + minute;

            return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute ;
        }
        

        function fnAuction(){
         
            if($("#tradeIng").val()=="N"){
            	alert("종료된 경매입니다.");
            	return ;
         	}
         
         
	        if($("#userNum").val()==""){
	           alert("비회원은 입찰 불가합니다. 회원가입 해주세요!");
	           return ;
	        }
	        
	        let userRole = parseInt($("#userRole").val());
                  
            if(userRole < 1){
            	alert("준회원은 입찰 불가합니다. 이메일을 인증해주세요!");
            	return ;
         	}         
         

            let tradeEnd = new Date($("#tradeEnd").val() + ":00").getTime();
            let tradeStart = new Date($("#tradeStart").val() + ":00").getTime();
         
            let nowDate = new Date().getTime();

                  
            if(nowDate < tradeStart){
               alert("경매 시작 전입니다.");
               return ;
            } 
         
	        if(nowDate > tradeEnd){
	           alert("지난 경매는 참여하실 수 없습니다.");
	           return ;
	        }
         
	        let userPrice = parseInt($("#userPrice").val().replace(/,/g, ''));
	        let tradeOldPrice = parseInt($("#tradeOldPrice").val().replace(/,/g, ''));
	        let tradeMinPrice = parseInt($("#tradeMinPrice").val().replace(/,/g, ''));
	        let tradeFinalPrice = parseInt($("#tradeFinalPrice").val().replace(/,/g, ''));
	        let userCash = parseInt($("#userCash").val().replace(/,/g, ''));
	        
	        if(userPrice > userCash){
	           alert("보유금보다 높게 입찰할 수 없습니다.");
	           return ;
	        }
         
	        if(userPrice < tradeMinPrice){
	           alert("최소금액 이하로는 입찰 불가합니다.");
	           return ;
	        }
	        
	        if(userPrice <= tradeOldPrice){
	           alert("현재금액보다 높은 금액으로 입찰하여 주십시오.");
	           return ;
	        }
	        
	        if(userPrice > tradeFinalPrice){
	           alert("즉시 구매가보다 높게 입찰하실 수 없습니다.");
	           return ;
	        }
	
	        if(userPrice != tradeFinalPrice && $("#userNum").val() == $("#tradeOldUserNum").val()){
	           alert("현재 최고가가 본인으로 입찰할 수 없습니다.");
	           return;
	        }
	        
	         
	        let tradeForm = $("#tradeForm");
	        let tradeBuyNowPrice = $("#userPrice").val().replace(/,/g, '');
	        tradeForm.append("<input type='hidden' name='tradeBuyNowPrice' value='"+tradeBuyNowPrice+"'>");
	        
	        $('.wrap-loading').show();
	        tradeForm.submit();
	                 
		         
	         
	      }
       
         function fnGetPresentPrice(){
         	var tradeNumber = $("#tradeNumber").val();

        	$.ajax({
            	url: '/trade/getPresentPrice',
            	type: 'post',
            	data: {
               		'tradeNumber' : tradeNumber
            	},
	            success:function (data){
	               let price = $.parseJSON(data).data;
	               $('.nowPrice').html("현재가 : " + formatNumberWithCommas(price) +" &#8361;");
	               $('input[name=userPrice]').attr('value', formatNumberWithCommas(price));
	            },
	            error: function (e){
	               alert("관리자에게 문의1");
	            }
	         })
      	}
		
	 
       
	      function fnGetBidsList(){
	         var tradeNumber = $("#tradeNumber").val();
			 
	         
	         $.ajax({
	            url: '/trade/getBidsList',
	            type: 'post',
	            data: {
	               'tradeNumber' : tradeNumber
	            },
	            
	            
	            success:function (data){
	            	
	            	$("#tradeOldUserNum").val($(data).get(0).userNum);
	            	$('#userBidTableBody').empty();
	            	let index = 1 ;
	            	
	            	$(data).each(function(){
	             		
	             		let bidDate = new Date(this.userBidTime);
	
	             		if(index == 1){
	                 		$('#userBidTableBody').append("<tr><td style='font-weight:700; color:red;'>" + index + "</td>" +
															"<td style='font-weight:700; color:red;'>" + dateFormat(bidDate) + "</td>" + 
															"<td style='font-weight:700; color:red;'>" + formatNumberWithCommas(this.userBidPrice) +" &#8361; </td>" +
															"<td style='font-weight:700; color:red;'>" + this.userId + "</td>" );
	             		}else {
	             			$('#userBidTableBody').append("<tr><td>" + index + "</td>" +
									"<td>" + dateFormat(bidDate) + "</td>" + 
									"<td>" + formatNumberWithCommas(this.userBidPrice) + " &#8361; </td>" +
									"<td>" + this.userId + "</td>" );
	             			
	             		}
	
	             		index++ ;
		
	    			});
	
	/*                 console.log("data " + data);
	              
	                let parsedData = JSON.parse(data); // 문자열을 객체로 변환
	                let json = parsedData.userBids;
	               
	                console.log("json " + json);
	                console.log("json.length " + json.length);
	                console.log("json " + data.length);
	      
	                json.userBids.forEach(function (bid, index) {
	                   console.log(index + 1);
	                   console.log(bid.userBidTime);
	                   console.log(bid.userBidPrice);
	                   console.log(bid.userId);
	               }) 
	                
	               
	               $(".userBidBox1").append(
	                       "<table>" +
	                       "<thead>" +
	                       "<tr>" +
	                       "<th>순번</th>" +
	                       "<th>입찰시간</th>" +
	                       "<th>입찰금액</th>" +
	                       "<th>입찰자</th>" +
	                       "</tr>" +
	                       "</thead>" 
	                )       
	               
	                for(var i=0; i<json.length; i++){
	                    let count = i+1;
	                    let userBidTime = json[i].userBidTime;
	                    let userBidPrice = json[i].userBidPrice;
	                    let userId = json[i].userId;
	                    $(".userBidBox1").append(
	                          "<tr>" +
	                          "<td style='font-weight:700; color:red;'>" + count + "</td>" +
	                          "<td style='font-weight:700; color:red;'>" + userBidTime + "</td>" +
	                          "<td style='font-weight:700; color:red;'>" + userBidPrice + "</td>" +
	                          "<td style='font-weight:700; color:red;'>" + userId + "</td>" +
	                          "</tr>"
	                  )
	               }  
	               
	               $(".userBidBox1").append(
	
	                       "</table>" 
	               )  */
	           },
	           error: function (e){
	               alert("에러에러에에러러");
	           }
	           
	         })
	      }

      
	      function fnAuctionNow() {
	          if(confirm("즉시구매하시겠습니까?")){
	             let price = $("#tradeFinalPrice").val();
	             $("#userPrice").val(formatNumberWithCommas(price));
	           
	             fnAuction(); 
	             
	         }else{
	             return false;
	         }
	
	      }
      
      
	     function FnPriceReset() {
	         let price = $("#tradeOldPrice").val();
	          $("#userPrice").val(formatNumberWithCommas(price));     
	         
	     }
	      
   </script> 

   	<div class="wrap-loading">
		<div>
			<img style="width: 25rem;" alt="" src="https://media2.giphy.com/media/ZO9b1ntYVJmjZlsWlm/giphy.gif?cid=ecf05e47e7vbjc78wv2xxky7x01vqz6fnbrzqugdbznnni9c&rid=giphy.gif&ct=g">
		</div>
	</div>
   
   
   
   <section id="section">
    <h1> 경매품 상세보기 </h1>
   </section>
      <div id="center" style="margin-top:25px;">
         <c:if test="${sessionScope.user != null && sessionScope.user.userRole gt 7}">
            <button type="button" id="button" style=" margin:10px 30px; padding:10px 20px; width:200px; height:42.4px;">
            <a href="/item/getListHaving?itemHave=1">판매가능상품 확인</a></button>
         </c:if>
 
         <c:if test="${sessionScope.user != null && sessionScope.user.userRole gt 7}">
         <button type="button" class="delBtn" id="delBtn">경매 물품 삭제하기</button>
         </c:if>
       </div>
	 <section id="section">
	 <div id="center" class="mainbox1">
	 <form method="post" action="/trade/tradeBid" id="tradeForm" name="tradeForm">
	    <div id="center" class="box1">
	     <div class="tradeInfo" id="tradeInfo">
	          <div id="center" class="box2">
	            <img src="${images.get(0).viewLoadName}" style="width:500px; height:500px; margin:auto;">
	               
	               <div class="date_box" style="margin-left:10px;">
	                  <div class="row1" style="margin-bottom:5px;">
	                    <h1 >상품이름 : ${item.itemName}</h1>
	                 </div> <!-- row1 -->
	                 <div class="row2" style="margin-bottom:5px;">
	                  시작시간 : ${trade.tradeStart}              
	                  <input type="hidden" name="tradeStart" id ="tradeStart"  class="tradeStart" value="${trade.tradeStart}">    
	               </div> <!-- row2 -->
	               <div class="row3" style="margin-bottom:5px;">
	                  종료시간 : ${trade.tradeEnd}
	                     <input type="hidden" name="tradeEnd" id ="tradeEnd" class="tradeEnd" value="${trade.tradeEnd}">
	                 </div> <!-- row3 -->
	                 
	                   <div class="date_dDay">
	                     <div class="date_dDay${status.index}">
	                        <input type="hidden" value="${trade.tradeEnd}" class="deadtime" name="deadtime" />
	                        <p>
	                           남은시간 : 
	                            <span class="day"></span>
	                            <span class="time"></span>
	                            <span class="min"></span>
	                            <span class="sec"></span>
	                        </p>
	                     </div><!-- date_dDay${status.index} -->
	                  </div><!-- date_dDay -->
	                  
	                    <input type="hidden" name="tradeMinPrice" id ="tradeMinPrice" value="${trade.tradeMinPrice}">
	                    <p>시작가 : <fmt:formatNumber value="${trade.tradeMinPrice}" pattern="#,###" /> &#8361;</p>
	            
	                    <p style="color:red" class="nowPrice">현재가 : <fmt:formatNumber value="${trade.tradeBuyNowPrice}" pattern="#,###" /> &#8361;</p>
	                     
	                     <input type="hidden" name="tradeFinalPrice" id ="tradeFinalPrice" value="${trade.tradeFinalPrice}">
	                   <p>즉구가 : <fmt:formatNumber value="${trade.tradeFinalPrice}" pattern="#,###" /> &#8361;</p>
	                 
	      
	                    <input type="hidden" name="tradeOldPrice" id ="tradeOldPrice" value="${trade.tradeBuyNowPrice}">
	                    <input type="hidden" name="tradeOldUserNum" id="tradeOldUserNum" value="${trade.userNum}">
	                 
	                     입찰가격 : <input type="text" value='<fmt:formatNumber value="${trade.tradeBuyNowPrice}" pattern="#,###" />' 
	                        class="userPrice"   id="userPrice" name="userPrice" disabled style="width:200px"> &#8361;
	                     <Br>
	                     <button type="button" class="btn-ui" onclick="fnPriceUp1()">+10,000</button>
	                     <button type="button" class="btn-ui" onclick="fnPriceUp3()">+30,000</button>
	                     <button type="button" class="btn-ui" onclick="fnPriceUp5()">+50,000</button>
	                     <button type="button" class="btn-ui" onclick="fnPriceUp10()">+100,000</button>
	                     <button type="button" class="btn-ui" onclick="fnPriceUp50()">+500,000</button>
	                     <button type="button" class="btn-ui" onclick="fnPriceUp100()">+1,000,000</button>
	               <br>
	                     <button type="button" class="btn-ui" onclick="fnPriceDown1()">-10,000</button>
	                     <button type="button" class="btn-ui" onclick="fnPriceDown3()">-30,000</button>
	                     <button type="button" class="btn-ui" onclick="fnPriceDown5()">-50,000</button>
	                     <button type="button" class="btn-ui" onclick="fnPriceDown10()">-100,000</button>
	                     <button type="button" class="btn-ui" onclick="fnPriceDown50()">-500,000</button>
	                     <button type="button" class="btn-ui" onclick="fnPriceDown100()">-1,000,000</button>
	                  <br>
	                     <input type="hidden" name="userRole" id ="userRole" value='${sessionScope.user eq null ? "":sessionScope.user.userRole}'>
	                     <input type="hidden" name="tradeNumber" id ="tradeNumber" value="${trade.tradeNumber}">
	                     <input type="hidden" name="userNum" id ="userNum" value='${sessionScope.user eq null ? "":sessionScope.user.userNum}'>
	                     <input type="hidden" name="itemNumber" id ="itemNumber" value="${item.itemNumber}">
	                     <input type="hidden" name="tradeIng" id="tradeIng" value="${trade.tradeIng}">
	                     <input type="hidden" name="userCash" id="userCash" value="${sessionScope.user.userCash}">
	         
	                    <button type="button" style="width:299px; font-size:20px;" class="btn-ui" onclick="fnAuction()">입찰하기</button>
	                    <button type="button" style="width:299px; font-size:20px;" class="btn-ui" onclick="fnAuctionNow()">즉시구매</button>
	                    <button type="button" style="width:110px; font-size:20px;" class="btn-ui" onclick="FnPriceReset()">초기화</button>
	              </div> <!-- date_dDay -->
	        </div> <!-- box2 --> 
	      </div> <!-- tradeInfo -->
	   </div> <!-- box1 --> 
	   
	           <div id="center" class="contentbox1">
	              <table id="bidContent">
	                 <tr>
	                    <th style="text-align:center; margin-bottom:5px;">
	                       <b style="font-size:24px; letter-spacing:2px;">▽ 작품설명 ▽</b>
	                    </th>
	                 </tr>
	                 <tr>
	                   <td>
	                       <div id="center" style="height:100px; letter-spacing:2px;" >
	                     	 <p style="margin:auto; font-size:24px;">"${item.itemContent}"</p>
	                     	</div>
	                  </td>
	               </tr>
	            </table>
	           </div> <!-- contentbox1 -->
	          
	          <div id="center" class="bidTableBox1">
	          <div id="bidLists">
	              <div id="center" class="userBidBox1">
	                 
	                  <table id="userBidTable">
	                      <thead>
	                          <tr>
	                              <th colspan="4" style="text-align:center; font-size:24px;">
	                                  입찰내역
	                              </th>
	                          </tr>
	                          <tr>
	                              <th>No.</th>
	                              <th>입찰시간</th>
	                              <th>입찰금액</th>
	                              <th>입찰자</th>
	                          </tr>
	                      </thead>
	                      <tbody id="userBidTableBody">
		                      <c:choose>
		                          <c:when test="${empty userBids}">
		                              <tr>
		                                  <td colspan="4" style="text-align:center; font-size:20px;">
		                                      현재 입찰자가 없습니다.
		                                  </td>
		                              </tr>
		                          </c:when>
	<%-- 	                          <c:otherwise>
		                  	          <tr>
		                                  <td style="font-weight:700; color:red;"></td>
		                                  <td style="font-weight:700; color:red;"></td>
		                                  <td style="font-weight:700; color:red;"></td>
		                                  <td style="font-weight:700; color:red;"></td>
		                              </tr>
		                              <tr><td></td><td></td><td></td><td></td></tr>
		                              <tr><td></td><td></td><td></td><td></td></tr>
		                              <tr><td></td><td></td><td></td><td></td></tr>
		                              <tr><td></td><td></td><td></td><td></td></tr>
		                              <tr><td></td><td></td><td></td><td></td></tr>
		                              <tr><td></td><td></td><td></td><td></td></tr>
		                              <tr><td></td><td></td><td></td><td></td></tr>
		                              <tr><td></td><td></td><td></td><td></td></tr>
		                            
		                          </c:otherwise> --%>
		                      	  <c:otherwise>
		                      			<script>
		                      				fnGetBidsList();
		                      			</script>
		                      	  </c:otherwise>    
		                      </c:choose>
		                  </tbody>        
	                  </table>
	              </div><!-- userBidbox1 -->
	              <c:forEach var="image" items="${images}" varStatus="status">
	                  <div id="center">
	                      <p style="letter-spacing:2px;">상품이미지${status.count}</p>
	                  </div>
	      
	                  <div id="center">
	                      <img src="${image.viewLoadName}" style="width:500px; height:500px;">
	                  </div>
	              </c:forEach>
	          </div><!-- bidLists -->
	      </div><!-- bidtablebox1 -->
	
	            
	           <!--  <button type="button" class="listBtn" id="listBtn">다른 경매 보기 리스트 확인하기</button> -->
	     
	           
	      
	</form>
	</div> <!-- mainbox1 -->
	</section>       
       <hr>
       <div id="center">
          <button type="button" class="listBtn" id="listBtn">다른 경매 보기 리스트 확인하기</button>
       </div>
    
   




<%@ include file="../include/footer2.jsp"  %>