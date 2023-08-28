<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html>
<!--
	Arcana by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
  <head>
    <title>I-Pet</title>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, user-scalable=no"
    />
    <link rel="stylesheet" href="../resources/assets/css/main.css" />
    <link
      rel="shortcut icon"
      type="image/x-icon"
      href="../resources/images/favicon.jpg"
    />

    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script>
      $(document).ready(function () {
        $("#chat-icon").click(function () {
          let link = "/member/chat";
          var title = "문의하기";
          var status =
            "toolbar=no,scrollbars=no,resizable=no,status=no,menubar=no,width=373, height=574";
          window.open(link, title, status);
        });

        const imageWrapper = $(".productWrapper");
        const imageCount = 6;
        const imageWidth = 340;
        var currentPosition = 0;

        function moveProductContainer() {
          currentPosition += imageWidth * 3;

          if (currentPosition > (imageCount - 3) * imageWidth) {
            currentPosition = 0;
          }

          imageWrapper.css(
            "transform",
            "translateX(-" + currentPosition + "px)"
          );
        }

        setInterval(moveProductContainer, 3000);
      });
    </script>
    <style>
			#chat-icon {
        width: 75px;
        height: 75px;
        position: fixed;
        right: 20px;
        bottom: 20px;
        z-index: 9999;
      }

      .productSilder {
        width: 1000px;
        height: 500px;
        position: relative;
        overflow: hidden;
        margin: 0 auto;
      }

      .productWrapper {
        display: flex;
        transition: transform 0.5s ease;
      }

      .productContainer {
        white-space: nowrap;
        display: inline-block;
        width: 330px;
        height: 480px;
        background-color: rgb(248, 248, 248);
        box-shadow: 0 8px 8px rgba(0, 0, 0, 0.2);
        border-radius: 1rem;
        margin-left: 10px;
        margin-right: 30px;
      }

      .productPicture {
        border-bottom: 3px solid rgb(230, 230, 230);
        text-align: center;
        margin-top: 5px;
      }

      .productInfoContainer,
      .productInfoContainer div {
        height: 30%;
        display: flex;
        width: 330px;
        flex-direction: column;
        justify-content: center;
        align-items: center;
      }

      .productPrice {
        margin-bottom: 10px;
      }

      .productLink a {
        display: inline;
        border: 2px solid rgb(200, 200, 200);
        border-radius: 0.5rem;
        padding: 5px;
        text-decoration: none;
        font-weight: 400;
        color: black;
      }
    </style>
  </head>

  <body class="is-preload">
    <div id="page-wrapper">
      <%@include file="header.jsp" %>
      <!-- Banner -->
      <section
        id="banner"
        style="
          background-image: url('https://png.pngtree.com/thumb_back/fw800/back_our/20190620/ourmid/pngtree-pet-shop-adoption-cartoon-hand-painted-white-banner-image_170656.jpg');
        "
      >
        <header>
          <h3>애완동물 용품, 동물 병원, 정보 공유를 한번에</h3>
        </header>
      </section>

<section id="top6">
        <h3 style="text-align: center; margin-top: 20px">I-pet 인기 판매 상품</h3>
        <div class="productSilder">
          <div class="productWrapper">
            <c:forEach var="list" items="${productList}">
              <div class="productContainer">
                <div class="productPicture">
                  <img
                    src="/ipet/displayProductImage?imageName=${list.imageName}"
                    width="300px"
                    height="300px"
                  />
                </div>
                <div class="productInfoContainer">
                  <div class="productName">${list.pname}</div>
                  <div class="productPrice">가격 ${list.price}원</div>
                  <div class="productLink">
                    <a href="/products/read?pno=${list.pno}">상세보기</a>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
      </section>


      <!-- Highlights -->
      <section class="wrapper style1">
        <div class="container">
          <div class="row gtr-200">
            <section class="col-4 col-12-narrower">
              <div class="box highlight">
                <img
                  src="../resources/images/foodImg.png"
                  style="width: 73px; height: 73px"
                />
                <h3>반려동물 용품 판매</h3>
                <p>
                  i-Pet에서 엄선한 반려동물 용품들을 지금 반려동물 용품 판매
                  페이지에서 만나보세요.
                </p>
              </div>
            </section>
            <section class="col-4 col-12-narrower">
              <div class="box highlight">
                <img
                  src="../resources/images/hospitalImg.png"
                  style="width: 73px; height: 73px"
                />
                <h3>지역 동물병원 검색</h3>
                <p>
                  여러분의 집 근처에 있는 동물병원을 가장 빠르게 검색해드립니다.
                </p>
              </div>
            </section>
            <section class="col-4 col-12-narrower">
              <div class="box highlight">
                <img
                  src="../resources/images/communityImg.png"
                  style="width: 73px; height: 73px"
                />
                <h3>반려동물 정보 공유</h3>
                <p>
                  소동물도 OK! 전국 방방곡곡의 많은 사람들과 당신의 반려동물에
                  대해 이야기해봐요!
                </p>
              </div>
            </section>
          </div>
        </div>
      </section>

        <c:if test="${not empty loginMember }">
          <!-- chat -->
          <c:if test="${loginMember.auth == 'm' }">
							<div class="chat">
								<img src="../resources/images/chat-icon.png" alt="Chat Icon" id="chat-icon" style="cursor:pointer;">
							</div>
						</c:if>
        </c:if>
    </div>

    <%@include file="footer.jsp" %>

    <!-- Scripts -->
    <script src="../resources/assets/js/jquery.min.js"></script>
    <script src="../resources/assets/js/jquery.dropotron.min.js"></script>
    <script src="../resources/assets/js/browser.min.js"></script>
    <script src="../resources/assets/js/breakpoints.min.js"></script>
    <script src="../resources/assets/js/util.js"></script>
    <script src="../resources/assets/js/main.js"></script>
  </body>
</html>
