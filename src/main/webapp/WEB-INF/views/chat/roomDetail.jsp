<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>	
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!-- <script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js" integrity="sha512-3kMAxw/DoCOkS6yQGfQsRY1FWknTEzdiz8DOwWoqf+eGRN45AmjS2Lggql50nCe9Q6m5su5dDZylflBY2YjABQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/sidebars.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/directMsg.css">
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/roomDetail.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" /> 
<style>
#chat-list-container li{
  border: 0 none;
}
</style>

<sec:authentication property="principal" var="principal"/>
<div class="container">
	<div class="row justify-content-start">
		<div class="flex-shrink-0  col-md-2" >
	     	<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 fw-bold text-primary">${chatroom.title}</h6>
				</div>
				<div class="card-body">
					<ul class="list-unstyled ps-0">
			      		<li class="mb-1">
				       	<button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#join-collapse" aria-expanded="false">
				          내가 참여한 채팅
				        </button>
				        <div class="collapse" id="join-collapse">
				        </div>
			      		</li>
			     		 <li class="border-top my-3"></li>
				      <li class="mb-1">
				        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#account-collapse" aria-expanded="false">
				         현재 참여 직원
				        </button>
				        <div class="collapse" id="account-collapse">
				       </div>
			   		 </li>
	    			</ul>
	     		<button class="btn btn-primary" type="button" id="disconnect">나가기</button>
					</div>
				</div>
	  	</div>

	<div class="col-md-10">
	   <div class="col-md-12">
	      <input type="hidden" id="receive_username"/>
	         <div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary"></h6>
				</div>
				<div class="card-body">
					<div id="cont" class="mb-3" style="height: 500px; overflow: auto; border:1px solid #fff;  border-radius: .55rem;">
						<ul class="list-group list-group" id="chat-list-container">
						</ul>
					</div>
					<div class="input-group mb-3" id="msg-input">
					  <input type="text" id="msg" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2">
					  <button class="btn btn-primary" type="button" id="msgSend"><i class='bx bxs-send' ></i></button>
					</div>
					<div class="input-group mb-3" id="update-container" style="display:none;">
					  <input type="text" class="form-control" placeholder="" id="updateInput" aria-label="Recipient's username" aria-describedby="button-addon2">
					  <input type="hidden" name="msgNo" value="">
						<button class="btn btn-info" type="button" id="up-btn" onclick="updateMsgReal()"><i class='bx bxs-send' ></i></button>
					</div>
				</div>
			</div>
	        </div>
		</div>
	</div>
</div>


<!-- 토스트 -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 5">
  <div id="liveToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <strong class="me-auto"></strong>
      <small id="joinDate"></small>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
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
    				//showMsg(frame);
    				chatList();
    				
    			});

    			//입장 구독
    			stompClient.subscribe(`/topic/chat/greeting/${chatroomNo}`, frame => {
    				console.log(frame);
    				showGreeting(frame);
    				//유저리스트 갱신
    				showUserList();
    				
    			});
				//업데이트 구독
				stompClient.subscribe(`/topic/chat/updated/${chatroomNo}`, frame => {
					//업데이트한 메세지의 높이 전달
    				const type = "up";
    				const body = JSON.parse(frame.body)
    				const {msgNo} = body;
    				const height = $(`#\${msgNo}`).data("lo");
    				
    				chatList(type, height);
    			
    				
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

				//챗룸 참여 여부 확인
    			checkJoin();
    			
    		});
    	}		

    	
				
    			//채팅방에 참여한 인원 가져오는 펑션
				const showUserList = () => {
					$.ajax({
						url : `${pageContext.request.contextPath}/chat/userList/${chatroomNo}`,
						method: 'GET',
						contentType:"application/json; charset=utf-8",
						
						success(data){
							const $userContainer = $("#account-collapse");
							let html = "<ul class='btn-toggle-nav list-unstyled fw-normal pb-1 small'>";

							$(data).each((index, user) => {
								console.log(user)
								html += `<li>\${user.EMP_NAME}</li>`;
								
							})
							
							html += "</ul>";
							$userContainer.html(html);

						},
						error:console.log,

						
					})
				}

				//참여한 채널,챗룸 가져오는 펑션
				const showJoinList = () => {
					const empNo = ${principal.empNo};
					
					$.ajax({
						url : `${pageContext.request.contextPath}/chat/joinList/\${empNo}`,
						method: 'GET',
						contentType:"application/json; charset=utf-8",
						success(data){
							const $joinContainer = $("#join-collapse");
							console.log($joinContainer)
							let html = "<ul class='btn-toggle-nav list-unstyled fw-normal pb-1 small'>";
							
							$(data).each((index, room) => {
								const title = room.TITLE;
								const chatroomNo = room.CHATROOM_NO;
								
								html += `<li>
										<a href=${pageContext.request.contextPath}/chat/room/enter/\${chatroomNo} class="link-dark rounded">\${title}</a>
										</li>`;
							})
							
							html += "</ul>";
							$joinContainer.html(html);

						},
						error:console.log,
					})
				}
							

				//채팅내역 가져오는 펑션
				const chatList = (type, height) => {
					
					$.ajax({
						url : `${pageContext.request.contextPath}/chat/room/chatList/${chatroomNo}`,
						method: 'GET',
						contentType:"application/json; charset=utf-8",
						success(data){
							
							if(data!=null){
							
								const $container = $("#chat-list-container");
								let html = '';
								$.each(data, function(key, value){
									
									const username = ${principal.empNo};
									//console.log(value);
									const {msgNo, chatroomNo, writerNo, msg, regDate, empName} = value;
									const location = $container[0].scrollHeight;
									
									html += `<li class="list-group-item d-flex justify-content-between align-items-start" 
												id="\${msgNo}" data-lo="\${location}" onmouseenter="showIcon(\${msgNo})">
												    <div class="ms-2 me-auto">
												      <div class="fw-bold">\${empName}</div>
												      \${msg}
												    </div>`;
											if(username == writerNo){    
													html += `<div class="icon-container"><box-icon type='solid' name='edit'
														onclick="updateMsg(\${msgNo}, '\${msg}')"></box-icon>
														<box-icon name='x'  
													    onclick="deleteMsg(\${msgNo})"></box-icon></div>`;
												}
												
											html += `</li>`;
									
								})
								
								$container.html(html);
							} else {
								
								const $container = $("#chat-list-container");
								html = '';
								$container.html(html);
							}
							
							
							//업데이트한 경우 업데이트한 메세지 위치로 이동
							const $container = $("#chat-list-container");
							if(type=="up"){
								
								$("#cont").scrollTop(height);
							} else {
								$("#cont").scrollTop($container[0].scrollHeight);
							}
						
						},
						error:console.log,
					})
				}

				//메세지 수정 전 가져오기
        		const updateMsg = (no, msg) => {
            		$("#msg-input").hide();
            		
					$("#updateInput").val(msg);
					$("[name=msgNo]").val(no);

					$("#update-container").show();

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
	        			
	        		 $("#msg-input").show();
	        		 $("#update-container").hide();
	        		 $("#updateInput").val('');
				}
        		
				
				//메세지 삭제
				const deleteMsg = (msgNo) => {
					console.log(msgNo);

					 stompClient.send("/app/delete", {}, JSON.stringify({
						 'chatroomNo': ${chatroomNo},
							'msgNo' : msgNo
					 }));
					
				}


			
				//입장
				const sendUser = () => {
					stompClient.send("/app/join", {}, JSON.stringify({
						'empNo' : ${principal.empNo},
						'chatroomNo': ${chatroomNo}
					}));
	
				}

				//나가기
				const sendDisconnect = (msg) => {
    				stompClient.send("/app/disconnect", {}, JSON.stringify({
    					'empNo' : ${principal.empNo},
						'chatroomNo': ${chatroomNo}
    				}));
    				location.href = "${pageContext.request.contextPath}/chat/chatRoomList.do";
    			}

				//메세지 보내기
				const sendMessage = (msg) => {
    				stompClient.send("/app/message", {}, JSON.stringify({
    					'chatroomNo': ${chatroomNo},
    					'writerNo' : ${principal.empNo},
    					'msg' : $("#msg").val()

    				}));
    				$("#msg").val('');
    			}
		
    			
				 	
    			
				//입장메세지 출력
				const showGreeting = (joinInfo) => {
					const {empNo, regDate} = JSON.parse(joinInfo.body);
					
					 $(".toast-body").text(`\${empNo}님이 입장하셨습니다.`);
					 $("#joinDate").text(moment((moment().format())).fromNow());
					  $('#liveToast').toast('show');
	    			
	    			
	    		}

				//나갈때 출력
	    		const showDisconnect = (empNo) => {
		    		console.log(empNo)
		    		
		    		 $(".toast-body").text(`\${empNo}님이 나가셨습니다.`);
					 $("#joinDate").text(moment((moment().format())).fromNow());
					  $('#liveToast').toast('show');
	    		}
	   			
				
	 			//메세지 출력, chatList로 대체
	    		const showMsg = ({body}) => {
		    		
		    		const value = JSON.parse(body)
	    			const {msgNo, chatroomNo, writerNo, msg, regDate} = value;
					const username = ${principal.empNo};
					  			 
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
							
	    			$("#chat-list-container").append(html);
	    			$("#cont").scrollTop($("#chat-list-container")[0].scrollHeight);
	    		}

	    		


				$("#dropdwonIcon", ".dropdown-item").click(e => {
					console.log(e);
					e.preventDefault();
				});

				

//챗룸 조인 여부 확인
const checkJoin = () => {
		const empNo = ${principal.empNo};
		const chatroomNo = ${chatroomNo};
			$.ajax({
				url:"${pageContext.request.contextPath}/chat/checkJoinDuplicate",
				data: {empNo, chatroomNo},
				success:data=>{
					console.log(data); //{"available":true}
					console.log(data.available);
					if(data.available){
						//true시 정보를 서버에 보냄
						sendUser();
					
					}else {
						console.log("이미 참여")	
					}
								
				},
				error:console.log,

			})
						
}


				
			
    			$(function() {
        			
    				chatList();
    			
		    				    				
    				$("#disconnect").click(function() {
    					sendDisconnect();
    					
    				}); 
    				
    				$("#nameSend").click(function() {
    					chatList();

    				});

					$("#dmSend").click(e=> {
						sendDM();
						showDmList();
					})
    				
    				$("#msgSend").click(function() {
    					sendMessage();
    				});
					$("#msg").keydown(function(key) {
		               
		                if (key.keyCode == 13) {
		                	sendMessage();
		                  
		                }
		            });
		            
					$("#updateInput").keydown(function(key) {
			               
		                if (key.keyCode == 13) {
		                	updateMsgReal();
		                  
		                }
		            });

        			
    			});


showJoinList();
connect();
showUserList();
showAddrList();
   	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />