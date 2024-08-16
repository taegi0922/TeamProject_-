<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<% 
MemberType memtype = (MemberType)session.getAttribute("membertype");
%>
<style>
.hidden{
	display: none;
}


.notice-list {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
}

.notice-item {
	width: 48%;
	margin-bottom: 20px;
	background-color: #f9f9f9;
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	overflow: hidden;
}

.notice-item img {
	width: 100%;
	height: 300px;
}

.notice-item-content {
	padding: 10px;
}

.notice-item-content h3 {
	margin: 10px 0;
	font-size: 18px;
	color: #333;
}

.notice-item-content p {
	margin: 5px 0;
	color: #666;
	font-size: 14px;
}

.pageBtn {
	text-align: center;
	margin-top: 20px;
}

.pageBtn .pagination {
	display: inline-block;
}

.pageBtn .pagination li {
	display: inline;
	margin: 0 5px;
}

.pageBtn .pagination li a {
	text-decoration: none;
	color: #333;
	padding: 5px 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.pageBtn .pagination li a.active {
	background-color: #333;
	color: white;
}
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
							<h3>공지사항</h3>
							<div>
								<div class="notice-list">
									<c:forEach items="${allnotice}" var="notice">
										<div class="notice-item">
											<img src="http://localhost:8090/NoticeDownload?fileName=<c:out value='${notice.uniqueName}' />&originalFileName=<c:out value='${notice.fileName}' />&fileType=<c:out value='${notice.fileType}' />" />
											<div class="notice-item-content">
												<h3><a href="/noticedetail?id_announcement=${notice.id_announcement}&memberType=<%=memtype %>">${notice.title}</a></h3>
												<p><fmt:formatDate value="${notice.created_at}" pattern="yyyy.MM.dd"/></p>
											</div>
										</div>
									</c:forEach>
								</div>
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
											<a href="${num}">${num}</a>
										</li>
									</c:forEach>
									<c:if test="${pageMaker.next }">
										<li class="paginate_button next">
											<a href="${pageMaker.endPage + 1 }">Next</a>
										</li>
									</c:if>
								</ul>
							</div>
							
							<form id="pageForm" action="/notice" method="get">
								<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
								<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
								<input type="hidden" name="type" value="${pageMaker.cri.type }">
								<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
							</form>
							    <% if (memtype != null && memtype == MemberType.ADMIN) { %>
							       <div>
							     <br>
								<button type="button" class="btn">
									<a href="/noticewrite">작성</a>
								</button>
							</div>
							    <% } %>
							
						</div>
					</div>
				</div>
			</div>
		</section>
							
							



<script>
	let pageForm = $("#pageForm");

	$(".paginate_button a").on("click", function(e) {
		// a태그의 기본 기능인 링크를 삭제 
		e.preventDefault();
		// pageNum 값을 사용자가 클릭한 a 태그의 href 속성값으로 변경
		pageForm.find("input[name='pageNum']").val($(this).attr("href"));
		pageForm.submit();
	});
</script>

<%@include file="include/footer.jsp"%>