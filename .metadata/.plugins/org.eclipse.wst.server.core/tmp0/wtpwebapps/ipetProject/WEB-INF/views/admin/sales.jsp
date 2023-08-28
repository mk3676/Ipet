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
				<script src="https://cdn.canvasjs.com/canvasjs.min.js"></script>
				<script src="https://code.jquery.com/jquery-3.6.3.js"></script>

				<script>
					window.onload = function () {

						var chart = new CanvasJS.Chart("chartContainer", {
							theme: "light2", // "light1", "dark1", "dark2"
							exportEnabled: true,
							animationEnabled: true,
							title: {
								text: "카테고리별 판매 현황"
							},
							data: [{
								type: "pie",
								toolTipContent: "<b>{label}</b>: {y}%",
								indexLabelFontSize: 16,
								indexLabel: "{label} - {y}%",
								dataPoints: ${ dataPoints }
						}]
					});
					chart.render();
						
					 
					var chart2 = new CanvasJS.Chart("chartContainer2", {
						animationEnabled: true,
						theme: "light2", // "light1", "dark1", "dark2"
						title: {
							text: "전체 판매량 상위 5위 상품"
						},
						axisX: {
							title: "상품명"
						},
						data: [{
							type: "column",
							indexLabel: "{y}",
							dataPoints: ${dataPoints2}
						}]
					});
					chart2.render();
					
					
					var chart3 = new CanvasJS.Chart("chartContainer3", {
						theme: "light2",
						title: {
							text: "일별 상품 판매량"
						},
						axisX: {
							title: "날짜"
						},
						axisY: {
							title: "상품 판매 갯수",
							includeZero: true
						},
						data: [{
							type: "line",
							yValueFormatString: "#,##0개",
							dataPoints : ${dataPoints3}
						}]
					});
					chart3.render();
					
					var chart4 = new CanvasJS.Chart("chartContainer4", {
						theme: "light2",
						title: {
							text: "일별 가입자 수"
						},
						axisX: {
							title: "날짜"
						},
						axisY: {
							title: "가입자 수",
							includeZero: true
						},
						data: [{
							type: "line",
							yValueFormatString: "#,##0명",
							dataPoints : ${dataPoints4}
						}]
					});
					chart4.render();
					
					}
				</script>
			
			</head>

			<body class="is-preload">
				<div id="page-wrapper">

					<%@include file="adminheader.jsp" %>
						<section class="wrapper style1">
							<div class="container">
								<div id="content">

									<!-- Content -->

									<article>
										<header style="display: inline;">
											<h2 style="display: inline;">데이터 모니터링</h2>
										</header>

										<div id="chartContainer" style="height: 370px; width: 100%;"></div>
										<br/><br/><br/><br/><br/>
										<div id="chartContainer2" style="height: 370px; width: 100%;"></div>
										<br/><br/><br/><br/><br/>
										<div id="chartContainer3" style="height: 370px; width: 100%;"></div>
										<br/><br/><br/><br/><br/>
										<div id="chartContainer4" style="height: 370px; width: 100%;"></div>
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