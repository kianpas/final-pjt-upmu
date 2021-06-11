<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>

<h1>챗 화면</h1>

    <div class="container" id="app" v-cloak>
        <div class="row">
            <div class="col-md-12">
                <h3>채팅방 리스트</h3>
            </div>
        </div>
        
        <div class="input-group">
            <div class="input-group-prepend">
                <label class="input-group-text">방제목</label>
            </div>
          
           <!--  <div class="input-group-append">
                <button class="btn btn-primary" type="button" @click="createRoom">채팅방 개설</button>
            </div> -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
 			 채팅방 개설
			</button>
        </div>
        <ul class="list-group">
        <c:forEach items="${chatRoomList}" var="chatRoomList">
            <li class="list-group-item list-group-item-action d-flex justify-content-between align-items-start"  onclick="chatRoomDetail(${chatRoomList.chatroomNo})">
            	${chatRoomList.title}   
            </li>
            <!--<c:if test="${chatRoomList.empCreate eq loginMember.empNo}">
            <button type="button" class="btn btn-danger" onclick="chatRoomDelete(${chatRoomList.chatroomNo})">Danger</button>
         	</c:if>-->
         </c:forEach>
        </ul>
    </div>
   
  <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 380px;">
    <a href="/" class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
      <svg class="bi me-2" width="30" height="24"><use xlink:href="#bootstrap"/></svg>
      <span class="fs-5 fw-semibold">List group</span>
    </a>
    <div class="list-group list-group-flush border-bottom scrollarea">
    
     <c:forEach items="${chatRoomList}" var="chatRoomList">
      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
        <div class="d-flex w-100 align-items-center justify-content-between">
          <strong class="mb-1">${chatRoomList.title}</strong>
          <small class="text-muted">Tues</small>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
      </a>
     </c:forEach>
     </div>
  </div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form id="chatRoomCreateFrm">
      <div class="modal-body">
          <input type="text" class="form-control" name="title">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary"  id="btn-create">생성</button>
      </div>
      </form>
    </div>
  </div>
</div>
<script>
//챗룸 생성하기
$("#chatRoomCreateFrm").submit(e =>{
	e.preventDefault();
	const $frm = $(e.target);
	console.log($frm);
	const title = $frm.find("[name=title]").val();
	
	const empCreate = 1;
	const chatRoom = {title, empCreate};
	
	$.ajax({
		url:"${pageContext.request.contextPath}/chat/room",
		method:"post",
		data : JSON.stringify(chatRoom),
		contentType:"application/json; charset=utf-8",
		success(data){
			console.log(data);
		},
		error:console.log,
		
		});
$('#exampleModal').modal('hide');
	
});
function chatRoomDelete(chatroomNo){

	$.ajax({
		url:`${pageContext.request.contextPath}/chat/chatRoomDelete/\${chatroomNo}`,
		method:"get",
		contentType:"application/json; charset=utf-8",
		success(data){
			console.log(data);
		},
		error:console.log,
		
		});
};


function chatRoomDetail(chatroomNo){
	console.log(chatroomNo);
	 location.href="${pageContext.request.contextPath}/chat/room/enter/"+chatroomNo;
};



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