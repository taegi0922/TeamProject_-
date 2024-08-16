=<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
		<!-- End Header Area -->

		<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-10" id="mediSerchSection">
						<div class="table-container">
							<h3>약 목록</h3>
							<div id="mediSerchTitle">
								<input type="text" id="searchInput" placeholder="약이름">
								<button class="serch-btn" onclick="ajaxTest()">검색</button>
							</div>
							<div class="card mb-4">
								<div class="table-container">
									<table id="datatablesSimple" class ="resultTestApi">
										<thead>
											<tr>
												<th>회사명</th>
												<th>약품코드</th>
												<th>약품명</th>
												<th>약품 이미지</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${mediApi}" var="medis">
												<c:forEach items="${medis.body.items}" var="medi">
													<tr>
														<td data-th='회사명'>${medi.entpName}</td>
														<td data-th='약품코드'>${medi.itemSeq}</td>
														<td data-th='약품명'><a href="/medidetail?itemSeq=${medi.itemSeq}">${medi.itemName}</a></td>
														<td data-th='약품 이미지'>
														    <img src="${medi.itemImage != null && !medi.itemImage.isEmpty() ? medi.itemImage : '../../resources/img/noimage.png'}" style="width: 100px; height: auto;">
														</td>
													</tr>
												</c:forEach>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>


<!-- /End Newsletter Area -->
<script type="text/javascript">
function ajaxTest() {
    let find = $("#searchInput").val();
    console.log("검색어: " + find);

    $.ajax({
        url: "ajaxTest",
        type: "post",
        dataType: "json",
        data: { "search": find },
        success: function(data) {
            // 결과 테이블을 비웁니다.
            $('.resultTestApi tbody').empty();
            $.each(data, function(index, response) {
                $.each(response.body.items, function(idx, item) {
                    // 새로운 행 생성
                    var tr = $("<tr>");
                    // 각 항목을 셀로 추가
                    tr.append($("<td data-th='회사명'>").text(item.entpName));
                    tr.append($("<td data-th='약품코드'>").text(item.itemSeq));
                    tr.append($("<td data-th='약품명'>").html("<a href='/medidetail?itemSeq=" + item.itemSeq + "'>" + item.itemName + "</a>"));
                    var itemImage = item.itemImage != null &&  item.iatemImage !="" ? item.itemImage : "../../resources/img/noimage.png";
                    tr.append($("<td data-th='약품 이미지'>").html("<img src='" + itemImage + "' alt='약품 이미지' style='width: 100px; height:auto;'>"));
                    // 행을 테이블에 추가
                    $('.resultTestApi tbody').append(tr);
                });
            });
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", status, error);
        }
    });
}
</script>
		
<%@include file="include/footer.jsp"%>