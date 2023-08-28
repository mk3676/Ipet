<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>

<head>
	<title>I-Pet</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="../resources/assets/css/main.css" />
	<link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
      <script>
        $(document).ready(function () {
          
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
        }</style>
<body class="is-preload">
	<div id="page-wrapper">

		<%@include file ="adminheader.jsp" %>
			<section class="wrapper style1">
	            <div class="container">
	              <div id="content">
	
	                <!-- Content -->
	
	                <article>
	                  <header style="display: inline;">
	                    <h2 style="display: inline;">상품 리스트</h2>
	                  </header>
	
	                  <a href = "/admin/productInsert"><button id="insertproduct" style="float: right;">상품 추가</button></a>
					  
	                  <div class="product">
	                  <br/>
	                   <table class="table">
						<thead style="font-weight: bolder; background-color: #cfe2f3">
	                        <th>상품번호</th>
	                        <th>상품사진</th>
	                        <th>카테고리</th>
	                        <th>상품이름</th>
	                        <th>상품가격</th>
	                        <th>등록일</th>
	                        <th>작성자</th>
	                        <th>정보수정</th>
	                      </thead>
	                      <tbody style="white-space: nowrap;">
	                        <c:forEach var="productList" items="${productList}">
	                          <tr>
	                            <td>${productList.pno}</td>
	                            <c:choose>
									<c:when test="${not empty productList.imageName}">
	                            		<td><img src="/productImage/${productList.imageName }?timestamp=12345" style="width:70px;height:70px"/></td>
	                            	</c:when>
	                            	<c:when test="${empty productList.imageName }">
	                            		<td><img src="../resources/images/noImage.jpg" style="width:70px;height:70px"/></td>
	                            	</c:when>
	                            </c:choose>
	                            <c:choose>
	                            	<c:when test="${productList.category eq 'food' }">
	                            		<td>사료/간식</td>
	                            	</c:when>
	                            	<c:when test="${productList.category eq 'pad' }">
	                            		<td>패드/장난감</td>
	                            	</c:when>
	                            	<c:when test="${productList.category eq 'bath' }">
	                            		<td>목욕/하네스</td>
	                            	</c:when>
	                            </c:choose>
	                            <td>${productList.pname}</td>
	                            <td>${productList.price}</td>
	                             <td><fmt:formatDate pattern="yyyy년 M월 d일 hh시 m분" value="${productList.regtime}" /></td>
	                             <th>${productList.id }</th>
	                             <td><a href="/admin/productsUpdate?pno=${productList.pno}">수정</a></td>
	                            
	                          </tr>
	                        </c:forEach>
	                      </tbody>
	                    </table>
	                    <div class='pagination'>
	                     <c:if test="${paging.prev}">
                        <c:set var="prevPage" value="${paging.startNum-1}" />
                        <a href="/admin/productList?pageNum=${prevPage}" class="pageClass">이전</a>
                      </c:if>

                      <c:forEach begin="${paging.startNum}"
                        end="${paging.startNum+9 > paging.lastNum ? paging.lastNum : paging.startNum+9}" var="page">
                        <c:choose>
							<c:when test="${page ne paging.pageNum}">
								<a style="cursor:pointer;" class="pageClass" href="/admin/productList?pageNum=${page}">${page}</a>
						 	</c:when>
						 	 <c:when test="${page eq paging.pageNum}">
						 	 	<a style="cursor:pointer; background-color: #cfe2f3;"class="pageClass" href="/admin/productList?pageNum=${page}">${page}</a>
						 	 </c:when>
						 </c:choose>
                      </c:forEach>

                      <c:if test="${paging.next}">
                        <c:set var="nextPage" value="${paging.startNum+10}" />
                        <a class="pageClass" href="/admin/productList?pageNum=${nextPage}">다음</a>
                      </c:if>
                      </div>
	                  </div>
	                </article>
	              </div>
           		</div>
          	</section>
		<%@include file ="../footer.jsp" %>

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