<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<% 
MemberType memtype = (MemberType)session.getAttribute("membertype");
%>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }
    .notice-container {
        width: 80%;
        margin: 20px auto;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }
    .notice-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .notice-header h2 {
        margin: 0;
    }
    .notice-header button {
        background-color: #1A76D1;
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
        text-decoration: none;
    }
    .notice-header button a {
        color: white;
        text-decoration: none;
    }
    .notice-table {
        width: 100%;
        margin-top: 20px;
        border-collapse: collapse;
    }
    .notice-table td {
        border: 1px solid #ddd;
        padding: 10px;
    }
    .notice-table h4 {
        margin: 0;
    }
    .btn_right {
        display: flex;
        justify-content: flex-end;
    }
    .admin_btn {
        display: flex;
        justify-content: flex-end;
        margin-top: 15px;
    }
    .admin_btn button, .admin_btn input {
        background-color: #dc3545;
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
        margin-left: 10px;
    }
</style>

<div class="notice-container">
    <div class="notice-header">
        <h2>공지사항</h2>
        <button type="button"><a href="/notice">목록</a></button>
    </div>
    <table class="notice-table">
        <tbody>
            <tr>
               
                <td> 제목 :<h4> ${notice.title}</h4></td>    
            </tr>
            <tr>
            	
                <td>작성자 : ${notice.writerName}</td>    
            </tr>
            <tr>
                <td>작성일자 : ${notice.created_at}</td>
            </tr>
            <tr>
                <td colspan="8"><textarea style="height:500px;">${notice.content}</textarea></td>
            </tr>
        </tbody>
    </table>
    <div class="btn_right mt15">
        <!-- 추가 버튼들 -->
    </div>
    <% if (memtype != null && memtype == MemberType.ADMIN) { %>
        <div class="admin_btn">
            
            <input type="button" value="삭제하기" id="delete">
        </div>
    <% } %>
</div>

<script type="text/javascript">
$(document).ready(function(){
    document.getElementById('delete').addEventListener('click',function() {
        let result = confirm("게시글을 삭제하시겠습니까?");
        if (result) {
            window.location.href = "/deletenotice?id_announcement=${notice.id_announcement}";
        }
    });
});
</script>

<%@include file="include/footer.jsp"%>
