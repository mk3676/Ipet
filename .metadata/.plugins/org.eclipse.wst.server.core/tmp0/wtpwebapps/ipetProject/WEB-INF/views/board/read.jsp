<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
              // "수정" 버튼: 데이터를 수정하기 위해 수정 페이지로 이동한다.
              $("#modify").click(function () {
                var bno = $("#bno").val();

                location.href = "/community/modify?bno=" + bno
              });

              // "이전으로" 버튼: 이전 페이지(메인 페이지로 이동)
              $("#back").click(function () {
                location.href = "/ipet/community"
              });

              // 댓글 추가
              $("#submitButton").click(function () {
                if ($("#reply").val().length == 0) {
                  alert("댓글을 입력해주세요.")
                }
                else {
                  var data = $("#insertReply")[0];
                  var formData = new FormData(data);
                  console.log(formData)

                  $.each($("input[type='file']")[0].files, function(i, file) {
            		formData.append('imgList', file);
            		alert(formData.get("imgList"))
				});
                  
                  $.ajax({
                    type: 'post',
                    url: "/community/insertReply",
                    dataType: "json",
                    contentType: false,
                    processData: false,
                    data: formData,
                    success: function (result) {
                      alert(result["text"])
                      location.href = "/community/read?bno=" + $("#bno").val()
                    }
                  });
                }
              });

              // 댓글 삭제
              $("a[name='deleteReply']").click(function () {
                if (confirm("삭제 하시겠습니까?")) {
                  var rno = $("#rno").val()
                  $.ajax({
                    type: 'delete',
                    url: "/community/deleteReply",
                    data: JSON.stringify(rno),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (result) {
                      alert(result["text"]);
                      location.reload();
                    }
                  });
                }
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
              $(insertReply.img).on("change", function (e) {
                var reader = new FileReader();
                reader.onload = function (e) {
                  $("#img").attr("src", e.target.result);
                };
                reader.readAsDataURL(this.files[0]);
              });

              $("#proimg").on("click", function () {
                $("#insertReply input[name='img']").click();
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

            #content {
              border: 1px solid rgb(102, 102, 102);
              padding: 10px;
              border-radius: 0.5rem;
              white-space: nowrap;
              min-height: 400px;
              margin-top: 20px;
              margin-bottom: 20px"

            }

            .oneImage {
              max-width: 960px;
              max-height: 560px;
            }

            #content-regDate,
            .date {
              float: right;
            }

            #content-writer,
            .replyID {
              float: left;
            }

            #content-title {
              font-weight: bold;
              font-size: 30px;
              margin-top: 30px;
              margin-bottom: 30px;
            }

            #content-content {
              margin-top: 30px;
              margin-bottom: 30px;
            }

            .contentButton,
            .button-replyContainer {
              display: flex;
              justify-content: center;
              align-items: center;
            }

            #modify {
              width: 100px;
              margin-right: 20px;
            }

            #back {
              width: 100px;
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
                  <h2 style="display: inline;">게시글 읽기</h2>
                  <!-- Content -->
                  <div id="content">
                    <input type="hidden" name="bno" id="bno" value="${data.bno}" readonly>
                    <div>
                      <span id="content-regDate">
                        <c:if test="${data.updateDate == null}">
                          작성일:
                          <fmt:formatDate pattern='yyyy년 M월 d일 hh시 m분' value='${data.regDate}' />
                        </c:if>
                        <c:if test="${data.updateDate != null}">
                          수정일:
                          <fmt:formatDate pattern='yyyy년 M월 d일 hh시 m분' value='${data.updateDate}' />
                        </c:if>
                      </span>
                      <span id="content-writer">
                        작성자: ${data.writer}
                      </span>
                    </div>
                    <br>
                    <div id="content-title">
                      ${data.title}
                    </div>
                    <div id="content-content" contentEditable="false">
                      <c:if test="${not empty data.imageName}">
                        <c:set var="imgName" value="${fn:split(data.imageName, '#')}" />
                        <c:forEach var="imageName" items="${imgName}">
                          <img src="/community/displayContent?imageName=${imageName}" class="oneImage" />
                        </c:forEach>
                      </c:if>
                       <br />
                      ${data.content}
                    </div>
                  </div>
                  <!-- Content 수정 -->
                  <div class="contentButton">
                    <c:if test="${loginMember.id == data.writer || loginMember.auth eq 'a'}">
                      <input type="button" id="modify" value="수정">
                    </c:if>
                    <input type="button" id="back" value="이전으로">
                  </div>
                  <div id="replyContent">
                    <!-- 댓글 추가 -->
                    <div id="inputReply">
                      <form id="insertReply" enctype="multipart/form-data">
                        <input type="hidden" name="bno" id="bno" value="${data.bno}" readonly>
                        <input type="hidden" name="id" id="id" value="${loginMember.id}" readonly>
                        <div style="display: flex; align-items: center;">
                          <img src="../resources/images/comment.png" width="40px" height="40px">
                          댓글 작성: <input type="text" id="reply" name="reply" placeholder="댓글을 입력해주세요.">
                          <input type="button" value="전송" id="submitButton">
                          <a id="replyImageButton">첨부파일 올리기</a>
                          <div id="replyImageContainer" style="display: none; margin: 10px;">
                            <div>
                              <a id="proimg" class="title" style="cursor:pointer; ">파일 선택</a>
                            </div>
                            <img src="http://placehold.it/150x120" id="img" width=150 />
                            <input type="file" id='img' name="img" accept=".gif, .jpg, .png"
                              style="visibility: hidden;" multiple>
                          </div>
                        </div>
                      </form>
                    </div>
                  </div>
                  <!-- 댓글 리스트 -->
                  <div id="showReply">
                    <c:forEach var="list" items="${replyList}">
                      <div class="replyContainer">
                        <span class="replyID">작성자: ${list.id}</span>
                        <span class="date">작성일:
                          <fmt:formatDate pattern="yyyy년 M월 d일 hh시 m분" value="${list.replyDate}" />
                        </span><br>
                         <c:if test="${not empty list.imageName}">
                        <c:set var="imgName" value="${fn:split(list.imageName, '#')}" />
                        <c:forEach var="imageName" items="${imgName}">
                        <div class="image-replyContainer" style="text-align: left; margin: 10px;">
                          <img src="/community/displayReply?imageName=${imageName}" class="oneImage" />
                          </div>
                        </c:forEach>
                      </c:if>
                        <div class="reply" style="text-align: left; margin: 10px;">
                          ${list.reply}</div>
                        <c:if test="${list.id == loginMember.id || loginMember.auth eq 'a'}">
                          <div class="button-replyContainer">
                            <a href="/community/modifyReply?rno=${list.rno}&bno=${list.bno}"
                              style="padding: 5px 5px 0px 5px">수정</a>
                            <a name="deleteReply" style="cursor: pointer; padding: 5px 5px 0px 5px">삭제</a>
                            <input type="hidden" name="rno" id="rno" value="${list.rno}">
                          </div>
                        </c:if>
                      </div>
                    </c:forEach>
                  </div>
                </section>
              </section>
          </div>

          <%@include file="../footer.jsp" %>
        </body>

        </html>