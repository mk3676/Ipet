<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Arcana by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>

<head>
	<title>I-Pet</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="../resources/assets/css/main.css" />
	<link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
      <script>
        $(document).ready(function () {
          // "수정" 버튼: 데이터를 수정하고 해당 페이지에 잔류한다.
          $("#update").click(function () {
            data = {
            		pno: $("#pno").val(),
            		cate: $("#cate").val(),
                    item: $("#item").val(),
                    price: $("#price").val(),
                    des: $("#des").val(),
                    img: $("#img").val(),
            }

            $.ajax({
              type: "put",
              url: "/products/update",
              data: JSON.stringify(data),
              dataType: "json",
              contentType: "application/json; charset=utf-8",
              success: function (result) {
                alert("수정됨")
                location.href = "/ipet/pro"
              }
            });
          });

          // "삭제" 버튼: 데이터를 수정하고 메인 페이지로 돌아간다.
          $("#delete").click(function () {
            var pno = $("#pno").val()

            $.ajax({
              type: "delete",
              url: "/products/delete",
              data: JSON.stringify(pno),
              contentType: "application/json; charset=utf-8",
              success: function (result) {
            	  alert("삭제됨")
                  location.href = "/ipet/pro"
              }
            });
          });

          // "이전으로" 버튼: 이전 페이지(메인 페이지로 이동)
          $("#pro").click(function () {
            location.href = "/ipet/pro"
          });
        });
      </script>
</head>

<body class="is-preload">
	<div id="page-wrapper">

	<%@include file ="../header.jsp" %>
      <div class="page_wrapper">
          <section class="wrapper style1">
            <section class="container">
              <div id="content">
                <form action="#" method="post">
                  번호오우: <input type="text" name="pno" id="pno" value="${vo.pno}" readonly>
                  카테고리: 
                  <select name="cate" id="cate" >
					  <option value="food" selected="selected">food</option>
					  <option value="pad">pad</option>
					  <option value="bath">bath</option>
				  </select>
				  <br>
                  상품이름: <input type="text" name="item" id="item" value="${vo.item}">
                  상품가격: <input type="text" name="price" id="price" value="${vo.price}">
                  상품내용: <textarea name="des" id="des" cols="30" rows="10">${vo.des}</textarea>
                  <label for="img">상품사진:</label>
				  <div>
					  <img src="http://placehold.it/150x120" id="img" width=150 />
					  <input type="file" name="img" accept="img/*" style="visibility: hidden;">
				  </div>
                  등록일자: <input type="text" name="regtime" id="regtime" value="${vo.regtime}" readonly>
                  수정일자: <input type="text" name="uptime" id="uptime" value="${vo.uptime}" readonly>
                  <input type="button" id="update" value="수정">
                  <input type="button" id="delete" value="삭제">
                  <input type="button" id="pro" value="리스트보기">
                </form>
              </div>
            </section>
          </section>
      </div>
		
	<%@include file ="../footer.jsp" %>

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