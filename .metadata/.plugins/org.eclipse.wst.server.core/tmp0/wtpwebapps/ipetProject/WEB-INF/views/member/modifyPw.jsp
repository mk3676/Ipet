<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="../resources/assets/css/main.css" />
		<link rel="stylesheet" href="../resources/assets/css/community.css" />
		<link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
		<title>I-Pet</title>
		<script src="https://code.jquery.com/jquery-3.6.3.js"></script>

		<script>
			$(document).ready(function () {


				$(".pwd").keyup(function (e) {
					var password = $("#password").val();
					var hiddenPwd = $("#hiddenPwd").val();

					if (password == hiddenPwd && $(this).val().length != 0) {
						$("#checkPwd").text("비밀번호 확인이 비밀번호와 동일합니다.").css("color", "blue")
						$("#pwdResult").val("Y")

					}
					else {
						$("#checkPwd").text("비밀번호 확인이 비밀번호와 동일하지 않습니다. 다시 입력해주세요.").css("color", "red")
						$("#pwdResult").val("N")
					}
				})
				$("#modify").click(function () {
					$.ajax({
						url: "/member/pwCheck",
						type: "Post",
						dataType: 'json',
						data: JSON.stringify({ "password": $("#originPassword").val() }),
						contentType: "application/json;charset=UTF-8",
						success: function (result) {
							console.log(result['result'])
							if (result['result'] == 'Y' && $("#pwdResult").val() == 'Y') {
								$.ajax({
									url: "/member/modifyPw",
									type: "post",
									dataType: "json",
									contentType: "application/json;charset=UTF-8",
									data: JSON.stringify({ "password": $("#password").val() }),
									success: function (result) {
										alert(result['result'])
										window.close()
									}
								})
							} else if (result['result'] == 'Y' && $("#pwdResult").val() == 'N') {
								alert('변경할 비밀번호가 일치하지 않습니다.')
							} else if (result['result'] == 'N') {
								alert('기존 비밀번호가 일치하지 않습니다.')
							}
						}
					})
				})
			})
		</script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	</head>

	<body>
		기존 비밀번호: <input type="password" name="originPassword" id="originPassword">
		변경할 비밀번호: <input type="password" name="password" id="password" class="pwd">
		변경할 비밀번호 확인: <input type="password" name="hiddenPwd" id="hiddenPwd" class="pwd">
		<input type="hidden" id="pwdResult" readonly>
		<span id="checkPwd"></span><br />
		<button id="modify">비밀번호 변경</button>
		<a onclick="window.close()"><button>닫기</button></a>
	</body>

	</html>