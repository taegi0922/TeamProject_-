<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<style>
table tr input{
	float:left;
 margin-bottom: 10px;
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
    if (memberType != MemberType.ADMIN) {
%>
    <script>
        alert("작성권한이 없습니다");
        window.location.href = "notice"; // 로그인 페이지로 리디렉션
    </script>
<%
        return;
    }
%>	


	<section class="Feautes section">
			<div class="container">
				
				<div class="row">
					<div class="col-lg-10" id="mediSerchSection">
						<div class="table-container">
							<h3>공지사항 작성</h3>
								<div>
									<form method="post" action="/insertnotice" enctype="multipart/form-data">
										<table>
											<caption>
												<strong><span>*</span> 표시는 필수입력 항목입니다.</strong>
											</caption>
											<tbody>
												<tr >
													<th>제목<span>*</span></th>
													<td><input  name="noticetitle" value=""  required/></td>
												</tr>
												<tr>
													<th>작성자<span>*</span></th>
													<td><input name="writerName" value="" required/></td>
												</tr>
												<tr>
													<th>내용<span>*</span></th>
													<td><textarea  name="noticecontent"
															cols="30" rows="10" class="textarea01" required></textarea></td>
												</tr>
												 <tr>
							                            <th>파일 선택:<span>*</span></th>
							                            <td><input type="file" name="file" id="file"></td>
							                        </tr>
											</tbody>
										</table>
										<div class="btn_right mt15">
											<button type="button" class="btn"><a href="/notice">목록으로</a></button>
											<button type="submit" class="btn">등록하기</button>			
										</div>
							
									</form>
							
								</div>
							
						</div>
					</div>
				</div>
			</div>
		</section>
		
	


<%@include file="include/footer.jsp"%>