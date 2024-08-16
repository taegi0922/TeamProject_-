<%@page import="com.medicalInfo.project.model.PrescriptDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
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
	
	//Get the session attribute "membertype"
	MemberType memberType2 = (MemberType) session.getAttribute("membertype");
	MemberDTO memberDTO2 = (MemberDTO) session.getAttribute("member_info");
	PrescriptDTO prescriptDTO2 = (PrescriptDTO) session.getAttribute("prescript");
	
	// Check if the membertype is null
	if (memberType2 == null) {
	    // Redirect to login.jsp
	    response.sendRedirect("/login");
	    return;
	} else if (memberType2.equals("EXPERT") || memberType2.equals("PATIENT") && memberDTO2.getMemberNum() == prescriptDTO.getMemberNum()) {
		// Redirect to login.jsp
	    response.sendRedirect("/index");
	 return;
	}
%>

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
							<h3>환자 마이페이지</h3>
							<br/>
							<div class="patient-tab">
								<ul>
									<li><a href="/mypage/patientMypage">돌아가기</a></li>
									<li><a href="/mypage/myQa">마이QA 문의</a></li>
								</ul>
							</div>
							<br/>
							<h5 id="qaPrescriptTitle">마이처방전 목록</h5>
							<br/>
							<div class="card mb-4">
								<table id="boardTable" class="medicine-table">
									<thead>
										<tr>
											<th>NO.</th>
											<th>처방일자</th>
											<th>환자명</th>
											<th>처방기관</th>
											<th>전문가명</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
							<div class="pageBtn">
							<ul class="pagination-centered">
								<c:if test="${pageMaker.prev}">
									<li class="paginate_button previous">
										<a href="${pageMaker.startPage - 1 }">Previous</a>
									</li>
								</c:if>
								<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
									<li class="paginate_button ${pageMaker.cri.pageNum == num? 'active':'' }"><a href="${num }">${num }</a></li>
								</c:forEach>
								<c:if test="${pageMaker.next }">
									<li class="paginate_button next">
										<a href="${pageMaker.endPage + 1 }">Next</a>
									</li>
								</c:if>
							</ul>
						</div>
						<form id="pageForm" action="/mypage/patientMypage" method="get">
							<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
							<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
							<input type="hidden" name="type" value="${pageMaker.cri.type }">
							<input type="hidden" name="type" value="${pageMaker.cri.memberNum }">
						</form>
						</div>
					</div>
				</div>
			</div>
		</section>
			

		<section class="Feautes section"></section>
		<section class="Feautes section">
			<div class="section-title">
			<br/>
			<br/>
			<br/>
			<br/>
			</div>
		</section>





<!--/ End QaView -->
<script type="text/javascript">
	$(document).ready(
			function() {
				loadTable();
				
				$('.banner-close').click(function() {
					$(this).parent().hide();
				});

				console.log("전체게시글 화면 이동");

				// loadTable() 시작
				function loadTable() {
					$.ajax({
						url : "/mypage/getPatientMypage",
						type : "post",
						data : {pageNum : $("#pageForm").find("input[name='pageNum']").val(),
								amount : $("#pageForm").find("input[name='amount']").val(),
								type : $("#searchType").val()},
						dataType : "json",
						success : function(data) {
							// data의 타입 Array
							var boardTbody = $("#boardTable tbody"); // 테이블 본문(tbody) 요소 저장
							boardTbody.empty(); // 테이블 본문을 비워서 기존 데이터 삭제

							// 서버에서 전달받은 Array를 반복적으로 화면에 출력
							$.each(data, function(index, prescript) {
								console.log("prescipttest:::::"+index);
								var row = $("<tr>"); // 새로운 테이블의 행 요소 생성
								row.append($("<td data-th='NO.'>").text(prescript.prescript_no)); // 생성한 tr요소에 게시글 번호가 담긴 td요소 추가
								
								
								var parseDate = new Date(prescript.prescribed_date); // DB에 저장된 등록 날짜를 Date객체로 변환
								// numeric : (2024, 7), 2-digit: (24, 07)
								var options = {
									year : "numeric",
									month : "2-digit",
									day : "2-digit",
									hour : "2-digit",
									minute : "2-digit"
								};
								var formattedDate = parseDate.toLocaleString(
										"ko-KR", options); // 날짜 형식을 한국 시간 형식과 지정 옵션으로 반환
								
								var prescribedDateLink = $("<a>").attr("href",
										"/mypage/prescriptDetail?prescript_no=" + prescript.prescript_no + "&memberNum=" + prescript.memberNum).text(formattedDate);
								var prescribedDateTd = $("<td data-th='처방일자'>").append(prescribedDateLink);
								row.append(prescribedDateTd);
										
								// 게시글 제목을 누르면 상세보기로 이동해야하므로 링크(a태그)를 만들어서 url등록
								var patientNameLink = $("<a>").attr("href",
										"/mypage/prescriptDetail?prescript_no=" + prescript.prescript_no + "&memberNum=" + prescript.memberNum).text(prescript.patient_name);
								var patientNameTd = $("<td data-th='환자명'>").append(patientNameLink); // a태그를 td태그에 추가
								row.append(patientNameTd);
								
								row.append($("<td data-th='처방기관'>").text(prescript.institution_address));
								row.append($("<td data-th='전문가명'>").text(prescript.expert_name));
										
								boardTbody.append(row); // 생성한 tr요소를 테이블 본문에 추가 
							});
						},
						error : function(e) {
							console.log("실패");
							console.log(e);
						}
					});
					
					let pageForm = $("#pageForm");
					
					$(".paginate_button a").on("click", function(e) {
						// a태그의 기본 기능인 링크를 삭제
						e.preventDefault();
						// pageNum값을 사용자가 클릭한 a태그의 href의 속성값으로 변경
						pageForm.find("input[name='pageNum']").val($(this).attr("href"));
						pageForm.submit();
					});
				}
			});
</script>
<%@include file="../include/footer.jsp"%>