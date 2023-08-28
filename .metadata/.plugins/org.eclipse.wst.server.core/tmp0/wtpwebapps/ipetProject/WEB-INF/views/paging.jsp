<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<div class='pagination'>
									<c:if test="${paging.prev}">
										<c:set var="prevPage" value="${paging.startNum-1}" />
										<a style="cursor:pointer;"data-page="${prevPage}" class="pageClass">이전</a>
									</c:if>

									<c:forEach begin="${paging.startNum}"
										end="${paging.startNum+9 > paging.lastNum ? paging.lastNum : paging.startNum+9}"
										var="page">
										<c:choose>
											<c:when test="${page ne paging.pageNum}">
												<a style="cursor:pointer;" class="pageClass" data-page="${page}">${page}</a>
										 	</c:when>
										 	 <c:when test="${page eq paging.pageNum}">
										 	 	<a style="cursor:pointer; background-color: #cfe2f3;"class="pageClass" data-page="${page}">${page}</a>
										 	 </c:when>
										 </c:choose>
									</c:forEach>

									<c:if test="${paging.next}">
										<c:set var="nextPage" value="${paging.startNum+10}" />
										<a style="cursor:pointer;" class="pageClass" data-page="${nextPage}">다음</a>
									</c:if>
</div>