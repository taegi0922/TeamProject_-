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

<style>
#banner, #banner2 {
    width: 230px;
    height: 350px;
    text-align: center;
    position: absolute;
    border: 1px solid #ddd;
    box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
    background-color: #f9f9f9;
    padding: 10px;
    box-sizing: border-box;
    border-radius: 10px;
    overflow: hidden;
    z-index: 1;
}
#banner {
    left: 30px;
    top: 150px;  
}
#banner2 {
    right: 30px;
    top: 150px;
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
  margin-right: 260px; /* 오른쪽 배너의 너비만큼 오른쪽 여백 추가 */
  
  .star-rating {
    font-size: 0;
}

.rate {
    background: url(https://aldo814.github.io/jobcloud/html/images/user/star_bg02.png) no-repeat;
    width: 121px;
    height: 20px;
    position: relative;
}

.rate span {
    position: absolute;
    top: 0;
    left: 0;
    background: url(https://aldo814.github.io/jobcloud/html/images/user/star02.png) no-repeat;
    width: auto;  /* 전체 넓이를 차지하도록 설정 */
    height: 20px;
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
							<h3>전문가 마이페이지</h3>
							<br/>
							<div class="patient-tab">
								<ul>
									<li><a href="/mypage/myQaRating">QA게시판 평점보기</a></li>
									<li><a href="/mypage/myPrescriptRating">처방전 평점보기</a></li>
									<li><a href="../mypage/expertMyQaComment">QA 답변 내역 확인</a></li>
								</ul>
							</div>
							<br/>
							<h5 id="qaPrescriptTitle">처방전 목록</h5>
							<br/>
							<div class="card mb-4">
								<table id="boardTable" class="medi-table">
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
							<form id="pageForm" action="/mypage/expertMypage" method="get">
								<input type="hidden" name="pageNum" value="${expertPageMaker.cri.pageNum }">
								<input type="hidden" name="amount" value="${expertPageMaker.cri.amount }">
								<input type="hidden" name="type" value="${expertPageMaker.cri.type }">
								<input type="hidden" name="type" value="${expertPageMaker.cri.memberNum }">
							</form>
							<br/>
							<div id="rateExpert">
								<h5 id="qaPrescriptTitle"><%=memberDTO.getMemberName() %> <span>전문가</span>님의 평균 평점은?</h5>
								<c:choose> 
								  	<c:when test="${empty myAvgRating}">
								  		<div class="star-rating">
									        <div class="star-rating-top" style="width: ${myAvgRating.rate * 20}%;"></div>
									        <div class="star-rating-bottom"></div>
									     </div>
									     <br/>
									     <div id="starRateingMent"><p><b>아직 남겨진 평점이 없습니다!</b></p></div>
								   	</c:when>
								   	<c:otherwise>
										<div class="rate">
									        <span style="width: ${myAvgRating.rate * 20}%;"></span>
									        
									    </div>
									    <div>평점 : ${myAvgRating.rate}점</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		
		
		<section class="Feautes section">
			<div class="section-title">
			</div>
		</section>
		

<script type="text/javascript">
	$(document).ready(
			function() {
				loadTable();

				console.log("전체게시글 화면 이동");

				// loadTable() 시작
				function loadTable() {
					$.ajax({
						url : "/mypage/getExpertMypage",
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
								row.append($("<td data-th='No.'>").text(prescript.prescript_no)); // 생성한 tr요소에 게시글 번호가 담긴 td요소 추가
								
								
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
										"/mypage/expertPrescriptDetail?prescript_no=" + prescript.prescript_no + "&memberNum=" + prescript.memberNum).text(formattedDate);
								var prescribedDateTd = $("<td data-th='처방일자'>").append(prescribedDateLink);
								row.append(prescribedDateTd);
										
								// 게시글 제목을 누르면 상세보기로 이동해야하므로 링크(a태그)를 만들어서 url등록
								var patientNameLink = $("<a>").attr("href",
										"/mypage/expertPrescriptDetail?prescript_no=" + prescript.prescript_no + "&memberNum=" + prescript.memberNum).text(prescript.patient_name);
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
				
				$('.banner-close').click(function() {
					$(this).parent().hide();
				});
				
			});
</script>
<%@include file="../include/footer.jsp"%>