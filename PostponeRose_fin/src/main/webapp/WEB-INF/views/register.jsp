<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<!-- End Header Area -->
<style>

.section-title div:first-child {
	margin: 0 auto;
}

/* Form Box Styles */
.resister-box {
	width: 800px;
    background-color: #ffffff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
}

.resister {
    margin: 0 auto;
}

/* Table Styles */
.resister-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 10px;
    margin: 0 auto;
}

.resister-table td {
    padding: 5px;
}

.resister-table input[type="text"],
.resister-table input[type="password"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.resister-table button {
    padding: 8px 16px;
    border: none;
    background-color: #1A76D1;
    color: white;
    border-radius: 4px;
    cursor: pointer;
}

.resister-table button:hover {
    background-color: #2C2D3F;
}

/* Error Message Styles */
#idCheckResult,
#passwordValidationResult,
#passwordCheckResult,
#addressValidationResult,
#phoneValidationResult {
    display: block;
    color: red;
    margin-top: 5px;
}

/* Submit Button Styles */
.table-bottom {
    margin-top: 20px;
    text-align: center;
}

.table-bottom .resister-btn {
    padding: 10px 20px;
    border: none;
    color: white;
    font-size: 16px;
    border-radius: 4px;
    cursor: pointer;
}

</style>

	<section class="Feautes section">
		<div class="section-title">
			<br><br><br><br><br>
			<div>
				<div class="resister-box">
					<div>
					  	<div class="resister">
					  		<br>
					  		<h3 style="color: #1A76D1;"><b>회원가입</b></h3>
					  		<br><br>
				  			<form name="registerForm" action="/user/register" method="post" onsubmit="return validateForm()">
		                        <table class="resister-table">
		                            <tbody>
		                                <tr>
		                                    <td>아이디</td>
		                                    <td><input type="text" name="memberId" id="memberId" oninput="validateForm()"></td>
		                                    <td><button type="button" name="memberIdCheck" id="idcheck">중복 체크</button></td>
		                                </tr>
		                                <tr>
		                                    <td colspan="3"><span id="idCheckResult" style="color: red;"></span></td>
		                                </tr>
		                                <tr>
		                                    <td>비밀번호</td>
		                                    <td><input type="password" name="memberPw" id="memberPw" oninput="validatePassword()"></td>
		                                </tr>
		                                <tr>
		                                    <td colspan="3"><span id="passwordValidationResult" style="color: red;"></span></td>
		                                </tr>
		                                <tr>
		                                    <td>비밀번호 확인</td>
		                                    <td><input type="password" name="memberPwConfirm" id="memberPwConfirm" oninput="validatePasswordMatch()"></td>
		                                </tr>
		                                <tr>
		                                    <td colspan="3"><span id="passwordCheckResult" style="color: red;"></span></td>
		                                </tr>
		                                <tr>
		                                    <td>이름</td>
		                                    <td><input type="text" name="memberName" id="memberName" required="required" oninput="validateForm()"></td>
		                                </tr>
		                                <tr>
										    <td>주소</td>
										    <td><input type="text" name="memberAddress" id="memberAddress" oninput="validateAddress()"></td>
										</tr>
										<tr>
										    <td colspan="3"><span id="addressValidationResult" style="color: red;"></span></td>
										</tr>
										<tr>
										    <td>전화번호</td>
										    <td><input type="text" name="memberPhone" id="memberPhone" oninput="validatePhoneNumber()"></td>
										</tr>
										<tr>
										    <td colspan="3"><span id="phoneValidationResult" style="color: red;"></span></td>
										</tr>
		                                <tr>
		                                    <td>이메일</td>
		                                    <td><input type="text" readonly="readonly"
		                                        name="memberEmail" value="${kakaoEmail}"></td>
		                                </tr>
		                            </tbody>
		                        </table>
		                        <div class="table-bottom">
		                            <input class="btn" type="submit" value="회원가입" id="registerButton">
		                        </div>
		                    </form>
				  	
				  	
				  		</div>
				  	</div>
				</div>
			</div>
		</div>
	</section>
	
	

<script type="text/javascript">
var isIdChecked = false;

function setIdChecked(value) {
    isIdChecked = value;
    validateForm();
}

function validatePassword() {
    var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,20}$/;
    var memberPw = document.forms["registerForm"]["memberPw"].value;
    var passwordValidationResult = document.getElementById("passwordValidationResult");

    if (!passwordPattern.test(memberPw)) {
        passwordValidationResult.textContent = "비밀번호는 8자 이상 20자 이하이어야 하며, 최소 하나의 대문자, 소문자, 숫자 및 특수문자를 포함해야 합니다.";
    } else {
        passwordValidationResult.textContent = "";
    }
    validateForm();
}

function validatePasswordMatch() {
    var memberPw = document.forms["registerForm"]["memberPw"].value;
    var memberPwConfirm = document.forms["registerForm"]["memberPwConfirm"].value;
    var passwordCheckResult = document.getElementById("passwordCheckResult");

    if (memberPw !== memberPwConfirm) {
        passwordCheckResult.textContent = "비밀번호와 비밀번호 확인이 일치하지 않습니다.";
    } else {
        passwordCheckResult.textContent = "";
    }
    validateForm();
}

function validateAddress() {
    var addressPattern = /^[가-힣0-9\s]+$/; // Korean address pattern
    var memberAddress = document.forms["registerForm"]["memberAddress"].value;
    var addressValidationResult = document.getElementById("addressValidationResult");

    if (!addressPattern.test(memberAddress)) {
        addressValidationResult.textContent = "주소는 한글과 숫자, 공백만 허용됩니다.";
    } else {
        addressValidationResult.textContent = "";
    }
    validateForm();
}

function validatePhoneNumber() {
    // Updated pattern: allows only 11-digit numbers
    var phonePattern = /^\d{11}$/;
    var memberPhone = document.forms["registerForm"]["memberPhone"].value;
    var phoneValidationResult = document.getElementById("phoneValidationResult");

    if (!phonePattern.test(memberPhone)) {
        phoneValidationResult.textContent = "전화번호는 11자리 숫자여야 합니다. (예: 01012345678)";
    } else {
        phoneValidationResult.textContent = "";
    }
    validateForm();
}

function validateForm() {
    var usernamePattern = /^[a-zA-Z][a-zA-Z0-9_]{4,14}$/;
    var phonePattern = /^\d{11}$/; // Updated to match the phonePattern in validatePhoneNumber
    var addressPattern = /^[가-힣0-9\s]+$/; // Korean address pattern

    var memberId = document.forms["registerForm"]["memberId"].value;
    var memberPw = document.forms["registerForm"]["memberPw"].value;
    var memberPwConfirm = document.forms["registerForm"]["memberPwConfirm"].value;
    var memberPhone = document.forms["registerForm"]["memberPhone"].value;
    var memberName = document.forms["registerForm"]["memberName"].value;
    var memberAddress = document.forms["registerForm"]["memberAddress"].value;

    var isValid = true;

    // 중복 체크 확인
    if (!isIdChecked) {
        isValid = false;
    }
    
    // 유효성 검사
    if (!usernamePattern.test(memberId)) {
        isValid = false;
    }

    if (document.getElementById("passwordValidationResult").textContent !== "" ||
        document.getElementById("passwordCheckResult").textContent !== "" ||
        document.getElementById("addressValidationResult").textContent !== "" ||
        document.getElementById("phoneValidationResult").textContent !== "") {
        isValid = false;
    }

    if (!phonePattern.test(memberPhone)) {
        isValid = false;
    }

    if (!addressPattern.test(memberAddress)) {
        isValid = false;
    }

    // 버튼 색상 변경
    var registerButton = document.getElementById("registerButton");
    if (isValid) {
        registerButton.style.backgroundColor = "#1A76D1";
        registerButton.disabled = false;
    } else {
        registerButton.style.backgroundColor = "grey";
        registerButton.disabled = true;
    }
}

$(document).ready(function(){
    var usernamePattern = /^[a-zA-Z][a-zA-Z0-9_]{4,14}$/;

    $("#idcheck").on("click", function(){
        var memberId = $("#memberId").val();
        var idCheckResult = $("#idCheckResult");
        
        if (!usernamePattern.test(memberId)) {
            idCheckResult.text("아이디는 영문으로 시작해야 하며, 5자 이상 15자 이하이어야 하고, 숫자와 특수문자(_)를 포함할 수 있습니다.").css("color", "red");
            setIdChecked(false);
            return;
        }
        
        $.ajax({
            url: "/user/memberIdCheck",
            type: "POST",
            data: { memberId: memberId },
            dataType: "json",
            success: function(response) {
                var idCheckResult = $("#idCheckResult");
                if (response == true) {
                    idCheckResult.text("아이디 사용가능").css("color", "green");
                    setIdChecked(true);
                } else if(response == false){
                    idCheckResult.text("이미 있는 아이디입니다.").css("color", "red");
                    setIdChecked(false);
                }
            },
            error: function() {
                alert("에러가 발생했습니다. 다시 시도해주세요.");
            }
        });
    });

    validateForm(); // 페이지 로드 시 초기 유효성 검사를 수행합니다.
});
</script>

<%@include file="include/footer.jsp"%>