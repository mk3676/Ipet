<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, user-scalable=no"
    />
    <link rel="stylesheet" href="../resources/assets/css/main.css" />
    <link rel="stylesheet" href="../resources/assets/css/community.css" />
    <link
      rel="shortcut icon"
      type="image/x-icon"
      href="../resources/images/favicon.jpg"
    />
    <title>i-Pet</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script>
      $(document).ready(function () {
        // 댓글 수정 후 전송
        $("#submitButton").click(function (e) {
          e.preventDefault();

          if ($("#reply").val().length == 0) {
            alert("댓글을 입력해주세요.");
          } else {
            var data = $("#modifyReply")[0];
            var formData = new FormData(data);
            
            $.each($("input[type='file']")[0].files, function(i, file) {
              	formData.append('imgList', file);
              	console.log(formData.get("imgList"))
  			});
            
            console.log(formData);

            $.ajax({
              type: "post",
              url: "/community/modifyReply",
              dataType: "json",
              contentType: false,
              processData: false,
              data: formData,
              success: function (result) {
                alert(result["text"]);
                location.href = "/community/read?bno=" + $("#bno").val();
              },
            });
          }
        });

        // 첨부파일 on/off
        $("#replyImageButton").click(function () {
          var replyImageContainer = $("#replyImageContainer");

          if (replyImageContainer.css("display") == "none") {
            replyImageContainer.css("display", "block");
          } else {
            replyImageContainer.css("display", "none");
          }
        });

        // 이미지 업로드 시 파일 선택 창이 뜨도록 변경
        $(modifyReply.img).on("change", function (e) {
          var reader = new FileReader();
          reader.onload = function (e) {
            $("#img").attr("src", e.target.result);
          };
          reader.readAsDataURL(this.files[0]);
        });

        $("#proimg").on("click", function () {
          $("#modifyReply input[name='img']").click();
        });
      });
    </script>
    <style>
      @media screen and (max-width: 1680px) {
        .oneImage {
          width: 85%;
        }
      }

      @media screen and (max-width: 1280px) {
        .oneImage {
          width: 85%;
        }
      }

      @media screen and (max-width: 980px) {
        .oneImage {
          width: 85%;
        }
      }

      @media screen and (max-width: 840px) {
        .oneImage {
          width: 85%;
        }
      }

      @media screen and (max-width: 736px) {
        .oneImage {
          width: 85%;
        }
      }

      @media screen and (max-width: 480px) {
        .oneImage {
          width: 85%;
        }
      }

      #replyContent {
        padding-top: 20px;
      }

      #inputReply {
        white-space: nowrap;
      }

      #submitButton {
        width: 100px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      #reply {
        display: inline;
        width: 60%;
        height: 40px;
        margin: 10px;
      }

      #replyImageButton {
        margin: 10px;
      }
    </style>
  </head>

  <body class="is_preload">
    <div class="page_wrapper">
      <%@ include file="../header.jsp" %>
      <section class="wrapper style1">
        <section class="container">
          <h2 style="display: inline">댓글 수정하기</h2>
          <div id="replyContent" style="white-space: nowrap">
            <form id="modifyReply" enctype="multipart/form-data">
              <input
                type="hidden"
                name="bno"
                id="bno"
                value="${reply.bno}"
                readonly
              />
              <input
                type="hidden"
                name="rno"
                id="rno"
                value="${reply.rno}"
                readonly
              />
              <div style="display: flex; align-items: center">
                <img
                  src="../resources/images/comment.png"
                  width="40px"
                  height="40px"
                />
                댓글 수정:
                <input
                  type="text"
                  id="reply"
                  name="reply"
                  value="${reply.reply}"
                  placeholder="댓글을 입력해주세요."
                />
                
                <c:if test="${not empty reply.imageName}">
                  <c:set var="imgName" value="${fn:split(reply.imageName, '#')}" />
                        <c:forEach var="imageName" items="${imgName}">
                          <img src="/community/displayReply?imageName=${imageName}" class="oneImage" />
                        </c:forEach>
                        <br />
                </c:if>
                <input type="button" value="전송" id="submitButton" />
                <a id="replyImageButton">첨부파일 올리기</a>
                <div
                  id="replyImageContainer"
                  style="display: none; margin: 10px"
                >
                  <div>
                    <a id="proimg" class="title" style="cursor: pointer"
                      >파일 선택</a
                    >
                  </div>
                  <img src="http://placehold.it/150x120" id="img" width="150" />
                  <input
                    type="file"
                    id="img"
                    name="img"
                    accept=".gif, .jpg, .png"
                    style="visibility: hidden" multiple
                  />
                </div>
              </div>
            </form>
          </div>
        </section>
      </section>
    </div>

    <%@include file="../footer.jsp" %>
  </body>
</html>
