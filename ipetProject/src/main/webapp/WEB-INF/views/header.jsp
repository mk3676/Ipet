<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<script>
			$(document).ready(function () {
				if(${index}){
					if(${index} == 1) $("#index").attr("class",'current')
					if(${index} == 2) $("#product").attr("class",'current')
					if(${index} == 3) $("#hospital").attr("class",'current')
					if(${index} == 4) $("#community").attr("class",'current')
				}
				$('.slider-2 .page-nav > div').click(function() {
				    
				    var $this = $(this);
				    var $pagenav = $this.parent()
				    var $current = $pagenav.find('.active');
				    
				    $current.removeClass('active');
				    $this.addClass('active');

				    var index = $this.index();
				    var $슬라이더 = $this.closest('.slider-2');
				    
				    $슬라이더.find('.slides > div.active').removeClass('active');
				    $슬라이더.find('.slides > div').eq(index).addClass('active');
				    
				    
				});

				$('.slider-2 > .side-btns > div:first-child').click(function() {
				    var $this = $(this);
				    var $slider = $this.closest('.slider-2');
				    
				    var $current = $slider.find('.page-nav > div.active');
				    var $post = $current.prev();
				    
				    if ( $post.length == 0 ) {
				        $post = $slider.find('.page-nav > div:last-child');
				    }
				    
				    $post.click();
				});

				$('.slider-2 > .side-btns > div:last-child').click(function() {
				    var $this = $(this);
				    var $slider = $this.closest('.slider-2');
				    
				    var $current = $slider.find('.page-nav > div.active');
				    var $post = $current.next();
				    
				    if ( $post.length == 0 ) {
				        $post = $slider.find('.page-nav > div:first-child');
				    }
				    
				    $post.click();
				});
				let interval = setInterval(() => {
					$(".slider-2 > .side-btns > div:last-child").click();
				}, 3000);
			})
		</script>
		<style>

.slider-2 {
    height:400px;
    position:relative;
}

.slider-2 .slides > div {
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background-position:center;
    /* 이미지를 최대한 안짤리게 한다. */
    background-size:cover;
    /* 배경 반복 금지 */
    background-repeat:no-repeat;
    opacity:0;
    transition: opacity 0.5s;
}

.slider-2 .slides > div.active {
    opacity:1;
}

@media ( max-width:700px ) {
    .slider-2 {
        height:300px;
    }
}

.slider-2 .page-nav {
    position:absolute;
    width:100%;
    text-align:center;
    bottom:0;
    left:0;
}

.slider-2 .page-nav > div {
    display:inline-block;
    width:15px;
    height:15px;
    background-color:rgba(255,255,255,0.5);
    border-radius:2px;
    cursor:pointer;
}

.slider-2 .page-nav > div.active {
    background-color:rgba(255,255,255,1);
}

.slider-2>.side-btns>div{
    position:absolute;
    top:0;
    left:0;
    width:30%;
    height:100%;
    cursor:pointer;
    z-index:10;

}

.slider-2>.side-btns>div>span:active{
    transform:translatey(-40%);
}
.slider-2>.side-btns>div:last-child{
    left:auto;
    right:0;
}

.slider-2>.side-btns>div>span{
    position:absolute;
    top:50%;
    transform:translatey(-50%);
    left:inherit;
    right:inherit;
    width:70px;
    height:70px;
    background-color:rgba(255,255,255,0.4);
    border-radius:100%;
    margin:0 10px;
}
.slider-2>.side-btns>div>span > i{
    position:absolute;
    top:50%;
    left:50%;
    font-size:3rem;
    color:rgba(0,0,0,0.4);
    transform:translateX(-70%) translateY(-50%);
}

.slider-2>.side-btns>div:last-child>span > i {
    transform:translateX(-20%) translateY(-50%);
} 
#nav ul {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
  }

  #nav ul li {
    margin: 0 10px;
  }
/* 슬라이드 버튼 끝 */
		</style>
		<!-- Header -->
		
		<div id="header" >
			<c:choose>
				<c:when test="${empty loginMember.mno}">
					<span style="text-align: right; display: block">
						<a style="color: black;" href="/ipet/index">홈으로</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/login">로그인</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/register">회원가입</a>
					</span>
					<br />
					<span id="timer"></span>
				</c:when>
				<c:when test="${not empty loginMember.mno && loginMember.auth eq 'm'}">
					<span style="text-align: right; display: block">
					<a style="color: black;" href="/ipet/index">홈으로</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/mypage">마이페이지</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/cart">장바구니</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/logout">로그아웃</a>
						<br />
						<span style="text-align: right; display: block;">${loginMember.id}님</span>
					</span>

				</c:when>
				<c:when test="${not empty loginMember.mno && loginMember.auth eq 'a'}">
					<span style="text-align: right; display: block">
						<a style="color: black;" href="/ipet/index">홈으로</a> &nbsp; &nbsp;
						<a style="color: black;" href="/admin/member">관리자 페이지</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/mypage">마이페이지</a> &nbsp; &nbsp;
						<a style="color: black;" href="/member/logout">로그아웃</a>
						<br />
						<span style="text-align: right; display: block;">${loginMember.id}님</span>
					</span>

				</c:when>

			</c:choose>
			<!-- Logo -->
			</div>
			<div id="logo" style="align-items: center;">
				 <div class="slider-2">
    
				     <div class="side-btns">
				        <div><span><i class="fas fa-caret-left"></i></i></span></div>
				        <div><span><i class="fas fa-caret-right"></i></span></div>
				    </div>
				    
				    <div class="slides">
				       <div class="active" style="background-image:url(https://icatcare.org/app/uploads/2019/02/CFC-website-banner-1920x660.jpg?auto=compress,format);"></div>
				       <div style="background-image:url(https://petlifesa.com/wp-content/uploads/slider2/PLSA630-petilfesa-web-dog-banner-image-FA.jpeg?auto=compress,format);"></div>
				    </div>
				    
				    <div class="page-nav">
				        <div class="active"></div>
				        <div></div>
				        
				    </div>
				</div>
				  
				  
				
				
			</div>
			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li id='index' ><a href="/ipet/index">메인 페이지</a></li>
					<li id='product'><a href="/ipet/pro">반려동물 용품 판매</a>
						<ul>
							<li><a href="/products/food">사료/간식</a></li>
							<li><a href="/products/pad">패드/장난감</a></li>
							<li><a href="/products/bath">목욕/하네스</a></li>
						</ul>
					</li>
					<li id='hospital'><a href="/ipet/hos">동물병원 검색</a></li>
					<li id='community'><a href="/ipet/community">커뮤니티</a></li>
				</ul>
				<!-- Scripts -->
				<script src="../resources/assets/js/jquery.min.js"></script>
				<script src="../resources/assets/js/jquery.dropotron.min.js"></script>
				<script src="../resources/assets/js/browser.min.js"></script>
				<script src="../resources/assets/js/breakpoints.min.js"></script>
				<script src="../resources/assets/js/util.js"></script>
				<script src="../resources/assets/js/main.js"></script>
			</nav>
	
	