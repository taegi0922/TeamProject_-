<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp"%>

<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<section class="Feautes section">
	<div class="section-title">
	<br><br><br><br><br>
		<div class="findpw-box">
			<div>
			  	<div class="findpw">
			  		<!-- 첫 번째 폼: 이메일 인증번호 전송 -->
					<form class="content" id="emailForm" action="pw_auth.me" method="post">
					    <div class="textbox">
					    	<h6><b>아이디를 입력해주세요.</b></h6>
					    	<br/>
					        <label for="id">아이디</label>
					        <input id="id" name="id" required="" type="text" />
					    </div>
					    <br/>
					    <br/>
					    <div class="textbox">
					        <h6><b>인증번호를 전달받을 이메일을 입력해주세요.</b></h6>
					        <br/>
					        <label for="email">이메일</label>
					        <input id="email" name="email" required="" type="email" />
					    </div>
					    <br/>
					    <input type="submit" id="sendAuthCode" value="이메일 인증번호 전송" class="btns">
					</form>
					
					<!-- 알림 메시지 표시 영역 -->
					<div id="notification" style="display: none; color: green;"></div>
					
					<br><br><br/>
					<!-- 두 번째 폼: 인증번호 확인 -->
					<form id="authCodeForm" action="/pw_set.me" method="post"> 
					    <div class="content">
					        <div class="textbox">
					        	<h6><b>전달받은 인증번호를 입력해주세요.</b></h6>
					        	<br/>
					            <label for="email_injeung">인증번호</label>
					            <input type="text" id="email_injeung" name="email_injeung" placeholder="인증번호를 입력하세요">
					            <div class="error"></div>
					            <br/>
					            <button id="verifyAuthCode" type="submit" class="btns">인증번호 확인</button>        
					        </div> 
					    </div>
					</form>
					
					<!-- 인증번호 확인 결과 표시 영역 -->
					<div id="authResult" style="display: none;"></div>
			    </div>
			</div>
		</div>
	</div>
</section>






<script>
$(document).ready(function() {
    // 이메일 인증번호 전송 폼 제출 이벤트 처리
    $('#emailForm').on('submit', function(event) {
        event.preventDefault(); // 폼 기본 제출 방지
        $('#notification').text('인증번호 전송 중... 잠시만 기다려 주세요.').show();
        $.ajax({
            url: $(this).attr('action'),
            method: $(this).attr('method'),
            data: $(this).serialize(),
            success: function(response) {
                $('#notification').text('이메일로 인증번호가 전송되었습니다').show();
            },
            error: function() {
                $('#notification').text('인증번호 전송에 실패했습니다. 다시 시도해주세요.').css('color', 'red').show();
            }
        });
    });

    // 인증번호 확인 폼 제출 이벤트 처리
    $('#authCodeForm').on('submit', function(event) {
        event.preventDefault(); // 폼 기본 제출 방지

        // 인증번호 입력값에서 공백 제거
        var authCode = $('#email_injeung').val().replace(/\s/g, '');
        $('#email_injeung').val(authCode);

        $.ajax({
            url: $(this).attr('action'),
            method: $(this).attr('method'),
            data: $(this).serialize(),
            success: function(response) {
                if (response === 'success') {
                    alert('인증번호 확인되었습니다.');
                    window.location.href = '/pw_new.me';
                } else {
                    alert('인증번호가 틀렸습니다.');
                    window.location.href = '/login';
                }
            },
            error: function() {
                alert('인증번호 확인 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    });
});
</script>

<%@ include file="include/footer.jsp" %>