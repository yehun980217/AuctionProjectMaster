<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header2.jsp"%>

   <section id="section">
      <h1>회원 정보</h1>
   </section>
   
   
   <div id="justify" style="margin:0 auto; width:1500px;">
      <div></div>
    <form name="searchForm" id="searchForm" action="/member/memberListAdmin" method="get" >
               <select id="type" name="type">
                  <option value="" ${pageDTO.pi.type==null?"selected":""}>선택하세요</option>
                  <option value="N" ${pageDTO.pi.type eq 'N'?"selected":""}>이름</option>
                  <option value="I" ${pageDTO.pi.type eq 'I' ?"selected":""}>아이디</option>
                  <option value="NI" ${pageDTO.pi.type eq 'NI'?"selected":""}>이름or아이디</option>
               </select>
               <input type="text" name="keyword" id="keyword" value="${pageDTO.pi.keyword}" style="width : 200px">
               <input type="hidden" name="pageNum" value="1">
               <input type="hidden" name="amount" value="${pageDTO.pi.amount}">      
               <button id="searchInput" style="width: 150px; padding:0 30px;" type="submit">검색</button>
       </form>
       </div>
       <div id="center">
      <form action="/updateUserRoleAdmin" method="post">
          <table border="1" style="text-align:center; table-layout:fixed;" class="listTable">
              <tr>
                  <th style="width:50px;">No</th>
                  <th style="width:210px;">아이디(email)</th>
                  <th style="width:110px;">이름</th>
                  <th style="width:160px;">휴대폰</th>
                  <th style="width:150px;">등급</th>
                  <th style="width:130px;">가입일</th>
                  <th style="width:130px;">토큰</th>
                  <th style="width:300px;">주소</th>
                  <th style="width:80px;">삭제</th>
              </tr>
      
                    <c:forEach var="user" items="${memberList}" >
                        <tr>
                            <td style="padding:5px;">${user.rno}</td>
                            <td>${user.userId}</td>
                            <td>${user.userName}</td>
                            <td>${user.userPhoneNum}</td>
      
                            <td>
                               <c:choose>
                               <c:when test="${user.userRole eq 0}">
                                   <c:set var="userRoleLabel" value="준회원" />
                               </c:when>
                               <c:when test="${user.userRole eq 1}">
                                   <c:set var="userRoleLabel" value="정회원" />
                               </c:when>
                               <c:when test="${user.userRole eq 8}">
                                   <c:set var="userRoleLabel" value="관리자" />
                               </c:when>
                               <c:when test="${user.userRole eq 9}">
                                   <c:set var="userRoleLabel" value="마스터" />
                               </c:when>
                               <c:otherwise>
                                   <c:set var="userRoleLabel" value="알 수 없음" />
                               </c:otherwise>
                           </c:choose>
                        <b> ${user.userRole} </b> &nbsp [${userRoleLabel}]<br>
                     
                          <select style="cursor:pointer;" name="userRole_${user.userNum}" id="userRole_${user.userNum}">
                         <option value="" selected disabled>${userRoleLabel}</option>
                         <c:choose>
                            <c:when test="${sessionScope.user.userRole eq 8}">
                              <option value="0">준회원</option>
                              <option value="1">정회원</option>
                            </c:when> 
                             <c:when test="${sessionScope.user.userRole eq 9}">
                                  <option value="0">준회원</option>
                              <option value="1">정회원</option>
                                 <option value="8">관리자</option>
                             </c:when>
                         </c:choose>
                     </select>
                      </td>
                      
                      <td><fmt:formatDate value="${user.userRegDate}" pattern="yyyy-MM-dd hh:mm" /></td>
                     <td><fmt:formatNumber value="${user.userCash}" pattern="#,##0"/> &#8361;</td>
                      <td>${user.userAddress}</td>
                      
                      <td>
                         <form action="/deleteMemberByNum" id="deleteForm_${user.userNum}"eteForm" method="post">
                         <input type="hidden" name="userNum" value="${user.userNum}" />
                         <button id="button" style="width:50px;" type="button" onclick="confirmDelete('${user.userNum}')">삭제</button>
                         <input type="hidden" name="sessionUserRole" value="${sessionScope.user.userRole}"/>
                     </form>
                  </td>
                         <input type="hidden" name="userRole_${user.userNum}" value="${user.userRole}" />
                       <input type="hidden" name="userNum_${user.userNum}" value="${user.userNum}" />
                      
                    </tr>
              </c:forEach>
              <!-- 위에서 만든 select 엘리먼트와 다른 필요한 입력 필드들 추가 -->
                 <tr>
                    <td colspan="9" style="text-align:center">
                      <button type="submit" class="listBtn">등급변경</button>
                    </td>
                 </tr>
          </table>
          
         
        </form>
       
      
    
   </div>
   
   <div class="pageWrap">
      <ul class="listPagination">
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
   
   <!-- 페이지 번호를 클릭하면 form 태그를 submit시킨다. -->
      <form id="userForm" action="/member/memberList" method="get" >
       <input type="hidden" name="pageNo" value="${pageDTO.pi.pageNo}">
       <input type="hidden" name="amount" value="${pageDTO.pi.amount}">
       <input type="hidden" name="type" value="${pageDTO.pi.type}">
       <input type="hidden" name="keyword" value="${pageDTO.pi.keyword}">
    </form>   
   
   
   
   
   
   <script>
      function confirmDelete(userNum) {
         
          var formId = "deleteForm_" + userNum; // 해당 form을 찾기 위한 ID 생성
          var form = document.getElementById(formId);
   
          if (confirm("정말로 삭제하시겠습니까?")) {
              // 사용자가 확인을 누르면 form을 전송
               form.submit();
               alert("삭제되었습니다.");
         /*      document.getElementById("deleteForm").submit();*/
          } else {
              // 사용자가 취소를 누르면 아무 동작도 하지 않음
          }
      }
        
        $(".page-link").on("click", function(e){
           
           var userForm = $('#userForm');
           e.preventDefault();
           
           var targetPage = $(this).attr("href");
            
           userForm.find("input[name='pageNo']").val(targetPage) ;
           userForm.submit();
        });
        
        
   
   </script>
<%@ include file="../include/footer2.jsp"%>