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
        // "수정" 버튼: 데이터를 수정하고 해당 페이지에 잔류한다.
        $("#modify").click(function () {
          if (
            $("#textcontent").val().length == 0 ||
            $("#textcontent").val() == ""
          ) {
            alert("내용을 입력해주세요.");
          } else if ($("#title").val().length == 0) {
            alert("제목을 입력해주세요.");
          } else {
            if (confirm("수정 하시겠습니까?")) {
              var data = $("#modifyContent")[0];
              var formData = new FormData(data);

              $.each($("input[type='file']")[0].files, function(i, file) {
              	formData.append('imgList', file);
              	console.log(formData.get("imgList"))
  			});
              
              var bno = $("#bno").val();
              console.log(data);

              $.ajax({
                type: "post",
                url: "/community/modify",
                dataType: "json",
                contentType: false,
                processData: false,
                data: formData,
                success: function (result) {
                  alert(result["text"]);
                  location.href = "/community/read?bno=" + bno;
                  location.reload();
                },
              });
            }
          }
        });

        // "삭제" 버튼: 데이터를 수정하고 메인 페이지로 돌아간다.
        $("#delete").click(function () {
          if (confirm("삭제 하시겠습니까?")) {
            var bno = $("#bno").val();

            $.ajax({
              type: "delete",
              url: "/community/delete",
              data: JSON.stringify(bno),
              contentType: "application/json; charset=utf-8",
              dataType:"json",
              success: function (result) {
                alert(result["text"]);
                location.href = "/ipet/community";
              },
            });
          }
        });

        // "이전으로" 버튼: 이전 페이지(메인 페이지로 이동)
        $("#back").click(function () {
          location.href = "/ipet/community";
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
        $(modifyContent.img).on("change", function (e) {
          var reader = new FileReader();
          reader.onload = function (e) {
            $("#img").attr("src", e.target.result);
          };
          reader.readAsDataURL(this.files[0]);
        });

        $("#proimg").on("click", function () {
          $("#modifyContent input[name='img']").click();
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

      .oneImage {
        max-width: 960px;
        max-height: 560px;
      }

      #replyImageContainer {
        display: none;
        margin: 10px;
      }

      #textcontent {
        margin-top: 10px;
        margin-bottom: 10px;
      }
    </style>
  </head>

  <body class="is_preload">
    <div class="page_wrapper">
      <%@ include file="../header.jsp" %>
      <section class="wrapper style1">
        <section class="container">
          <h2 style="display: inline">게시글 수정하기</h2>
          <div id="content">
            <form id="modifyContent" enctype="multipart/form-data">
              번호:
              <input
                type="text"
                name="bno"
                id="bno"
                value="${data.bno}"
                readonly
              />
              제목:
              <input
                type="text"
                name="title"
                id="title"
                value="${data.title}"
              />
              이미지:
 <c:if test="${not empty data.imageName}">
 <div>
                         <c:set var="imgName" value="${fn:split(data.imageName, '#')}" />
                        <c:forEach var="imageName" items="${imgName}">
                          <img src="/community/displayContent?imageName=${imageName}" class="oneImage" />
                        </c:forEach>
                        <br />
 </div>

                      </c:if>
              내용:
              <textarea name="content" id="textcontent" cols="30" rows="10">
${data.content}</textarea
              >
              작성자:
              <input
                type="text"
                name="writer"
                id="writer"
                value="${data.writer}"
                readonly
              />
              <c:if test="${data.updateDate == null}">
                입력일:
                <input
                  type="text"
                  id="regDate"
                  value="<fmt:formatDate pattern='yyyy년 M월 d일 hh시 m분' value='${data.regDate}' />"
                  readonly
                />
              </c:if>
              <c:if test="${data.updateDate != null}">
                수정일:
                <input
                  type="text"
                  id="updateDate"
                  value="<fmt:formatDate pattern='yyyy년 M월 d일 hh시 m분' value='${data.updateDate}' />"
                  readonly
                />
              </c:if>
              <div style="display: flex; align-items: center">
                <a id="replyImageButton">첨부파일 올리기</a>
                <div id="replyImageContainer">
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
              <input type="button" id="modify" value="수정" />
              <input type="button" id="delete" value="삭제" />
              <input type="button" id="back" value="이전으로" />
            </form>
          </div>
        </section>
      </section>
    </div>

    <%@include file="../footer.jsp" %>
  </body>
</html>
