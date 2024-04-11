<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>
<section id="section">
   <h1>상품 상세보기</h1>
</section>
<section id="section">
   <form name="itemForm" id="itemForm" action="/item/getList" method="get" enctype="multipart/form-data">

      <table id="itemModifyForm">
         <tr style="border: 1px solid #fff;">
            <th><label for="itemNumber">번호</label></th>
            <th colspan="4"><label for="itemName">상품명</label></th>
         </tr>

         <tr>
            <th><input type="text" class="form-control" id="itemNumber" name="itemNumber" value="${item.itemNumber}" readonly></th>
            <th colspan="4"><input type="text" class="form-control" id="itemName" name="itemName" value="${item.itemName}"></th>
         </tr>

         <tr>
            <td colspan="5">
            	<textarea class="itemContent" id="itemContent" name="itemContent" rows="15" cols="75" maxlength="500"
                  style="resize: none;">${item.itemContent}</textarea>
            </td>
         </tr>

         <tr>
            <td colspan="5"><input type="hidden" id="imageOk" value="${images.size()}"> 
            <c:choose>
                  <c:when test="${images.size()!=0}">
                     <c:forEach var="image" items="${images}" varStatus="status">
                        <div class="imgDelDiv">
                           <img src="${image.viewLoadName}"
                              style="width: 130px; height: 200px; outline: 2px solid #000; margin: 3px">
                           <button class="delImgBtn" type="button"
                              value="${image.loadFileRootName}">X</button>
                        </div>
                     </c:forEach>
                  </c:when>
		          <c:otherwise>
		            첨부파일 없음
		          </c:otherwise>
               </c:choose>
               </td>
         </tr>

         <c:if test="${item.tradeIng eq 'Y'}">
            <td>진행 경매로 등록된 상품입니다.</td>
         </c:if>

         <c:if test="${item.itemHave eq 0}">
            <td>재고가 없는 상품입니다.</td>
         </c:if>
         <tr>

            <td colspan="2" class="file_load">
            <label for="inputFile" class="fileButton">파일 선택</label> 
            <input type="file" name="files" id="inputFile" multiple="multiple" accept="image/*" style="display: none;"></td>
         </tr>
         <tr>

            <td colspan="2">
               <p>추가 이미지 미리보기</p>
               <div class="previewBox" style="display: none;"></div>
            </td>
         </tr>
      </table>

      <input type="hidden" name="pageNo" value="${PageInfo.pageNo}">
      <input type="hidden" name="amount" value="${PageInfo.amount}">
      <input type="hidden" name="type" value="${PageInfo.type}"> 
      <input type="hidden" name="keyword" value="${PageInfo.keyword}"> 
      <input type="hidden" name="itemHave" id="itemHave" value="${itemHave}">
      <input type="hidden" name="tradeIng" id="tradeIng" value="${item.tradeIng}">
      <div id="center">
         <button type="button" class="btn btn-default modBtn" onclick="fnModify()">수정하기</button>
         <button type="button" class="btn btn-default delBtn">삭제하기</button>
         <button type="button" class="btn btn-default itemlistBtn">리스트로 이동</button>
      </div>
   </form>
</section>

<section id="section">

   <c:if test="${item.itemHave eq 1 && item.tradeIng eq 'N'}">

      <div>
         <div style="margin-bottom: 20px; text-align: center;">
            <h3 style="font-size: 50px;">경매등록</h3>
         </div>
         <form method="POST" action="/trade/register" name="tradeRegForm" id="tradeRegForm">
            <input type="hidden" name="itemNumber" value="${item.itemNumber}">
            <input type="hidden" name="pageNo" value="${PageInfo.pageNo}">
            <input type="hidden" name="amount" value="${PageInfo.amount}">
            <input type="hidden" name="type" value="${PageInfo.type}"> 
            <input  type="hidden" name="keyword" value="${PageInfo.keyword}">

            <table>
               <tr>
                  <th id="font30">경매시작 :</th>
                  <td><input type="text" id="tradeStart" name="tradeStart"
                     class="trade-Start" readonly></td>
               </tr>

               <tr>
                  <th id="font30">경매종료 :</th>
                  <td><input type="text" id="tradeEnd" name="tradeEnd"
                     class="trade-End" readonly></td>
               </tr>

               <tr>
                  <td colspan="2"><b style="lettet-spacing:2px;">최소 금액은 10,000원 이며 10,000원 단위로 입력 가능합니다.</b></td>
               </tr>
               <tr>
                  <th id="font30">경매 시작 금액 :</th>
                  <td><input type="text" name="tradeMinPrice"
                     id="tradeMinPrice" class="priceStart"></td>
               </tr>
               <tr>
                  <td colspan="2"><b style="lettet-spacing:2px;">경매 종료 금액은 최대 1,000,000,000 원 입니다.</b></td>
               </tr>
               <tr>
                  <th id="font30">경매 종료 금액 :</th>
                  <td><input type="text" name="tradeFinalPrice"
                     id="tradeFinalPrice" class="priceEnd"></td>
               </tr>
               <tr>
                  <td colspan="2" style="text-align:center;"><button type="button"
                        class="btn btn-default auctionBtn">경매등록</button></td>
                  <td></td>
               </tr>
            </table>

         </form>
      </div>
   </c:if>
</section>

<script type="text/javascript">
//*-----------------------------------------------------미리보기 관련*/
      $(document).ready(function() {
           $("#inputFile").on("change", handleImgsFilesSelect);
       
          
           let priceStart = document.querySelector('.priceStart');
           priceStart.addEventListener('keyup', function(e) {
               let value = e.target.value;
               value = Number(value.replaceAll(',', ''));
               
               if(isNaN(value)) {
                  input.value = 0;
               }else {
                       const formatValue = value.toLocaleString('ko-KR');
                       priceStart.value = formatValue;
                }
           });
           
           let priceEnd = document.querySelector('.priceEnd');
           priceEnd.addEventListener('keyup', function(e) {
                 let value = e.target.value;
               value = Number(value.replaceAll(',', ''));
               
               if(isNaN(value)) {
                  input.value = 0;
               }else {
                       const formatValue = value.toLocaleString('ko-KR');
                       priceEnd.value = formatValue;
                }
           });
           
      
      
      
      }); 
   
   
      var sel_files = [] ; 
      var del_files = [] ; 
   
       function handleImgsFilesSelect(e) {
          sel_files.length = 0;
          var files = e.target.files;
           var filesArr = Array.prototype.slice.call(files);
           $(".previewBox").css('display', 'block');
           $(".previewBox").empty();
           
           
           filesArr.forEach(function(f) {
   
               sel_files.push(f);
   
               var reader = new FileReader();
               reader.onload = function(e) {
                  
                  var img_html = "<img style='width:100px; height:150px; margin:0 10px; outline:1px solid black;' src=\"" + e.target.result + "\" />";
                   $(".previewBox").append(img_html);
                   
               }
               reader.readAsDataURL(f);
           });
       }
      
//파일 변경에 대한 함수 -----------------------------------------------------------------------------
      function fnModify(){
         let itemName = $("#itemName").val();
         let itemContent = $("#itemContent").val();
         let itemNumber = $("#itemNumber").val();
         let tradeIng = $("#tradeIng").val();
         let itemHave = $("#itemHave").val();
           //Regex
         if(itemName == ""  || itemName == null){
            alert("제목 입력은 필수 입니다.");
            return;
         }
         if(itemContent == ""  || itemContent == null){
            alert("내용 입력은 필수 입니다.");
            return;
         }
         
         if(itemNumber == ""  || itemContent == null){
            alert("상품 번호가 없습니다.");
            return;
         }
         
         if(tradeIng == "Y"){
            alert("진행 경매중인 상품은 수정 불가합니다.");
            return;
         }

         let formData = new FormData();
         formData.append('itemName', itemName);
         formData.append('itemContent', itemContent);
         formData.append('itemNumber', itemNumber);
         
         if(del_files.length!=0){
            formData.append('delFileName', del_files);
         }

         for(var i = 0; i<sel_files.length; i++){
            formData.append('files', sel_files[i]);
         }
         
         $.ajax({
            type : 'POST',
            url : '/item/modify',
            data : formData,
            processData : false,
            contentType : false,
            success : function (data){
               let d = $.parseJSON(data);
               if(d.result == 'S'){
                  alert('수정 완료!');
                  var itemForm = $("#itemForm");
                  
                  
                  if(itemHave==null||itemHave==""){
                     itemForm.find("input[name='itemHave']").remove();
                     itemForm.submit();
                     
                  }else {
                     itemForm.attr("action", "/item/getListHaving").submit();
                  }
         
               }
            },
            error : function (){
               alert('관리자에게 문의!');
            }
         })
      }
   
    /*-----------------------------------------------------미리보기 관련*/
 
/*       $(".modBtn").click(function(e){
         var itemForm = $("#itemForm");
         e.preventDefault();

         itemForm.attr("action", "/item/modify") ;
         itemForm.attr("method", "post");
         
         itemForm.submit();
         
      }); */

      

       
         
/*       $(".listBtn").click(function(e){
         var itemForm = $("#itemForm");
      
         e.preventDefault();
         itemForm.submit();

      });    */
      
//개별 이미지 등록 때--------------------------------------------------      
/*       $("#fileBtn").click(function(){
         var count = $("#load_cnt").val();
         var num = parseInt(count);

         if(num > 4){
            alert("5개 초과할 수 없습니다.");
            return;
         }
         
         $(".file_load").append('파일 선택 : <input type="file" name="files" accept="image/*"><br>'); 
         num = num+1;
         $("#load_cnt").val(num) ;
       }); */
            
//개별 이미지 등록 때--------------------------------------------------   
   
   
      $(function() {
   //파일 삭제에 대한------------------------------------------------------
         $(".delBtn").click(function(e){
            
            
            if($("#tradeIng").val() == "Y"){
               alert("진행 경매중인 상품은 삭제 불가합니다.");
               return;
            }
            
            var itemForm = $("#itemForm");
         
            e.preventDefault();
            itemForm.attr("action", "/item/remove") ;
            itemForm.attr("method", "post");
            
            if(confirm("삭제하시겠습니까?")){
               itemForm.submit();
            }
            
         });
         
   //이미지 삭제----------------------------------------
         $(".delImgBtn").click(function(){
            var delValue = $(this).val();
            del_files.push(delValue);
            $(this).parent().hide();
      
          });   
   //--------------------------------------------------
   
         $(".itemlistBtn").click(function(e){
            var itemForm = $("#itemForm");
            var itemHave = $("#itemHave").val() ;
            itemForm.attr("method", "get") ;
            e.preventDefault();
            
            if(itemHave==null||itemHave==""){
               itemForm.find("input[name='itemNumber']").remove();
               itemForm.find("input[name='itemName']").remove();
               itemForm.find("textarea[name='itemContent']").remove();
               itemForm.attr("action", "/item/getList").submit() ;
               
            }else {
               itemForm.find("input[name='itemNumber']").remove();
               itemForm.find("input[name='itemName']").remove();
               itemForm.find("textarea[name='itemContent']").remove();
               itemForm.attr("action", "/item/getListHaving?itemHave="+itemHave).submit() ;
            }
            
         });   
         
         
          let allowTimes = [
                '10:00', '10:10', '10:20', '10:30', '10:40', '10:50',
                '11:00', '11:10', '11:20', '11:30', '11:40', '11:50',
                '12:00', '12:10', '12:20', '12:30', '12:40', '12:50',
                '13:00', '13:10', '13:20', '13:30', '13:40', '13:50',
                '14:00', '14:10', '14:20', '14:30', '14:40', '14:50',
                '15:00', '15:10', '15:20', '15:30', '15:40', '15:50',
                '16:00', '16:10', '16:20', '16:30', '16:40', '16:50',
                '17:00', '17:10', '17:20', '17:30', '17:40', '17:50', '18:00'
          ] ;

           $("#tradeStart").datetimepicker({
              minDate: 0,
              format: "Y-m-d H:i",
              sideBySide: true,
              showButtonPanel: true,
              isRTL: false,
              allowTimes: allowTimes,
              onClose: function (selectedDate) {
              
                let selectDate = ('0' + selectedDate.getHours()).slice(-2) + ':' + ('0' + selectedDate.getMinutes()).slice(-2);
               
                let startDateData = new Date(selectedDate);
             
                let sysDateData = new Date();
             
             let endDateData = null; 
               
                console.log("selectTime" + selectDate);
                console.log("selectTime" + selectDate);
                
                
                if($("#tradeStart").val()==""||$("#tradeStart").val()==null){
                  return;
                  
                }else if(allowTimes.indexOf(selectDate) < 0){
                   $("#tradeStart").val("");
                   alert("날짜와 시간을 올바르게 선택해주세요.");
                   
                }else if(startDateData<=sysDateData){
                  $("#tradeStart").val("");
                  alert("지난 시간이나 현재시간 등록은 불가합니다.");
                  
                } else if ($("#tradeEnd").val()!=""&&$("#tradeEnd").val()!=null){
                   let endDateInput = $("#tradeEnd").val();
                   endDateData = new Date(endDateInput);
                   if(startDateData >= endDateData){
                       alert("종료시간보다 작게 설정해주세요.");
                 	   $("#tradeStart").val("");
                   }
                }
              }  

           });

          
         $("#tradeEnd").datetimepicker({
            minDate: 0,
              format: "Y-m-d H:i",
              sideBySide: true,
              showButtonPanel: true,
              isRTL: false,
              allowTimes: allowTimes,
              onClose: function (selectedDate){

               //선택시간에 대한 정보
               let selectDate = ('0' + selectedDate.getHours()).slice(-2) + ':' + ('0' + selectedDate.getMinutes()).slice(-2);
               
               //현재 시간데이터
               let sysDateData = new Date();

               //종료시간 데이터
               let endDateData = new Date(selectedDate);

               //시작시간
               let startDateInput = $("#tradeStart").val();
               let startDateData = new Date(startDateInput);
               
               //시작시간 72시간 후
               let endDate1 = new Date(startDateData.getTime() + (72 * 60 * 60 * 1000) + (60 * 1000));
               
               //종료시간 객체
               let endDate2 = new Date(endDateData.getTime());
               
               
               console.log(startDateData);
               
               console.log(endDateData);
               console.log(endDateData > startDateData);
               console.log(endDate2 > endDate1);
               
               
               //값이 아예 없다면
                  if($("#tradeEnd").val()==""||$("#tradeEnd").val()==null){
                       return;
                    //값이 주어진 값에 없다면
                  }else if(allowTimes.indexOf(selectDate) < 0){
                      $("#tradeEnd").val("");
                      alert("날짜와 시간을 올바르게 선택해주세요.");
                      
                  //종료시간이 3일 뒤보다 높다면    
                  }else if(endDate2 > endDate1){
                      alert("시작시간으로부터 최대 72시간입니다.");
                      $("#tradeEnd").val("");
                  //시작시간이 더 크다면                
                  }else if(startDateData >= endDateData){
                     alert("시작시간보다 크게 설정해주세요.");
                  $("#tradeEnd").val("");
               //종료시간이 현재시간보다 작으면   
                  } else if(endDateData <= sysDateData){
                     $("#tradeEnd").val("");
                     alert("지난 시간이나 현재시간 등록은 불가합니다.");
                     
                  }
               console.log("");
            }
         });
         
/*             $("#tradeStart").change(function(){
               var startVal = $(this).val();
               if(startVal.slice(-1)!='0'){
                  alert('10분 단위로 입력되어야 합니다');
                  $(this).val() == "";
                  $(this).focus();
                  return;
               }
            
               alert('시간 입력이 되었습니다.');
               return;
         });  */


         $(".auctionBtn").click(function(e){
            
            let imageOk = parseInt($("#imageOk").val());
            
            
            if(imageOk==0){
               alert("경매등록 전 이미지 등록은 필수입니다.");
               return;
            }
            
            
            if($("#tradeStart").val()==null||$("#tradeStart").val()==""){
               alert("시작시간을 입력해주세요");
               $("#tradeStart").focus() ;
               return;
            }
            
            if($("#tradeEnd").val()==null||$("#tradeEnd").val()==""){
               alert("종료시간을 입력해주세요");
               $("#tradeEnd").focus();
               return;
            }
            
             if($("#tradeMinPrice").val()==null||$("#tradeMinPrice").val()==""){
               alert("최소 금액을 적어주세요");
               $("tradeMinPrice").focus();
               return;
            }else {
               let priceStr =   $("#tradeMinPrice").val().replaceAll(',', '');
            var priceInt = parseInt(priceStr);
               
            if(priceInt >1000000000) {
                  alert("1,000,000,000 원이 최대 금액입니다.");
                  $("#tradeMinPrice").focus();
                  return;
            }
                  
               
               if(priceInt%10000!=0){
                  alert("만원 단위 금액을 적어주세요");
                  $("#tradeMinPrice").focus();
                  return;
               }
               
            }
            
            if($("#tradeFinalPrice").val()==null||$("#tradeFinalPrice").val()==""){
               alert("최대 금액을 적어주세요");
               $("#tradeFinalPrice").focus();
               return;
            }else {
               let priceStr =   $("#tradeFinalPrice").val().replaceAll(',', '');
               priceInt = parseInt(priceStr);
               
            if(priceInt >1000000000) {
                  alert("1,000,000,000 원이 최대 금액입니다.");
                  $("#tradeFinalPrice").focus();
                  return;
            }
               
               if(priceInt%10000!=0){
                  alert("만원 단위 금액을 적어주세요");
                  $("#tradeFinalPrice").focus();
                  return ;
               }
            }
            
            let startPrice = parseInt($("#tradeMinPrice").val().replaceAll(',', ''));
            let endPrice = parseInt($("#tradeFinalPrice").val().replaceAll(',', ''));
            
            if(startPrice>=endPrice){
               alert("종료 금액이 더 커야 합니다.");
               $("#tradeFinalPrice").focus();
               return ;
            }
            
            $("#tradeMinPrice").val(startPrice);
            $("#tradeFinalPrice").val(endPrice);
            
            
            var tradeRegForm = $("#tradeRegForm");

            alert("상품이 등록되었습니다.")
            tradeRegForm.submit(); 
         
         });   
         
         
         
      });
       
       
       
   </script>



<link rel="stylesheet" type="text/css" media="screen"
   href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css">
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>

<%@ include file="../include/footer2.jsp"%>