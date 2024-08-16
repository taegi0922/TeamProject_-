<%@page import="com.medicalInfo.project.model.MemberType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<!-- End Header Area -->
<%
Boolean isLogin = (Boolean) session.getAttribute("isLogin");
if (isLogin == null || isLogin == false) {
    // Redirect to login.jsp if the user is not logged in
%>
<script>
    alert("로그인 후 이용해주세요");
    window.location.href = "login"; // 로그인 페이지로 리디렉션
</script>
<%
} 

%>
<!-- Slider Area -->
<%
    MemberType memberType = (MemberType) session.getAttribute("membertype");
    if (memberType == null) {
%>
    <script>
        alert("로그인 후 이용해주세요");
        window.location.href = "login"; // 로그인 페이지로 리디렉션
    </script>
<%
        return;
    }
%>

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
.tableForm {
    width: 100%;
    border-collapse: separate;
    border-spacing: 10px;
    margin: 0 auto;
}

.tableForm td {
    padding: 5px;
}

.tableForm input[type="text"],
.tableForm input[type="password"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.tableForm button {
    padding: 8px 16px;
    border: none;
    background-color: #1A76D1;
    color: white;
    border-radius: 4px;
    cursor: pointer;
}

.tableForm button:hover {
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
    margin-top: 50px;
    text-align: center;
}

.btn:hover {
    background: #2C2D3F;
    border: none;
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
					  		<h3 style="color: #1A76D1;"><b>전문가 회원 신청</b></h3>
					  		<br><br>
					  		<form id="expertForm" action="upload_ok" method="post" enctype="multipart/form-data">
				                <table class="tableForm">
				                    <tbody>
				                        <tr>
				                            <td>이름 : </td>
				                            <td><input type="text" name="memberName" id="memberName"></td>
				                        </tr>
				                        <tr> 
				                            <td>의료 면허: </td>
				                            <td><input type="text" name="medicalLicense" id="medicalLicense"></td>
				                        </tr>
				                        <tr> 
				                            <td>의료 기관: </td>
				                            <td><input type="text" name="medicalInstitution" id="medicalInstitution"></td> 
				                        </tr>
				                        <tr> 
				                            <td>의료 기관주소: </td>
				                            <td><input type="text" name="InstitutionAddress" id="InstitutionAddress"></td> 
				                        </tr>
				                        <tr>
				                            <td>의료 기관 전화번호: </td>   
				                            <td><input type="text" name="institutionTel" id="institutionTel"></td> 
				                        </tr>
				                        <tr>
				                            <td>연락 받을 이메일: </td>
				                            <td><input type="text" name="email" id="email"></td> 
				                        </tr>
				                        <tr>
				                            <td>증명사진 파일 선택: </td>
				                            <td><input type="file" name="picture" id="picture"></td>
				                        </tr>
				                        <tr>
				                            <td>전문가 면허증 파일 선택: </td>
				                            <td><input type="file" name="file" id="file"></td>
				                        </tr>
				                        
				                        <tr>
				                            <td colspan="2"><input type="submit" class="btn" value="제출하기"></td>
				                        </tr>
				                    </tbody>
				                </table>
				                
				            </form>
					  	
				  		</div>
				  	</div>
				  </div>
			</div>
		</div>
	</section>
		                        




<%@include file="include/footer.jsp"%>

<script>
    document.getElementById('expertForm').onsubmit = function(e) {
        var missingFields = [];

        var fields = [
            {id: 'memberName', name: '이름'},
            {id: 'medicalLicense', name: '의료 면허'},
            {id: 'medicalInstitution', name: '의료 기관'},
            {id: 'InstitutionAddress', name: '의료 기관주소'},
            {id: 'institutionTel', name: '의료 기관 전화번호'},
            {id: 'email', name: '연락 받을 이메일'},
            {id: 'picture', name: '증명사진 파일 선택'},
            {id: 'file', name: '전문가 면허증 파일 선택'}
        ];

        fields.forEach(function(field) {
            var value = document.getElementById(field.id).value;
            if (!value) {
                missingFields.push(field.name);
            }
        });

        if (missingFields.length > 0) {
            alert(missingFields.join(', ') + '이(가) 필요합니다.');
            e.preventDefault();
        } else {
            alert("신청이 완료되었습니다.");
        }
    };
</script>