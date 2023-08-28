<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <!DOCTYPE HTML>
    <html>

    <head>
      <title>I-Pet</title>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
      <link rel="stylesheet" href="../resources/assets/css/main.css" />
      <link rel="stylesheet" href="../resources/assets/css/community.css" />
      <link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
      <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
      <script>
        $(document).ready(function () {

          $("#csvClick").click(function (e) {
            e.preventDefault();
            if (confirm("고객정보를 다운로드 하시겠습니까?")) {
              $.ajax({
                url: "http://localhost:5500/admin/getlist"
              })
              setTimeout(function () {
                $("#csvDownload")[0].click();
              }, 2000)
            }
          })
        })				
      </script>
    </head>
<style>
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
        </style>
    <body class="is-preload">
      <div id="page-wrapper">

        <%@ include file="adminheader.jsp" %>
          <!-- Main -->
          <section class="wrapper style1">
            <div class="container">
              <div id="content">

                <!-- Content -->

                <article>
                  <header style="display: inline;">
                    <h2 style="display: inline;">회원 정보</h2>
                    <a id='csvClick' href="#"><span style="float:right;">고객정보 엑셀 다운로드</span></a>
                    <a id='csvDownload' href="/filepath/memberList.csv" download="고객리스트.csv" style="display: none;"></a>
                  </header>

                  <div class="board">
                    <table class="table">
						<thead style="font-weight: bolder; background-color: #cfe2f3; white-space: nowrap;">
                        <th>고객 번호</th>
                        <th>이름</th>
                        <th>주소</th>
                        <th>이메일</th>
                        <th>아이디</th>
                        <th>가입 날짜</th>
                        <th></th>
                      </thead>
                      <tbody style="white-space: nowrap;">
                        <c:forEach var="list" items="${memberList}">
                          <tr>
                            <td>${list.mno }</td>
                            <td>${list.name}</td>
                            <td>${list.address1} ${list.address2 }</td>
                            <td>${list.email}</td>
                            <td>${list.id}</td>
                            <td><fmt:formatDate pattern="yyyy년 M월 d일 hh시 m분" value="${list.createDate}"/></td>
                            <td><a href="/admin/update?mno=${list.mno}"><input type="button" value="고객정보 수정" /></a>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                    <div class="pagination">
                    <c:if test="${paging.prev}">
                      <c:set var="prevPage" value="${paging.startNum-1}" />
                      <a href="/admin/member?pageNum=${prevPage}" class="pageClass">이전</a>
                    </c:if>

                    <c:forEach begin="${paging.startNum}"
                      end="${paging.startNum+9 > paging.lastNum ? paging.lastNum : paging.startNum+9}" var="page">
                      <c:choose>
						<c:when test="${page ne paging.pageNum}">
							<a style="cursor:pointer;" class="pageClass" href="/admin/member?pageNum=${page}">${page}</a>
					 	</c:when>
					 	 <c:when test="${page eq paging.pageNum}">
					 	 	<a style="cursor:pointer; background-color: #cfe2f3;"class="pageClass" href="/admin/member?pageNum=${page}">${page}</a>
					 	 </c:when>
					 </c:choose>
                    </c:forEach>

                    <c:if test="${paging.next}">
                      <c:set var="nextPage" value="${paging.startNum+10}" />
                      <a class="pageClass" href="/admin/member?pageNum=${nextPage}">다음</a>
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