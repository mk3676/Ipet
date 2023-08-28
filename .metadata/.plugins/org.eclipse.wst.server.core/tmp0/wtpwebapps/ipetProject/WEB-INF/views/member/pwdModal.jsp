<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>비밀번호 찾기</title>

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
			//비밀번호 찾는 버튼 클릭시 실행
			$("#findPwdBtn").click(function (e) {
				e.preventDefault();
				if ($("#emailResult").val() == "N" || $("#emailResult") == null) {
					alert("이메일 인증을 진행해 주세요.")
				}
				else if ($("#emailResult").val() == "Y") {
					let vo = $("#pwdform").serialize();
					$.ajax({
						url: '/member/findPwd',
						data: vo,
						dataType: 'json',
						success: function (result) {
							alert(result['msg'])
						}
					})
				}
			})

			// 이메일 인증 버튼을 눌렀을때 인증번호를 발급한다.
			$("#emailCheck").click(function () {
				var email = $("#email").val();

				if (email != "") {
					alert('인증번호를 발송했습니다.')
					$("#emailauth").remove()
					$("#authEmail").append("<div id='emailauth' >인증번호를 입력해 주세요: <input type='text' id='authNum'/><p id='ckTime' style='font-weight: bold;'></p><a id='authButton' style='cursor: pointer;'>인증번호 입력</a><input type='hidden' id='emailResult' value='N' readonly></div>")
					let time = 120;
					let timer = setInterval(function () {
						let min = parseInt(time / 60);
						let sec = time % 60;
						$("#ckTime").text(min + "분 " + sec + "초");
						time--;
						if (time < 0) {
							clearInterval(timer);
							$("#ckTime").text("시간초과");
							$("#authNum").prop("readonly", true);
							$("#authNum").val("");
							$("#emailResult").val("N");
							alert("이메일 인증 시간초과")
						}
					}, 1000);
					console.log(email)

					$.ajax({
						type: "post",
						url: "/member/emailCheck",
						data: JSON.stringify({ "email": email }),
						contentType: "application/json; charset=utf-8",
					});
				} else {
					alert("이메일을 입력해주세요.")
				}
			});

			// 사용자가 인증번호를 입력하면 컨트롤러로 전송하여 성공 여부를 판별한다.
			$("#authEmail").on("click", "#authButton", function () {
				var authNum = $("#authNum").val();
				var email = $("#email").val();

				if (authNum != "") {
					console.log(authNum)

					data = {
						"email": email,
						"auth": authNum
					}

					$.ajax({
						type: "post",
						url: "/member/vaildAuth",
						data: JSON.stringify(data),
						dataType: "json",
						contentType: "application/json; charset=utf-8",
						success: function (outcome) {
							if (outcome["status"] == 1) {
								alert(outcome["word"]);
								$("#emailResult").val("Y");
								$("#email").prop("readonly", true);
								$("#authNum").prop("readonly", true);
								$("#authButton").remove();
							}
							else if (outcome["status"] == 0) {
								alert(outcome["word"]);
								$("#authNum").val("");
								$("#emailResult").val("N");
							}
						}
					});
				} else { alert("인증번호를 입력해 주세요") }
			});
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
		}
	</style>

	<body>

		<!-- 모달 버튼 -->
		<h3>비밀번호 찾기</h3>


		<!-- 모달 본문 -->
		<div class="modal-body">
			<form action="/member/findPwd" method="post" id="pwdform">
				<div class="form-group">
					<label for="name">아이디:</label>
					<input type="text" class="form-control" id="id" name="id" required>
				</div>
				<div class="form-group">
					<label for="email">이메일:</label>
					<input type="email" name="email" id="email">
				</div>
				<div id="authEmail">
					<a id="emailCheck" style="cursor: pointer;">이메일 인증</a>
				</div>
				<br />
				<br />
				<div>
					<button type="submit" class="btn btn-primary" id='findPwdBtn'>비밀번호 찾기</button>

					<button onclick="$('#findModal .modal-content').html('');" type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>

			</form>
		</div>

	</body>

	</html>