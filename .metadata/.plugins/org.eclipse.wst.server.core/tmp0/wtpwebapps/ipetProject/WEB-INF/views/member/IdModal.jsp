<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>ID 찾기</title>

		<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
		<!-- 부트스트랩 JavaScript -->
		<script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
			integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
			crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
			integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
			crossorigin="anonymous"></script>

	</head>
	<script>
		$(document).ready(function () {
			$("#findIdBtn").click(function (e) {
				e.preventDefault();
				let vo = $("#idform").serialize();
				$.ajax({
					url: '/member/findId',
					data: vo,
					dataType: 'json',
					success: function (result) {
						alert(result['msg'])
					}

				})
			})
		})
	</script>
	<style>
		.modal-dialog {
			height: 66%;
		}

		.modal {
			display: none;
			/* 모달을 숨김 */
			position: fixed;
			/* 모달 위치를 고정 */
			z-index: 1;
			/* 모달을 다른 요소보다 위에 표시 */
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			overflow: auto;
			/* 모달이 스크롤되도록 설정 */
			background-color: rgba(0, 0, 0, 0.4);
			/* 모달 배경 색상 */
		}

		/* 모달 내용 */
		.modal-content {
			background-color: #fefefe;
			margin: 15% auto;
			/* 모달이 중앙에 위치하도록 설정 */
			padding: 20px;
			border: 1px solid #888;
			width: 40%;
			height: 66%;
			border-radius: 20px;
			border-color: gray;
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: center;
		}

		/* 닫기 버튼 */
		.close {
			color: #aaa;
			float: right;
			font-size: 28px;
			font-weight: bold;
		}

		.close:hover,
		.close:focus {
			color: black;
			text-decoration: none;
			cursor: pointer;
	</style>

	<body>

		<!-- 모달 버튼 -->
		<h3>아이디 찾기</h3>


		<!-- 모달 본문 -->
		<div class="modal-body">
			<form action="/member/findId" method="post" id="idform">
				<div class="form-group">
					<label for="name">이름:</label>
					<input type="text" class="form-control" id="name" name="name" required>
				</div>
				<div class="form-group">
					<label for="email">이메일:</label>
					<input type="email" name="email" id="email">
				</div>
				<br />
				<br />
				<div>
					<button type="submit" class="btn btn-primary" id='findIdBtn'>ID 찾기</button>
					<button onclick="$('#findModal .modal-content').html('');" type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>

			</form>
		</div>

	</body>

	</html>