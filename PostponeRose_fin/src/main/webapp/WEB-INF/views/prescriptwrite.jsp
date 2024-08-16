<%@page import="com.medicalInfo.project.model.MemberInfoDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
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

<%
MemberInfoDTO memberInfo = (MemberInfoDTO)session.getAttribute("memInfo");
MemberType memberType = (MemberType) session.getAttribute("membertype");
if (memberType != MemberType.EXPERT) {
%>
<script>
	alert("접근 권한이 없습니다");
	window.location.href = "login"; // 로그인 페이지로 리디렉션
</script>
<%
return;
}else if (memberType==null){
%>	
<script>
	alert("접근 권한이 없습니다");
	window.location.href = "login"; // 로그인 페이지로 리디렉션
</script>
<%
return;
}
%>


		<section class="Feautes section">
			<div class="container">
				
				<div class="row">
					<div class="col-lg-10" id="mediSerchSection">
						<div class="table-container">
							<h3>전문가 마이페이지</h3>
							<br/>
							<h5 id="qaPrescriptTitle">처방전 리스트</h5>
							<br/>
							
							<form id="prescriptionForm" action="insertprescript" method="post"> 
								<div class="prescriptWrite-expertBox">
									<div>
										<label>발행기관 : </label>
										<input type="text" name="prescribingInstitution" id="prescribingInstitution" value="<%=memberInfo.getInstitutionName() %>">
										
										<label>전문가 성명 : </label>
										<input type="text" name="prescribingDoctor" value="<%=memberDTO.getMemberName() %>">
									</div>
									<hr>
								</div>
								<div class="prescriptWrite-mediBox">
									<div>
										<label>환자 이메일 : </label>
										<input type="text" name="memberId" id="memberId">
										<button type="button" id="lookupBtn" class="medicine-btn">조회</button>
									
										<label>환자 성명 : </label>
										<input type="text" name="patientName" id="patientName" style="width: 120px;">
										
										<label>환자 연락처 : </label>
										<input type="text" name="phoneNum" id="phoneNum">
										
										<button type="button" id="registerPatient" class="medicines-btn">신규 등록</button>
									</div>
									<hr>
									<div id="mediBoxs">
										<label>약품 코드 : </label>
										<input type="text" readonly="readonly" name="itemSeq" id="itemSeq" 
											style="width: 150px; text-align: center;">
										
										<label>약품 명 : </label>
										<input type="text" readonly="readonly" name="itemName" id="itemName"
											placeholder="약 검색 란에서 검색 후 약을 선택해주세요!" style="width: 300px;">
										
										<label>투약량 : </label>
										<input type="text" name="dosage" id="dosage" style="width: 40px;">
										
										<label>투약일 : </label>
										<input type="text" name="dosageDate" id="dosageDate" style="width: 40px;">
										
										<label>추가/삭제 : </label>
										<input type="checkbox" name="addordrop" id="addordrop" value="Y" checked>
									</div>
									<br/>
									<div>	
										<label>변동사항 comment : </label>
										<input type="text" name="detail_comment" id="detail_comment" placeholder="환자를 위한 변동사항 코멘트를 남겨주세요!" style="width: 730px;">
										
										<button type="button" id="addMedicineBtn" class="medicine-btn">등록</button>
									</div>
								</div>
								<hr>
								
								<div class="card mb-4">
									<table class="medicine-table" id="medicineTable">
										<thead>
											<tr>
												<th>고유번호</th>
												<th>약품명</th>
												<th>투약량</th>
												<th>투약일</th>
												<th>추가/삭제</th>
												<th>코멘트</th>
												<th>작업</th>
											</tr>
										</thead>
										<tbody></tbody>
									</table>
								</div>
								<br/>
								<input type="submit" value="처방전 작성" class="medicines-btn">
							</form>
							<hr>
							<h5 id="qaPrescriptTitle">약 검색</h5>
							<br/>
							<div style="text-align: left;">
								<input type="text" id="searchInput" placeholder="약이름">
								<button onclick="ajaxTest()" class="medicine-btn">검색</button>
							</div>
							<br/>
							<div class="card mb-4">
								<table id="datatablesSimple" class ="resultTestApi">
									<thead>
										<tr>
											<th>회사명</th>
											<th>약품코드</th>
											<th>약품명</th>
											<th>약품 이미지</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${mediApi}" var="medis">
											<c:forEach items="${medis.body.items}" var="medi">
												<tr>
													<td>${medi.entpName}</td>
													<td>${medi.itemSeq}</td>
													<td><a href="javascript:void(0);" class="medLink" data-itemseq="${medi.itemSeq}" data-itemname="${medi.itemName}">${medi.itemName}</a></td>
													<td><img src="${medi.itemImage}" alt="${medi.itemName} 이미지"></td>
												</tr>
											</c:forEach>
										</c:forEach>
									</tbody>
								</table>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</section>
						
							


			
<script>
$(document).ready(function(){
    $("#lookupBtn").click(function(){
        var memberId = $("#memberId").val();
        $.ajax({
            url: "lookupPatient", // URL of the controller
            type: "post",
            data: { memberId:memberId },
            dataType : "json",
            success: function(response) {
                console.log("response체크"+response.memberName);
                if (response.success) {
                    $("#patientName").val(response.memberName);
                    $("#phoneNum").val(response.phoneNum);
                } else {
                    alert("환자 정보를 찾을 수 없습니다.");
                }
            },
            error: function() {
                alert("오류가 발생했습니다.");
            }
        });
    });
    
    $("#registerPatient").click(function(){
        var patientEmail = $("#memberId").val();
        var patientName = $("#patientName").val();
        var patientTel = $("#phoneNum").val();
        $.ajax({
            url: "registerpatient", // URL of the controller
            type: "post",
            data: {patientName:patientName,
                patientEmail: patientEmail,
                patientTel:patientTel},
            dataType : "json",
            success: function(response) {
                console.log("response체크"+response);
                if (response) {
                    alert("환자 정보를 추가등록 했습니다.");
                } else {
                    alert("환자 정보를 찾을 수 없습니다.");
                }
            },
            error: function() {
                alert("오류가 발생했습니다.");
            }
        });
    });

    // Event delegation to handle dynamically created links
    $(document).on("click", ".medLink", function() {
        var itemSeq = $(this).data("itemseq");
        var itemName = $(this).data("itemname");
        $("#itemSeq").val(itemSeq);
        $("#itemName").val(itemName);
    });

    // Add new row to #medicineTable
    $("#addMedicineBtn").click(function() {
        var itemSeq = $("#itemSeq").val();
        var itemName = $("#itemName").val();
        var dosage = $("#dosage").val();
        var dosageDate = $("#dosageDate").val();
        var detailComment = $("#detail_comment").val();
        var addordrop = $("#addordrop").prop("checked") ? "ADD" : "DROP";
        // Create a new row
        var newRow = "<tr>" +
            "<td>" + itemSeq + "<input type='hidden' name='mediID[]' value='" + itemSeq + "'></td>" +
            "<td>" + itemName + "<input type='hidden' name='itemName[]' value='" + itemName + "'></td>" +
            "<td>" + dosage + "<input type='hidden' name='pd[]' value='" + dosage + "'></td>" +
            "<td>" + dosageDate + "<input type='hidden' name='td[]' value='" + dosageDate + "'></td>" +
            "<td>"+ addordrop + "<input type='hidden' name='addordrop[]' value='"+ addordrop  +"'></td>" +
            "<td>" + detailComment + "<input type='hidden' name='d_comment[]' value='" + detailComment + "'></td>" +
            "<td><button type='button' class='medicine-btn'>삭제</button></td>" +
            "</tr>";

        // Append the new row to the table
        $("#medicineTable tbody").append(newRow);

        // Clear the input fields
        $("#itemSeq").val("");
        $("#itemName").val("");
        $("#dosage").val("");
        $("#dosageDate").val("");
        $("#detail_comment").val("");
    });

    // Event delegation to handle delete button
    $(document).on("click", ".medicine-btn", function() {
        $(this).closest("tr").remove();
    });

    // Prevent form submission on button click
    $("button").not("[type='submit']").click(function(event){
        event.preventDefault();
    });

    // Prevent form submission if no medicine is added
    $("#prescriptionForm").submit(function(event) {
        if ($("#medicineTable tbody tr").length === 0) {
            alert("처방전에 약품을 추가하세요.");
            event.preventDefault();
        }
    });
});

function ajaxTest() {
    let find = $("#searchInput").val();
    console.log("검색어: " + find);

    $.ajax({
        url: "ajaxTest",
        type: "post",
        dataType: "json",
        data: { "search": find },
        success: function(data) {
            // 결과 테이블을 비웁니다.
            $('.resultTestApi tbody').empty();
            
            // 데이터 구조에 따라 처리합니다.
            $.each(data, function(index, response) {
                $.each(response.body.items, function(idx, item) {
                    // 새로운 행 생성
                    var tr = $("<tr>");

                    // 각 항목을 셀로 추가
                    tr.append($("<td>").text(item.entpName));
                    tr.append($("<td>").text(item.itemSeq));
                    tr.append($("<td>").html("<a href='javascript:void(0);' class='medLink' data-itemseq='" + item.itemSeq + "' data-itemname='" + item.itemName + "'>" + item.itemName + "</a>"));
                    var itemImage = item.itemImage != null &&  item.iatemImage !="" ? item.itemImage : "../../resources/img/noimage.png";
                    tr.append($("<td data-th='약품 이미지'>").html("<img src='" + itemImage + "' alt='약품 이미지' style='width: 100px; height:auto;'>"));

                    // 행을 테이블에 추가
                    $('.resultTestApi tbody').append(tr);
                });
            });
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", status, error);
        }
    });
}
</script>
<%@include file="include/footer.jsp"%>