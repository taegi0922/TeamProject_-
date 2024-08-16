<%@page import="com.medicalInfo.project.model.PrescriptDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<%

 Boolean isInvalidSession = (Boolean) request.getAttribute("isInvalidSession");

 if (isInvalidSession != null && isInvalidSession) {
 %>
	     <script type="text/javascript">
	         alert("로그인 후 이용해주세요");
	         window.location.href = "http://localhost:8090/login"; // 로그인 페이지로 리디렉션
	     </script>
<%
return;
}
%>
<style>
.memEdit-container {
   width: 80%;
   margin: 0 auto;
   margin-top: 20px;
   padding: 20px;
   border: 1px solid rgba(0, 0, 0, .09);
   border-radius: 8px;
   background-color: rgba(0, 0, 0, .01);
   box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
   transition: transform 0.5s ease, box-shadow 0.5s ease;
}

.memEdit-container:hover {
    transform: scale(1.02);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
}

.memEdit-container form {
    display: flex;
    flex-direction: column;
    gap: 15px;
    text-align: left;
}

.memEdit-container label {
    font-weight: bold;
    color: #555;
    text-align: left;
    margin-left: 210px;
}

.memEdit-container input[type="text"] {
    width: 30%;
    padding: 5px;
    margin-top: 5px;
    margin-left: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    text-align: left;
}

.memEdit-container p {
    font-weight: bolder;
    font-size: medium;
    text-align: center;
}

.memEdit-container input[readonly="readonly"] {
    background-color: #e9e9e9;
}

.memEdit-container button.btn {
    width: 20%;
    padding: 10px;
    margin-top: 20px;
    border: none;
    border-radius: 5px;
    background-color: #1A76D1;
    color: white;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s;
    text-align: center;
    margin-left: 290px;
}

.memEdit-container button.btn:hover {
    background-color: #1A76D1;
}

.memEdit-container #Withdrawal {
    background-color: #2C2D3F;
}

.memEdit-container #Withdrawal:hover {
    opacity: 0.8;
}

.memEdit-container img {
	width: 200px;
	height: 260px;
    display: block;
    margin: 10px auto;
    border: 1px solid #ddd;
    border-radius: 5px;
}
</style>


		<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-10" id="mediSerchSection">
						<div class="table-container">
							<h3>회원 마이페이지</h3>
							<br/>
							<h5 id="qaPrescriptTitle">회원 정보 수정</h5>
							<br/>
							<div class="memEdit-container">
								<div>
									<form name="editForm" action="/mypage/edit" method="post" onsubmit="return validateForms()">
										<%
											String memberID = memberDTO.getMemberId();
											String memberName = memberDTO.getMemberName();
											String memberAddress = memberDTO.getMemberAddress();
											String memberEmail = memberDTO.getMemberEmail();
											String memberPhone = memberDTO.getMemberPhone();
											int memberNum = memberDTO.getMemberNum();
										%>
										<div>
											<label>회원 ID</label>
								            <input type="text" readonly="readonly" name="memberId" value="${memberDto.memberId }">
								        </div>
										<div>
											<label>회원 이름</label>
								            <input type="text" readonly="readonly" name="memberName" value="<%=memberName%>">
								        </div>
								        <div>
											<label>회원 주소</label>
								            <input type="text" name="memberAddress" value="${memberDto.memberAddress }">
								        </div>
								       	<div>
											<label>회원 이메일 주소</label>
								            <input type="text" readonly="readonly" name="memberEmail" value="<%=memberEmail%>">
								        </div>
								        <div>
								        	<label>회원 연락처</label>
								            <input type="text" name="memberPhone" value="${memberDto.memberPhone }">
								        </div>
								        <br/>
								        <%
											if (membertype == MemberType.EXPERT) {
												String institutionName = memberInfoDTO.getInstitutionName();
												String institutionAddress = memberInfoDTO.getInstitutionAddress();
												String license = memberInfoDTO.getLicense();
												String institytionTel = memberInfoDTO.getInstitutionTel();
												System.out.println("이거 찍히냐?"+memberInfoDTO.toString());
										%>
							        	<p><strong>전문기관 등록 정보 변경 필요 시 재등록 요청 부탁드립니다.</strong></p>
								        <div>
								        	<img src="http://localhost:8090/download2?fileName=<%=memberInfoDTO.getPicuniName() %>&originalFileName=<%=memberInfoDTO.getPictureName() %>&fileType=<%=memberInfoDTO.getPicType() %>" width="200px" />
								        </div>
								       	<div>
								        	<label>전문가 자격증</label>
											<a href="http://localhost:8090/download?fileName=<%=memberInfoDTO.getUniqueName()%>&originalFileName=<%=memberInfoDTO.getFileName() %>&fileType=<%=memberInfoDTO.getFileType()%>"> <%=memberInfoDTO.getFileName() %> 다운로드</a>
											 
								        </div>
								        <div>
											<label>전문기관 이름</label>
								            <input type="text" readonly="readonly" name="institutionName" value="<%=institutionName%>">
								        </div>
								        <div>
								            <label>전문기관 주소</label>
								            <input type="text" readonly="readonly" name="institutionAddress" value="<%=institutionAddress%>">
								        </div>
								        <div>
											<label>전문기관 사업자 등록번호</label>
								            <input type="text" readonly="readonly" name="license" value="<%=license%>">
								        </div>
								        <div>
								            <label>전문기관 연락처</label>
								            <input type="text" readonly="readonly" name="institytionTel" value="<%=institytionTel%>">
								        </div>
								        <%
										    }
										%>
										<button type="submit" class="btn">수정 완료</button>
								
									</form>
										</div>									
										
								<form action="/mypage/withdraw" method="post">
									<input type="hidden" name="memberNum"  value="<%=memberNum%>" >
									<button type="submit" class="btn" id="Withdrawal">회원 탈퇴</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>




<script type="text/javascript">
$(document).ready(function() {
	$('#Withdrawal').on('click', function(){
		if (!confirm("정말 탈퇴하시겠습니까?")) {
			 event.preventDefault();
		}
	});
 });
	
	function validateForms() {
	    // 정규식 패턴
	    var usernamePattern = /^[a-zA-Z][a-zA-Z0-9_]{4,14}$/;
	
	    // 입력 필드 값
	    var memberId = document.forms["editForm"]["memberId"].value;
	    var membersId = document.forms["editForm"]["memberId"].placeholder;
	    var memberAddress = document.forms["editForm"]["memberAddress"].value; 
	    var membersAddress = document.forms["editForm"]["memberAddress"].placeholder; 
	    var memberPhone = document.forms["editForm"]["memberPhone"].value; 
	    var membersPhone = document.forms["editForm"]["memberPhone"].placeholder;
		
	 	// 유효성 검사
	    if (memberId == null) {
	    	memberId = membersId;
	    } 
	 	if (!usernamePattern.test(memberId)) {
	        alert("아이디는 알파벳으로 시작하고 5자 이상 15자 이하이어야 하며, 알파벳, 숫자, 언더스코어(_)만 포함할 수 있습니다.");
	        return false;
	    }
	    
	    if (memberAddress == null) {
	    	memberAddress = membersAddress;
	    }
	    
	    if (memberPhone == null) {
	    	memberPhone = membersPhone;
	    }
	
	    return true; // 유효성 검사를 통과한 경우 폼을 제출합니다.
	}
	
</script>
<%@include file="../include/footer.jsp"%>