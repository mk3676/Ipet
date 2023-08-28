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
        	$(".answerQna").click(function (e) {
				let link="/admin/answerQna?id="+$(this).data("id");
				  var status = "toolbar=no,scrollbars=no,resizable=no,status=no,menubar=no,width=373, height=574"; 
			    window.open(link,$(this).data("id")+" 고객님",status);
			});
        	$(".deleteQna").click(function(){
        		if(confirm("대화를 삭제 하시겠습니까?")){
	        		$.ajax({
	        			url:$(this).data('url'),
	        			type:"delete",
	        			dataType:"text",
	        			success:function(result){
	        				alert(result);
	        				location.href="/admin/qna"
	        			}
	        		})
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
	                    <h2 style="display: inline;">QnA 리스트</h2>
	                  </header>
					  
	                  <div class="product">
	                  <br/>
	                   <table class="table">
						<thead style="font-weight: bolder; background-color: #cfe2f3;white-space: nowrap;">
							<th><a href="/admin/qna?readCheck=n">안읽은 메세지 보기</a></th>
	                        <th>고객아이디</th>
	                        <th>최근 문의 내용</th>
	                        <th>최근 문의 시간</th>
	                        <th></th>
	                      </thead>
	                      <tbody style="white-space: nowrap;">
	                        <c:forEach var="chatList" items="${chatList}">
	                          <tr>
	                          	<c:choose>
	                          		<c:when test="${chatList.readCheck eq 'n' }">
	                          			<td>읽지않음</td>
	                          		</c:when>
	                          		<c:otherwise>
	                          			<td>읽음</td>
	                          		</c:otherwise>
	                          	</c:choose>
	                            <td>${chatList.id}</td>
	                            <td>${chatList.contents}</td>
	                            <td><fmt:formatDate pattern="yyyy년 M월 d일 hh시 m분" value="${chatList.insertDate}" /></td>
	                            <td> <a class="answerQna" data-id="${chatList.id }" style="cursor: pointer;">답변 하기</a> / <a class="deleteQna" data-url="/admin/deleteQna?id=${chatList.id}" style="cursor: pointer;">채팅 지우기</a></td> 	                            
	                          </tr>
	                        </c:forEach>
	                      </tbody>
	                    </table>
	                    <div class='pagination'>
	                     <c:if test="${paging.prev}">
                        <c:set var="prevPage" value="${paging.startNum-1}" />
                        <a href="/admin/qna?pageNum=${prevPage}&readCheck=${readCheck}" class="pageClass">이전</a>
                      </c:if>

                      <c:forEach begin="${paging.startNum}"
                        end="${paging.startNum+9 > paging.lastNum ? paging.lastNum : paging.startNum+9}" var="page">
                        <c:choose>
							<c:when test="${page ne paging.pageNum}">
								<a style="cursor:pointer;" class="pageClass" href="/admin/qna?pageNum=${page}&readCheck=${readCheck}">${page}</a>
						 	</c:when>
						 	 <c:when test="${page eq paging.pageNum}">
						 	 	<a style="cursor:pointer; background-color: #cfe2f3;"class="pageClass" href="/admin/qna?pageNum=${page}&readCheck=${readCheck}">${page}</a>
						 	 </c:when>
						 </c:choose>
                      </c:forEach>

                      <c:if test="${paging.next}">
                        <c:set var="nextPage" value="${paging.startNum+10}" />
                        <a class="pageClass" href="/admin/qna?pageNum=${nextPage}&readCheck=${readCheck}">다음</a>
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