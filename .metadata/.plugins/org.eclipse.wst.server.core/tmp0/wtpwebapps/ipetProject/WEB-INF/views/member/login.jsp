<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
      <link rel="stylesheet" href="../resources/assets/css/main.css" />
      <link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
      <title>I-Pet</title>
      <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    </head>
    <script>
      $(document).ready(function () {
        // 로그인 비밀번호찾기 아이디찾기 버튼 클릭시 해당 주소로 이동하는 기능
        $("button").click(function (e) {
          e.preventDefault()
          let id = $(this).attr("id")
          $("form").attr("action", "/member/" + id)
          if (id == "findId") {
            $.ajax({
              url: '/member/IdModal', // findId.jsp를 처리하는 URL
              type: 'GET',
              success: function (response) {
                $('#findModal .modal-content').html(response); // 받아온 HTML 코드를 모달의 내용으로 설정

                $("#findModal").css('display', 'block')

              },
              error: function (error) {
                console.log(error);
              }
            });
          }
          else if (id == "findPassword") {
            $.ajax({
              url: '/member/pwdModal', // findId.jsp를 처리하는 URL
              type: 'GET',
              success: function (response) {
                $('#findModal .modal-content').html(response); // 받아온 HTML 코드를 모달의 내용으로 설정

                $("#findModal").css('display', 'block')

              },
              error: function (error) {
                console.log(error);
              }
            });
          }
          else {
            if ($("input[name=id]").val().length == 0) alert("아이디를 입력해주세요.")
            else if ($("input[name=password]").val().length == 0) alert('비밀번호를 입력해 주세요.')
            // 입력된 id가 없거나 password가 틀리면 error로 이동
            else {
              let vo = $("form").serialize()
              $.ajax({
                url: "/member/login",
                type: "post",
                dataType: "json",
                data: vo,
                success: function (result) {
                  console.log(result)
                  if (result['message'] == "1") {
                    window.location.href = '/ipet/index';
                  }
                  else alert(result['message'])

                },
                error: function (result, textStatus, errorThrown) {
                  alert(result)
                }
              })
            }
          }
        })

      })
    </script>

    <body class="is_preload">
      <div class="page_wrapper">
        <%@ include file="../header.jsp" %>
          <section class="wrapper style1">
            <section class="container">
              <div id="content">
                <div class="login-wrapper"
                  style="display: flex; justify-content: center; align-items: center; margin-bottom: 20px;">
                  <form action="#" method="post">
                    아이디&nbsp; <input type='text' id="mid" name="id"
                      style="width:380px; height:42px;text-align: center;" /><br />
                    비밀번호 <input id="mpassword" type="password" name='password'
                      style="width:380px; height:42px;text-align: center;" /><br />
                    <button id="login" type="button"> 로그인 </button> &nbsp;
                    <button id="findId" type="button" data-toggle="modal" data-target="#findModal"> 아이디 찾기
                    </button>&nbsp;
                    <button id="findPassword" type="button" data-toggle="modal" data-target="#findModal"> 비밀번호 찾기
                    </button>&nbsp;
                  </form>
                </div>
                <div class="ad-wrapper"
                  style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                  <a href="https://www.lacoste.com/kr/90-anniversary.html?utm_source=naver&utm_medium=branding&utm_campaign=kr_brandcampaign-ss23reach_&utm_term=coupleboard&utm_content=vintage;"
                    id="ac_banner_a" target="_blank">
                    <img
                      src="	https://ssl.pstatic.net/melona/libs/1442/1442950/d1a9361bd50c99be2d31_20230428111327912.jpg"
                      alt="광고 이미지" style="width: 1400px; height: 200px;"></a>
                </div>
              </div>
            </section>
          </section>
      </div>
      <div class="modal fade" id="findModal" tabindex="-1" role="dialog" aria-labelledby="findModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
          </div>
        </div>
      </div>

      <%@include file="../footer.jsp" %>
    </body>

    </html>