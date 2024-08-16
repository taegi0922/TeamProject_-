<%@page import="com.medicalInfo.project.model.MemberType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>

<style>
.best-experts {
    display: flex;
    justify-content: center;
    padding: 20px;
}

.expert {
    border: 1px solid #ddd;
    padding: 20px;
    border-radius: 8px;
    width: 30%;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    text-align: center;
    margin: 0 10px; /* 중앙 정렬을 위해 간격 추가 */
    position: relative; /* 메달 이미지를 위한 상대 위치 설정 */
}

.expert img.medal {
    position: absolute;
    top: 10px; /* 상단에서의 위치 조정 */
    left: 10px; /* 왼쪽에서의 위치 조정 */
    width: 50px; /* 메달 이미지 크기 조정 */
    height: auto;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    font-weight: bold;
}

.form-group input {
    width: 100%;
    padding: 8px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 4px;
    text-align: center;
}

h3 {
    color: #333;
}

.expert-img {
	width: 50px; /* Set the width to 50px */
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
MemberType memberType = (MemberType) session.getAttribute("membertype");
if (memberType == null) {
%>
<script type="text/javascript">
    alert("로그인 해주세요");
    window.location.href = "http://localhost:8090/login";
</script>
<%
}
%>
<h1 style="text-align: center;">실시간 전문가 BEST 3</h1>
<div class="best-experts">

    <div class="expert">
        <c:choose>
            <c:when test="${empty ratingTwoName.memberName}">
                <img src="../resources/img/bestexpert2.png">
            </c:when>
            <c:otherwise>
                <img src="../resources/img/bestRating_second.png" class="medal">
                <div>
                    <img src="http://localhost:8090/download2?fileName=<c:out value="${memberInfoTwo.picuniName}"/>&originalFileName=<c:out value="${memberInfoTwo.pictureName}"/>&fileType=<c:out value="${memberInfoTwo.picType}"/>" width="200px" />
                </div>
                <div class="form-group">
                    <label>이름</label><br> <input readonly="readonly"
                        value='<c:out value="${ratingTwoName.memberName}"/>'>
                </div>
                <div class="form-group">
                    <label>평균 평점</label><br> <input readonly="readonly"
                        value='<c:out value="${ratingTwo.rate }"/>'>
                </div>
                <div class="form-group">
                    <label>병원 이름</label><br> <input readonly="readonly"
                        value='<c:out value="${memberInfoTwo.institutionName }"/>'>
                </div>
                <div class="form-group">
                    <label>병원 주소</label><br> <input readonly="readonly"
                        value='<c:out value="${memberInfoTwo.institutionAddress }"/>'>
                </div>
                <div class="form-group">
                    <label>병원 번호</label><br> <input readonly="readonly"
                        value='<c:out value="${memberInfoTwo.institutionTel }"/>'>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="expert">
        <c:choose>
            <c:when test="${empty ratingName.memberName}">
                <img src="../resources/img/bestexpert1.png" >
            </c:when>
            <c:otherwise>
                <img src="../resources/img/bestRating_first.png" class="medal">
                <div>
                    <img src="http://localhost:8090/download2?fileName=<c:out value="${memberInfo.picuniName}"/>&originalFileName=<c:out value="${memberInfo.pictureName}"/>&fileType=<c:out value="${memberInfo.picType}"/>" width="200px" />
                </div>
                <div class="form-group">
                    <label>이름</label><br> <input readonly="readonly" name="name"
                        value='<c:out value="${ratingName.memberName}"/>'>
                </div>
                <div class="form-group">
                    <label>평균 평점</label><br> <input readonly="readonly"
                        name="rating" value='<c:out value="${rating.rate }"/>'>
                </div>
                <div class="form-group">
                    <label>병원 이름</label><br> <input readonly="readonly"
                        name="institutionName"
                        value='<c:out value="${memberInfo.institutionName }"/>'>
                </div>
                <div class="form-group">
                    <label>병원 주소</label><br> <input readonly="readonly"
                        name="institutionAddress"
                        value='<c:out value="${memberInfo.institutionAddress }"/>'>
                </div>
                <div class="form-group">
                    <label>병원 번호</label><br> <input readonly="readonly"
                        name="institutionTel"
                        value='<c:out value="${memberInfo.institutionTel }"/>'>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="expert">
        <c:choose>
            <c:when test="${empty ratingThreeName.memberName}">
                <img src="../resources/img/bestexpert3.png" >
            </c:when>
            <c:otherwise>
                <img src="../resources/img/bestRating_third.png" class="medal">
                <div>
                    <img src="http://localhost:8090/download2?fileName=<c:out value="${memberInfoThree.picuniName}"/>&originalFileName=<c:out value="${memberInfoThree.pictureName}"/>&fileType=<c:out value="${memberInfoThree.picType}"/>" width="200px" />
                </div>
                <div class="form-group">
                    <label>이름</label><br> <input readonly="readonly"
                        value='<c:out value="${ratingThreeName.memberName}"/>'>
                </div>
                <div class="form-group">
                    <label>평균 평점</label><br> <input readonly="readonly"
                        value='<c:out value="${ratingThree.rate }"/>'>
                </div>
                <div class="form-group">
                    <label>병원 이름</label><br> <input readonly="readonly"
                        value='<c:out value="${memberInfoThree.institutionName }"/>'>
                </div>
                <div class="form-group">
                    <label>병원 주소</label><br> <input readonly="readonly"
                        value='<c:out value="${memberInfoThree.institutionAddress }"/>'>
                </div>
                <div class="form-group">
                    <label>병원 번호</label><br> <input readonly="readonly"
                        value='<c:out value="${memberInfoThree.institutionTel }"/>'>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-10" id="mediSerchSection">
						<div class="table-container">
							<h3>전문가 검색</h3>
							<div class="qa-serch">
								<div>
									<form id="searchForm" action="/bestRating" method="get">
										<select id="searchType" name="type">
											<option value="all" ${pageMaker.cri.type == "all"? "selected":"" }>All</option>
								            <option value="name" ${pageMaker.cri.type == "name"? "selected":"" }>이름</option>
								            <option value="institution" ${pageMaker.cri.type == "institution"? "selected":"" }>병원</option>
								        </select>
								        <div id="serchInput">
								        	<input type="search" name="keyword" value="${pageMaker.cri.keyword }">
									        <button type="submit"><i class="fa fa-search"></i></button>
									    </div>
							    	</form>
							    </div>
								
							</div>
							<div class="card mb-4"> 
								<form class="form" action="#">
									<table id="QaTable">
										  <thead>	
										 	<tr>
											 	<th>번호</th>
												<td>이미지</td>
												<td>전문가 이름</td>
												<td>평균 평점</td>
												<td>병원 이름</td>
												<td>병원 주소</td>
												<td>병원 번호</td>
										 	</tr>
									    </thead>
										<tbody></tbody>	
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
							
							<form id="pageForm" action="/bestRating" method="get">
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
	
	var number = 1;
	loadTable();
	
	function loadTable(){
		$.ajax({
			url :"/getRate",
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
				
				
				$.each(data, function(index, rateTot) {		
					var row = $("<tr>");
					row.append($("<td>").text(number++)); 
					
					var expertImg = $("<img>").attr("src", "http://localhost:8090/download2?fileName="+rateTot.picuniName+"&originalFileName="+rateTot.pictureName+"&fileType="+rateTot.picType);
					var imgId = $("<td>").append(expertImg);
					expertImg.addClass("expert-img");
					row.append(imgId);
					
					var expertName = $("<td>").text(rateTot.memberName);
					row.append(expertName); 
					
					var averageRate = $("<td>").text(rateTot.averageRate);
					row.append(averageRate);
					
					var institutionName = $("<td>").text(rateTot.institutionName);
					row.append(institutionName);
					
					var institutionAddress = $("<td>").text(rateTot.institutionAddress);
					row.append(institutionAddress);
					
					var institutionTel = $("<td>").text(rateTot.institutionTel);
					row.append(institutionTel);
					
				
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

<%@include file="include/footer.jsp"%>