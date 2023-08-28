<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
	<html>

	<head>
		<title>반려동물 용품 판매</title>

		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="../resources/assets/css/main.css" />
		<link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
		<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
		<script>
		// Save file to local storage
		function downloadImageFromURL(url, fileName) {
						  // Create a new anchor element
						  const link = document.createElement('a');
						  link.href = url;
						  link.download = fileName;

						  // Dispatch a click event on the anchor element
						  const event = new MouseEvent('click');
						  link.dispatchEvent(event);
						}

						function getImageDataFromURL(url) {
						  return new Promise((resolve, reject) => {
						    const xhr = new XMLHttpRequest();
						    xhr.open('GET', url, true);
						    xhr.responseType = 'blob';

						    xhr.onload = function () {
						      if (xhr.status === 200) {
						        resolve(xhr.response);
						      } else {
						        reject(new Error('Failed to retrieve image data.'));
						      }
						    };

						    xhr.onerror = function () {
						      reject(new Error('Error occurred while retrieving image data.'));
						    };

						    xhr.send();
						  });
						}
			$(document).ready(function () {
				
				$("#button").click(function (e) {
					if (confirm("게시물을 등록 하시겠습니까?")) {
						if ($("#pname").val() == null || $("#pname").val() == "") {
							alert("제품 이름을 입력해 주세요");
						} else if ($("#price").val() == null || $("#price").val() == "") {
							alert("가격을 입력해 주세요");
						} else if ($("#description").val() == null || $("#description").val() == "") {
							alert("상품 내용을 입력해 주세요.")
						} else {
							let data = $("#frm")[0];
							let formData = new FormData(data);

							$.ajax({
								url: "/products/productRegist",
								data: formData,
								type: "Post",
								processData: false,
								contentType: false,
								cache: false,
								enctype: 'multipart/form-data',
								dataType: "json",
								success: function (result) {
									alert(result['result'])
									location.href = "/admin/productList";
								}
							})
						}
					}

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

				//openai 사용하여 이미지 생성
				$("#makeImg").click(function () {
					let img = prompt('만드려는 이미지를 입력해 주세요.')
					alert("잠시만 기다려 주세요. 자동으로 이미지가 생성됩니다.")
					$.ajax({
						url:'/admin/makeImage?img='+img,
						type:'get',
						dataType:'text',
						success:function(result){
							$("#resultImg").attr('src',result)
						}
					})
				})
			
				$("#download").click(function(){
					if($("#resultImg").attr('src')){
						$("#download").attr("href","/makeImage/${loginMember.id}.png")
					}
				})
				
				
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
									<input type="hidden" name="id" value="${loginMember.id }" />
									<div>
										<label for="cate" style="width:110px;">카테고리:</label>
										<select name="category" id="category" style="width:135px;">
											<option value="food" selected="selected">사료/간식</option>
											<option value="pad">패드/장난감</option>
											<option value="bath">목욕/하네스</option>
										</select>
									</div>
									<div>
										<label for="pname" style="width:200px;">상품이름:</label>
										<input type="text" name="pname" id="pname">
									</div>
									<div>
										<label for="price" style="width:200px;">상품가격:</label>
										<input type="text" name="price" id="price"
											oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
									</div>
									<div>
										<label for="description" style="width:200px;">상품내용:</label>
										<textarea name="description" id="description" cols="30" rows="10"></textarea>
									</div>
									<div>
										<label for="img" style="width:200px;">상품사진</label>
										<br />
										<a id="proimg" class="title" style="cursor:pointer;">파일 선택</a>
										<div id="downloadImg">
											<img src="http://placehold.it/150x120" id="img" width=150 />
											<a id="download" download><img  id='resultImg' style="width:150px; height:120px;" ></a>
											<input type="file" id='img' name="img" accept=".gif, .jpg, .png"
												style="visibility: hidden;">
											
											
										</div>
									</div>
									<input type="button" id="button" value="전송">
									<input type="button" value="이미지 만들기" id="makeImg" >
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