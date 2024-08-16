<%@page import="com.medicalInfo.project.model.QaDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

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
MemberDTO dto = (MemberDTO)session.getAttribute("member_info");
MemberType memtype = (MemberType)session.getAttribute("membertype");

QaDTO qaDTO = (QaDTO) request.getAttribute("q_ID");
 Integer qaDtoMemberNum = qaDTO.getMember_num();
 
 if (dto == null) {
	 %>
	     <script type="text/javascript">
	         alert("로그인이 필요합니다.");
	         window.location.href = "http://localhost:8090/member/login";
	     </script>
	 <%
	 }else if (dto.getMemberNum() != qaDTO.getMember_num()) {
		 if(membertype==MemberType.EXPERT){
			 
		 }else{
	 %>
	     <script type="text/javascript">
	         alert("권한이 없습니다.");
	         window.location.href = "http://localhost:8090/qa/list";
	     </script>
	 <%
		 }
	 }
	 %>
	 
	 	<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-10" id="mediSerchSection">
						<div class="table-container">
							<h3>QA 게시판</h3>
							<div class="card mb-4">
								<div class="qa-title">
									<span id="span1"><b>제목 </b>${q_ID.title }</span>
									<span id="span2"><b>작성자 </b>${q_ID.writer }</span>
									<span id="span3"><b>작성일 </b><fmt:formatDate pattern = "yyyy-MM-dd hh:mm" value="${q_ID.created_at }"/></span>
									
									<span id="span4"><b>조회 </b>${q_ID.viewcnt }</span>
								</div>
								<div class="qa-content">
									<p>${q_ID.context }</p>
								</div>
							</div>
							<c:choose> 
							  	<c:when test="${q_ID.prescript_no ==0 }">
							   	</c:when>
							   	<c:otherwise>
							   		
							   		<h5 id="qaPrescriptTitle">마이처방전 내역</h5>
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
									<c:choose> 
									  	<c:when test="${empty prescriptDetailDTO }">
									   	</c:when>
									   	<c:otherwise>
											<div class="card mb-4">
												<table class="medicine-table">
													<thead>
														<tr>
															<th>약품명</th>
															<th>투약 횟수</th>
															<th>처방 일수</th>
															<th>변동 사항</th>
															<th>변동 사항 설명</th>
														</tr>
													</thead>
													<tbody>
													   <c:forEach items="${prescriptDetailDTO}" var="prescriptDetail">
													   	<tr>
													   		<td data-th='약품명'><c:out value="${prescriptDetail.medicine_name}"/></td>
													   		<td data-th='투약 횟수'><c:out value="${prescriptDetail.per_day}"/></td>
													   		<td data-th='처방 일수'><c:out value="${prescriptDetail.total_day}"/></td>
													   		<td data-th='변동 사항'><c:out value="${prescriptDetail.addordrop}"/></td>
													   		<td data-th='변동 사항 설명'><c:out value="${prescriptDetail.detail_comment}"/></td>
													   	<tr> 
													   	</c:forEach>
													</tbody>  	
												</table>
											</div>
										</c:otherwise>
									</c:choose>
							   	</c:otherwise>
							</c:choose>
							
		
							
							<div class="form-group">
								<div class="button">
								  <button id="list" class="btn"  type="button">돌아가기</button>
				      			  <button id="modify" class="btn" type="button">수정 하기</button>
								</div>
							</div>
							<br/>
							<br/>
						    <h4 id="qaComentTitle">댓글</h4>
						    <br/>
						     <table id="qaComment">
						     	<tbody>
								<c:forEach items="${commDTO}" var="com">
									<tr>
										<td class="user-name" data-membertype="${com.memberType }" data-expertnum="${com.writer}"><c:out value="${com.writerName}"/></td>
										<td><input type="text" value="<c:out value="${com.content}"/>" readonly="readonly"></td>
										<td><fmt:formatDate pattern = "yyyy-MM-dd hh:mm" value="${com.created_at}"/></td>
										
										<td> <input class="user-comid" type="hidden" name="comid"  value="${com.comment_id}" ></td>
										<td ><button class="modMode" id="qa-btn"> 댓글 수정 </button></td>
										<td ><button class="DeleteMode" id="qa-btn">댓글 삭제</button></td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							<br/>
						    <form method="post" action="/qa/write" id="qaCommentWrite">
						         <input type="hidden" name="writer"  value="<%= dto.getMemberNum() %>" >
						         <input type="hidden" name="memberPhone"  value="${q_ID.member_num}">
						         <input type="hidden" name="title"  value="${q_ID.title }">
						         <input type="hidden" name="table_type" value="QA" >
						         <input type="hidden" name="qa_no" value="${q_ID.qa_id}" >
						         <input type="hidden" name="writerName" value="<%= dto.getMemberName() %>" >
						         <input type="hidden" name="memberType" value="<%= memtype %>" >
						         <input type="hidden" name="prescript_no" value="${q_ID.prescript_no}" >
						         <textarea rows="5" cols="80" name="content" placeholder="댓글을 작성해 주세요!" required="required"></textarea>
						         <br/>
						         <button type="submit" id="btnCommentWrite"  class="btn">댓글 작성</button>
						    </form>
						
						
						
						
						
						
						</div>
					</div>
				</div>
			</div>
		</section>
						
<div id="userModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>전문가 평점주기</h2>
        <p>작성자: <%= dto.getMemberName() %></p>
        <div id="userInfo">
       
        </div>
        <label for="rating">평점:</label>
        <select id="rating">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select>
        <button id="submitRating" class="btn">평점 제출</button>
    </div>
</div>
    
<script type="text/javascript">
$(document).ready(function() {
    const modal = $('#userModal');
    const span = $('.close');
    let  selectedExpertNum;
 
    $('.user-name').on('click', function(e) {
    	 e.preventDefault();
    	 const myNum = "<%=dto.getMemberNum()%>";
    	 const expertType = $(this).data("membertype");
    	 selectedExpertNum =$(this).data("expertnum");
    	 console.log("selectedExpertNum<<<<"+selectedExpertNum);
    	 console.log("expertType<<<<"+expertType);
    	 if(selectedExpertNum == myNum){
    		 alert('자신한테는 평점이 불가능입니다.');
    		 	return;
    	}
    	 
    	if(expertType == "EXPERT"){	
    		modal.show();	
    	}else if(expertType == "PATIENT"){
   		 alert('환자는 평점이 불가능입니다.');
    	}   
        
    });

    span.on('click', function() {
        modal.hide();
    });

    $(window).on('click', function(e) {
        if ($(e.target).is(modal)) {
            modal.hide();
        }
    });

    $('#submitRating').on('click', function() {
    	
        const userNum = "<%=dto.getMemberNum()%>";
        const userMemType = "<%= memtype %>";
        const ratedtable_type = "QACOMMENT";
        const ratedqa_no = ${q_ID.qa_id};
        const rating = $('#rating').val();
        const expertNum = selectedExpertNum;

        console.log("userNum>>" + userNum);
        console.log("userMemType>>" + userMemType);
        console.log("ratedtable_type>>" + ratedtable_type);
        console.log("ratedqa_no>>" + ratedqa_no);
        console.log("rating>>" + rating);
        console.log("expertNum>>" + selectedExpertNum);

        $.ajax({
            url: '/qa/Rating',
            type: 'POST',
            data: {
                userNum: userNum,
                userMemType: userMemType,
                ratedtable_type: ratedtable_type,
                ratedqa_no: ratedqa_no,
                rating: rating,
                expertNum: expertNum
            },
            dataType : "json",
            success:function(response) {
            	console.log("response"+response);
                if(response == true){
                    alert('평점이 제출되었습니다.');
                    modal.hide();
                }else if(response == false){
                    alert('이미 평점완료.');
                    modal.hide();
                }
            },
            error: function() {
                alert('에러가 발생했습니다. 다시 시도해주세요.');
            }
        });
    });

    $("#modify").on("click", function() {
    	const userNum = "<%=dto.getMemberNum()%>";
    	const qaNum=${q_ID.member_num};
    	if(userNum != qaNum){
   		 alert('자기게시물만 수정가능.');
   		 window.location.href = "http://localhost:8090/qa/list";
   	}else{
           location.href = "/qa/modify?qa_id=${q_ID.qa_id}&prescript_no=${q_ID.prescript_no}&memberNum="+userNum;
   	}
    
       
    });
    
    $(".DeleteMode").on("click", function() {
    	const userNum = "<%=dto.getMemberNum()%>";
    	var expertnum = $(this).closest('tr').find('.user-name').data('expertnum');
    	var commId = $(this).closest('tr').find('.user-comid').val();
    	console.log("commId"+commId);
    	console.log("userNum"+userNum);
    	console.log("qaNexpertnumum"+expertnum);
    	if(userNum != expertnum){
    		 alert('자기댓글만 삭제가능.');
    		 window.location.href = "http://localhost:8090/qa/list";
    	}else{
    		alert("댓글이 삭제되었습니다.");
            location.href = "/qa/commRemove?comment_id="+commId+"&qa_id=${q_ID.qa_id}&prescript_no=${q_ID.prescript_no }";
    	}
    	
    });

    $("#list").on("click", function() {
        location.href = "/qa/list";
    });

	
	
    $(".modMode").on("click", function(event) {
        console.log("버튼 클릭됨");
        const $this = $(this);
        const $row = $this.closest("tr");
        const $input = $row.find("input[type='text']");
        const userNum = "<%=dto.getMemberNum()%>";
        var expertnum = $row.find('.user-name').data('expertnum');

        console.log("userNum: " + userNum);
        console.log("expertnum: " + expertnum);

        if (userNum != expertnum) {
            alert('자기댓글만 수정가능.');
            window.location.href = "http://localhost:8090/qa/list";
            return;
        }

        if ($input.prop("readonly")) {
            // Enable editing
            $input.removeAttr("readonly").focus();
            $this.text("수정 완료");
        } else {
            // Handle the update logic here, e.g., send data to the server
            const href = $row.find("a").attr("href");
        	var commId = $(this).closest('tr').find('.user-comid').val();
            const newContent = $input.val();
            console.log("commId: " + commId);
            // Example AJAX request to update the comment
            $.ajax({
                url: `/qa/commUpdate`,
                type: 'POST',
                data: {
                    comment_id: commId,
                    content:newContent
                },
                dataType : "json",
                success: function(response) {
                	console.log("AJAX 요청 성공, response:", response);
                    if (response == true) {
                        $input.attr("readonly", "readonly");
                        $this.text("댓글 수정");
                        alert("댓글이 수정되었습니다.");
                    } else if(response == false) {
                    	alert("댓글 수정에 실패했습니다.");
                    }
                },
                error: function() {
                    alert("에러가 발생했습니다. 다시 시도해주세요.");
                }
            });
        }
    });
});
</script>

<%@include file="../include/footer.jsp" %>