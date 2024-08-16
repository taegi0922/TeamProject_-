<%@page import="com.medicalInfo.project.model.PrescriptDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<style>
    .tableForm select {
        position: relative;
        z-index: 1000;
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
							<h3>전문가 마이페이지</h3>
							<br/>
							<div class="patient-tab">
								<ul>
									<li><a href="/mypage/expertMypage">돌아가기</a></li>
									<li><a href="/mypage/myQaRating">QA게시판 평점보기</a></li>
									<li><a href="/mypage/myPrescriptRating">처방전 평점보기</a></li>
								</ul>
							</div>
							<br/>
							<h5 id="qaPrescriptTitle">QA 답변 내역 확인</h5>
							<br/>
							<div class="card mb-4">
								<table id="boardTable" class="medi-table">
							        <thead>
							            <tr>
							                <th>No.</th>
							                <th>작성종류</th>
							                <th>작성자</th>
							                <th>작성일</th>
							            </tr>
							        </thead>
									<tbody></tbody>
								</table>
							</div>
							<div class="pageBtn">
								<ul class="pagination-centered">
									<c:if test="${qaCommentPageMaker.prev}">
										<li class="paginate_button previous">
											<a href="${qaCommentPageMaker.startPage - 1 }">Previous</a>
										</li>
									</c:if>
									<c:forEach var="num" begin="${qaCommentPageMaker.startPage }" end="${qaCommentPageMaker.endPage }">
										<li class="paginate_button ${qaCommentPageMaker.cri.pageNum == num? 'active':'' }"><a href="${num }">${num }</a></li>
									</c:forEach>
									<c:if test="${qaCommentPageMaker.next }">
										<li class="paginate_button next">
											<a href="${qaCommentPageMaker.endPage + 1 }">Next</a>
										</li>
									</c:if>
								</ul>
							</div>
							<form id="pageForm" action="/mypage/expertMyQaComment" method="get">
								<input type="hidden" name="pageNum" value="${qaCommentPageMaker.cri.pageNum }">
								<input type="hidden" name="amount" value="${qaCommentPageMaker.cri.amount }">
								<input type="hidden" name="type" value="${qaCommentPageMaker.cri.type }">
								<input type="hidden" name="type" value="${qaCommentPageMaker.cri.memberNum }">
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
						url : "/mypage/getExpertMyQaComment",
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
							$.each(data, function(index, comment) {
								console.log("qatest:::::"+index);
								var row = $("<tr>"); // 새로운 테이블의 행 요소 생성
								row.append($("<td data-th='No.'>").text(comment.comment_id)); // 생성한 tr요소에 게시글 번호가 담긴 td요소 추가
								
								// 게시글 제목을 누르면 상세보기로 이동해야하므로 링크(a태그)를 만들어서 url등록
								var qaTitleLink = $("<a>").attr("href",
										"/qa/get?qa_id=" + comment.qa_no +"&prescript_no="+comment.prescript_no+"&memberNum="+ comment.writer).text(comment.table_type);
								var qaTitleTd = $("<td data-th='작성종류'>").append(qaTitleLink); // a태그를 td태그에 추가
								row.append(qaTitleTd);
								
								var commentWriterLink = $("<a>").attr("href",
										"/qa/get?qa_id=" + comment.qa_no +"&prescript_no="+comment.prescript_no+"&memberNum="+ comment.writer).text(comment.writerName);
								var commentWriterTd = $("<td data-th='작성자'>").append(commentWriterLink); // a태그를 td태그에 추가
								row.append(commentWriterTd);
								
								var parseDate = new Date(comment.created_at); // DB에 저장된 등록 날짜를 Date객체로 변환
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
								
								var createdLink = $("<a>").attr("href",
										"/qa/get?qa_id=" + comment.qa_no +"&prescript_no="+comment.prescript_no+"&memberNum="+ comment.writer).text(formattedDate);
								var createdTd = $("<td data-th='작성일'>").append(createdLink);
								row.append(createdTd);
								
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
