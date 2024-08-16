<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
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
<div>
	<h2>공지사항 수정</h2>
<form action="modnotice" method="post">
	<table>
		<tbody>
			<tr>
				<th>No</th>
				<td><input name="id_announcement" readonly="readonly" value="${notice.id_announcement}"></td>
				<th>제목</th>
				<td><input name="title" value="${notice.title}"></td>
				<th>게시자</th>
				<td>${notice.writerName}</td>
				<th>게시일</th>
				<td>${notice.created_at}</td>
			</tr>
			<tr>
				<td colspan="8"><input name="content" value="${notice.content}"></td>
			</tr>
		</tbody>
	</table>
	<div class="btn_right mt15">
		<button type="button"><a href="/notice">목록으로</a></button>
		<button type="submit">수정하기</button>		
		<%-- <button type="button"><a href="/deletenotice?id_announcement=${notice.id_announcement}">
			삭제하기</a></button> --%>
		<input type="button" value="삭제하기" id="delete">
 	</div>
 		<script>
    		document.getElementById('delete').addEventListener('click', function() {
        	let result = confirm("게시글을 삭제하시겠습니까?");
        	if (result) {
            	window.location.href = "/deletenotice?id_announcement=${notice.id_announcement}";
       		}
    	});
		</script>
	
	</form>
	

</div>
<%@include file="include/footer.jsp"%>
