<%@page import="com.medicalInfo.project.model.PrescriptDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	} else if (memberType2.equals("EXPERT") || memberType2.equals("PATIENT") && memberDTO2.getMemberNum() == prescriptDTO2.getMemberNum()) {
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

.pageBtn {width: 100%; margin:0 auto; box-sizing: border-box;}
.pagination {text-align: center; vertical-align: middle; }
.paginate_button {display: inline-block; list-style: none; padding: 6px; text-align: center;}


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
							<h3>처방전 상세</h3>
							<br/>
							<div id="myPreSerchBtn">
							<button type="button" class="myPre-btn"><a href="/mypage/expertMypage">처방전 목록</a></button>
							</div>
							<br/>
							<br/>
							<div class="card mb-4">
								<div class="qa-title">
									<span id="span1"><b>No. </b>${dto.prescript_no }</span>
									<span id="span1"><b>환자명 </b>${dto.patient_name }</span>
									<span id="span2"><b>전문가명 </b>${dto.expert_name }</span>
									<span id="span3"><b>처방기관 </b>${dto.institution_address }</span>
									
									<span id="span4"><b>처방일자 </b><fmt:formatDate pattern = "yyyy-MM-dd hh:mm" value="${dto.prescribed_date }"/></span>
								</div>
							</div>
							<c:choose>
								<c:when test="${empty detaillist }">
								</c:when>
								<c:otherwise>
									<div class="card mb-4">
										<table class="medicine-table">
											<c:if test="${not empty detaillist }">
												<thead>
													<tr>
														<th>No.</th>
														<th>약품명</th>
														<th>1일 투약횟수</th>
														<th>총 투약일수</th>
														<th>변동사항</th>
														<th>설명</th>
													</tr>
												</thead>
												<c:forEach var="detaildto" items="${detaillist }" varStatus="status">
														<tbody>
															<tr>
																<td><c:out value="${status.count }"/></td>
																<td><c:out value="${detaildto.medicine_name }"/></td>
																<td><c:out value="${detaildto.per_day }"/></td>
																<td><c:out value="${detaildto.total_day }"/></td>
																<td><c:out value="${detaildto.addordrop }"/></td>
																<td><c:out value="${detaildto.detail_comment }"/></td>
															</tr>
														</tbody>
												</c:forEach>
											</c:if>
										</table>
									</div>
								</c:otherwise>
							</c:choose>
							<button type="button" class="myPre-btn"><a href="/mypage/expertPrescriptMod?prescript_no=${dto.prescript_no }">처방전 수정</a></button> 
							<br/>
							<br/>
							<br/>
							<!-- Start Commente댓글 출력 -->
							<form method="post" action="/mypage/remove">
								<c:if test="${not empty commentlist}">
									<div>
										<c:forEach var="commentsdto" items="${commentlist }">
											<li style="list-style-type: none;">
												<div>
													<c:choose>
														<c:when test="${commentsdto.writer eq dto.memberNum }">
															<h5 id="myPreRatingTitle">환자 Comment</h5>
															<br/>
															<p>작성자: ${commentsdto.writerName } 작성일자: [<fmt:formatDate pattern="yyyy-MM-dd-HH:mm" value="${commentsdto.created_at }"/>]</p>
														</c:when>
														<c:otherwise>
															<h5 id="myPreRatingTitle">Comment</h5>
															<br/>
															<p>작성자: ${commentsdto.writerName }</p>
														</c:otherwise>
													</c:choose>
													<strong> -> ${commentsdto.content }</strong>
													<br/>
													<br/>
													<hr/>
												</div>
											</li>
										</c:forEach>
									</div>
								</c:if>
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
			</div>
		</section>

		
<%@include file="../include/footer.jsp"%>