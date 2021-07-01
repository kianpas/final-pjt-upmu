<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<!DOCTYPE html>
<html lang="ko">
	<head >
		<meta charset="UTF-8">
		<meta name="_csrf" content="${_csrf.token}"/>
 		<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>${param.title}</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- 조직도 테이블 관련 -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@300&display=swap" rel="stylesheet">

<!-- popper 추가 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<!-- box-icon -->
<script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<!-- 개인 챗용 css, stomp, moment -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/directMsg.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js" integrity="sha512-3kMAxw/DoCOkS6yQGfQsRY1FWknTEzdiz8DOwWoqf+eGRN45AmjS2Lggql50nCe9Q6m5su5dDZylflBY2YjABQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>	
	
<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />

<!-- bootstrap -->
<%-- <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script> --%>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

<%-- <c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script> 
</c:if>--%>
</head>
<body style="width: 1280px; height: 300px; margin: auto;">
	<header class="header responsive-wrapper">
  <a class="header-left" href="${pageContext.request.contextPath}/index.jsp">
  <img alt="logo" src="${pageContext.request.contextPath }/resources/images/logo1.png"  width="200" height="150">
  </a>
  <nav class="navbar navbar-expand-lg navbar-light bg-lig" style="display: flex; width: 60%; background-color: #f8f3eb;">
    <div class="container-fluid" >
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page"
              href="${pageContext.request.contextPath}/board/boardList.do">게시판</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page"
              href="${pageContext.request.contextPath}/document/docForm.do">전자결재</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page"
              href="${pageContext.request.contextPath}/attendance/attendanceManage.do">근태관리</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page"
              href="${pageContext.request.contextPath}/chat/chatRoomList.do">채팅</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown"
              aria-expanded="false">
              조직도
            </a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
              <li><a class="dropdown-item" href="${pageContext.request.contextPath}/employeeList/eList.do">페이지이동</a>
              </li>
              <li><input value="새창으로이동" onclick="eListPop();" class="dropdown-item" /></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown"
              aria-expanded="false">
              메일함
            </a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
              <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mail/sendMailList.do">보낸 메일함</a>
              </li>
              <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mail/receiveMailList.do">받은 메일함</a>
              </li>
            </ul>
          </li>
         <!--  <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling"><box-icon name='book' type='solid' color='#ffffff' ></box-icon></button> -->
       		<li class="nav-item">
              <a class="nav-link active" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling" style="cursor: pointer">주소록</a>
          </li>
       		
       		
       		<button type="button" class="btn btn-primary" id="chat-btn" onclick="openChat();" style="border-radius: 50%;"><box-icon name='chat' type='solid' color='#ffffff' ></box-icon>
</button>	
        </ul>
      </div>
    </div>
  </nav>
  <div class="header-right">
    <nav class="header-nav">
      <!-- 로그인이전 -->
      <sec:authorize access="isAnonymous()">
      <a href="${pageContext.request.contextPath}/employee/empLogin.do" class="header-link">Login</a>
      <a href="${pageContext.request.contextPath}/employee/empEnroll.do" class="header-link header-link--button">Sign Up</a> 
      </sec:authorize>
      <!-- 로그인이후 -->
      <sec:authorize access="isAuthenticated()">
      
      
      <sec:authentication property="principal" var="principal" />
		    <a href="${pageContext.request.contextPath}/member/memberDetail.do">
		   	<sec:authentication property="principal.username"/></a>님, 안녕하세요.			    
		   		&nbsp;
			   	<form:form class="d-inline" action="${pageContext.request.contextPath}/employee/empLogout.do" method="POST">
			   		<button class="btn btn-outline-success my-2 my-sm-0" type="submit">로그아웃</button>
			   	</form:form>
    	</sec:authorize>
      <c:import url="/notice/noticeBtn"></c:import>
    </nav>
  </div>
  <!-- 주소록 오프캔버스 -->
	<div class="offcanvas offcanvas-end" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling" aria-labelledby="offcanvasScrollingLabel">
	  <div class="offcanvas-header">
	    <h5 class="offcanvas-title" id="offcanvasScrollingLabel">주소록</h5>
	    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	  </div>
	  <div class="offcanvas-body">
	    <p></p>
	    <div class="list-group list-group-flush border-bottom scrollarea" id="addrList">
	      <div class="list-group-item list-group-item-action py-3 lh-tight" > 
	        <div class="d-flex w-80 align-items-center justify-content-between">
	          <strong class="mb-1"></strong>
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
	 <!-- 개인채팅창 -->
<div class="card card-bordered" id="chat-pop">
 	<div class="card-header">
 		<h4 class="card-title"><strong id="dmName"></strong></h4>
	</div>
	<div class="ps-container ps-theme-default ps-active-y" id="chat-content" style="overflow-y: scroll !important; height:400px !important;">               
		<div class="ps-scrollbar-x-rail" style="left: 0px; bottom: 0px;">
			<div class="ps-scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div>
        </div>
        <div class="ps-scrollbar-y-rail" style="top: 0px; height: 0px; right: 2px;">
            <div class="ps-scrollbar-y" tabindex="0" style="top: 0px; height: 2px;"></div>
        </div>
    </div>
    <div class="publisher bt-1 border-light" id="dm-input"> 
    	<input class="publisher-input" type="text" placeholder="" id="directMsg"> 
    	<span class="publisher-btn file-group"><i class='bx bxs-send' id="dmSend"></i></span>
    </div>
    <div class="publisher bt-1 border-light" id="dm-update" style="display:none;"> 
    	<input class="publisher-input" type="text" placeholder="" id="updateDmInput" >
    	<input type="hidden" name="messageNo" value="">
    	<span class="publisher-btn file-group"><i class='bx bxs-send' onclick="updateDmReal()"></i></span>
    </div>
</div>
	
	
<input type="hidden" id="receive_username"/>

<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");



//주소록리스트
const showAddrList = () => {
	
	$.ajax({
		url : `${pageContext.request.contextPath}/address/addrList/${principal.empNo}`,
		method: 'GET',
		contentType:"application/json; charset=utf-8",
		success(data){
			console.log(data)
			const $Container = $("#addrList");
			let html = "";
			$(data).each((index, list) => {
				const {addrNo, savedEmp, empName} = list
				 html += `<div class="list-group-item list-group-item-action py-3 lh-tight" onclick="addDm(\${savedEmp}, '\${empName}')"> 
				        <div class="d-flex w-80 align-items-center justify-content-between">
				          <strong class="mb-1">\${empName}</strong>
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

//주소록 삭제
const addrDelete = (addrNo) =>{
	//임시 사번
	const byEmp = ${principal.empNo};
	const address = {addrNo};
	console.log(address);
	$.ajax({
		url : `${pageContext.request.contextPath}/address/delete`,
		method: 'POST',
		contentType:"application/json; charset=utf-8",
		data : JSON.stringify(address),
		beforeSend: function (xhr) {
			xhr.setRequestHeader(header, token);
		},
		success(data){
			console.log(data);
			showAddrList();
		},
		error:console.log,
	})
	
}

var stompClient = null;
	
//개인메세지 구독
function dconnect() {
	const socket = new SockJS(
			'${pageContext.request.contextPath}/websocket-chat');
	stompClient = Stomp.over(socket);
	
	stompClient.connect({}, frame => {

			//내 개인메세지 구독
			
			
			const username = ${principal.empNo};
			const recvname = $("#receive_username").val();
			stompClient.subscribe(`/user/\${username}/directMsg`, frame => {
				console.log(frame)
				//showDm(frame);
				showDmList();
			});

			stompClient.subscribe(`/user/\${username}/updated`, frame => {
				//업데이트한 메세지의 높이 전달
				const type = "up";
				const body = JSON.parse(frame.body)
				const {messageNo} = body;
				const height = $(`#\${messageNo}`).data("lo");
				
				showDmList(type, height);
				
				//showDm(frame);
						
			});
		
			stompClient.subscribe(`/user/\${username}/deleted`, frame => {
				showDmList();
				
				//showDm(frame);
						
			});
		
			//보낸개인메세지 구독
			stompClient.subscribe(`/user/\${recvname}/directMsg`, frame => {
				showDmList();
				
				//showDm(frame);
						
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

//개인메세지 가져오기
const showDmList = (type, height) => {
	const username = ${principal.empNo};
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
											
					//서버와의 시간차 9시간 조정
					const time = moment(messageTime).format("Do hh:mm a")
										
					 if(username == messageSender){       
	                    	html += `<div class="media media-chat media-chat-reverse" id="dm\${messageNo}" onmouseover="showDmIcon(\${messageNo})">
			                            <div class="media-body reverse">
			                                <p>\${messageContent}</p>
				                            </div>
				                            <p class="meta-reverse">\${time}</p>
				                            <div class="icon-dm">
					                         <box-icon type='solid' name='edit' onclick="updateDm(\${messageNo}, '\${messageContent}')"></box-icon>
					                         <box-icon name='x'  onclick="deleteDm(\${messageNo})"></box-icon>
				                         </div>
			                         </div>`;
			                         
	                    	} else {
					
							html += `<div class="media media-chat"> 
			                            <div class="media-body">
			                                <p>\${messageContent}</p>
			                                
				                        </div>
				                        <p class="meta">\${time}</p>
				                     </div>`;
	                   }
					
					
				})
				
				
				$container.html(html)
				const location = $("#chat-content")[0].scrollHeight;
					
					console.log(location)
					
				//업데이트한 경우 업데이트한 메세지 위치로 이동
				if(type=="up"){
					$container.scrollTop(height);
				} else {
					$container.scrollTop($container[0].scrollHeight);
				}
			},
			error:console.log,
		})
		
			console.log($("#chat-content")[0].scrollHeight)
			
}


//메세지 수정 전 가져오기
const updateDm = (no, msg) => {
	$("#dm-input").hide();
	$("#dm-update").show();
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

	$("#dm-input").show();
	$("#dm-update").hide();
}

//메세지 삭제
const deleteDm = (messageNo) => {
	console.log(messageNo);
	
	 stompClient.send("/app/deleteDm", {}, JSON.stringify({
		 'messageReceiver' : $("#receive_username").val(),
			'messageNo' : messageNo
			
	 }));

}
//dm 보내기
const sendDM = (msg) => {
	
	stompClient.send("/app/directMsg", {}, JSON.stringify({
		'messageContent': $("#directMsg").val(),
		'messageSender' : ${principal.empNo},
		'messageReceiver' : $("#receive_username").val()
	}));
	
	
}

//주소록에서 dm을 전달
const addDm = (id, name) =>{
	$("#receive_username").val(id);
	$("#dmName").text(name)
	dconnect();
	showDmList();
	$("#chat-btn").show();
}

//개인메세지 창 열기
const openChat = () => {
	
	if($("#chat-pop").css("display") == "none"){
	    $("#chat-pop").show();
	} else {
	    $("#chat-pop").hide();
	}
	
}

//개인대화창 수정, 삭제 아이콘 표시
const showDmIcon = (messageNo) => {
	
	const $list = $(`#dm\${messageNo}`);
	
	const $icon = $(`#dm\${messageNo} .icon-dm`);
	
	$list.hover(function(){
		$icon.show();
	})
	
	$list.mouseleave(function(){
		$icon.hide();
		
	})
}

$(function(){
	$("#dmSend").click(e=> {
		sendDM();
		showDmList();
	})
	$("#chat-btn").hide();
	
})

showAddrList();
</script>
</header>
