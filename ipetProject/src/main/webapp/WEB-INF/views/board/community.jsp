<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE HTML>
      <html>

      <head>
        <title>i-Pet</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
        <link rel="stylesheet" href="../resources/assets/css/main.css" />
        <link rel="stylesheet" href="../resources/assets/css/community.css" />
        <link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
        <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
        <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
        <script>
          $(document).ready(function () {
            $("#insertion").click(function () {
              location.href = "/community/insert"
            });
            $("#searchCondition").change(function () {
              var searchOption = $("#searchOption").val();
              var searchCondition = $("#searchCondition").val();

              location.href = "/ipet/community?searchOption=" + searchOption + "&searchCondition=" + searchCondition
            })
          })
        </script>
        <style>
          .searchCondition {
            display: inline;
            width: 100px;
          }

          .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
          }

          .pagination a {
            margin: 0 5px;
            color: #333;
            text-decoration: none;
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
          }

          .pagination a.active {
            background-color: #333;
            color: #fff;
          }

          thead tr th {	
            border-bottom: 1px solid #333;
          }
          
          tbody tr td {
            font-size: 16px;
            border-bottom: 1px solid #e4e4e4;
            padding-top: 5px; 
            padding-bottom: 5px;
          }
        </style>
      </head>

      <body class="is-preload">
        <div id="page-wrapper">
          <%@ include file="../header.jsp" %>
            <!-- Main -->
            <section class="wrapper style1">
              <div class="container">
                <div id="content">
                  <!-- Content -->
                  <article>
                    <header style="display: inline;">
                      <h2 style="display: inline;">게시글 목록</h2>
                    </header>
                    <c:if test="${not empty loginMember.id}">
                      <button id="insertion" style="float: right;">게시글 추가</button>
                    </c:if>
                    <div class="searchSection" align="center" style="padding: 10px">
                      <select name="searchOption" id="searchOption" style="height: 40px; display: inline;">
                        <c:choose>
                          <c:when test="${empty searchOption}">
                            <option value=1>제목</option>
                            <option value=2>내용</option>
                            <option value=3>작성자</option>
                          </c:when>
                          <c:when test="${not empty searchOption}">
                            <c:choose>
                              <c:when test="${searchOption == 1}">
                                <option value=1 selected>제목</option>
                                <option value=2>내용</option>
                                <option value=3>작성자</option>
                              </c:when>
                              <c:when test="${searchOption == 2}">
                                <option value=1>제목</option>
                                <option value=2 selected>내용</option>
                                <option value=3>작성자</option>
                              </c:when>
                              <c:when test="${searchOption == 3}">
                                <option value=1>제목</option>
                                <option value=2>내용</option>
                                <option value=3 selected>작성자</option>
                              </c:when>
                            </c:choose>
                          </c:when>
                        </c:choose>
                      </select>
                      <c:choose>
                        <c:when test="${empty searchCondition}">
                          <input type="text" name="searchCondition" id="searchCondition"
                            placeholder="키워드 입력 후 '엔터키'를 눌러주세요." style="width: 400px; height: 44px; display: inline;">
                        </c:when>
                        <c:when test="${not empty searchCondition}">
                          <input type="text" name="searchCondition" id="searchCondition" value="${searchCondition}"
                            style="width: 400px; height: 44px; display: inline;">
                        </c:when>
                      </c:choose>
                    </div>
                    <div class="board">
                      <table style="text-align: center; white-space: nowrap;">
                        <thead>
                          <tr>
                            <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">내용</th>
                            <th scope="col">작성자</th>
                            <th scope="col">작성일</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="list" items="${list}">
                            <tr>
                              <td scope="row">${list.bno}</td>
                              <td><a href="/community/read?bno=${list.bno}">${list.title}</a></td>
                              <td>${list.content}</td>
                              <td>${list.writer}</td>
                              <td>
                                <fmt:formatDate pattern="yyyy년 M월 d일 hh시 m분" value="${list.regDate}" />
                              </td>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                      <div class="pagination">
                        <c:if test="${paging.prev}">
                          <c:set var="prevPage" value="${paging.startNum-1}" />
                          <a href="/ipet/community?pageNum=${prevPage}&searchOption=${searchOption}&searchCondition=${searchCondition}"
                            class="pageClass">이전</a>
                        </c:if>

                        <c:forEach begin="${paging.startNum}"
                          end="${paging.startNum+9 > paging.lastNum ? paging.lastNum : paging.startNum+9}" var="page">
                          <c:choose>
                            <c:when test="${page ne paging.pageNum}">
                              <a style="cursor:pointer;" class="pageClass"
                                href="/ipet/community?pageNum=${page}&searchOption=${searchOption}&searchCondition=${searchCondition}">${page}</a>
                            </c:when>
                            <c:when test="${page eq paging.pageNum}">
                              <a style="cursor:pointer; background-color: #cfe2f3;" class="pageClass"
                                href="/ipet/community?pageNum=${page}&searchOption=${searchOption}&searchCondition=${searchCondition}">${page}</a>
                            </c:when>
                          </c:choose>

                        </c:forEach>

                        <c:if test="${paging.next}">
                          <c:set var="nextPage" value="${paging.startNum+10}" />
                          <a class="pageClass"
                            href="/ipet/community?pageNum=${nextPage}&searchOption=${searchOption}&searchCondition=${searchCondition}">다음</a>
                        </c:if>
                      </div>
                    </div>
                  </article>
                </div>
              </div>
            </section>

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