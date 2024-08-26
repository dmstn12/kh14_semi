<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page= "/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	<!-- 주문 삭제버튼 스타일-->
	.link-box {
		width: 100%;
	}
	.link-box a {
		width: 150px;
		text-align: center; 
	}
	
</style>

<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script type="text/javascript">
	//전체선택
	$(function(){
		$('.all-checkbox').change(function(){
			//체크박스 상태
			var checked = $(this).prop("checked");
			$(".check-item").prop("checked", checked);	
			$(".check-item").trigger("change");
		});
	});
	
// 	수량 증가-
// 	$(function(){
// 		//지금 있는 수량에 1개를 추가->vlaue를 갖고오기
// 		var originCnt = parseInt($("[name=cartCnt]").val());
// 		var itemCnt = ${itemCnt}; //jsp
		
// 		$(".btn-up").click(function(){
// 			if(originCnt < itemCnt) {
// 				originCnt+=1;
// 				$("[name=cartCnt]").val(originCnt);
// 			}
// 			else {
// 				alert("재고가 부족합니다.");
// 			}
// 		});
		
	});
	
	

</script>
<div class="container w-1200 my-50">
	<div class="row center">
		<h1>장바구니</h1>
	</div>

<!-- 장바구니가 비어있다면(회원, 비회원)  -->
<c:choose>
	<c:when test="${cartList.isEmpty()}">
		<!-- 결과가 없을때  -->
		<div class="row center">
			<p>장바구니가 비어있습니다</p>
		</div>
	</c:when>	
	<c:otherwise>
	<!-- 결과가 있을때  -->
	<!-- 장바구니 목록 -->
	<form action="delete" method="post">
		<table border="1" width="1200">
			<thead>
				<tr>
					<th>
						<input type="checkbox" class="all-checkbox">
					</th>
					<th>이미지</th>
					<th>상품정보</th>
					<th>판매가</th>
					<th>수량</th>
					<th>배송구분</th>
					<th>배송비</th>
					<th>합계</th>
					<th>선택</th>
				</tr>
			</thead>
			
			<!-- cartList 반복문 -->
			<tbody class="center">
			<c:forEach var="cart" items="${cartList}">
				<tr>
					<td>
						<input type="checkbox" class="check-item" name="cartNo" value="${cart.cartNo}">
					</td>
					<td>
						<a href="#"><img src="https://via.placeholder.com/20"></a> <!-- 임시 이미지 -->
					</td>
					<!--itemList 반복문 -->
					<c:forEach var="item" items="${itemList}">
			            <c:if test="${item.itemNo == cart.cartItemNo}">
			                <td>${item.itemName}</td> 
			                <td>${item.itemPrice}원</td>
			            </c:if>
			        </c:forEach>
					<td>
						<span class="input_cartCnt">
							<input type="text"  name="cartCnt"  value="${cart.cartCnt}" size="2">
							<button type="submit" class="btn-up"><i class="fa-solid fa-angle-up Icon_carCnt"></i></button>
							<button type="submit" class="btn-down"><i class="fa-solid fa-angle-down Icon_carCnt"></i></button>
						</span>
					</td>
					<td>기본배송</td>
					<td>2500원</td>
					<td>${cart.cartTotalPrice}원</td> <!-- 배송비 미포함 -->
			 		<td class="link-box flex-box"  style="flex-direction: column; align-items:center;">
						<button type="submit" class="btn btn-positive">주문하기</button>
						<button type="submit" class="btn btn-negative">삭제하기</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
			
		<tfoot class="right">
			<tr>
				<td colspan="10" >
					상품구매금액: ${cartTotalPrice}원
				</td>
			</tr>
		</tfoot>
			
		</table>
	</form>
	<div class="float-box" >
		<form action="deleteAll" method="post" class="float-right"> <!-- form 블록요소 여기에 float 적용시킴 -->
			<button type="submit" class="btn btn-empty"><i class="fa-solid fa-trash-can"></i> 장바구니 비우기</button>
		</form>
	<!-- 주문 form 넣으면 됩니다 -->
			<button type="submit" class="btn float-left">선택상품 주문하기</button>
			<button type="submit"  class="btn float-left">전체 주문하기</button>
	</div>
	</c:otherwise>
</c:choose>
</div>
<jsp:include page= "/WEB-INF/views/template/footer.jsp"></jsp:include>