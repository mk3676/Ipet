<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			<!DOCTYPE HTML>
			<html>

			<head>
				<title>I-Pet</title>
				<meta charset="utf-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
				<link rel="stylesheet" href="../resources/assets/css/main.css" />
				<link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
				<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
					integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
					crossorigin="anonymous">
				<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
				<script>
					$(document).ready(function () {
						$("input[class='total']").each(function(){
							 $("#allprice").val(Number($("#allprice").val())+Number($(this).val()))
						 })
						 
						$(".amount").keyup(function () {
							$(".total[data-pno=" + $(this).data('pno') + "]").val($(this).val() * $(".price[data-pno=" + $(this).data('pno') + "]").val())
							
							$("#allprice").val(0)
							$("input[class='total']").each(function(){
							$("#allprice").val(Number($("#allprice").val())+Number($(this).val()))
						 	})
							if ($(this).val() < 1) {
								alert("수량은 0개 아래로 내려갈수 없습니다.")
								$(this).val(1)
								$(".total[data-pno=" + $(this).data('pno') + "]").val($(".amount[data-pno=" + $(this).data('pno') + "]").val() * $(".price[data-pno=" + $(this).data('pno') + "]").val())
								
								$("#allprice").val(0)
								$("input[class='total']").each(function(){
								$("#allprice").val(Number($("#allprice").val())+Number($(this).val()))
							 	})
							}
						 })

						$(".up").click(function () {
							$(".amount[data-pno=" + $(this).data('pno') + "]").val(Number($(".amount[data-pno=" + $(this).data('pno') + "]").val()) + 1)
							$(".total[data-pno=" + $(this).data('pno') + "]").val($(".amount[data-pno=" + $(this).data('pno') + "]").val() * $(".price[data-pno=" + $(this).data('pno') + "]").val())
							$("#allprice").val(0)
							$("input[class='total']").each(function(){
							$("#allprice").val(Number($("#allprice").val())+Number($(this).val()))
						 	})
						 
						})

						$(".down").click(function () {
							$(".amount[data-pno=" + $(this).data('pno') + "]").val(Number($(".amount[data-pno=" + $(this).data('pno') + "]").val()) - 1)
							$(".total[data-pno=" + $(this).data('pno') + "]").val($(".amount[data-pno=" + $(this).data('pno') + "]").val() * $(".price[data-pno=" + $(this).data('pno') + "]").val())
						    $("#allprice").val(Number($("#allprice").val())-$(".price[data-pno=" + $(this).data('pno') + "]").val())
						 	$("#allprice").val(0)
							$("input[class='total']").each(function(){
							$("#allprice").val(Number($("#allprice").val())+Number($(this).val()))
						 	})
							if ($(".amount[data-pno=" + $(this).data('pno') + "]").val() == 0) {
								$(".amount[data-pno=" + $(this).data('pno') + "]").val(1)
								$(".total[data-pno=" + $(this).data('pno') + "]").val($(".amount[data-pno=" + $(this).data('pno') + "]").val() * $(".price[data-pno=" + $(this).data('pno') + "]").val())
								$("#allprice").val(0)
								$("input[class='total']").each(function(){
								$("#allprice").val(Number($("#allprice").val())+Number($(this).val()))
							 	})
							}
						})
					    
						$(".delete").click(function(){
							if(confirm("장바구니에서 삭제 하시겠습니까?")){
								
								
								$.ajax({
									url:"/member/deleteCart?pno="+$(this).data("pno")+"&mno=${loginMember.mno}",
									dataType:"text",
									success:function(result){
										alert(result);
										location.href="/member/cart";
									}
								})
							}else{
								
							}
						})
					   $("#productPurchase").click(function(){
						   if(confirm("구매 하시겠습니까?")){
							   $(".pno").each(function(){
								 console.log("pno : " + $(this).val())
								 console.log("pname : " + $(".pname[data-pno="+$(this).val()+"]").val())
								 console.log("price : " + $(".price[data-pno="+$(this).val()+"]").val())
								 console.log("amount : " + $(".amount[data-pno="+$(this).val()+"]").val())
								 console.log("total : " + $(".total[data-pno="+$(this).val()+"]").val())
								 $.ajax({
									 url:"/member/purchase",
									 type:"post",
									 data:{'mno':'${loginMember.mno}',
										   'pno':$(this).val(),
										   'pname':$(".pname[data-pno="+$(this).val()+"]").val(),
										   'price':$(".price[data-pno="+$(this).val()+"]").val(),
										   'amount':$(".amount[data-pno="+$(this).val()+"]").val(),
										   'total':$(".total[data-pno="+$(this).val()+"]").val(),
										   'id':'${loginMember.id}'
										   }
								 })
							   })
							   
							   $.ajax({
								   url:"/member/deleteAllCart?mno=${loginMember.mno}",
								   type:"get",
								   success:function(){
									   alert("구매가 완료 됐습니다.");
									   location.href="/member/cart";								   
								   }
							   })
						   }else{}
					   })
						
					})
				</script>
			</head>
			<style>
				.pagination {
					display: flex;
					justify-content: center;
					margin-top: 20px;
				}

				.pagination a {
					margin: 0 5px;
					color: #333;
					text-decoration: none;
					padding: 5px 10px;
					border: 1px solid #ccc;
					border-radius: 5px;
				}

				.pagination a.active {
					background-color: #333;
					color: #fff;
				}

				.quantity-controls {
					display: flex;
					justify-content: center;
					align-items: center;
					margin-top: 10px;
				}

				.quantity-controls input[type="button"] {
					width: auto;
					/* 가로 크기를 자동으로 설정 */
					height: 50px;
					/* 세로 크기를 50px로 고정 */
					font-size: 14px;
					background-color: #ccc;
					border: none;
					color: #fff;
					padding: 0;
					border-radius: 0;
				}

				.amount {
					width: 30px;
					height: 30px;
					/* 정사각형으로 변경 */
					text-align: center;
					font-weight: bold;
					padding: 5px;
				}

				.price,
				.total {
					width: auto;
					text-align: center;
					font-size: medium;
					font-weight: bolder;

				}
			</style>

			<body class="is-preload">
				<div id="page-wrapper">

					<%@include file="../header.jsp" %>
						<section class="wrapper style1">
							<div class="container">
								<div id="content">

									<!-- Content -->

									<article>
										<header style="display: inline;">
											<h2 style="display: inline;">${loginMember.id}님의 장바구니</h2>
										</header>

										<div class="product">
											<br />
											<table class="table">
												<thead
													style="font-weight: bolder; background-color: #cfe2f3; text-align: center; white-space: nowrap;">
													<th>상품사진</th>
													<th>카테고리</th>
													<th>상품이름</th>
													<th>상품가격</th>
													<th>수량</th>
													<th>결제 가격</th>
													<th></th>
												</thead>
												<tbody style="white-space: nowrap; text-align: center;">
													<c:forEach var="cart" items="${cartList}">
													<input type="hidden" value="${cart.pno }" class="pno"/>
														<tr>
															<c:choose>
																<c:when test="${not empty cart.imageName}">
																	<td><img src="/productImage/${cart.imageName }?timestamp=12345"
																			style="width:70px;height:70px" /></td>
																</c:when>
																<c:when test="${empty cart.imageName }">
																	<td><img src="../resources/images/noImage.jpg"
																			style="width:70px;height:70px" /></td>
																</c:when>
															</c:choose>
															<c:choose>
																<c:when test="${cart.category eq 'food' }">
																	<td>사료/간식</td>
																</c:when>
																<c:when test="${cart.category eq 'pad' }">
																	<td>패드/장난감</td>
																</c:when>
																<c:when test="${cart.category eq 'bath' }">
																	<td>목욕/하네스</td>
																</c:when>
															</c:choose>
															<td >
																<div class="quantity-controls">
																<input type="text" value="${cart.pname}"
																		style="border: none;" class="pname"
																		data-pno="${cart.pno }" readonly />
																</div>
															</td>
															<td>
																<div class="quantity-controls">
																	<input type="text" value="${cart.price}"
																		style="border: none;" class="price"
																		data-pno="${cart.pno }" readonly />
																</div>
															</td>
															<td>
																<div class="quantity-controls">
																	<a class='down'
																		style="cursor:pointer; text-decoration: none;"
																		data-pno="${cart.pno }">🔽</a>
																	&nbsp; &nbsp;
																	<input type="text" id="amount" class="amount"
																		data-pno="${cart.pno }" value=1
																		style="width:60px"
																		oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
																	&nbsp; &nbsp;
																	<a class='up' data-pno="${cart.pno }"
																		style="cursor:pointer;text-decoration: none;">🔼</a>

																</div>
															</td>
															<td>
																<div class="quantity-controls">
																	<input type="text" readonly value="${cart.price}"
																		data-pno="${cart.pno }" class="total"
																		style="border: none;">
																	
																</div>
															</td>

															<td><a class="delete" data-pno="${cart.pno}" style="cursor: pointer;">삭제</a>
															</td>

														</tr>
													</c:forEach>
												</tbody>
																
											</table>
											<div style="display: flex; align-items: center;">
													<h3 style="white-space: nowrap;">총 결제 금액 : </h3>
													<input type="text" style="border: none; font-size: 25px; font-weight: bold; width: auto;" id="allprice" readonly/>
											</div>
											<div>
												<input type="button" id="productPurchase" value="결제하기"/>
												<a href="/member/history?mno=${loginMember.mno }"><input type="button" id="productPurchase" value="구매내역"/></a>
											</div>
											<div class='pagination'>
												<c:if test="${paging.prev}">
													<c:set var="prevPage" value="${paging.startNum-1}" />
													<a href="/member/cart?pageNum=${prevPage}" class="pageClass">이전</a>
												</c:if>

												<c:forEach begin="${paging.startNum}"
													end="${paging.startNum+9 > paging.lastNum ? paging.lastNum : paging.startNum+9}"
													var="page">
													<c:choose>
														<c:when test="${page ne paging.pageNum}">
															<a style="cursor:pointer;" class="pageClass"
																href="/member/cart?pageNum=${page}">${page}</a>
														</c:when>
														<c:when test="${page eq paging.pageNum}">
															<a style="cursor:pointer; background-color: #cfe2f3;"
																class="pageClass"
																href="/member/cart?pageNum=${page}">${page}</a>
														</c:when>
													</c:choose>
												</c:forEach>

												<c:if test="${paging.next}">
													<c:set var="nextPage" value="${paging.startNum+10}" />
													<a class="pageClass" href="/member/cart?pageNum=${nextPage}">다음</a>
												</c:if>
											</div>
										</div>
									</article>
								</div>
							</div>
						</section>
						<%@include file="../footer.jsp" %>

				</div>

				<!-- Scripts -->
				<script src="../resources/assets/js/jquery.min.js"></script>
				<script src="../resources/assets/js/jquery.dropotron.min.js"></script>
				<script src="../resources/assets/js/browser.min.js"></script>
				<script src="../resources/assets/js/breakpoints.min.js"></script>
				<script src="../resources/assets/js/util.js"></script>
				<script src="../resources/assets/js/main.js"></script>

			</body>

			</html>