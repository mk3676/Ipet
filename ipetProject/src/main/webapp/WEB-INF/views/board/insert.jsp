<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="../resources/assets/css/main.css" />
    <link rel="stylesheet" href="../resources/assets/css/community.css" />
    <link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
    <title>i-Pet</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script>
      $(document).ready(function () {
        // 새 글 추가 후 메인 페이지로 이동
        $("#button").click(function () {
          if ($("#title").val.length == 0) {
            alert("제목을 입력해 주세요.")
          }
          else if ($("#textcontent").val().length == 0 || $("#textcontent").val() == '') {
            alert("내용을 입력해 주세요.")
          }
          else if ($("#title").val().length > 0 && $("#textcontent").val().length > 0) {
            var data = $("#insertContent")[0];
            var formData = new FormData(data);

            $.each($("input[type='file']")[0].files, function(i, file) {
            	formData.append('imgList', file);
            	console.log(formData.get("imgList"))
			});
            
            $.ajax({
              type: 'post',
              url: "/community/insert",
              dataType: "json",
              contentType: false,
              processData: false,
              data: formData,
              success: function (result) {
                alert(result["text"])
                location.href = "/ipet/community"
              }
            });
          }
        })

        // "이전으로" 버튼: 이전 페이지(메인 페이지로 이동)
        $("#back").click(function () {
          location.href = "/ipet/community"
        });

        // 첨부파일 on/off
        $("#replyImageButton").click(function () {
          var replyImageContainer = $("#replyImageContainer");

          if (replyImageContainer.css("display") == "none") {
            replyImageContainer.css("display", "block");
          }
          else {
            replyImageContainer.css("display", "none");
          }
        });

        // 이미지 업로드 시 파일 선택 창이 뜨도록 변경
        $(insertContent.img).on("change", function (e) {
          var reader = new FileReader();
          reader.onload = function (e) {
            $("#img").attr("src", e.target.result);
          };
          reader.readAsDataURL(this.files[0]);
        });

        $("#proimg").on("click", function () {
          $("#insertContent input[name='img']").click();
        });
      })
    </script>
  </head>

  <body class="is_preload">
    <div class="page_wrapper">
      <%@ include file="../header.jsp" %>
        <section class="wrapper style1">
          <section class="container">
            <h2 style="display: inline;">게시글 추가하기</h2>
            <div id="content">
              <form id="insertContent" enctype="multipart/form-data">
                제목: <input type="text" name="title" id="title">
                내용: <textarea name="content" id="textcontent" cols="30" rows="10"></textarea>
                <input type="hidden" name="writer" id="writer" value="${loginMember.id}">
                <a id="replyImageButton" style="margin: 10px;">첨부파일 올리기</a>
                <div id="replyImageContainer" style="display: none; margin: 10px;">
                  <div>
                    <a id="proimg" class="title" style="cursor:pointer; ">파일 선택</a>
                  </div>
                  <img src="http://placehold.it/150x120" id="img" width=150 />
                  <input type="file" id='img' name="img" accept=".gif, .jpg, .png" style="visibility: hidden;" multiple>
                </div>
                <div class="contentButton" style="display: flex; justify-content: center; align-items: center;">
                  <input type="button" id="button" value="전송" style=" width: 100px; margin-right: 20px;">
                  <input type="button" id="back" value="이전으로" style=" width: 100px;">
                </div>
              </form>
            </div>
          </section>
        </section>
    </div>

    <%@include file="../footer.jsp" %>
  </body>

  </html>