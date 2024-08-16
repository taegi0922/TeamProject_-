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

#rateform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#rateform fieldset legend{
    text-align: right;
}
#rateform input[type=radio]{
    display: none;
}
#rateform label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#rateform label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#rateform label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#rateform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewContents {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
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
							<h3>마이처방전 상세</h3>
							<br/>
							<div id="myPreSerchBtn">
							<button type="button" class="myPre-btn"><a href="/mypage/patientMypage">처방전 목록</a></button>
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
							
							<br/>
							<br/>
							<br/>
							<h5 id="myPreRatingTitle"><strong>처방전을 내려준 전문의에게 별점을 남겨주세요!</strong></h5>
							<br/>
							<div class="mb-3" name="rateform" id="rateform">
								<fieldset>
									<span class="text-bold">별점을 선택해주세요</span>
									<br/>
									<input type="radio" name="rate" value="5" id="rate1"><label for="rate1">★</label>
									<input type="radio" name="rate" value="4" id="rate2"><label for="rate2">★</label>
									<input type="radio" name="rate" value="3" id="rate3"><label for="rate3">★</label>
									<input type="radio" name="rate" value="2" id="rate4"><label for="rate4">★</label>
									<input type="radio" name="rate" value="1" id="rate5"><label for="rate5">★</label>
								</fieldset>
								<br/><br/>
								<div id="subRating">
									<button type="button" id="submitRating" class="myPre-btn">별점 제출</button>
								</div>
							</div>	
							
							
							<hr/>
							<c:if test="${empty commentlist}">
								<div style="width: 100px, text-align:center">
									<form method="post" action="/mypage/write">
										<input type="hidden" name="writer"  value="${dto.memberNum }" >
								        <input type="hidden" name="table_type" value="PRESCRIPT" >
								        <input type="hidden" name="prescript_no" value="${dto.prescript_no }" >
								        <input type="hidden" name="writerName" value="${dto.patient_name }" >
								        
								        <textarea class="col-auto form-control" name="content" id="reviewContents" 
								        placeholder="처방전에 대한 평가를 남겨주세요!" required="required"></textarea>
								        <br/>
								        <button type="submit" id="btnCommentWrite" class="myPre-btn">댓글 작성</button>
								    </form>
								</div>
							</c:if>
							
							<p/>
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
															<p>작성자: ${commentsdto.writerName } 작성일자: [<fmt:formatDate pattern="yyyy-MM-dd-HH:mm:ss" 
															value="${commentsdto.created_at }"/>]</p>
														</c:when>
														<c:otherwise>
															<h2>의사 Comment</h2>
															<br/>
															<p>작성자: ${commentsdto.writerName }</p>
														</c:otherwise>
													</c:choose>
													<strong> -> ${commentsdto.content }</strong>
													<br/>
													<br/>
													<c:if test="${commentsdto.writer eq dto.memberNum }">
														<button type="button" class="myPre-btn" id="btnCommentModify">
															<a href='/mypage/prescriptDetailModify?prescript_no=<c:out value="${commentsdto.prescript_no }"/>&comment_id=<c:out value="${commentsdto.comment_id }"/>#modifyContent'>수정</a>
														</button>
														<input type="hidden" name="comment_id" value="${commentsdto.comment_id }" >
														<input type="hidden" name="writer" value="${dto.memberNum }" >
												        <input type="hidden" name="table_type" value="PRESCRIPT" >
												        <input type="hidden" name="prescript_no" value="${dto.prescript_no }" >
												        <input type="hidden" name="writerName" value="${dto.patient_name }" >
														<button type="submit" class="myPre-btn" id="btnCommentDelete">삭제</button>
													</c:if>
													</p>
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


<script type="text/javascript">
	$(document).ready(function() {
		
		$('#btnCommentWrite').on('click', function(){
			alert("댓글이 작성되었습니다.");
		});
	
		
		$('#btnCommentDelete').on('click', function(){
			alert("댓글이 삭제되었습니다.");
		});
		
		
	    $('#submitRating').click(function() {
	        var selectedStar = $('input[name="rate"]:checked').val();
	        const membernum ="<%= memberDTO2.getMemberNum() %>";
	        const memberType = "<%= memberType2 %>";
	        const prescript_no = ${dto.prescript_no};
	        const expertnum = ${dto.memberNum_expert};
	        
	        console.log("selectedStar :"+selectedStar);
	        console.log("membernum :"+membernum);
	        console.log("memberType :"+memberType);
	        console.log("prescript_no :"+prescript_no);
	        console.log("expertnum :"+expertnum);
 
	        if (selectedStar) {
	            $.ajax({
	                type: 'post',
	                url: '/mypage/addRate',
	                data: { rate: selectedStar,
	                		memberNum: membernum,
	                		ratedtable_type:'PRESCIRPT',
	                		membertype: memberType,
	                		ratedtprescript_no:prescript_no,
	                		expertNum: expertnum,
	                		expertype:"EXPERT"
	                },
	                dataType : "json",
	                success : function(response) {
	                	if(response == true){
	                		 alert('평점이 제출되었습니다.');
		    	            location.href = "/mypage/prescriptDetail?prescript_no="+prescript_no+"&memberNum="+membernum;
	                	}else if(response == false){
	                		 alert('이미 한번 평점줬음.');
	                	}
	                },
					error : function(e) {
						console.log("실패");
						console.log(e);
					}
	            });                       
	        } else {
	            alert('별점을 선택해주세요.');
	        }
	    });
	});
</script>
		
<%@include file="../include/footer.jsp"%>