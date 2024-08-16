<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>   
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

      <!-- 기존 회원 Login Start -->
      <div class="login">
         <div class="login-boxs" style="background-image:url('resources/img/login.png')">
            <div class="login-container">
               <div class="container">
                  <div class="row"  id="loginContainer">
                     <div class="login-text">
						<p class="text1" style="margin-top: 30px;">당신의 모든 약 정보,</p>
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
                     <div id="loginBox">
                        <table id="loginForm">
                           <tr>
                              <td><input name="id" id="id" placeholder="아이디"></td>
                           </tr>
                           <tr>
                              <td><input name="pw" id="pw" type="password" placeholder="비밀번호"></td>
                           </tr>                        
                        </table>
                        <p id="error-message" style="color:red; display:none;">아이디 또는 비밀번호가 잘못되었습니다.</p>
                        <div>
                           
                           <input class="login-btn" type="submit" value="로그인" onclick="login()">
                        
                           <span>아이디를 잊으셨나요? <a href="/findid"><strong>아이디 찾기</strong></a></span>
                           <br/>
                           <span>비밀번호를 잊으셨나요? <a href="/findpw"><strong>비밀번호 찾기</strong></a></span>
                        </div>
                     </div>
                  </div>
               </div>
               
            </div>
         </div>
      </div>
      
<script type="text/javascript">
    

    function login() {
        const id = $('#id').val();
        const pw = $('#pw').val();
        
        $.ajax({
            url: '/loginidpw',
            type: 'POST',
            data: {
                id: id,
                pw: pw
            },
            dataType: 'json',  // Expect JSON response
            success: function(response) {
                console.log(response);  // Log the response to check its content
                if (response) {
                    console.log("로그인 성공");
                    window.location.href = '/login';  // Redirect on success
                } else {
                    console.log("로그인 실패");
                    $('#error-message').show();
                }
            },
            error: function() {
                console.log("서버 오류 발생");
                $('#error-message').text('서버 오류가 발생했습니다. 나중에 다시 시도해주세요.').show();
            }
        });
    }
    
    const contents = [
        `
        <p class="text1" style="margin-top: 30px;">당신의 모든 약 정보,</p>
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
        <p class="text1" style="margin-top: 30px;">처방전에 대한 궁금증,</p>
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
        <p class="text1" style="margin-top: 30px;">건강을 위한 첫걸음,</p>
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

      
   
<%@include file="include/footer.jsp"%>
