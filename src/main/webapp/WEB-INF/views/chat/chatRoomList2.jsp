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
	<script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
	<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/chat.css">    
<div class="l-navbar" id="nav-bar">
	<nav class="nav">
		<div>
			<a href="#" class="nav_logo"> <i
				class='bx bx-layer nav_logo-icon'></i> <span class="nav_logo-name">BBBootstrap</span>
			</a>
			<div class="nav_list">
				<a href="#" class="nav_link active"> <i
					class='bx bx-grid-alt nav_icon'></i> <span class="nav_name">Dashboard</span>
				</a> <a href="#" class="nav_link"> <i class='bx bx-user nav_icon'></i>
					<span class="nav_name">Users</span>
				</a> <a href="#" class="nav_link"> <i
					class='bx bx-message-square-detail nav_icon'></i> <span
					class="nav_name">Messages</span>
				</a> <a href="#" class="nav_link"> <i
					class='bx bx-bookmark nav_icon'></i> <span class="nav_name">Bookmark</span>
				</a> <a href="#" class="nav_link"> <i class='bx bx-folder nav_icon'></i>
					<span class="nav_name">Files</span>
				</a> <a href="#" class="nav_link"> <i
.					class='bx bx-bar-chart-alt-2 nav_icon'></i> <span class="nav_name">Stats</span>
				</a>
			</div>
		</div>
		<a href="#" class="nav_link"> <i class='bx bx-log-out nav_icon'></i>
			<span class="nav_name">SignOut</span>
		</a>
	</nav>
</div>
<!--Container Main start-->
<div class="height-100 bg-light">
	<h4>Main Components</h4>
</div>

<script>
document.addEventListener("DOMContentLoaded", function(event) {

	const showNavbar = (toggleId, navId, bodyId, headerId) =>{
		const toggle = document.getElementById(toggleId),
		nav = document.getElementById(navId),
		bodypd = document.getElementById(bodyId),
		headerpd = document.getElementById(headerId)

	// Validate that all variables exist
	if(toggle && nav && bodypd && headerpd){
		toggle.addEventListener('click', ()=>{
			// show navbar
			nav.classList.toggle('show')
			// change icon
			toggle.classList.toggle('bx-x')
			// add padding to body
			bodypd.classList.toggle('body-pd')
			// add padding to header
			headerpd.classList.toggle('body-pd')
			})
		}
	}

	showNavbar('header-toggle','nav-bar','body-pd','header')

	/*===== LINK ACTIVE =====*/
	const linkColor = document.querySelectorAll('.nav_link')

	function colorLink(){
		if(linkColor){
		linkColor.forEach(l=> l.classList.remove('active'))
		this.classList.add('active')
		}
	}
	linkColor.forEach(l=> l.addEventListener('click', colorLink))

	// Your code to run since DOM is loaded and ready
	});


//챗룸 생성하기
$("#chatRoomCreateFrm").submit(e => {
	//e.preventDefault();
	const $frm = $(e.target);
	console.log($frm);
	const empCreate =  $frm.find("[name=empCreate]").val(1);
	return true;
	
	$('#exampleModal').modal('hide');
	
});
//삭제하기
function chatRoomDelete(chatroomNo){
	const $frm = $("#chatRoomDeleteFrm");
	console.log($frm);
	$frm.find("[name=chatroomNo]").val(chatroomNo);
	$frm.attr("action", `${pageContext.request.contextPath}/chat/chatRoomDelete/\${chatroomNo}`);
	$frm.submit();
	
};
//입장하기
const chatRoomDetail = (chatroomNo) => {
	console.log(chatroomNo);
	 location.href="${pageContext.request.contextPath}/chat/room/enter/"+chatroomNo;
}

/* function chatRoomDetail(chatroomNo){
	console.log(chatroomNo);
	 location.href="${pageContext.request.contextPath}/chat/room/enter/"+chatroomNo;
}; */



/*  vue.js 참조용
var vm = new Vue({
    el: '#app',
    data: {
        room_name : '',
        chatrooms: [
        ]
    },
    created() {
        this.findAllRoom();
    },
    methods: {
        findAllRoom: function() {
            axios.get('${pageContext.request.contextPath}/chat/rooms').then(response => { this.chatrooms = response.data; });
        },
        createRoom: function() {
            if("" === this.room_name) {
                alert("방 제목을 입력해 주십시요.");
                return;
            } else {
                var params = new URLSearchParams();
                params.append("name",this.room_name);
                axios.post('${pageContext.request.contextPath}/chat/room', params)
                .then(
                    response => {
                        alert(response.data.name+"방 개설에 성공하였습니다.")
                        this.room_name = '';
                        this.findAllRoom();
                    }
                )
                .catch( response => { alert("채팅방 개설에 실패하였습니다."); } );
            }
        },
        enterRoom: function(roomId) {
            var sender = prompt('대화명을 입력해 주세요.');
            if(sender != "") {
                localStorage.setItem('wschat.sender',sender);
                localStorage.setItem('wschat.roomId',roomId);
                location.href="${pageContext.request.contextPath}/chat/room/enter/"+roomId;
            }
        }
    }
});  */
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />