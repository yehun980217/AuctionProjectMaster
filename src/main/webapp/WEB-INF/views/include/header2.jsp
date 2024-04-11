<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/headerStyle.css">
<link rel="stylesheet" href="/css/footerStyle.css">
<link rel="stylesheet" href="/css/mainStyle.css">
<link rel="stylesheet" href="/css/qaCss.css">
<link rel="stylesheet" href="/css/syhStyle.css">
<link rel="stylesheet" href="/css/modify.css">
<link rel="stylesheet" href="/css/faqCss.css">
<link  rel="stylesheet" href="/css/announcementStyle.css" type="text/css">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<title>하기찌렁잉</title>

</head>
<body>
   <header>
      <div class="logo">
         <a href="/"><img src="/logo/logo2.png" alt="Logo"> </a>
      </div>
      <nav class="header-nav">
         <ul>

            <c:if test="${empty sessionScope.user}">
               <li><a href="/login/getLogin">로그인</a></li>
               <li><a href="/signup/signup">회원가입</a></li>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
               <li><c:choose>
                     <c:when test="${sessionScope.user.userRole eq 0}">
                        <c:set var="userRoleLabel" value="준회원" />
                     </c:when>
                     <c:when test="${sessionScope.user.userRole eq 1}">
                        <c:set var="userRoleLabel" value="정회원" />
                     </c:when>
                     <c:when test="${sessionScope.user.userRole eq 8}">
                        <c:set var="userRoleLabel" value="관리자" />
                     </c:when>
                     <c:when test="${sessionScope.user.userRole eq 9}">
                        <c:set var="userRoleLabel" value="마스터" />
                     </c:when>
                     <c:otherwise>
                        <c:set var="userRoleLabel" value="알 수 없음" />
                     </c:otherwise>
                  </c:choose> 
                  
                  
                  <c:if test="${!empty sessionScope.user and sessionScope.user.userRole le 2}">
                        <input type="hidden" id="userId" name="userId" value="${sessionScope.user.userId}"> 
                        <button onclick="fnHaveCash()" id="chkCash" style="background: none;">
                           [보유머니 확인하기]
                        </button>
                        
                        &nbsp;&nbsp;&nbsp;
                      <span style="color: white; font-size: 15px; font-weight: 100;" id="userHaveCash">
                        </span>
                   </c:if>
                  
                  <span style="width: 500px; color: white; font-size: 15px; font-weight: 100;">
                     ${sessionScope.user.userName}님 [${userRoleLabel}] 환영합니다! &nbsp <%-- <c:if
                        test="${!empty sessionScope.user and sessionScope.user.userRole le 1}">
                        <span style="color: #fff; font-size: 14px; font-weight: normal;">보유
                           금액 : <fmt:formatNumber value="${sessionScope.user.userCash}" pattern="#,###" />원</span>&nbsp
                     </c:if> --%> <c:choose>
                        <c:when test="${sessionScope.user.userRole eq 0}">
                           <a style="font-size: 10px;" href="/email/verification_form">
                                  ▷인증하기◁
                           </a>
                        </c:when>
                        <c:otherwise>
                           <!-- 다른 사용자 권한에 대한 처리 (예: 아무것도 표시하지 않음) -->
                        </c:otherwise>
                     </c:choose>
               </span> &nbsp <a href="/logout" onclick="logout()">로그아웃</a></li>

               <script>
                  function logout() {
                     alert("로그아웃 되었습니다.");
                  }
               </script>
            </c:if>

            <!-- 로그인 후 le(작거나 같다)사용해서 userRole 0,1일 시 마이페이지 노출  -->
            <c:if test="${!empty sessionScope.user and sessionScope.user.userRole le 1}">
               <li><a href="/member/myPage">마이페이지</a></li>
            </c:if>

            <!-- 로그인 후 ge(크거나 같다)사용해서 userRole 8,9일 시 관리자페이지 노출 -->
            <c:if test="${!empty sessionScope.user and sessionScope.user.userRole ge 8 }">
               <li><a href="/admin/adminPage">관리자메뉴</a></li>
            </c:if>
            <c:if test="${!empty sessionScope.user and sessionScope.user.userRole ge 8 }">
               <li><a href="/item/getList">보유상품현황</a></li>
            </c:if>
         </ul>
      </nav>
   </header>

   <nav class="main-nav" style="font-weight: bold;">
      <ul>
         <li><a href="/intro/intro" class="btn">소개</a>
            <ul class="submenu">
               <li><a href="/intro/intro">소개글</a></li>
            </ul>
         </li>
         <li><a href="/trade/getListIng" class="btn">경매</a>
            <ul class="submenu">
               <li><a href="/trade/getListIng">진행(예정)경매</a></li>
               <li><a href="/trade/getListEnd">이전경매</a></li>
            </ul>
         </li>
         <li><a href="/announcement/getList" class="btn">게시판</a>
            <ul class="submenu">
               <li><a href="/announcement/getList">공지사항</a></li>
            </ul>
         </li>
         <li><a href="/qa/getList" class="btn">Q&A</a>
            <ul class="submenu">
               <li><a href="/question/register">문의하기</a></li>
               <li><a href="/qa/getList">FAQ</a></li>
            </ul>
         </li>
      </ul>
   </nav>
   
   <script type="text/javascript">
       
         function fnHaveCash() {
            let userId = $("#userId").val();
            $.ajax({
                url: '/chkHaveCash',
                type: 'post',
                data: {
                   'userId' : userId
                },
                success:function (data){
                   let userHaveCash = $.parseJSON(data).data;
                   $('#userHaveCash').html("보유하신 금액은 : " + 
                         formatNumberWithCommas(userHaveCash) + " 원 입니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                                     
                   setTimeout(function () {
                      $('#userHaveCash').html("");
                    }, 3000);   
                
                },
                error: function (e){
                   alert("관리자에게 문의해주세요.");
                }
             })
         }
         
        function formatNumberWithCommas(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
   

        
   </script>