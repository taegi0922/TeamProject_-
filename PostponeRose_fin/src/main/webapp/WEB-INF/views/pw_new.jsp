<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        #password-change-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 400px;
            width: 100%;
            margin: 50px auto;
            font-family: 'Arial', sans-serif;
        }
        #password-change-container h2 {
            text-align: center;
            color: #333;
        }
        #password-change-container table {
            width: 100%;
            margin-top: 20px;
        }
        #password-change-container td {
            padding: 10px 0;
        }
        #password-change-container input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        #password-change-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            background-color: grey;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }
        #password-change-container input[type="submit"]:hover {
            background-color: blue;
        }
    </style>
</head>
<body>
    <div id="password-change-container">
        <h2>비밀번호 변경</h2>
        <form name="registerForm" action="pw_new.me" method="post" onsubmit="return validateForm()">
            <table>
                <tbody>
                    <tr>
                        <td>새 비밀번호</td>
                        <td><input type="password" name="memberPw"></td>
                    </tr>
                    <tr>
                        <td>새 비밀번호 확인</td>
                        <td><input type="password" name="memberPwConfirm"></td>
                    </tr>
                </tbody>
            </table>
            <input type="hidden" name="success" value="false" id="successField">
            <input type="submit" value="비밀번호 변경">
        </form>
    </div>
    <script type="text/javascript">
        function validateForm() {
            var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,20}$/;
            var memberPw = document.forms["registerForm"]["memberPw"].value;
            var memberPwConfirm = document.forms["registerForm"]["memberPwConfirm"].value;

            if (!passwordPattern.test(memberPw)) {
                alert("비밀번호는 8자 이상 20자 이하이어야 하며, 최소 하나의 대문자, 소문자, 숫자 및 특수문자를 포함해야 합니다.");
                return false;
            }

            if (memberPw !== memberPwConfirm) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                return false;
            }

            document.getElementById("successField").value = "true";
            alert('비밀번호가 성공적으로 변경되었습니다.');
            return true; // 유효성 검사를 통과한 경우 폼을 제출합니다.
        }
    </script>
</body>
</html>
<%@include file="include/footer.jsp"%>