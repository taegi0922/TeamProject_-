<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
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
MemberType memberType = (MemberType) session.getAttribute("membertype");
 memberDTO = (MemberDTO) session.getAttribute("member_info");
%>
<%
if (memberDTO == null || memberType == null) {
	System.out.println("MemberDTO is nullHBYGBYBYG: " + memberDTO);
	System.out.println("MemberType is null: " + memberType);
%>
<script type="text/javascript">
	alert("로그인 해주세요");
	window.location.href = "http://localhost:8090/login";
</script>
<%
}
%>



<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-10" id="mediSerchSection">
						<div class="table-container">
							<h3>QA 게시판</h3>
							<h5 id="qaPrescriptTitle">글 작성</h5>
							<div id="qaListBtn">
								
							</div>
							<br/>
							<form id="qaform" class="form" action="http://localhost:8090/qa/register" method="post">
								<div class="card mb-4">
									<div class="qa-title">
										<span id="span1"><b>제목 </b><input name="title" type="text" placeholder="필수입력" required="required"></span>
										<span id="span2" class="span3-writer"><b>작성자 </b><input name="writer" type="text" value="<%=memberDTO.getMemberName() %>" readonly="readonly"></span>
										<span id="span4"><b>처방전 번호 입력 </b><input name="prescript_no" type="text" placeholder="처방전 No."></span>
										
									</div>
									<div class="qa-content">
										<p><textarea name="context" placeholder="필수입력" required="required"></textarea></p>
									</div>
									<div>
										<input type="hidden" name="memberType" value="<%=memberType %>" >
										<input type="hidden" name="memberNum" value="<%=memberDTO.getMemberNum() %>" >
									</div>
								</div>
								
								<c:choose> 
							  	 <c:when test="${empty myPrescript}">
							   	 </c:when>
							   	 <c:otherwise>
							   	 <h5 id="qaPrescriptTitle">마이처방전</h5>
								 <br/>
								 <div class="card mb-4">
									<table class="medicine-table">
									    <thead>	
										 <tr>
										 	<th>처방전 No.</th>
											<th>환자명</th>
											<th>전문가명</th>
											<th>처방기관</th>
											<th>처방일자</th>
										 </tr>
									   </thead>
									   <tbody>
									   	  <c:forEach items="${myPrescript}" var="my">
											   	<tr>
											   		<td data-th='처방전 No.' class="user_prescript_no"><c:out value="${my.prescript_no}"/></td>
											   		<td data-th='환자명' ><c:out value="${my.patient_name}"/></td>
											   		<td data-th='전문가명'><c:out value="${my.expert_name}"/></td>
											   		<td data-th='처방기관'><c:out value="${my.institution_address}"/></td>
											   		<td data-th='처방일자'><fmt:formatDate pattern = "yyyy-MM-dd hh:mm" value="${my.prescribed_date}"/></td>
											   	 <tr> 
									   		</c:forEach>	
									    </tbody>
									  </table>
									</div>
									<div class="pageBtn">
										<ul class="pagination-centered">
											<c:if test="${pageMaker.prev }">
												<li class="paginate_button previous"><a
													href="${pageMaker.startPage-1}">Previous</a></li>
											</c:if>
											<c:forEach var="num" begin="${pageMaker.startPage }"
												end="${pageMaker.endPage }">
												<li
													class="paginate_button ${pageMaker.cri.pageNum == num? 'active':'' }">
													<a href="${num }">${num }</a>
												</li>
											</c:forEach>
											<c:if test="${pageMaker.next }">
												<li class="paginate_button next"><a
													href="${pageMaker.endPage+1 }">Next</a></li>
											</c:if>
										</ul>
									</div>
									<form id="pageForm" action="/qa/register" method="get">
										<input type="hidden" name="pageNum"value="${pageMaker.cri.pageNum }"> 
										<input type="hidden"name="amount" value="${pageMaker.cri.amount }"> 
										<input type="hidden" name="type" value="${pageMaker.cri.type }"> 
										<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
										<input type="hidden" name="memberNum" value="<%=memberDTO.getMemberNum() %>">
									</form>
							   	 </c:otherwise>
							   </c:choose>
							   <br/>
							    <button type="submit" class="btn" id="submitBtn">글작성 완료</button>
							    <button type="button" class="btn"><a href="/qa/list">QA 리스트</a></button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>




<script type="text/javascript">
	$(document).ready(function() {
		let pageForm = $("#pageForm");

		$(".paginate_button a").on("click", function(e) {
			// a 태그의 기본 기능인 링크를 제거
			e.preventDefault();

			// 클릭한 a 태그의 href 속성 값을 pageNum에 설정
			let pageNum = $(this).attr("href");
			pageForm.find("input[name='pageNum']").val(pageNum);

			// 폼 제출
			pageForm.submit();
		});

		 $("#submitBtn").on("click", function(e) {
	            e.preventDefault();

	            const inputPrescriptNo = $("input[name='prescript_no']").val().trim(); // 입력값을 가져오고 앞뒤 공백을 제거
	            let isValid = false;

	            if (inputPrescriptNo === "") {
	                isValid = true;
	            } else {
	                $(".user_prescript_no").each(function() {
	                    if (inputPrescriptNo === $(this).text()) {
	                        isValid = true;
	                    }
	                });
	            }

	            if (!isValid) {
	                alert("본인의 처방전 번호만 입력할 수 있습니다.");
	                return;
	            }

	            // 유효성 검사가 성공하면 form 제출
	            $("#qaform").submit();
	        });
	});
</script>
<%@include file="../include/footer.jsp"%>
