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
      function popup(url, title, w, h) {
        var screenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
        var screenTop = window.screenTop != undefined ? window.screenTop : screen.top;

        width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
        height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

        var left = ((width / 2) - (w / 2)) + screenLeft;
        var top = ((height / 2) - (h / 2)) + screenTop;

        window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
      }
      $(document).ready(function () {
        if ("${msg}") {
          alert("${msg}")
        }
        $("#update").click(function (e) {
          e.preventDefault();
          if (confirm("수정 하시겠습니까?")) {
            $("form").submit();
          }
        })
        $("#delete").click(function () {
          if (confirm("정말로 삭제하시겠습니까?")) {
            alert("계정이 삭제 됐습니다.")
            $.ajax({
              url: "/member/delete",
              type: "get",
              success: function () {
                window.location.href = '/member/logout';
              }
            })
          }
        })
		 $("#kakaoaddr").click(function () {
          new daum.Postcode({
            oncomplete: function (data) {
              document.getElementById("address1").value = data.address;
              document.querySelector("input[name=address2]").focus();
            }
          }).open();
        })
      })
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  </head>
  <style>
    input:read-only,
    textarea:read-only {
      box-shadow: none;
      background-color: rgba(134, 130, 130, 0.349);
    }
  </style>

  <body class="is_preload">
    <div class="page_wrapper">
      <%@ include file="../header.jsp" %>
        <section class="wrapper style1">
          <section class="container">
            <div id="content">
              <form action="/member/update" method="post">
                아이디: <input type="text" name="id" id="id" oninput="this.value = this.value.replace(/[ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');"
                  value="${loginMember.id}" readonly>
                <span id="krCheck"></span>
                <a href="#" onclick="popup('/member/modifyPw','비밀번호 변경',430,250)">비밀번호 변경</a>
                <br />
                <input type="hidden" id="pwdResult" readonly>
                <span id="checkPwd"></span><br />
                이름: <input type="text" name="name" id="name" value="${loginMember.name}" required="required">
                전화번호: <input type="text"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" name="phone"
                  id="phone" placeholder="- 빼고 입력해 주세요" value="${loginMember.phone}" required="required" />
                주소 : <a id="kakaoaddr" style='cursor: pointer;'>주소찾기</a>
                <input type="text" name="address1" id="address1" readonly required="required"
                  value="${loginMember.address1}">
                상세주소 : <input type="text" name="address2" required="required" value="${loginMember.address2}">
                이메일: <input type="email" name="email" id="email" readonly value="${loginMember.email}">
                <input type="submit" id="update" value="수정완료" style="background-color: #50c8fc;">
                <input type="button" id="delete" value="회원탈퇴" style="background-color: #50c8fc;">
              </form>
            </div>
          </section>
        </section>
    </div>


    <%@include file="../footer.jsp" %>
  </body>

  </html>