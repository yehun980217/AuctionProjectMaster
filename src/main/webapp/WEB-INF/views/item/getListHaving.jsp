<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header2.jsp"%>

	<section id="section">
		<h1 style="font-family: 'MBC1961GulimM'; letter-spacing: 10px;">보유상품현황</h1>
	</section>
		<div id="center" >
			<div id="justify">
				<div id="itemButton" class="wrap">
				   <button type="button" onclick="fnListAll()">전체</button>
				   <button type="button" onclick="fnListHaving()">경매중(미입찰) / 판매대기</button>
				   <button type="button" onclick="fnListNo()">경매중(입찰) / 판매완료</button>
				</div>
				
				<div style="margin-top:50px;">
					<button id="itemInput" style="width:150px; height:45px;" type="button"><a href="/item/register">상품 등록</a></button>
				</div>
			</div><!-- justify -->
		</div><!-- center -->
	<section id="section">
		<form id="itemInfoForm">
			<c:forEach var="item" items="${itemList}">
				<div class="itemInfo" style="width: 300px; height: 350px;">
					<p style="margin: 0 20px; margin-top: 20px; font-weight: bold;">${item.rno}</p>
					<div class="itemImage">
						<c:choose>
							<c:when test="${item.imageList.size()!=0}">
								<a class="move" href="${item.itemNumber}"><img
									src="${item.imageList.get(0).viewLoadName}"
									style="width:130px; height:150px; outline:2px solid #000;"></a>
							</c:when>
							<c:otherwise>
								<p>이미지 없음</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="itemDetail">
						<c:choose>
							<c:when test="${item.itemHave eq 0}">
								<c:if test="${item.tradeIng eq 'Y'}">
									<p>판매중</p>
									<p style="color: coral; font-style: oblique;">경매 진행중</p>
								</c:if>
								<c:if test="${item.tradeIng eq 'N'}">
									<p>판매완료</p>
									<p style="color: gray; font-style: oblique;">판매완료</p>
								</c:if>
							</c:when>
							<c:when test="${item.itemHave eq 1}">
								<c:if test="${item.tradeIng eq 'Y'}">
									<p>판매 중</p>
									<p style="color: coral;">경매 등록 상품</p>
								</c:if>
								
								<c:if test="${item.tradeIng eq 'N'}">
								<p>판매대기</p>
									<p style="color: orange; font-style: oblique;">경매 미등록 상품</p>
								</c:if>
							</c:when>
						</c:choose>
						<a style="font-size: 30px;" class="move" href="${item.itemNumber}">${item.itemName}</a>
					</div>
				</div>
			</c:forEach>
		</form>
	</section>
	
	<ul id="itemListPagination" class="pagination">
		<c:if test="${pageDTO.preView}">
			<li class="page-item"><a class="page-link"
				href="${pageDTO.startPage-1}">이전으로</a></li>
		</c:if>
		<c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}"
			var="pageNo">
			<li class="page-item"><a class="page-link" href="${pageNo}">${pageNo}</a>
			</li>
		</c:forEach>
	
		<c:if test="${pageMaker.next}">
			<li class="page-item"><a class="page-link"
				href="${pageMaker.endPage+1}">다음으로</a></li>
		</c:if>
	</ul>
	
	<section id="section">
		
	
		<form name="searchForm" id="searchForm" action="/item/getListHaving"
			method="get">
			<select id="type" name="type">
				<option value="" ${pageDTO.pi.type==null?"selected":""}>선택하세요</option>
				<option value="N" ${pageDTO.pi.type eq 'N'?"selected":""}>제목</option>
				<option value="C" ${pageDTO.pi.type eq 'C' ?"selected":""}>내용</option>
				<option value="A" ${pageDTO.pi.type eq 'A'?"selected":""}>제목or내용</option>
			</select> <input type="text" name="keyword" id="keyword"
				value="${pageDTO.pi.keyword}"> <input type="hidden"
				name="pageNum" value="1"> <input type="hidden" name="amount"
				value="${pageDTO.pi.amount}"> <input type="hidden"
				name="itemHave" value="${itemList.get(0).itemHave}">
			<button id="searchInput" style="width: 150px; padding:0 30px;" type="submit">검색</button>
		</form>
	</section>
	<!-- 페이지 번호를 클릭하면 form 태그를 submit시킨다. -->
	<form id="itemForm" action="/item/getListHaving" method="get">
		<input type="hidden" name="pageNo" value="${pageDTO.pi.pageNo}">
		<input type="hidden" name="amount" value="${pageDTO.pi.amount}">
		<input type="hidden" name="type" value="${pageDTO.pi.type}">
		<input type="hidden" name="keyword" value="${pageDTO.pi.keyword}">
		<input type="hidden" name="itemHave" value="${itemList.get(0).itemHave}">
		<input type="hidden" name="itemNumber" id="itemNumber" value="">
	</form>
	<div id="myModal" class="myModal">
		<div class="modal-body">
			<p>Modal body text goes here.</p>
		</div>
		<div class="modal-footer">
			<button id="close-modal" class="close-modal">닫기</button>
		</div>
	</div>
	
	<script type="text/javascript">
			$(document).ready(function(){
				let result = '<c:out value="${result}"/>' ;
				checkModal(result);
				
				history.replaceState({}, null, null);
				
				function checkModal(result){
					const myModal = document.getElementById("myModal");	
					
					if(result === '' || history.state){
						return ;
					}
					
					if(result == 'regSuccess'){
						$(".modal-body").html("정상적으로 등록되었습니다.") ;
					}else if(result == 'modSuccess'){
						$(".modal-body").html("정상적으로 수정되었습니다.") ;
					}else if(result == 'delSuccess'){
						$(".modal-body").html("정상적으로 삭제되었습니다.") ;
					}
					
					myModal.style.display = "block";
					document.body.style.overflow = "hidden";
	
				}
				
				
				$(".close-modal").on("click", function(e){
					 const myModal = document.getElementById("myModal");	 
					 myModal.style.display = "none";
					 document.body.style.overflow = "auto";
				});
				
			
				var itemForm = $('#itemForm');
	        	
	        	$(".page-link").on("click", function(e){
	        		e.preventDefault();
	        		var targetPage = $(this).attr("href");
	          		itemForm.find("input[name='pageNo']").val(targetPage) ;
	        		itemForm.submit();
	        	});
	       	
	        	//get 보내기
	        	$(".move").on("click", function(e){
	        		e.preventDefault();
	        		
	        		var itemNumber = $(this).attr("href");
	        		
	        		 $("#itemNumber").val(itemNumber);
	        		itemForm.attr("action", "/item/modify");
	        		itemForm.submit();
					
	        	});	
	
			});
		
			function fnListAll(){
				location.href = "/item/getList"
			}
			
			function fnListHaving(){
				location.href = "/item/getListHaving?itemHave=1"
			}
			
			function fnListNo(){
				location.href = "/item/getListHaving?itemHave=0"
			}
		</script>
	
	
	
	
	
	<%@ include file="../include/footer2.jsp"%>
