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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js" integrity="sha512-3kMAxw/DoCOkS6yQGfQsRY1FWknTEzdiz8DOwWoqf+eGRN45AmjS2Lggql50nCe9Q6m5su5dDZylflBY2YjABQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/directMsg.css">  
<div class="container">
	<div class="row justify-content-start">
		<h2>채팅화면</h2>
		 <div class="col-md-2 d-flex flex-column flex-shrink-0 p-3">
		 <div class="accordion" id="accordionPanelsStayOpenExample">
	  		<div class="accordion-item">
		    <h2 class="accordion-header" id="panelsStayOpen-headingOne">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
		         테스트 #1
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
		        테스트 #2
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

	
	
	<div class="col-8">
		<div class="col-md-8 mb-4">
	          <label for="webchat_username">Username(로그인 대신) : </label>
	          <input type="text" id="webchat_username" placeholder="Put your username here..."/>
	          <button class="btn btn-primary" type="button" id="nameSend">유저네임보내기(로그인)</button>
	           <button class="btn btn-primary" type="button" id="disconnect">나가기(로그아웃)</button>
	    </div>
	        <div class="col-md-8">
	          <label for="webchat_username">Dm 받을 사람: </label>
	          <input type="text" id="receive_username" placeholder="Put your receiver here..."/>
	           <button class="btn btn-primary" type="button" id="dmSub">dm보낼 사람과 연결 구독</button>
	        </div>
		<div id="cont" style="height: 400px; overflow: auto;">
			
			<ul class="list-group list-group" id="greetings">
			
			</ul>
		</div>
		<div class="input-group">
			<div class="input-group mb-3">
			  <input type="text" id="msg" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2">
			  <button class="btn btn-primary" type="button" id="msgSend"><i class='bx bxs-send' ></i></button>
			</div>
		
		<div class="input-group mb-3">
		  <input type="text" class="form-control" placeholder="수정할 내용 표시" id="updateInput" aria-label="Recipient's username" aria-describedby="button-addon2">
		  <input type="hidden" name="msgNo" value="">
		  <button class="btn btn-info" type="button" id="button-addon2" onclick="updateMsgReal()"><i class='bx bxs-send' ></i></button>
		</div>
	</div> 
</div>
</div>

<!-- 오프캔버스 버튼 -->
<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling">주소록 오프캔버스</button>


	<!-- 개인대화창 오프캔버스 -->
	<div class="offcanvas offcanvas-end" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling" aria-labelledby="offcanvasScrollingLabel">
	  <div class="offcanvas-header">
	    <h5 class="offcanvas-title" id="offcanvasScrollingLabel">주소록</h5>
	    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	  </div>
	  <div class="offcanvas-body">
	    <p>주소록</p>
	    <div class="list-group list-group-flush border-bottom scrollarea" id="addrList">
	      <div class="list-group-item list-group-item-action py-3 lh-tight" > 
	        <div class="d-flex w-80 align-items-center justify-content-between">
	          <strong class="mb-1">사람이름 </strong>
	          <i id="dropdwonIcon" class='bx bx-dots-vertical-rounded bx-sm' data-bs-toggle="dropdown"></i>
			  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
			    <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#updateModal" data-no="" data-title="" id="updateBtn">방 이름 변경</a></li>
			      <li><hr class="dropdown-divider"></li>
			    <li><a class="dropdown-item">주소록 삭제</a></li>
			  </ul>
	        </div>
	     </div> 
	    </div>
	  </div>
	</div>

</div>
 
 <!-- 개인채팅창 -->
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
                    <div class="publisher bt-1 border-light"> <input class="publisher-input" type="text" placeholder="Write something" id="directMsg"> <span class="publisher-btn file-group"> <i class='bx bxs-send' id="dmSend"></i>
                      </span></div>
                      <div class="input-group mb-3">
						  <input type="text" class="form-control" placeholder="개인메세지 수정할 내용 표시" id="updateDmInput" aria-label="Recipient's username" aria-describedby="button-addon2">
						  <input type="hidden" name="messageNo" value="">
						  <button class="btn btn-info" type="button" id="button-addon2" onclick="updateDmReal()"><i class='bx bxs-send' ></i></button>
					</div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

        var stompClient = null;
       	
		
    	//native
    	function connect() {
    		const socket = new SockJS(
    				'${pageContext.request.contextPath}/websocket-chat');
    		stompClient = Stomp.over(socket);
    		
    		stompClient.connect({}, frame => {

    			console.log('Connected: ' + frame);

    			//특정 방 구독, 메세지 입력
    			stompClient.subscribe(`/topic/chat/room/${chatroomNo}`, frame => {
    				console.log(frame)
    				showMsg(frame);
    				//chatList();
    				
    			});

    			//입장 구독
    			stompClient.subscribe(`/topic/chat/greeting/${chatroomNo}`, frame => {
    				console.log(frame);
    				showGreeting(frame.body);
    				//유저리스트 갱신
    				showUserList();
    				
    			});
				//업데이트 구독
				stompClient.subscribe(`/topic/chat/updated/${chatroomNo}`, frame => {
    				console.log(frame)
    				chatList();
    				
				});
				//삭제 구독
				stompClient.subscribe(`/topic/chat/deleted/${chatroomNo}`, frame => {
    				console.log(frame)
    				chatList();
    				
				});

				//나갈때 구독
    			stompClient.subscribe(`/topic/chat/disconnect/${chatroomNo}`, frame => {
    				console.log(frame);
    				showDisconnect(frame.body);
    				//유저리스트 갱신
    				showUserList();
    			});

    		
    			
    		});
    	}		

    	//개인메세지 구독
    	function dconnect() {
    		const socket = new SockJS(
    				'${pageContext.request.contextPath}/websocket-chat');
    		stompClient = Stomp.over(socket);
    		
    		stompClient.connect({}, frame => {
    			//내 개인메세지 구독
    			showDmList();
    				const username = $("#webchat_username").val();
    				const recvname = $("#receive_username").val();
        			stompClient.subscribe(`/user/\${username}/directMsg`, frame => {
        				console.log(frame)
        				showDm(frame);
        				//showDmList();
        			});

        			stompClient.subscribe(`/user/\${username}/updated`, frame => {
        				showDmList();
        				
        				//showDm(frame);
        						
        			});
				
        			stompClient.subscribe(`/user/\${username}/deleted`, frame => {
        				showDmList();
        				
        				//showDm(frame);
        						
        			});
    			
    			//보낸개인메세지 구독
        			stompClient.subscribe(`/user/\${recvname}/directMsg`, frame => {
        				//showDmList();
        				
        				showDm(frame);
        						
        			});

        			
        			stompClient.subscribe(`/user/\${recvname}/updated`, frame => {
        				showDmList();
        				
        				//showDm(frame);
        						
        			});

        			stompClient.subscribe(`/user/\${recvname}/deleted`, frame => {
        				showDmList();
        				
        				//showDm(frame);
        						
        			});
    			

    		    })
    		}			

				
    			//채팅방에 참여한 인원 가져오는 펑션
				const showUserList = () => {
					$.ajax({
						url : `${pageContext.request.contextPath}/chat/userList/${chatroomNo}`,
						method: 'GET',
						contentType:"application/json; charset=utf-8",
						
						success(data){
							const $userContainer = $("#userList");
							let html = "<ul class='list-group list-group-flush'>";
							$(data).each((index, user) => {
								console.log(user)
								
								html += `<li class="list-group-item">\${user.empNo}</li>`;
							})
							html += "</ul>";
							$userContainer.html(html);

						},
						error:console.log,
					})
				}

							

				//채팅내역 가져오는 펑션
				const chatList = () => {
					
					$.ajax({
						url : `${pageContext.request.contextPath}/chat/room/chatList/${chatroomNo}`,
						method: 'GET',
						contentType:"application/json; charset=utf-8",
						
						success(data){
							//console.log(data);
							const $container = $("#greetings");
							let html = '';
							$.each(data, function(key, value){
								const username = $("#webchat_username").val();
								//console.log(value);
								const {msgNo, chatroomNo, writerNo, msg, regDate} = value;
										 
								html += `<li class="list-group-item d-flex justify-content-between align-items-start">
											    <div class="ms-2 me-auto">
											      <div class="fw-bold">\${writerNo}</div>
											      \${msg}
											    </div>`;
											if(username == writerNo){    
												html += `<box-icon type='solid' name='edit'
													onclick="updateMsg(\${msgNo}, '\${msg}')"></box-icon>
													<box-icon name='x'  
												    onclick="deleteMsg(\${msgNo})"></box-icon>`;
											}
											
										html += `</li>`;
									
								$container.html(html);
								
							})
							$("#cont").scrollTop($container[0].scrollHeight);
									 
							
						},
						error:console.log,
					})
				}

				//메세지 수정 전 가져오기
        		const updateMsg = (no, msg) => {
            		console.log(no, msg)
					$("#updateInput").val(msg);
					$("[name=msgNo]").val(no);

            	}
        		//메세지 실제 수정 
				const updateMsgReal = () => {
					const msg = $("#updateInput").val();
					const msgNo = $("[name=msgNo]").val();
					const chatroomNo = ${chatroomNo};
					
	        		 stompClient.send("/app/update", {}, JSON.stringify({
						'chatroomNo': ${chatroomNo},
						'msgNo' : msgNo,
						'msg' : $("#updateInput").val()
	
					}));
				}
        		
				
				//메세지 삭제
				const deleteMsg = (msgNo) =>{
					console.log(msgNo);

					 stompClient.send("/app/delete", {}, JSON.stringify({
						 'chatroomNo': ${chatroomNo},
							'msgNo' : msgNo
					 }));
					
				}

				

				//개인메세지 가져오기
    			const showDmList = () => {
    				const username = $("#webchat_username").val();
    				const recvname = $("#receive_username").val();
						$.ajax({
							url : `${pageContext.request.contextPath}/chat/dmList/\${username}/\${recvname}`,
							method: 'GET',
							contentType:"application/json; charset=utf-8",
							
							success(data){
								//const $container = $("#dmTable");
								const $container = $("#chat-content");

								let html = '';
								$.each(data, function(key, value){
									//console.log(value);
									const {messageNo, messageContent, messageTime, messageSender, messageReceiver, readCheck} = value;
																
									const time = moment(messageTime).format("MMM Do hh:mm a")
									
									 if(username == messageSender){       
					                    	html += `<div class="media media-chat media-chat-reverse">
							                            <div class="media-body">
							                                <p>\${messageContent}</p>
							                                <p class="meta" style="color:#000;">\${time}</p>
								                            </div>
							                         </div>
							                         <box-icon type='solid' name='edit' onclick="updateDm(\${messageNo}, '\${messageContent}')"></box-icon>
							                         <box-icon name='x'  onclick="deleteDm(\${messageNo})"></box-icon>`;
					                    	} else {
									
											html += `<div class="media media-chat"> 
							                            <div class="media-body">
							                                <p>\${messageContent}</p>
							                                <p class="meta">\${time}</p>
								                        </div>
								                     </div>`;
					                   }
					                   
							
									$container.html(html).scrollTop($("#chat-content")[0].scrollHeight);
									
								})
								
							},
							error:console.log,
						})

        		}


    			//메세지 수정 전 가져오기
        		const updateDm = (no, msg) => {
            		console.log(no, msg)
					$("#updateDmInput").val(msg);
					$("[name=messageNo]").val(no);

            	}

        		

    			//실제 수정
				const updateDmReal = () => {
					const messageContent = $("#updateDmInput").val();
					const messageNo = $("[name=messageNo]").val();
					const directMsg = {messageContent, messageNo};

					stompClient.send("/app/updateDm", {}, JSON.stringify({
						'messageContent': messageContent,
						'messageNo' : messageNo,
						'messageReceiver' : $("#receive_username").val()
					}));
				

				}

				//메세지 삭제
				const deleteDm = (messageNo) => {
					console.log(messageNo);
					
					 stompClient.send("/app/deleteDm", {}, JSON.stringify({
						 'messageReceiver' : $("#receive_username").val(),
							'messageNo' : messageNo
							
					 }));

				}
    	
				//입장
				const sendUser = () => {
					stompClient.send("/app/join", {}, JSON.stringify({
						'empNo' : $("#webchat_username").val(),
						'chatroomNo': ${chatroomNo}
					}));
	
				}

				//나가기
				const sendDisconnect = (msg) => {
    				stompClient.send("/app/disconnect", {}, JSON.stringify({
    					'empNo' : $("#webchat_username").val(),
						'chatroomNo': ${chatroomNo}
    				}));
    			}

				//메세지 보내기
				const sendMessage = (msg) => {
    				stompClient.send("/app/message", {}, JSON.stringify({
    					'chatroomNo': ${chatroomNo},
    					'writerNo' : $("#webchat_username").val(),
    					'msg' : $("#msg").val()

    				}));
    			}

				//dm 보내기
    			const sendDM = (msg) => {
					stompClient.send("/app/directMsg", {}, JSON.stringify({
    					'messageContent': $("#directMsg").val(),
    					'messageSender' : $("#webchat_username").val(),
						'messageReceiver' : $("#receive_username").val()
    				}));
    			}

    			
				 	
    			
				//입장메세지 출력
				const showGreeting = (member) => {
					let html = `<li class="list-group-item d-flex justify-content-between align-items-start">
					    <div class="ms-2 me-auto">
					      <div class="fw-bold">\${member}님이 입장하셨습니다.</div>
					    </div>
					  </li>`;
	    			
	    			$("#greetings").append(html)
	    			
	    		}

				//나갈때 출력
	    		const showDisconnect = (member) => {
	    			let html = `<li class="list-group-item d-flex justify-content-between align-items-start">
					    <div class="ms-2 me-auto">
					      <div class="fw-bold">\${member}님이 나가셨습니다.</div>
					    </div>
					  </li>`;
	    			
	    			$("#greetings").append(html)
	    		}
	   			
				
	 			//메세지 출력
	    		const showMsg = ({body}) => {
		    		const value = JSON.parse(body)
	    			const {msgNo, chatroomNo, writerNo, msg, regDate} = value;
					const username = $("#webchat_username").val();
	    			   			 
					let html = `<li class="list-group-item d-flex justify-content-between align-items-start">
								    <div class="ms-2 me-auto">
								      <div class="fw-bold">\${writerNo}</div>
								      \${msg}
								    </div>`;
								if(username == writerNo){    
									html += `<box-icon type='solid' name='edit'
										onclick="updateMsg(\${msgNo}, '\${msg}')"></box-icon>
										<box-icon name='x'  
									    onclick="deleteMsg(\${msgNo})"></box-icon>`;
								}
								
							html += `</li>`;
							
	    			$("#greetings").append(html);
	    			$("#cont").scrollTop($("#greetings")[0].scrollHeight);
	    		}

	    		

	    		//개인메세지 출력
	    		const showDm = ({body}) => {
		    		console.log(body)
	    			const value = JSON.parse(body);
	    			const {messageNo, messageContent, messageTime, messageSender, messageReceiver, readCheck} = value;
					
	    			const username = $("#webchat_username").val();
	    			const time = moment(messageTime).format("MMM Do hh:mm a");
	    			let html="";
	    			 if(username == messageSender){       
	                   html += `<div class="media media-chat media-chat-reverse">
			                            <div class="media-body">
			                                <p>\${messageContent}</p>
			                                <p class="meta">\${time}</p>
			                                <box-icon type='solid' name='edit' 
				                                onclick="updateDm(\${messageNo}, '\${messageContent}')"></box-icon>
					                         <box-icon name='x' onclick="deleteDm(\${messageNo})"></box-icon>
				                            </div>
			                         </div>`;
	                    	} else {
					
							html += `<div class="media media-chat"> 
			                            <div class="media-body">
			                                <p>\${messageContent}</p>
			                                <p class="meta">\${time}</p>
				                        </div>
				                     </div>`;
	                   }
	                   
						
	    			 $("#chat-content").append(html).scrollTop($("#chat-content")[0].scrollHeight);;


	    		}

	    		

				const showAddrList = () =>{
					
					$.ajax({
						url : `${pageContext.request.contextPath}/address/addrList/1`,
						method: 'GET',
						contentType:"application/json; charset=utf-8",
						success(data){
							console.log(data)
							const $Container = $("#addrList");
							let html = "";
							$(data).each((index, list) => {
								const {addrNo, savedEmp} = list
								 html += `<div class="list-group-item list-group-item-action py-3 lh-tight" onclick="addDm(\${savedEmp})"> 
								        <div class="d-flex w-80 align-items-center justify-content-between">
								          <strong class="mb-1">\${savedEmp}</strong>
								          <i id="dropdwonIcon" onclick="event.cancelBubble = true;" class='bx bx-dots-vertical-rounded bx-sm' data-bs-toggle="dropdown"></i>
										  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">

										    <li><a class="dropdown-item" onclick="event.cancelBubble = true; addrDelete(\${addrNo})">주소록 삭제</a></li>
										  </ul>
							          </div>
							        </div>`;
							})
						
							$Container.html(html);

						},
						error:console.log,
					})

				};
				

				const addDm = (id) =>{
					$("#receive_username").val(id);
				}

				$("#dropdwonIcon", ".dropdown-item").click(e => {
					console.log(e);
					e.preventDefault();
				});
				
				const addrDelete = (addrNo) =>{
					const byEmp = 1;
					const address = {addrNo};
					console.log(address);
					$.ajax({
						url : `${pageContext.request.contextPath}/address/delete`,
						method: 'POST',
						contentType:"application/json; charset=utf-8",
						data : JSON.stringify(address),
						success(data){
							console.log(data);
							showAddrList();
						},
						error:console.log,
					})
					
				}

			
    			$(function() {
					$("#dmSub").click(function(){
						dconnect();
					})
		    				    				
    				$("#disconnect").click(function() {
    					sendDisconnect();
    					
    				}); 
    				
    				$("#nameSend").click(function() {
    					sendUser();
    					chatList();
    					//showDmList();
    					
    				});
    				$("#msgSend").click(function() {
    					sendMessage();
    				});

    				$("#dmSend").click(function(){
        				
    					sendDM();
    					//showDmList();
        			})
        			

    				
    			});
    			connect();
    			showUserList();
    			$("#chat-content").scrollTop($("#chat-content")[0].scrollHeight);
    			showAddrList();
    			

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />