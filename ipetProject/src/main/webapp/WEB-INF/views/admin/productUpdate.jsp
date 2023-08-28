<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE HTML>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
				
				$("#button").click(function(e){
					if(confirm("수정 하시겠습니까?")){
						if($("#pname").val() == null || $("#pname").val() == ""){
							alert("제품 이름을 입력해 주세요");
						}else if($("#price").val() == null || $("#price").val() == ""){
							alert("가격을 입력해 주세요");
						}else if($("#description").val() == null || $("#description").val() == ""){
							alert("상품 내용을 입력해 주세요.")
						}else{
							let data = $("#frm")[0];
							let formData = new FormData(data);
					
							$.ajax({
								url:"/admin/productsUpdate",
								data:formData,
								type:"post",
								processData: false,    
						        contentType: false,
						        cache: false,
						        enctype:'multipart/form-data',
						        dataType:"json",
						        success:function(result){
						        	alert(result['result'])
						        	location.href="/admin/productList";
						        }
							})
						}
					}else{}
			}) 
			$("#delete").click(function(){
				if(confirm("게시글을 삭제 하시겠습니까?")){
					$.ajax({
						url:"/admin/productDelete?pno=${vo.pno}&imageName=${vo.imageName}",
						type:"delete",
						dataType:"json",
						success:function(result){;
							alert(result['result']);
							location.href="/admin/productList";
						}
					})
				}else{}
			})

				$(frm.img).on("change", function (e) {
					var reader = new FileReader();
					reader.onload = function (e) {
						$("#img").attr("src", e.target.result);
					};
					reader.readAsDataURL(this.files[0]);
				});

				// 이미지 업로드 시 파일 선택 창이 뜨도록 변경
				$("#proimg").on("click", function () {
					$("#frm input[name='img']").click();
				});
				
				if("${vo.id}" != "${loginMember.id}"){
					alert("본인이 작성한 게시물만 수정 가능합니다.")
					location.href="/admin/productList"
				}
			}); 
		</script>
		<style>
			.inputArea {
				margin: 10px 0;
			}

			select {
				width: 100px;
			}

			label {
				display: inline-block;
				width: 70px;
				padding: 5px;
			}

			label[for='des'] {
				display: block;
			}

			input {
				width: 150px;
			}

			textarea#des {
				width: 400px;
				height: 180px;
			}

			.select_img img {
				margin: 20px 0;
			}
		</style>
	</head>

	<body class="is-preload">
		<div id="page-wrapper">

			<%@include file="adminheader.jsp" %>
				<div class="page_wrapper">
					<section class="wrapper style1">
						<section class="container">
							<div id="content">
								<form action="/products/productRegist" method="post" id="frm">
								<input type="hidden" name="id" value="${loginMember.id }"/>
								<input type="hidden" name="pno" value="${vo.pno }"/>
									<div>
										<label for="cate" style="width:110px;">카테고리:</label>
										<select name="category" id="category">
											<option value="food" selected="selected">food</option>
											<option value="pad">pad</option>
											<option value="bath">bath</option>
										</select>
									</div>
									<div>
										<label for="pname" style="width:200px;">상품이름:</label>
										<input type="text" name="pname" id="pname" value="${vo.pname }" >
									</div>
									<div>
										<label for="price" style="width:200px;">상품가격:</label>
										<input type="text" name="price" id="price" value="${vo.price}" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
									</div>
									<div>
										<label for="description" style="width:200px;">상품내용:</label>
										<textarea name="description" id="description" cols="30" rows="10">${vo.description}</textarea>
									</div>
									<div>
										 <label for="img" style="width:200px;">상품사진</label>
										 <br/>
										<a id="proimg" class="title" style="cursor:pointer;">파일 선택</a>
										<div>
										<c:choose>
											<c:when test="${not empty vo.imageName }">
												<img src="/productImage/${vo.imageName }?timestamp=12345" id="img" width=150 />
											</c:when>
											<c:when test="${empty vo.imageName }">
												<img src="../resources/images/noImage.jpg" id="img" width=150 />
											</c:when>
										</c:choose>
											<input type="file" id='img' name="img" accept="img/*" style="visibility: hidden;">
										</div>
										<div>
											<label for="regtime" style="width:200px;">등록 날짜</label>
											<input type="text"  id="regtime" value="<fmt:formatDate pattern="yyyy년 M월 d일 hh시 m분" value="${vo.regtime}" />" readonly >
											<label for="updateTime" style="width:200px;">수정 날짜</label>
											<input type="text"  id="updateTime" value="<fmt:formatDate pattern="yyyy년 M월 d일 hh시 m분" value="${vo.updateTime}" />" readonly >	
										</div>
									</div>
									<input type="button" id="button" value="수정">
									<input type="button" id="delete" value="삭제">
									<a href="/admin/productList"><input type="button" value="목록으로"></a>
								</form>
							</div>
						</section>
					</section>
				</div>
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