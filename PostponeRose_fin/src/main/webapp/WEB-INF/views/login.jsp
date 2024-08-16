<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<!-- End Header Area -->
<style>
    .login-text {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        .text1 {
            font-size: 20px;
            color: #333;
        }
        .text2 {
            font-size: 16px;
            color: #666;
        }
        .buttons {
            text-align: left;
            margin-top: 10px;
        }
        .circle-btn {
            width: 20px;
            height: 20px;
            background-color: #ccc;
            border: none;
            border-radius: 50%;
            margin: 0 5px;
            cursor: pointer;
        }
        .circle-btn.active {
            background-color: #666;
        }
</style>

		<div class="login">
			<div class="login-box" style="background-image:url('resources/img/login.png')">
				<div class="login-container">
					<div class="container">
						<div class="row"  id="kakaoLoginContainer">
							<div class="login-text">
								<p class="text1" style="margin-top: 25px;">당신의 모든 약 정보,</p>
								<br/>
								<p class="text1">약 쳐봥</p>
								<br/>
								<br/>
								<p class="text2">약 정보와 처방전을</p>
								<p class="text2">한 번에 약 쳐봥에서 해결해 보세요.</p>
								<br/>
								<br/>
								<div class="buttons">
								    <button class="circle-btn" data-index="0"></button>
								    <button class="circle-btn" data-index="1"></button>
								    <button class="circle-btn" data-index="2"></button>
								</div>
							</div>
							<div class="login-kakao">
								<c:choose>
									<c:when test="${empty isLogin || isLogin==false}">
										<div id="kakaoLoginBox">
											<h3>Kakao로</h3>
											<h1>약쳐봥 시작하기</h1>
											<a
												href="https://kauth.kakao.com/oauth/authorize?client_id=bc19ac7c0d184c8fbf994a386db912f2&redirect_uri=http://localhost:8090/oauth&response_type=code">
												<img src="/resources/loginbtn.png">
											</a>
											<form action="medisearch" method="get" class="medisearch">
												<p>내가 복용하는 약의 정보가 궁금하다면?</p>
												<input type="text" id="medisearchForm" name="searchMed" placeholder="검색할 약의 이름을 입력해 주세요.">
												<input type="submit" class="medisearch-btn" value ="검색">
											</form>
											<div id="applyExpert">
												<p>나의 처방전 기록이 궁금하다면? <a href="/mypage/prescript"><strong>마이처방전 가기</strong></a></p>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div id="kakaoLogoutBox">
											<br/>
											<h3>${member_info.memberName}님 환영합니다!</h3>
											<div id="memberGrade">
												<p>멤버 등급: ${membertype}</p>
											</div>
											<br/>	
											<form action="medisearch" method="get" class="medisearch">
												<p>내가 복용하는 약의 정보가 궁금하다면?</p>
												<input type="text" id="medisearchForm" name="searchMed" placeholder="검색할 약의 이름을 입력해 주세요.">
												<input type="submit" class="medisearch-btn" value ="검색">
											</form>
											<div id="applyExpert">
												<p>나의 처방전 기록이 궁금하다면? <a href="/mypage/prescript"><strong>마이처방전 가기</strong></a></p>
											</div>
											<br/>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
			<br/>
			<div class="mainImage-box" style="background-image:url('resources/img/main2_1.jpg')"></div>
				<div class="mainImage-contentBox" style="background-image:url('resources/img/main2_2.jpg')"></div>
				<div class="mainImage-box" style="background-image:url('resources/img/main1_1.jpg')"></div>
				<div class="mainImage-contentBox" style="background-image:url('resources/img/main1_2.jpg')"></div>
			<br/><br/><br/>
		</div>
		
		
		
<script type="text/javascript">
	window.onload = function() {
		var message = "${message}";
		var error = "${error}";
		if (message) {
			alert(message);
		}
		if (error) {
			alert(error);
		}
	}
</script>
<!--Start of Tawk.to Script-->
<script type="text/javascript">
	var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
	(function() {
		var s1 = document.createElement("script"), s0 = document
				.getElementsByTagName("script")[0];
		s1.async = true;
		s1.src = 'https://embed.tawk.to/6695c28b32dca6db2cafecc3/1i2sfvs8d';
		s1.charset = 'UTF-8';
		s1.setAttribute('crossorigin', '*');
		s0.parentNode.insertBefore(s1, s0);
	})();
	
	
	
	const contents = [
        `
        <p class="text1" style="margin-top: 25px;">당신의 모든 약 정보,</p>
        <br/>
        <p class="text1">약 쳐봥</p>
        <br/>
        <br/>
        <p class="text2">약 정보와 처방전을</p>
        <p class="text2">한 번에 약 쳐봥에서 해결해 보세요.</p>
        <br/>
        <br/>
        <div class="buttons">
            <button class="circle-btn" data-index="0"></button>
            <button class="circle-btn" data-index="1"></button>
            <button class="circle-btn" data-index="2"></button>
        </div>
        `,
        `
        <p class="text1" style="margin-top: 25px;">처방전에 대한 궁금증,</p>
        <br/>
        <p class="text1">여기서 확인하세요</p>
        <br/>
        <br/>
        <p class="text2">더 많은 정보를 원하시면,</p>
        <p class="text2">우리와 함께하세요.</p>
        <br/>
        <br/>
        <div class="buttons">
            <button class="circle-btn" data-index="0"></button>
            <button class="circle-btn" data-index="1"></button>
            <button class="circle-btn" data-index="2"></button>
        </div>
        `,
        `
        <p class="text1" style="margin-top: 25px;">건강을 위한 첫걸음,</p>
        <br/>
        <p class="text1">약 쳐봥과 함께</p>
        <br/>
        <br/>
        <p class="text2">모든 약 정보를</p>
        <p class="text2">한 곳에서 확인하세요.</p>
        <br/>
        <br/>
        <div class="buttons">
            <button class="circle-btn" data-index="0"></button>
            <button class="circle-btn" data-index="1"></button>
            <button class="circle-btn" data-index="2"></button>
        </div>
        `
    ];

    let currentIndex = 0;

    function changeContent(index) {
        currentIndex = index;
        document.querySelector('.login-text').innerHTML = contents[currentIndex];
        updateButtons();
        addEventListeners(); // Re-add event listeners after updating the content
    }

    function updateButtons() {
        document.querySelectorAll('.circle-btn').forEach((btn, index) => {
            btn.classList.toggle('active', index === currentIndex);
        });
    }

    function addEventListeners() {
        document.querySelectorAll('.circle-btn').forEach((btn, index) => {
            btn.addEventListener('click', () => changeContent(index));
        });
    }

    setInterval(() => {
        currentIndex = (currentIndex + 1) % contents.length;
        changeContent(currentIndex);
    }, 4000);

    // Initial setup
    addEventListeners();
    updateButtons();
</script>
<!--End of Tawk.to Script-->
<!-- End Appointment -->



<%@include file="include/footer.jsp"%>