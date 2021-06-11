<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<div class="container" id="app">
	<div>
		<h2></h2>
	</div>
	<div>
		<ul id="userList">
		</ul>
	</div>
	<div class="col-md-4">
          <label for="webchat_username">Username:</label>
          <input type="text" id="webchat_username" placeholder="Put your username here..."/>
           <input type="text" id="receive_username" placeholder="Put your receiver here..."/>
        	<button class="btn btn-primary" type="button" id="nameSend">보내기</button>
        	
          <button class="btn btn-primary" type="button" id="disconnect">나가기</button>
        </div>
	<div style="height: 400px; overflow: auto;">
		<table id="conversation" class="table table-striped">
			<thead>
				<tr>
					<th>Greetings</th>
				</tr>
			</thead>
			<tbody id="greetings">
			<c:forEach items="${chatMsgList}" var="chatList">
				<tr><td>${chatList.writerNo} : ${chatList.msg}</td></tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div style="height: 400px; overflow: auto;">
		<table id="conversation" class="table table-striped">
			<thead>
				<tr>
					<th>Greetings</th>
				</tr>
			</thead>
			<tbody id="dmTable">
			
			</tbody>
		</table>
	</div>
	
	<div class="input-group">
		<div class="input-group-prepend">
			<label class="input-group-text">내용</label>
		</div>
		<input type="text" class="form-control" id="msg" />
		<div class="input-group-append">
			<button class="btn btn-primary" type="button" id="msgSend">보내기</button>
		</div>
	</div>
<div class="input-group">
		<div class="input-group-prepend">
			<label class="input-group-text">개인메시지</label>
		</div>
		<input type="text" class="form-control" id="directMsg" />
		<div class="input-group-append">
			<button class="btn btn-primary" type="button" id="dmSend">개인메세제보내기</button>
		</div>
	</div>

	<div></div>
</div>

<div class="page-content page-container" id="page-content">
    <div class="padding">
        <div class="row container d-flex justify-content-center">
            <div class="col-md-6">
                <div class="card card-bordered">
                    <div class="card-header">
                        <h4 class="card-title"><strong>Chat</strong></h4> <a class="btn btn-xs btn-secondary" href="#" data-abc="true">Let's Chat App</a>
                    </div>
                    <div class="ps-container ps-theme-default ps-active-y" id="chat-content" style="overflow-y: scroll !important; height:400px !important;">
                        <div class="media media-chat"> <img class="avatar" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="...">
                            <div class="media-body">
                                <p>Hi</p>
                                <p>How are you ...???</p>
                                <p>What are you doing tomorrow?<br> Can we come up a bar?</p>
                                <p class="meta"><time datetime="2018">23:58</time></p>
                            </div>
                        </div>
                        <div class="media media-meta-day">Today</div>
                        <div class="media media-chat media-chat-reverse">
                            <div class="media-body">
                                <p>Hiii, I'm good.</p>
                                <p>How are you doing?</p>
                                <p>Long time no see! Tomorrow office. will be free on sunday.</p>
                                <p class="meta"><time datetime="2018">00:06</time></p>
                            </div>
                        </div>
                        <div class="media media-chat"> <img class="avatar" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="...">
                            <div class="media-body">
                                <p>Okay</p>
                                <p>We will go on sunday? </p>
                                <p class="meta"><time datetime="2018">00:07</time></p>
                            </div>
                        </div>
                        <div class="media media-chat media-chat-reverse">
                            <div class="media-body">
                                <p>That's awesome!</p>
                                <p>I will meet you Sandon Square sharp at 10 AM</p>
                                <p>Is that okay?</p>
                                <p class="meta"><time datetime="2018">00:09</time></p>
                            </div>
                        </div>
                        <div class="media media-chat"> <img class="avatar" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="...">
                            <div class="media-body">
                                <p>Okay i will meet you on Sandon Square </p>
                                <p class="meta"><time datetime="2018">00:10</time></p>
                            </div>
                        </div>
                        <div class="media media-chat media-chat-reverse">
                            <div class="media-body">
                                <p>Do you have pictures of Matley Marriage?</p>
                                <p class="meta"><time datetime="2018">00:10</time></p>
                            </div>
                        </div>
                        <div class="media media-chat"> <img class="avatar" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="...">
                            <div class="media-body">
                                <p>Sorry I don't have. i changed my phone.</p>
                                <p class="meta"><time datetime="2018">00:12</time></p>
                            </div>
                        </div>
                        <div class="media media-chat media-chat-reverse">
                            <div class="media-body">
                                <p>Okay then see you on sunday!!</p>
                                <p class="meta"><time datetime="2018">00:12</time></p>
                            </div>
                        </div>
                        <div class="ps-scrollbar-x-rail" style="left: 0px; bottom: 0px;">
                            <div class="ps-scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div>
                        </div>
                        <div class="ps-scrollbar-y-rail" style="top: 0px; height: 0px; right: 2px;">
                            <div class="ps-scrollbar-y" tabindex="0" style="top: 0px; height: 2px;"></div>
                        </div>
                    </div>
                    <div class="publisher bt-1 border-light"> <img class="avatar avatar-xs" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="..."> <input class="publisher-input" type="text" placeholder="Write something"> <span class="publisher-btn file-group"> <i class="fa fa-paperclip file-browser"></i> <input type="file"> </span> <a class="publisher-btn" href="#" data-abc="true"><i class="fa fa-smile"></i></a> <a class="publisher-btn text-info" href="#" data-abc="true"><i class="fa fa-paper-plane"></i></a> </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

        var stompClient = null;
        var chatUsersList = [];
        let userList = [];
		
    	//native
    	function connect() {
    		var socket = new SockJS(
    				'${pageContext.request.contextPath}/websocket-chat');
    		stompClient = Stomp.over(socket);
    		
    		stompClient.connect({}, function(frame) {

    			console.log('Connected: ' + frame);

    			//특정 방 구독
    			stompClient.subscribe(`/topic/chat/room/${chatroomNo}`, function(msg) {
    				console.log(msg)
    				showMsg(JSON.parse(msg.body).writerNo, JSON.parse(msg.body).msg);
    			});

    			//입장 구독
    			stompClient.subscribe(`/topic/chat/greeting/${chatroomNo}`, function(msg) {
    				console.log(msg);
    				showGreeting(msg.body);
    				userList.push(msg.body);
    				console.log(userList);
    				showUser(userList)
    			});

				//나갈때 구독
    			stompClient.subscribe(`/topic/chat/disconnect/${chatroomNo}`, function(msg) {
    				console.log(msg);
    				showDisconnect(msg.body);
    				userList = userList.filter((e)=> e !== msg.body);
    				console.log(userList);
    				showUser(userList)
    			});
    			
    			stompClient.subscribe('/user/queue/newMember', function(data) {
    				//console.log(JSON.stringify(data.body));
    				
    				//chatUsersList.push(data.body);
    				console.log(chatUsersList);
    				
    			/* 	chatUsersList.forEach(function(userList){
        				console.log(userList)
        				
						let html ="<li>"+userList+"</li>";
						$("#userList").html(html);
        			}) */
        			    				
    			});
	
    			stompClient.subscribe('/topic/newMember', function(data) {
    				console.log(data);
    				console.log(data.body);
    				chatUsersList.push(data.body);
    				
    				$('#userList').append(data.body);
    				    				
    			});
				//개인메세지 구독
    			$("#nameSend").click(function() {
    				const username = $("#webchat_username").val();
        			stompClient.subscribe(`/user/\${username}/directMsg`, function(msg) {
        				console.log(msg)
        				showDm(JSON.parse(msg.body).messageSender, JSON.parse(msg.body).messageContent);
        			});
    			}); 
    			
    			
    		});
    	}		
    	
				//입장시 
				function sendUser(){
					stompClient.send("/app/join", {}, JSON.stringify({
						'empNo' : $("#webchat_username").val(),
						'chatroomNo': ${chatroomNo}
					}));
				}

				//메세지 보내기
				function sendMessage(msg) {
    				stompClient.send("/app/message", {}, JSON.stringify({
    					'chatroomNo': ${chatroomNo},
    					'writerNo' : $("#webchat_username").val(),
    					'msg' : $("#msg").val()

    				}));
    			}

				//dm 보내기
    			function sendDM(msg) {
    				stompClient.send("/app/directMsg", {}, JSON.stringify({
    					'messageContent': $("#directMsg").val(),
    					'messageSender' : $("#webchat_username").val(),
						'messageReceiver' : $("#receive_username").val()
    				}));
    			}

    			//나가기 정보
				function sendDisconnect(msg) {
    				stompClient.send("/app/disconnect", {}, JSON.stringify({
    					'empNo' : $("#webchat_username").val(),
						'chatroomNo': ${chatroomNo}
    				}));
    			}
				 
	
    			
				//입장메세지 출력
				function showGreeting(msg) {
	    			$("#greetings").append("<tr><td>" + msg + "님이 입장하셨습니다.</td></tr>");
	    		}
   			
				
	 			//메세지 출력
	    		function showMsg(name, msg) {
	    			$("#greetings").append("<tr><td>"+name +" : " + msg + "</td></tr>");
	    		}

	    		//나갈때 출력
	    		function showDisconnect(msg) {
	    			$("#greetings").append("<tr><td>" + msg + "님이 나가셨습니다.</td></tr>");
	    		}

	    		//개인메세지 출력
	    		function showDm(name, msg) {
	    			$("#dmTable").append("<tr><td>"+name +" : " + msg + "</td></tr>");
	    		}

				//userList표시
				function showUser(userList){
					userList.forEach(function(user){
					const html = `<li>\${user}</li>`;
					$("#userList").html(html);
					console.log(user)

					});

				}
	    		
    			
    			$(function() {
    				/* $("form").on('submit', function(e) {
    					e.preventDefault();
    				});*/
    				    				
    				$("#disconnect").click(function() {
    					sendDisconnect();
    				}); 
    				
    				$("#nameSend").click(function() {
    					sendUser();
    				});
    				$("#msgSend").click(function() {
    					sendMessage();
    				});

    				$("#dmSend").click(function(){
    					sendDM();
        			})

    				
    			});
    			connect();
    			

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />