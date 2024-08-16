<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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
</head>
<body>


		<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-10" id="mediSerchSection">
						<div class="table-container">
							<form id="modForm" action="">
								<h3>QA 게시판</h3>
								<h5 id="qaPrescriptTitle">수정 및 삭제</h5>
								<div id="qaListBtn">
									<button type="button" class="btn" data-oper ="list">게시판으로 돌아가기</button>
								</div>
								<br/>
								<div class="card mb-4">
									<div class="qa-title">
										<span id="span1"><b>제목 </b><input name="title" value='<c:out value="${q_ID.title }"/>'></span>
										<span id="span2" class="span3-writer"><b>작성자 </b><input readonly="readonly" name="writer" value='<c:out value="${q_ID.writer }"/>'></span>
										<span id="span3"><b>작성일 </b><fmt:formatDate pattern = "yyyy-MM-dd hh:mm" value="${q_ID.created_at }"/></span>
										
										<span id="span4"><b>조회 </b>${q_ID.viewcnt }</span>
									</div>
									<div class="qa-content">
										<p><textarea rows="5" cols="50" name="context"><c:out value="${q_ID.context }"/></textarea></p>
									</div>
								</div>
								<div id="qaPreNum">
									<span id="span1"><b>현재 게시글 처방전 번호 </b><input name="prescript_no" value='<c:out value="${q_ID.prescript_no }"/>'></span>
								</div>
								<br/>
								<c:choose> 
								  	<c:when test="${q_ID.prescript_no ==0 }">
								   	</c:when>
								   	<c:otherwise>
								   		<h5 id="qaPrescriptTitle">게시글 처방전</h5>
								   		<br/>
										<div class="card mb-4" id="qaPrescript">
											<div id="qaPrescriptContent1">
												<span id="qaPreSpan1"><b>처방전 No. </b>${prescriptDTO.prescript_no}</span>
												<span id="qaPreSpan2"><b>환자명 </b>${prescriptDTO.patient_name}</span>
												
												<span id="qaPreSpan3"><b>전문가명 </b>${prescriptDTO.expert_name}</span>
												<span id="qaPreSpan4"><b>처방기관 </b>${prescriptDTO.institution_address}</span>
												<span id="qaPreSpan5"><b>처방일자 </b><fmt:formatDate pattern = "yyyy-MM-dd hh:mm" value="${prescriptDTO.prescribed_date}"/></span>
											</div>
										</div>	
								   	</c:otherwise>
								</c:choose>
								<br/>
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
												   		<td data-th='환자명'><c:out value="${my.patient_name}"/></td>
												   		<td data-th='전문가명'><c:out value="${my.expert_name}"/></td>
												   		<td data-th='처방기관'><c:out value="${my.institution_address}"/></td>
												   		<td data-th='처방일자'><fmt:formatDate pattern = "yyyy-MM-dd hh:mm" value="${my.prescribed_date}"/></td>
												   	 <tr> 
										   		</c:forEach>	
										    </tbody>
										  </table>
										</div>
								   	 </c:otherwise>
								   </c:choose>			  
							</form>
							
							<div class="pageBtn">
								<ul class="pagination-centered">
									<c:if test="${pageMaker.prev }">
									<li class="paginate_button previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
									</c:if>
								<c:forEach var="num" begin="${pageMaker.startPage }"
									end="${pageMaker.endPage }">
								<li class="paginate_button ${pageMaker.cri.pageNum == num? 'active':'' }">
								<a href="${num }">${num }</a>
								</li>
								</c:forEach>
								<c:if test="${pageMaker.next }">
									<li class="paginate_button next"><a href="${pageMaker.endPage+1 }">Next</a></li>
								</c:if>
								</ul>
							</div>
						 <form id="pageForm" action="/qa/modify" method="get">
							<input type="hidden" name="pageNum"value="${pageMaker.cri.pageNum }"> 
							<input type="hidden"name="amount" value="${pageMaker.cri.amount }">
							<input type="hidden" name="type" value="${pageMaker.cri.type }"> 
							<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
							<input type="hidden" name="memberNum" value="<%=memberDTO.getMemberNum() %>">
							<input type="hidden" name="qa_id" value="${q_ID.qa_id }">
							<input type="hidden" name="prescript_no" value="${q_ID.prescript_no }">
						</form>
						</div>
						 <button type="button" class="btn" data-oper ="modify">수정</button>
						<button type="button" class="btn" data-oper ="delete">삭제</button>
					</div>
				</div>
			</div>
		</section>
							
							
							
							
	
<script type="text/javascript">
	$(document).ready(function() {
		const formObj = $("#modForm");
		
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
		
		$(".btn").on("click", function(e) {
			e.preventDefault(); 
			const operation = $(this).data("oper");
			let url = "";
			let method = "";
			
			switch(operation){
			case "list":
				url = "/qa/list";
				method = "get";
				break;
			case "modify":	
			       let inputPrescriptNo = $("input[name='prescript_no']").val();
		            let isValid = false;    
		            
		            $(".user_prescript_no").each(function() {
		                if (inputPrescriptNo == $(this).text() || inputPrescriptNo === "") {
		                	console.log("여기에들어가니"+inputPrescriptNo);
		                    isValid = true;
		                }
		            });

		            if (!isValid) {
		                alert("본인의 처방전 번호만 입력할 수 있습니다.");
		                return;
		            }
					console.log("inputPrescriptNo"+inputPrescriptNo);
					
		            url = "/qa/modify?qa_id=${q_ID.qa_id}";
		            method = "post";
		            break;
		            
				case "delete":
				if (!confirm("정말 삭제하시겠습니까?")) {
					return;
				}else{
					url = "/qa/remove?qa_id=${q_ID.qa_id}";
					method = "post";
					alert("게시글이 삭제되었습니다");
					break;
				}
				
			default:
				return;
			}
			
			formObj.attr("action",url).attr("method",method).submit();
		});
	});
</script>
<%@include file="../include/footer.jsp"%>