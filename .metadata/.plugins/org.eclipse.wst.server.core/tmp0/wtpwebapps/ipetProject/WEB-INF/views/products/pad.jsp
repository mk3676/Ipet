<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <!DOCTYPE HTML>
    <!--
Arcana by HTML5 UP
html5up.net | @ajlkn
Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
    <html>

    <head>
      <title>I-Pet</title>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
     <link rel="stylesheet" href="../resources/assets/css/main.css" />
      <link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
      <link href="../resources/assets/css/styles.css" rel="stylesheet" />
     <style>
		 .product-container {
          display: flex;
          flex-wrap: wrap;
          justify-content: center;
        }

        .product-item {
          width: 33.33%;
          padding: 10px;
          text-align: center;
        }

        /* Adjust pagination styles */
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
      <script>
      
      </script>
    </head>

    <body>

    <!-- Header-->
     <div id="page-wrapper">
         <%@include file="../header.jsp" %>
    </div>
     <%@include file="productsSection.jsp" %>
    <div class="main-section">
    <!-- Section-->
    <section class="py-5">
    
        <div class="container px-4 px-lg-5 mt-5">
	        <h1 style="text-align: center;">패드/장난감 판매</h1>
            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
             <c:forEach items="${foodList}" var="data">
                <div class="col mb-5">
                    <div class="card h-100">
                       <c:choose>
                            <c:when test="${not empty data.imageName}">
                              <a href="/products/read?pno=${data.pno}"><img  class="card-img-top" src="/productImage/${data.imageName}?timestamp=12345" class="product-image" /></a>
                            </c:when>
                            <c:when test="${empty data.imageName}">
                              <a href="/products/read?pno=${data.pno}"><img  class="card-img-top" src="../resources/images/noImage.jpg" class="product-image" /></a>
                            </c:when>
                          </c:choose>
                        <div class="card-body p-4">
                            <div class="text-center">
                                <!-- Product name-->
                                <h5 class="fw-bolder">상품명</h5>
                                <h5 class="fw-bolder"> ${data.pname }</h5>
                                <!-- Product price-->
                                <br/>
                                <h5 class="fw-bolder"><fmt:formatNumber value="${data.price}"/>원</h5>
                            </div>
                        </div>
                        <!-- Product actions-->
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                            <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="/products/read?pno=${data.pno}">상세보기</a>
                            </div>
                        </div>
                    </div>
                </div>
                </c:forEach>
               
 
            </div>
              <div class="pagination">
                <c:if test="${paging.prev}">
                  <c:set var="prevPage" value="${paging.startNum-1}" />
                  <a href="/products/pad?pageNum=${prevPage}">이전</a>
                </c:if>
                <c:forEach begin="${paging.startNum}"
                  end="${paging.startNum+9 > paging.lastNum ? paging.lastNum : paging.startNum+9}" var="page">
                  <c:choose>
                  <c:when test="${page ne paging.pageNum}">
						<a style="cursor:pointer;" class="pageClass" href="/products/pad?pageNum=${page}">${page}</a>
				 	 </c:when>
				 	 <c:when test="${page eq paging.pageNum}">
				 	 	<a style="cursor:pointer; background-color: #cfe2f3;"class="pageClass" href="/products/pad?pageNum=${page}">${page}</a>
				 	 </c:when>
				</c:choose>
                </c:forEach>
                <c:if test="${paging.next}">
                  <c:set var="nextPage" value="${paging.startNum+10}" />
                  <a href="/products/pad?pageNum=${nextPage}" class="pageClass">다음</a>
                </c:if>
              </div>
            </div>
          </section>
          </div>
          <%@include file="../footer.jsp" %>


      <!-- Scripts -->
      <script src="../resources/assets/js/jquery.min.js"></script>
      <script src="../resources/assets/js/jquery.dropotron.min.js"></script>
      <script src="../resources/assets/js/browser.min.js"></script>
      <script src="../resources/assets/js/breakpoints.min.js"></script>
      <script src="../resources/assets/js/util.js"></script>
      <script src="../resources/assets/js/main.js"></script>
    </body>

    </html>