<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<!-- End Header Area -->

<%
Boolean isLogin = (Boolean) session.getAttribute("isLogin");
memberDTO = (MemberDTO) session.getAttribute("member_info");
 membertype = (MemberType) session.getAttribute("membertype");
 System.out.println("isLogin 이거찍힘?" + isLogin);
 System.out.println("memberDTO 이거찍힘?" + memberDTO);
 System.out.println("membertype 이거찍힘?" + membertype);

 if (isLogin == null || !isLogin || memberDTO == null || membertype == null) {
     System.out.println("if문에 들어오니 이거찍힘?");
 %>
 <script type="text/javascript">
     alert("로그인 후 이용해주세요");
     window.location.href = "http://localhost:8090/login"; // 로그인 페이지로 리디렉션
 </script>
 <%
     return; // 더 이상의 처리를 중단
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
							<h3>QA 게시판</h3>
							<div class="qa-serch">
								<div>
									<form id="searchForm" action="/qa/list" method="get">
										<select id="searchType" name="type">
											<option value="all" ${pageMaker.cri.type == "all"? "selected":"" }>All</option>
								            <option value="title" ${pageMaker.cri.type == "title"? "selected":"" }>제목</option>
								            <option value="writer" ${pageMaker.cri.type == "writer"? "selected":"" }>작성자</option>
								            <option value="context" ${pageMaker.cri.type == "context"? "selected":"" }>내용</option>
								        </select>
								        <div id="serchInput">
								        	<input type="search" name="keyword" value="${pageMaker.cri.keyword }">
									        <button type="submit"><i class="fa fa-search"></i></button>
									    </div>
							    	</form>
							    </div>
								<div id="serchBtn">
									<button type="button" class="qa-btn" id="regBtn">글쓰기</button>
								</div>
							</div>
							<div class="card mb-4"> 
								<form class="form" action="#">
									<table id="QaTable">
										  <thead>	
										 	<tr>
											 	<th>번호</th>
												<th>작성날짜</th>
												<th>제목</th>
												<th>작성자</th>
												<th>조회수</th>
										 	</tr>
									    </thead>
										<tbody>
										</tbody>	
									</table>
								</form>
							</div>
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
							
							<form id="pageForm" action="/qa/list" method="get">
									<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
									<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
									<input type="hidden" name="type" value="${pageMaker.cri.type }">
									<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
							</form>
						</div>
					</div>	
				</div>
			</div>
		</section>

		

<script type="text/javascript">
$(document).ready(function(){
	
	$('.banner-close').click(function() {
		$(this).parent().hide();
	});
	
	var userNum ="<%=memberDTO.getMemberNum()%>";
	var number = 1;
	loadTable();
	var memberNum = '<%= memberDTO.getMemberNum() %>';
	console.log(<%=memberDTO.getMemberNum() %>);
	
	$("#regBtn").click(function() {
		window.location = "/qa/register?memberNum="+memberNum;
	});
	
	function loadTable(){
		$.ajax({
			url :"/qa/getList",
			type : "POST",
			data: {		   
				pageNum: $("#pageForm").find("input[name='pageNum']").val(),
				amount: $("#pageForm").find("input[name='amount']").val(),
				type: $("#searchType").val(),
				keyword: $("#searchForm").find("input[type='search']").val()
				  },
			dataType : "json",
			success: function(data) {			
				var qaTbody = $("#QaTable tbody");
				qaTbody.empty(); 
				$.each(data, function(index, qadto) {		
					var row = $("<tr>");
					row.append($("<td>").text(qadto.qa_id)); 
					var parseDate = new Date(qadto.created_at); // DB에 저장된 등록 날짜를 Date객체로 변환
					// numeric : (2024, 7), 2-digit : (24, 07) 
					var options = {year:"numeric", month:"2-digit", day:"2-digit", hour:"2-digit", minute:"2-digit"};
					var formmattedDate = parseDate.toLocaleString("ko-KR",options); // 날짜 형식을 한국 시간 형식과 지정 옵션으로 변환
					
					var dateLink = $("<a>").attr("href", "http://localhost:8090/qa/get?qa_id="+qadto.qa_id+"&prescript_no="+qadto.prescript_no+"&memberNum="+userNum).text(formmattedDate);
					var dateId = $("<td>").append(dateLink);
					row.append(dateId); 
					
					
					var titleLink = $("<a>").attr("href", "http://localhost:8090/qa/get?qa_id="+qadto.qa_id+"&prescript_no="+qadto.prescript_no+"&memberNum="+userNum).text(qadto.title);
					var titleId = $("<td>").append(titleLink); 
					row.append(titleId); 
					
					
					var writerLink = $("<a>").attr("href", "http://localhost:8090/qa/get?qa_id="+qadto.qa_id+"&prescript_no="+qadto.prescript_no+"&memberNum="+userNum).text(qadto.writer);
					var writerId = $("<td>").append(writerLink);
					row.append(writerId);
					
					row.append($("<td>").text(qadto.viewcnt));
				
					qaTbody.append(row); // 생성한 tr요소를 테이블 본문에 추가
					number++;
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