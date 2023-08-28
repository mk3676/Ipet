<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<script>
			$(document).ready(function () {
				let current = parseInt([[${ index }]]);
				for (let i = 0; i < $("li").length; i++) {
					$("li").eq(i).removeAttr("class")
				}
				$("li").eq(current).attr("class", "current")
			})
		</script>
		<!-- Header -->
		<div id="header">
					<span style="text-align: right; display: block">
						<a style="color: black;" href="/ipet/index">홈으로</a> &nbsp; &nbsp;
						<a style="color: black;" href="/admin/member;">관리자 페이지</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/mypage">마이페이지</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/logout">로그아웃</a>
						<br />
						<span style="text-align: right; display: block;">${loginMember.id}님</span>
					</span>

			<!-- Logo -->
			<div id="logo" style="align-items: center;">
				<h1><a href="/ipet/index" id="logo"><img id="logoImage" src="../resources/images/ipetLogo_fin.jpg" /></a>
				</h1>
			</div>
			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li class="current"><a href="/admin/member">회원정보 관리</a></li>
					<li><a href="/admin/productList">물품 등록</a></li>
					<li><a href="/admin/qna">QnA 관리</a></li>
					<li><a href="/admin/history">배송 관리</a></li>
					
				</ul>
				<!-- Scripts -->
				<script src="../resources/assets/js/jquery.min.js"></script>
				<script src="../resources/assets/js/jquery.dropotron.min.js"></script>
				<script src="../resources/assets/js/browser.min.js"></script>
				<script src="../resources/assets/js/breakpoints.min.js"></script>
				<script src="../resources/assets/js/util.js"></script>
				<script src="../resources/assets/js/main.js"></script>
			</nav>

		</div>