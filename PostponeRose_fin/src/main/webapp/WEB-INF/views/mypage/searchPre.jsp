<%@page import="com.medicalInfo.project.model.PrescriptDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<style>
#banner, #banner2 {
    width: 230px;
    height: 350px;
    text-align: center;
    position: absolute;
    left: 30px;
    top: 150px;  
    border: 1px solid #ddd;
    box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
    background-color: #f9f9f9;
    padding: 10px;
    box-sizing: border-box;
    border-radius: 10px;
    overflow: hidden;
    z-index: 1;
}
#banner2 {
    top: 500px;
    margin-top:20px;  
}
.banner-close {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
    font-size: 20px;
    color: #f00;
    background-color: #fff;
    border: 1px solid #ddd;
  
    width: 25px;
    height: 25px;
    line-height: 25px;
    text-align: center;
}
#mediSerchSection {
  margin-left: 100px; /* 배너의 너비만큼 왼쪽 여백 추가 */
}
</style>
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
	// Check if the membertype is null
	if (membertype == null) {
	    // Redirect to login.jsp
	    response.sendRedirect("/login");
	    return;
	} else if (membertype.equals("EXPERT") && memberDTO.getMemberNum() == prescriptDTO.getMemberNum()) {
		// Redirect to login.jsp
	    response.sendRedirect("/mypage/expertMypage");
	 return;
	}
%>

		
		<section class="Feautes section">
			<div class="container">
				<div id="banner">
					<span class="banner-close">&times;</span>
					<img src="../resources/img/banner.jpg" style="width:100%; height:calc(100% - 20px); object-fit:cover;">
				</div>
				<div id="banner2">
					<span class="banner-close">&times;</span>
					<img src="../resources/img/banner2.jpg" style="width:100%; height:calc(100% - 20px); object-fit:cover;">
				</div>
				<div class="row">
					<div class="col-lg-10" id="mediSerchSection">
						<div class="table-container">
							<h3>전문가 마이페이지</h3>
							<br/>
							<h5 id="qaPrescriptTitle">처방전 검색</h5>
							<br/>
							
							<form id="searchForm" action="/mypage/searchPre" method="get">
								<div id="serchInput" style="margin-left: 0;">
							       	<input type="search" name="keyword" value="${expertPageMaker.cri.keyword }" placeholder="환자의 이메일을 검색해주세요!" style="width: 250px;">
								    <button type="submit"><i class="fa fa-search"></i></button>
								</div>
							</form>
							<br/>
							<br/>
							<div>
								<table id="boardTable" class="medi-table">
									<thead>
										<tr>
											<th>NO.</th>
											<th>처방일자</th>
											<th>환자명</th>
											<th>환자 ID</th>
											<th>처방기관</th>
											<th>전문가명</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
								<br/>
								<div class="pageBtn">
									<ul class="pagination-centered">
										<c:if test="${expertPageMaker.prev}">
											<li class="paginate_button previous">
												<a href="${expertPageMaker.startPage - 1 }">Previous</a>
											</li>
										</c:if>
										<c:forEach var="num" begin="${expertPageMaker.startPage }" end="${expertPageMaker.endPage }">
											<li class="paginate_button ${expertPageMaker.cri.pageNum == num? 'active':'' }"><a href="${num }">${num }</a></li>
										</c:forEach>
										<c:if test="${expertPageMaker.next }">
											<li class="paginate_button next">
												<a href="${expertPageMaker.endPage + 1 }">Next</a>
											</li>
										</c:if>
									</ul>
								</div>
								<form id="pageForm" action="/mypage/searchPre" method="get">
									<input type="hidden" name="pageNum" value="${expertPageMaker.cri.pageNum }">
									<input type="hidden" name="amount" value="${expertPageMaker.cri.amount }">
									<input type="hidden" name="type" value="${expertPageMaker.cri.type }">
									<input type="hidden" name="type" value="${expertPageMaker.cri.memberNum }">
								</form>
								
							</div>
							
							
							
						</div>
					</div>
				</div>
			</div>
		</section>
		
		
		<section class="Feautes section"></section>
		<section class="Feautes section">
			<div class="section-title">
				<br/><br/><br/><br/><br/><br/>
				<br/><br/><br/><br/><br/><br/>
			</div>
		</section>

<script type="text/javascript">
$(document).ready(function() {
    loadTable();

    function loadTable() {
        $.ajax({
            url: "/mypage/searchPre",
            type: "post",
            data: {
                pageNum: $("#pageForm").find("input[name='pageNum']").val(),
                amount: $("#pageForm").find("input[name='amount']").val(),
                keyword: $("#searchForm").find("input[type='search']").val() // keyword 포함
            },
            dataType: "json",
            success: function(data) {
                var boardTbody = $("#boardTable tbody");
                boardTbody.empty();

                $.each(data, function(index, prescript) {
                    var row = $("<tr>");
                    row.append($("<td>").text(prescript.prescript_no));

                    var parseDate = new Date(prescript.prescribed_date);
                    var options = {
                        year: "numeric",
                        month: "2-digit",
                        day: "2-digit",
                        hour: "2-digit",
                        minute: "2-digit"
                    };
                    var formattedDate = parseDate.toLocaleString("ko-KR", options);

                    var prescribedDateLink = $("<a>").attr("href",
                        "/mypage/expertPrescriptDetail?prescript_no=" + prescript.prescript_no + "&memberNum=" + prescript.memberNum).text(formattedDate);
                    var prescribedDateTd = $("<td>").append(prescribedDateLink);
                    row.append(prescribedDateTd);

                    var patientNameLink = $("<a>").attr("href",
                        "/mypage/expertPrescriptDetail?prescript_no=" + prescript.prescript_no + "&memberNum=" + prescript.memberNum).text(prescript.patient_name);
                    var patientNameTd = $("<td>").append(patientNameLink);
                    row.append(patientNameTd);

                    var memberIdLink = $("<a>").attr("href",
                        "/mypage/expertPrescriptDetail?prescript_no=" + prescript.prescript_no + "&memberNum=" + prescript.memberNum).text(prescript.memberId);
                    var memberIdTd = $("<td>").append(memberIdLink);
                    row.append(memberIdTd);

                    row.append($("<td>").text(prescript.institution_address));
                    row.append($("<td>").text(prescript.expert_name));

                    boardTbody.append(row);
                });
            },
            error: function(e) {
                console.log("실패");
                console.log(e);
            }
        });

        $(".paginate_button a").on("click", function(e) {
            e.preventDefault();
            $("#pageForm").find("input[name='pageNum']").val($(this).attr("href"));
            loadTable(); // 페이지 클릭시 loadTable() 호출
        });
    }
});
</script>
<%@include file="../include/footer.jsp"%>
