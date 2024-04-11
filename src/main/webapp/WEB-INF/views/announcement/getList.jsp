<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"  %>

<div class="outWrap">   
   <div class="innerWrap">   
      <h1><img src="/img/notice.png" style="width:64px; height: 64px; "> Notice <img src="/img/notice.png" style="width:64px; height: 64px; "></h1>
      <div id="center">
      
         <div id="justify" style="width:900px;">
            <div></div>
            
            <div>
               <form name="searchForm" id="searchForm" action="/announcement/getList" method="get">
               <select id="type" name="type">
                  <option value="" ${pageDTO.pi.type==null?"selected":""}>선택하세요</option>
                  <option value="T" ${pageDTO.pi.type eq 'T'?"selected":""}>제목</option>
                  <option value="C" ${pageDTO.pi.type eq 'C' ?"selected":""}>내용</option>
                  <option value="TC" ${pageDTO.pi.type eq 'TC'?"selected":""}>제목or내용</option>
               </select>
               <input type="text" name="keyword" 
                     id="keyword" value="${pageDTO.pi.keyword}">
               <input type="hidden" name="pageNum" value="1">
                 <input type="hidden" name="amount" value="${pageDTO.pi.amount}">      
               <button id="searchInput" style="width: 150px; padding:0 30px;" type="submit">검색</button>
            </form>
         </div> 
         
         </div>  <!-- justify -->
        </div> <!-- center -->
         <table class="announcementTable">
           <thead>
             <tr>
               <th scope="col" style="width : 80px; height:50px;  background-color:yellow;">No</th>
               <th scope="col" style="width : 600px; background-color:yellow; ">제&nbsp;&nbsp;&nbsp;목</th>
                <th scope="col"style="width : 200px;  background-color:yellow; ">공지일자</th>
             </tr>
           </thead>
           <tbody>
                <c:forEach var="notice" items="${list}" varStatus="status">
                  <tr>
                     <th scope="row" style="width : 50px; height:50px; background-color:yellow;">${notice.rno}</th>
                     <td><a class="move" href="${notice.announcementNumber}">${notice.announcementTitle}</a></td>
                     <td><fmt:formatDate value="${notice.announcementDate}"
                           pattern="yyyy-MM-dd" /></td>
                  </tr>
                </c:forEach>
            </tbody>
             
         </table>
      <br>
      
     
   </div> <!-- innerWrap -->
</div>      <!-- outWrap -->
<div class="pageWrap">
   <ul class="pagination">
      <c:if test="${pageDTO.preView}">
         <li class="page-item"><a class="page-link" href="${pageDTO.startPage-1}">이전으로</a></li>
      </c:if>
      <c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="pageNo">
         <li class="page-item" >
            <a class="page-link" href="${pageNo}">${pageNo}</a>
         </li>
      </c:forEach>
   
      <c:if test="${pageMaker.next}">
         <li class="page-item"><a class="page-link" href="${pageMaker.endPage+1}" >다음으로</a></li>
      </c:if>      
   </ul>
</div>


<div id="center">
   <c:if test="${sessionScope.user != null && sessionScope.user.userRole gt 7}">
      <button type="button" class="inputbtn" ><a href="/announcement/register" >글 등록</a></button>
   </c:if>   
</div>
   
   
   
   <!-- 페이지 번호를 클릭하면 form 태그를 submit시킨다. -->
   <form id="announcementForm" action="/announcement/getList" method="get" >
      <input type="hidden" name="pageNo" value="${pageDTO.pi.pageNo}">
      <input type="hidden" name="amount" value="${pageDTO.pi.amount}">
      <input type="hidden" name="type" value="${pageDTO.pi.type}">
      <input type="hidden" name="keyword" value="${pageDTO.pi.keyword}">
      <input type="hidden" name="announcementNumber" id="announcementNumber" value="">
   
      
   </form>   
      


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
         
      
         var announcementForm = $('#announcementForm');
           
           $(".page-link").on("click", function(e){
              e.preventDefault();
              
              var targetPage = $(this).attr("href");
               
              announcementForm.find("input[name='pageNo']").val(targetPage) ;
              announcementForm.submit();
           });
          
           //get 보내기
           $(".move").on("click", function(e){
              e.preventDefault();
              
              var announcementNumber = $(this).attr("href");
              
              $("#announcementNumber").val(announcementNumber);
              announcementForm.attr("action", "/announcement/get");
              announcementForm.submit();
            
           });   
      });
   
   </script>
    <%@ include file="../include/footer2.jsp"  %>