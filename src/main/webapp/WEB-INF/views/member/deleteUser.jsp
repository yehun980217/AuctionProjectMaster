<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>
   <section id="section" style="padding: 25px 0;">
      <h2 style="font-size: 60px;">회원탈퇴</h2>
   </section>
   
   <section id="section">
      <form method="POST" action="/member/deleteUser" name="deleteUserForm">
      
         회원 탈퇴 시 저장된 모든 회원 정보는 삭제되며 진행중인 입찰에 대해서 환불은 불가능하오니 진행중인 경매가 끝난 후 회원
         탈퇴를 하시길 바랍니다.
         <input type="checkbox" name="agree" id="chk01"><br>
         
         회원 탈퇴 전 보유한 금액에 관하여 환불 진행을 위해 전화문의 해야하며 탈퇴 후 전화문의 하셔도 도움드릴 수 없습니다.
         <input type="checkbox" name="agree" id="chk02"><br> 
         
         회원 탈퇴 후 발생하는 사건 사고에 관해 당사는 책임이 없음을 동의합니다.         
         <input type="checkbox" name="agree" id="chk03"><br>
         
       	 <div id="center">
         <table style="width:800px;">
            <tr style="text-align:center;" >
               <th><label for="userIds">아이디</label></th>
               <th style="width:500px;"><input type="text" id="userIds" name="userIds" placeholder="아이디"><br></th>
            </tr> 
            <tr style="text-align:center;">
               <th><label for="userSecurityPassword">비밀번호</label></th>
               <th style="width:500px;"><input type="password" id="userSecurityPassword" name="userSecurityPassword" placeholder="비밀번호"><br></th>
            </tr>
            <tr>
               <td colspan="2" style="text-align:center;"><button style=" width:150px;"type="button" id="button" class="deleteBtn" onclick="deleteUser()">회원탈퇴</button></td>
               <td></td>
         </table>
         </div>
         
         <input type="hidden" id = "loginUserId" name="loginUserId" value="${user.userId}">
         <input type="hidden" id = "loginUserSecurityPassword" name="loginUserSecurityPassword" value="${user.userSecurityPassword}">
         <input type="hidden" id = "userPw" name="userPw" value="${user.userPw}">
      </form>
   </section>
<script>

   function deleteUser() {
      let userId = $("#userIds").val();
      let loginUserId = $("#loginUserId").val();
      let userSecurityPassword = $("#userSecurityPassword").val();
      let loginUserSecurityPassword = $("#loginUserSecurityPassword").val();
      
      if (userId == null || userId == "") {
         alert("아이디를 입력해주세요.");
         $("#userIds").focus();
         return;
      } else if (userSecurityPassword == null || userSecurityPassword == "") {
         alert("비밀번호를 입력해주세요.");
         $("#userPw").focus();
         return;
      } else if (userId != loginUserId) {
         alert("아이디가 일치하지 않습니다.");
         return;
      } else if (userSecurityPassword != loginUserSecurityPassword){
         alert("비밀번호가 일치하지 않습니다.");
         return;
      } else if ($("input:checkbox[id='chk01']").is(":checked") != true
            || $("input:checkbox[id='chk02']").is(":checked") != true
            || $("input:checkbox[id='chk03']").is(":checked") != true) {
         alert("약관에 동의해주세요.")
         return;
      } else {
         alert("정상적으로 탈퇴되었습니다. 이용해주셔서 감사합니다.")
         document.deleteUserForm.submit();
      }
   }
</script>
<%@ include file="../include/footer2.jsp"%>