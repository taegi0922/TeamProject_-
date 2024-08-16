<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style type="text/css">
table,th,td{
	border: 1px solid black;
}

</style>
</head>



<body>
	<h1>약 목록</h1>
	<input type="text" id="searchInput" placeholder="아이템 번호">
	<button onclick="ajaxTest()">검색 </button>


	<table id ="resultTestApi"></table>
	
	<a href="mypharm">마이팜</a>
<script type="text/javascript">
function ajaxTest() {
    let find = $("#searchInput").val();
    console.log("이거 값 뭐임?" + find);
    $.ajax({
        url: "medsearch",
        type: "get",
        contentType: "application/json; charset=utf-8;",
        dataType: "json",
        data: { "search": find },
        success: function(data) {
        	 $('#resultTestApi').empty();
            console.log(data.body.items[0]);
			
            row = $("<tr>");
            $.each(data.body.items[0], function(key, value) {
                row.append($("<th>").text(key));
            })
            row.append($("<th>"))
            $('#resultTestApi').append(row);
            $.each(data.body.items, function(index, item) {
                var tr = $("<tr>");
                $.each(item, function(key, value) {
                    //console.log(key);
                    if (item == null) {
                        tr.append($("<td>").text("검색한 약이 없습니다."));
                    } else {
                    	if(key=="itemImage"){
                    		tr.append($("<td>").append($("<img>").attr("src", value)));
                    	}else{
                        	tr.append($("<td>").text(value));
                    	}
                    }
                });
                // 데이터베이스에 저장할 값을 버튼의 data-* 속성에 포함하여 전송
                tr.append($("<td>").html("<button class='addPharm' data-item-id='"+item.id+"'>등록</button>"));
                $('#resultTestApi').append(tr);
            });

            // 클릭 이벤트 처리
             // 버튼 클릭 이벤트 핸들러 추가
            $(".addPharm").on("click", function() {
                let currentRow = $(this).closest("tr");
                let rowData = [];
                currentRow.find("td").each(function() {
                    rowData.push($(this).text());
                });
                console.log("Row Data: ", rowData);
                console.log("Row Data:0 ", rowData[0]);
                self.location="http://localhost:8090/addmedi?entpName="+rowData[0]+"&itemName="+rowData[1]+"&itemSeq="+rowData[2];
        /*         $.ajax({
                    url: "/addmedi",
                    type: "POST",
                    contentType: "application/json; charset=utf-8;",
                    data: JSON.stringify({
                        entpName: rowData[0],
                        itemName: rowData[1],
                        itemSeq: rowData[2]
                    }),
                    success: function(response) {
                    	
                    	String redirectUrl = "localhost:8090/addmedi";
                    	localStorage.setItem("resultValue", response.resultValue);
                    	window.location.href = response.redirectUrl; // Redirect to /addmedi after successful AJAX call
                    }
                }); */
                
            });
            
            
           
        },
        error: function() {
            // 에러 처리
        }
    });
}

</script>
</body>
</html>