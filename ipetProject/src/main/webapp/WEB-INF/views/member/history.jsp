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
											<h2 style="display: inline;">${loginMember.id}님의 구매내역</h2>
										</header>

										<div class="product">
											<br />
											<table class="table">
												<thead
													style="font-weight: bolder; background-color: #cfe2f3; text-align: center; white-space: nowrap;">
													<th>상품이름</th>
													<th>가격</th>
													<th>수량</th>
													<th>총 결제 가격</th>
													<th>구매 날짜</th>
													<th>배송 현황</th>
													<th></th>
												</thead>
												<tbody style="white-space: nowrap; text-align: center;">
													<c:forEach var="purchase" items="${purchaseList}">
														<tr>
															<td >
																	<div class="quantity-controls">
																	<input type="text" value="${purchase.pname}"
																			style="border: none;" class="pname"
																			readonly />
																	</div>
															</td>
															<td>
																<div class="quantity-controls">
																	<input type="text" value="<fmt:formatNumber value='${purchase.price}'/>"
																		style="border: none;" class="price"
																		 readonly />
																</div>
															</td>
															<td>
																<div class="quantity-controls">
																
																	<input type="text" value="${purchase.amount}"
																		style="border: none;" class="amount"
																		 readonly />
																</div>
															</td>
															<td>
																<div class="quantity-controls">
																	<input type="text" readonly value="<fmt:formatNumber value='${purchase.total}'/>"
																		 class="total"
																		style="border: none;" readonly>
																</div>
															</td>
															<td>
																<div class="quantity-controls">
																	<fmt:formatDate pattern='yyyy년 M월 d일 hh시 m분' value='${purchase.paydate}' />
																</div>
															</td>
															 <td>
																<c:choose>
																	<c:when test="${purchase.delivery eq 'r' }">
																		<div class="quantity-controls">
																			<input type="text" readonly value="상품 준비중"
																				 class="delivery"
																				style="border: none;" readonly>
																		</div>
																	</c:when>
																	<c:when test="${purchase.delivery eq 'd' }">
																		<div class="quantity-controls">
																			<input type="text" readonly value="배송중"
																				 class="delivery"
																				style="border: none;" readonly>
																		</div>
																	</c:when>
																	<c:when test="${purchase.delivery eq 'c' }">
																		<div class="quantity-controls">
																			<input type="text" readonly value="배송완료"
																				 class="delivery"
																				style="border: none;" readonly>
																		</div>
																	</c:when>
																</c:choose>
															</td> 
														</tr>
													</c:forEach>
												</tbody>
																
											</table>
											<div class='pagination'>
												<c:if test="${paging.prev}">
													<c:set var="prevPage" value="${paging.startNum-1}" />
													<a href="/member/history?mno=${loginMember.mno }&pageNum=${prevPage}" class="pageClass">이전</a>
												</c:if>

												<c:forEach begin="${paging.startNum}"
													end="${paging.startNum+9 > paging.lastNum ? paging.lastNum : paging.startNum+9}"
													var="page">
													<c:choose>
														<c:when test="${page ne paging.pageNum}">
															<a style="cursor:pointer;" class="pageClass"
																href="/member/history?mno=${loginMember.mno }&pageNum=${page}">${page}</a>
														</c:when>
														<c:when test="${page eq paging.pageNum}">
															<a style="cursor:pointer; background-color: #cfe2f3;"
																class="pageClass"
																href="/member/history?mno=${loginMember.mno }&pageNum=${page}">${page}</a>
														</c:when>
													</c:choose>
												</c:forEach>

												<c:if test="${paging.next}">
													<c:set var="nextPage" value="${paging.startNum+10}" />
													<a class="pageClass" href="/member/history?mno=${loginMember.mno }&pageNum=${nextPage}">다음</a>
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