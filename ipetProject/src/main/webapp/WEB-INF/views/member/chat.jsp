<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>I-pet</title>
</head>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="../resources/assets/css/main.css" />
<link rel="shortcut icon" type="image/x-icon" href="../resources/images/favicon.jpg">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script>
//전송 버튼 누르는 이벤트
var ws;
var userid="${loginMember.id}";

function connect(){
	ws = new WebSocket('ws:localhost:8080/chatting');
	ws.onopen = function(){
		register();
	};
	ws.onmessage = function(e){
		console.log('메시지 받음')
		var data = e.data;
		addMsg(data);
	};
	ws.onclose = function(){
		console.log("연결 종료")
	};
}
function addMsg(msg){
	var chat =$("#msgArea").val();
	if("${loginMember.auth}" == 'a'){
		chat = chat + '\n${targetId} 님 : ' + msg;
	}else{
		chat = chat + "\n 관리자 : " + msg;
	}
	$("#msgArea").val(chat);
	const top = $('#msgArea').prop('scrollHeight');
 	$('#msgArea').scrollTop(top);
	
}
function register(){
	if("${loginMember.auth}" == 'm'){
		var msg ={
				type:"register",
				userid:"${loginMember.id}",
				targetId:'admin'
		};
	}else{
		var msg ={
				type:"register",
				userid:"${loginMember.id}",
				targetId:"${targetId}"
		};
	}
	ws.send(JSON.stringify(msg))
}
function sendMsg(){
	var msg={
			type:"chat",
			userid:"${loginMember.id}",
			target:$("#targetUser").val(),
			message:$("#msg").val()
	}
	ws.send(JSON.stringify(msg));
}
$(document).ready(function(){
	connect();
	$(".input-div textarea").keydown(function(e){
		  
		  if(e.keyCode == 13 && !e.shiftKey) {
                e.preventDefault();
                var chat = $("#msgArea").val(); 
       		 	chat = chat + "\n나 : " + $("#msg").val();
       		 	$("#msgArea").val(chat);
       		 	const top = $('#msgArea').prop('scrollHeight');
       	  		$('#msgArea').scrollTop(top);
        		sendMsg();
        		$("#msg").val('')
		  }
		
	})

})
</script>
<style>
*{ margin: 0; padding: 0; }
 
.chat_wrap .header { font-size: 14px; padding: 15px 0; background: #F18C7E; color: white; text-align: center;  }
 
.chat_wrap .chat { padding-bottom: 80px; }
.chat_wrap .chat ul { width: 100%; list-style: none; }
.chat_wrap .chat ul li { width: 100%; }
.chat_wrap .chat ul li.left { text-align: left; }
.chat_wrap .chat ul li.right { text-align: right; }
 
.chat_wrap .chat ul li > div { font-size: 13px;  }
.chat_wrap .chat ul li > div.sender { margin: 10px 20px 0 20px; font-weight: bold; }
.chat_wrap .chat ul li > div.message { display: inline-block; word-break:break-all; margin: 5px 20px; max-width: 75%; border: 1px solid #888; padding: 10px; border-radius: 5px; background-color: #FCFCFC; color: #555; text-align: left; }
 
.chat_wrap .input-div { position: fixed; bottom: 0; width: 100%; background-color: #FFF; text-align: center; border-top: 1px solid #F18C7E; }
.chat_wrap .input-div > textarea { width: 100%; height: 140px; border: none; padding: 10px; }
 
.format { display: none; }
#chatContainer {
				background-color: rgb(250, 250, 250);
				box-shadow: 0 8px 8px rgba(0, 0, 0, 0.2);
				border-radius: 1.5rem;
				width: 350px;
				height: 480px;
				position: fixed;
				right: 20px;
				bottom: 100px;
				z-index: 9999;
			}
</style>
<body >
<div id="chatContainer" >
<div class="chat_wrap">
		<c:choose>
			<c:when test="${loginMember.auth eq 'm' }">
				<div class="header">
       				 관리자 문의
    			</div>
    		</c:when>
    		<c:when test="${loginMember.auth eq 'a' }">
				<div class="header">
       				 ${targetId } 고객님
    			</div>
			</c:when>
			</c:choose>
	 <div class="chat">
        <textarea id="msgArea" style="height: 380px;" readonly>---------------문의사항을 입력해 주세요-------------------</textarea>
    </div>
		<div class="input-div" style="width: 350px;">
			<textarea placeholder="Press Enter for send message." id="msg"></textarea>
			<c:choose>
			<c:when test="${loginMember.auth eq 'm' }">
				 <input type="hidden" id="targetUser" value="admin"/>
			</c:when>
			<c:when test="${loginMember.auth eq 'a' }">
				<input type="hidden" id="targetUser" value="${targetId }"/>
			</c:when>
			</c:choose>
		</div>
			  <div class="chat format">
		        <ul>
		            <li>
		            <div class="sender">
                    <span></span>
			                </div>
			                <div class="message">
			                    <span></span>
			                </div>
			            </li>
			        </ul>
			    </div>
			 </div>
			 </div>
</body>

</html>