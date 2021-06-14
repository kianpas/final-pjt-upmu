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
	<script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
	<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<div class="container">
	<div class="row justify-content-start">
		<h2>채팅화면</h2>
		 <div class="col-md-2 d-flex flex-column flex-shrink-0 p-3">
		 <div class="accordion" id="accordionPanelsStayOpenExample">
	  		<div class="accordion-item">
		    <h2 class="accordion-header" id="panelsStayOpen-headingOne">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
		        Item #1
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingOne">
		      <div class="accordion-body">
		        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
		            <li><a href="#" class="link-dark rounded">Overview</a></li>
		            <li><a href="#" class="link-dark rounded">Updates</a></li>
		            <li><a href="#" class="link-dark rounded">Reports</a></li>
		          </ul>
		      </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
		        Item #2
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
		      <div class="accordion-body">
		     </div>
		    </div>
		  </div>
		  <div class="accordion-item">
		    <h2 class="accordion-header" id="panelsStayOpen-headingThree">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
		        유저리스트
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree">
		      <div class="accordion-body" id="userList">
		      </div>
		    </div>
		  </div>
		</div>
	</div> 
	
	<div class="flex-shrink-0 p-3 bg-white" style="width: 280px;">
    <a href="/" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
      <svg class="bi me-2" width="30" height="24"><use xlink:href="#bootstrap"/></svg>
      <span class="fs-5 fw-semibold">Collapsible</span>
    </a>
    <ul class="list-unstyled ps-0">
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
          Home
        </button>
        <div class="collapse show" id="home-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li><a href="#" class="link-dark rounded">Overview</a></li>
            <li><a href="#" class="link-dark rounded">Updates</a></li>
            <li><a href="#" class="link-dark rounded">Reports</a></li>
          </ul>
        </div>
      </li>
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
          Dashboard
        </button>
        <div class="collapse" id="dashboard-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li><a href="#" class="link-dark rounded">Overview</a></li>
            <li><a href="#" class="link-dark rounded">Weekly</a></li>
            <li><a href="#" class="link-dark rounded">Monthly</a></li>
            <li><a href="#" class="link-dark rounded">Annually</a></li>
          </ul>
        </div>
      </li>
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#order-collapse" aria-expanded="false">
          유저리스트
        </button>
        <div class="collapse" id="order-collapse" >
        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small" id="userList2">
            
          </ul> 
        </div>
      </li>
      <li class="border-top my-3"></li>
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#account-collapse" aria-expanded="false">
          Account
        </button>
        <div class="collapse" id="account-collapse">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li><a href="#" class="link-dark rounded">New...</a></li>
            <li><a href="#" class="link-dark rounded">Profile</a></li>
            <li><a href="#" class="link-dark rounded">Settings</a></li>
            <li><a href="#" class="link-dark rounded">Sign out</a></li>
          </ul>
        </div>
      </li>
    </ul>
  </div>
	
	
	
	<div class="col-8">
		<div class="col-md-4">
	          <label for="webchat_username">Username : </label>
	          <input type="text" id="webchat_username" placeholder="Put your username here..."/>
	          <button class="btn btn-primary" type="button" id="nameSend">유저네임보내기</button>
	           <button class="btn btn-primary" type="button" id="disconnect">나가기</button>
	    </div>
	        <div class="col-md-4">
	          <label for="webchat_username">개인메세지 받을 사람: </label>
	          <input type="text" id="receive_username" placeholder="Put your receiver here..."/>
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
						<th>DirectMsg</th>
					</tr>
				</thead>
				<tbody id="dmTable">
				
				</tbody>
			</table>
		</div>
	<div class="input-group">
		<div class="input-group mb-3">
		  <input type="text" id="msg" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2">
		  <button class="btn btn-primary" type="button" id="msgSend"><i class='bx bxs-send' ></i></button>
		</div>
	</div>
	<div class="input-group">
		<div class="input-group-prepend">
			<label class="input-group-text">개인메시지</label>
		</div>
		<input type="text" class="form-control" id="directMsg" />
		<div class="input-group-append">
			<button class="btn btn-primary" type="button" id="dmSend">개인메세지보내기</button>
		</div>
	</div>
	</div>
</div>
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
    				
    				
    				showUserList();
    				
    			});

				//나갈때 구독
    			stompClient.subscribe(`/topic/chat/disconnect/${chatroomNo}`, function(msg) {
    				console.log(msg);
    				showDisconnect(msg.body);
    				
    				
    				showUserList();
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
    				
    				
    				    				
    			});
				//개인메세지 구독
    			$("#nameSend").click(function() {
    				const username = $("#webchat_username").val();
        			stompClient.subscribe(`/user/\${username}/directMsg`, function(msg) {
        				console.log(msg)
        				showDm(JSON.parse(msg.body).messageSender, JSON.parse(msg.body).messageContent);
        			});
    			}); 

    			//보낸개인메세지 구독
    			$("#dmSend").click(function() {
    				const recvname = $("#receive_username").val();
        			stompClient.subscribe(`/user/\${recvname}/directMsg`, function(msg) {
        				console.log(msg)
        				showDm(JSON.parse(msg.body).messageSender, JSON.parse(msg.body).messageContent);
        			});
    			}); 
    			
    			
    		});
    	}		

    			//채팅방에 참여한 인원 가져오는 펑션
				const showUserList = () => {
					$.ajax({
						url : `${pageContext.request.contextPath}/chat/userList/${chatroomNo}`,
						method: 'GET',
						contentType:"application/json; charset=utf-8",
						
						success(data){
							const $userContainer = $("#userList");
							let html = "<ul>";
							$(data).each((index, user) => {
								console.log(user)
								
							
								html += `<li>\${user.empNo}</li>`;
							})
							html += "</ul>";
							$userContainer.html(html);

							//2번째 후보
							const $userContainer2 = $("#userList2");
							let html2 = "";
							$(data).each((index, user) => {
								console.log(user)
								
							
								html2 += `<li class='link-dark rounded'>\${user.empNo}`;
							})
							html2 += "</li>";
							$userContainer2.html(html2);
							
						},
						error:console.log,
					})
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

				
	    		
    			
    			$(function() {
    				    				    				
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
    			showUserList();
    			

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />