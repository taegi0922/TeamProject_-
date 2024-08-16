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
	left: 30px;
	top: 150px;
	border: 1px solid #ddd;
	box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
	background-color: #f9f9f9;
	padding: 10px;
	box-sizing: border-box;
	border-radius: 10px;
	overflow: hidden;
}

#banner2 {
	top: 500px;
	margin-top: 20px;
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
			<img src="../resources/img/banner.jpg"style="width: 100%; height: calc(100% - 20px); object-fit: cover;">
		</div>
		<div id="banner2">
			<span class="banner-close">&times;</span> 
			<img src="../resources/img/banner2.jpg"style="width: 100%; height: calc(100% - 20px); object-fit: cover;">
		</div>
		<div class="row">
			<div class="col-lg-10" id="mediSerchSection">
				<div class="table-container">
					<h3>QA문의 게시판 Rating List</h3>
					<br/>
					<div class="patient-tab">
							<ul>
								<li><a href="/mypage/expertMypage">돌아가기</a></li>
								<li><a href="/mypage/myPrescriptRating">처방전 평점보기</a></li>
								<li><a href="/mypage/expertMyQaComment">QA 답변 보기</a></li>
							</ul>
					</div>
					<br/>
					<div class="card mb-4">
						<table id="boardTable" class="medicine-table">
							<thead>
							<tr>
								<th>No.</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>평점</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>  	
						</table>
						
				</div>
				<br>
				<div class="pageBtn">
   							 <ul class="pagination-centered">
       							 <c:if test="${pageMaker.prev }">
           							 <li class="paginate_button previous">
               							 <a href="${pageMaker.startPage - 1 }">Previous</a>
           							 </li>
        						</c:if>
       							<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
           							 <li class="paginate_button ${pageMaker.cri.pageNum == num? 'active':'' }">
               							 <a href="${num }">${num }</a>
           							 </li>
        						</c:forEach>
        						<c:if test="${pageMaker.next }">
           							 <li class="paginate_button next">
               							 <a href="${pageMaker.endPage + 1 }">Next</a>
           							 </li>
        						</c:if>
    						</ul>
						</div>
							
							<form id="pageForm" action="/mypage/myQaRating" method="get">
									<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
									<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
									<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
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
		<br/>
		<br/>
		<br/>
		<br/>
	</div>
</section>
<script type="text/javascript">
$(document).ready(function(){
	
	loadTable();
	
	function loadTable(){
		$.ajax({
			url :"/mypage/myQaRating",
			type : "POST",
			data: {		   
				pageNum: $("#pageForm").find("input[name='pageNum']").val(),
				amount: $("#pageForm").find("input[name='amount']").val(),
				  },
			dataType : "json",
			success: function(data) {
				
				var qaTbody = $("#boardTable tbody");
				qaTbody.empty(); 
				
				
				$.each(data, function(index, qr) {		
					var row = $("<tr>");
					
					
					var qa_id = $("<td>").text(qr.qa_id);
					row.append(qa_id);
					
					var title = $("<td>").text(qr.title);
					row.append(title); 
					
					var writer = $("<td>").text(qr.writer);
					row.append(writer);
					var parseDate = new Date(qr.created_at); // DB에 저장된 등록 날짜를 Date객체로 변환
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
					
					row.append(formattedDate);
					
					var rate = $("<td>").text(qr.rate);
					row.append(rate);
					
					/* <tr>
			   		<td data-th='No.'><c:out value="${qaRating.qadto.qa_id}"/></td>
			   		<td data-th='제목'><c:out value="${qaRating.qadto.title}"/></td>
			   		<td data-th='내용'><c:out value="${qaRating.qadto.context}"/></td>
			   		<td data-th='작성자'><c:out value="${qaRating.qadto.writer}"/></td>
			   		<td data-th='작성일'><c:out value="${qaRating.qadto.created_at}"/></td>
			   		<td data-th='평점'><c:out value="${qaRating.ratingdto.rate}"/></td>
			   	<tr>  */
				
					qaTbody.append(row); // 생성한 tr요소를 테이블 본문에 추가
				});
			},
			error: function(e) {
				console.log("실패");
				console.log(e);
			}
			
		});
	
	let pageForm = $("#pageForm");
	
	$(".paginate_button a").on("click", function(e) {
		// a태그의 기본 기능인 링크를 삭제 
		e.preventDefault();
		// pageNum 값을 사용자가 클릭한 a 태그의 href 속성값으로 변경
		pageForm.find("input[name='pageNum']").val($(this).attr("href"));
		pageForm.submit();
	});
	}
});	
</script>


<%@include file="../include/footer.jsp"%>