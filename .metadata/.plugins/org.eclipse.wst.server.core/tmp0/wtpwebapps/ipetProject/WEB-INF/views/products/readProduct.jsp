<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE HTML>
    <html>

    <head>
        <title>I-Pet</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
        <link rel="stylesheet" href="../resources/assets/css/main.css" />
        <link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
        <script src="https://code.jquery.com/jquery-3.6.3.js"></script>

        <style>
            .product-container {
                display: flex;
                margin-bottom: 20px;
            }

            .product-image {
                flex: 1;
                margin-right: 10px;
            }

            .product-details {
                flex: 1;
                display: flex;
                flex-direction: column;
            }

            .product-details label {
                margin-bottom: 10px;
            }

            .product-description {
                border: 1px solid #ccc;
                padding: 20px;
                text-align: center;
            }


            .quantity-controls {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 10px;
            }

            .quantity-controls input[type="button"] {
                width: auto;
                /* 가로 크기를 자동으로 설정 */
                height: 50px;
                /* 세로 크기를 50px로 고정 */
                font-size: 14px;
                background-color: #ccc;
                border: none;
                color: #fff;
                padding: 0;
                border-radius: 0;
            }

            .quantity-input {
                width: 50px;
                height: 50px;
                /* 정사각형으로 변경 */
                text-align: center;
                font-weight: bold;
                padding: 5px;
            }

            .action-buttons {
                display: flex;
                justify-content: center;
                margin-top: 10px;
            }

            .action-buttons input[type="submit"] {
                padding: 10px;
                width: 150px;
                margin: 0 5px;
            }


            .action-buttons #buy-button,
            .action-buttons #cart-button {
                padding: 10px !important;
                width: 150px !important;
                margin: 0 5px !important;
            }

            input[type="text"].price,
            input[type="text"].total {
                font-size: 1.2em;
                font-weight: bold;
                text-align: center;
                border: none;
                outline: none;
                margin: 0;
                padding: 0;
            }
        </style>
    </head>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <script>

        $(document).ready(function () {

            $("#buyBtn").click(function () {
            	if("${loginMember.auth}" == "a" ){
            		alert("관리자는 구매할수 없습니다.")
            	}else if("${loginMember.id}" == null || "${loginMember.id}" == ""){
            		alert("로그인을 해주세요.")
                    location.href="/member/login";
            	}else{
	                // IMP.init('imp88604855');
	              //  IMP.request_pay({
	               //     pg: 'html5_inicis.INIBillTst',
	               //     pay_method: 'card',
	               //     merchant_uid: '${product.pname}' + new Date().getTime(),
	               //     name: '${product.pname}'/*상품명*/,
	                 //   amount: $("#total").val() /*상품 가격*/,
	               //     buyer_email: '${loginMember.email}'/*구매자 이메일*/,
	                //    buyer_name: '${loginMember.name}'/*'구매자이름'*/,
	               //     buyer_tel: '${loginMember.phone}'/*구매자 연락처*/,
	                 //   buyer_addr: '${loginMember.address1}${loginMember.address2}'/*구매자 주소*/,
	               // }, function (rsp) {
	                    //결제 후 호출되는 callback함수
	               //     if (rsp.success) { //결제 성공
	                //        console.log(rsp);
	                //    } else {
	                //        alert('결제실패 : ' + rsp.error_msg);
	                //    }
	              //  }); 
	                 if(confirm('구매 하시겠습니까?')){
		                $.ajax({
		                	url:"/member/purchase",
		                	type:'post',
		                	data:{
		                		'mno':'${loginMember.mno}',
		                		'pno':'${product.pno}',
		                		'price':'${product.price}',
		                		'pname':'${product.pname}',
		                		'amount':$("#quantity").val(),
		                		'total':$("#total").val(),
		                		'id':'${loginMember.id}',
		                	},
		                	success:function(){
		                		alert("구매 성공")
		                		location.href='/products/${product.category}';		
		                	}
		                })
	                } 
                }

            })


            $("#quantity").keyup(function () {
                $("#total").val($(this).val() * $("#price").val())
                if ($(this).val() < 1) {
                    alert("수량은 0개 아래로 내려갈수 없습니다.")
                    $(this).val(1)
                    $("#total").val($("#quantity").val() * $("#price").val())
                }
            })
            $("#total").val($("#quantity").val() * $("#price").val())

            $("#up").click(function () {
                $("#quantity").val(Number($("#quantity").val()) + 1)
                $("#total").val($("#quantity").val() * $("#price").val())
            })

            $("#down").click(function () {
                $("#quantity").val(Number($("#quantity").val()) - 1)
                $("#total").val($("#quantity").val() * $("#price").val())
                if ($("#quantity").val() == 0) {
                    $("#quantity").val(1)
                    $("#total").val($("#quantity").val() * $("#price").val())
                }
            })

            $("#cart").click(function () {
                if ("${ loginMember }" == null || "${ loginMember }" == "") {
                    alert("로그인을 해주세요.")
                    location.href="/member/login";
                }else{
                	if("${loginMember.auth}" == "a"){
                		alert("관리자는 장바구니에 추가할 수 없습니다.")
                	}
                	else{
                		$.ajax({
                			url:"/member/insertCart?pno=${product.pno}",
                			type:"get",
                			dateType:"text",
                			success:function(result){
                				console.log(result)
                				alert(result)
                			}
                		})
                		}
                }
            })
        })   
    </script>

    <body class="is-preload">
        <div id="page-wrapper">

            <%@ include file="../header.jsp" %>
             <%@include file="productsSection.jsp" %>
                <section class="wrapper style1">
                    <div class="container">
                        <div id="content">
                            <div style="margin-top: 20px;"></div>

                            <div class="product-container"
                                style="border: 2px solid orange; border-radius: 10px; padding: 20px; width: calc(100% - 40px); max-width:1100px; margin-left: auto; margin-right: auto;">
                                <div class="product-image">
                                <c:choose>
	                                <c:when test="${not empty product.imageName}">
	                                    <img style="float: right;" src="/productImage/${product.imageName}" alt="상품 이미지"
	                                        width="400" height="400">
	                                 </c:when>
	                            	<c:when test="${empty product.imageName}">
	                              		<img  style="width: 400px;height: 400px;" class="card-img-top" src="../resources/images/noImage.jpg" class="product-image" />
	                            	</c:when>
                            	</c:choose>
                                </div>
                                <div class="product-details">
                                    <h2 style="text-align: center;">${product.pname}</h2>

                                    <div
                                        style=" display: flex;  flex-direction: column; align-items: center; gap: 5px;  ">
                                        <h3 style="text-align: center; margin: 0; padding: 0;">가격</h3>
                                        <input type="text" class="price" id="price" value="${product.price}" readonly>
                                    </div>

                                    <div class="quantity-controls">
                                        <strong>수량 &nbsp;&nbsp;&nbsp;</strong>
                                        <a id='down' style="cursor:pointer;">🔽</a>
                                        &nbsp; &nbsp;
                                        <input type="text" name="quantity" id="quantity" class="quantity-input" value=1
                                            style="width:60px"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                        &nbsp; &nbsp;
                                        <a id='up' style="cursor:pointer;">🔼</a>
                                    </div>
                                    <div class="quantity-controls">
                                        <strong>결제 금액 :</strong>
                                        <input type="text" class="total" id="total" style="width:100px" readonly>
                                    </div>
                                    <div class="action-buttons">
                                        <input type="submit" value="바로구매" id='buyBtn'>
                                        <input type="submit" value="장바구니 담기" id="cart">
                                        <input type="button" onclick="location.href='/products/${product.category}';"
                                            value="목록으로" />
                                    </div>
                                </div>
                            </div>

                            <div class="product-description"
                                style="border: 2px solid orange; border-radius: 10px; padding: 20px; text-align: center; width: calc(100% - 40px); max-width: 1100px; margin-left: auto; margin-right: auto;">
                                <h2>상품 상세 설명</h2>
                                <p>${product.description }</p>
                            </div>
                        </div>
                    </div>
                </section>
        </div>
        <form name="pgForm">
            <input type="hidden" name="Amt" value="1000">
            <input type="hidden" name="BuyerName" value="홍길동">
            <input type="hidden" name="OrderName" value="결제테스트">
        </form>
        <%@ include file="../footer.jsp" %>

    </body>

    <script src="../resources/assets/js/jquery.min.js"></script>
    <script src="../resources/assets/js/jquery.dropotron.min.js"></script>
    <script src="../resources/assets/js/browser.min.js"></script>
    <script src="../resources/assets/js/breakpoints.min.js"></script>
    <script src="../resources/assets/js/util.js"></script>
    <script src="../resources/assets/js/main.js"></script>

    </html>