<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>

<section id="section">
    <h1 style="text-align: center;">이메일 인증 [정회원 등업하기]</h1>
</section>

<section id="section" class="verification">
    <form action="/email/verification_form" id="verificationForm" method="post">
        <table>
            <tr>
                <td>
                    <label for="email">아이디(email) // 이메일이 올바르지 않을 경우 인증불가합니다.</label>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="email" name="email" value="${user.userId}" readonly>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <button id="button" class="sendButton" style="margin:0px; width:300px;" type="button" onclick="sendVerificationEmail()">인증 이메일 보내기</button>
                </td>
            </tr>
        </table>
    </form>
</section>

<script>
	function sendVerificationEmail() {
	    // 확인 대화상자 표시
	    var confirmationMessage = "인증메일을 보내시겠습니까?";
	    var confirmed = confirm(confirmationMessage);
	
	    if (confirmed) {
	        // 버튼 비활성화
	        var buttons = document.getElementsByClassName("sendButton");
	        for (var i = 0; i < buttons.length; i++) {
	            buttons[i].disabled = true;
	        }
	
	        // 지연 메시지 표시
	        alert("잠시만 기다려주십시오.. 이메일을 보내는 중입니다..");
	
	        // 폼을 서버로 제출
	        document.getElementById("verificationForm").submit();
	
	        setTimeout(function() {
	            alert("이메일을 성공적으로 보냈습니다.");
	        }, 1000);
	    }
	}

</script>

<%@ include file="../include/footer2.jsp"%>
