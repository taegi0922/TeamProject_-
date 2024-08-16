<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
		<!-- End Header Area -->
		

	
	
		<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-10" id="mediSerchSection">
						<div class="table-container">
							<h3>약 설명</h3>
							<div class="card mb-4">
								<div class="table-container">
									<table id="datatablesSimple">
										<thead>
											<tr>
											
												<th>회사명</th>
												<th>제품명</th>
												<th>품목 일련번호</th>
												<th>제품 이미지</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${medicine[0].body.items[0].entpName}</td>
												<td>${medicine[0].body.items[0].itemName}</td>
												<td>${medicine[0].body.items[0].itemSeq}</td>
												<td><img src="${medicine[0].body.items[0].itemImage}" alt="제품 이미지" style="width:100px;height:100px;"/></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="medi-tab">
					  <ul class="tabs">
					    <li class="tab-link current" data-tab="tab-1">효능 질문</li>
					    <li class="tab-link" data-tab="tab-2">사용 방법 질문</li>
					    <li class="tab-link" data-tab="tab-3">주의 사항 질문</li>
					    <li class="tab-link" data-tab="tab-4">주의 질문</li>
					    <li class="tab-link" data-tab="tab-5">상호 작용 질문</li>
					    <li class="tab-link" data-tab="tab-6">부작용 질문</li>
					    <li class="tab-link" data-tab="tab-7">보관 방법 질문</li>
					  </ul>
					
					  <div id="tab-1" class="tab-content current">${medicine[0].body.items[0].efcyQesitm}</div>
					  <div id="tab-2" class="tab-content">${medicine[0].body.items[0].useMethodQesitm}</div>
					  <div id="tab-3" class="tab-content">${medicine[0].body.items[0].atpnWarnQesitm}</div>
					  <div id="tab-4" class="tab-content">${medicine[0].body.items[0].atpnQesitm}</div>
					  <div id="tab-5" class="tab-content">${medicine[0].body.items[0].intrcQesitm}</div>
					  <div id="tab-6" class="tab-content">${medicine[0].body.items[0].seQesitm}</div>
					  <div id="tab-7" class="tab-content">${medicine[0].body.items[0].depositMethodQesitm}</div>
					
					</div> 
				</div>
			</div>
		</section>
	

		<!-- Slider Area -->
<script type="text/javascript">
	$(document).ready(function(){
	  
	  $('ul.tabs li').click(function(){
	    var tab_id = $(this).attr('data-tab');

	    $('ul.tabs li').removeClass('current');
	    $('.tab-content').removeClass('current');

	    $(this).addClass('current');
	    $("#"+tab_id).addClass('current');
	  })

	});
</script>
		
<%@include file="include/footer.jsp"%>