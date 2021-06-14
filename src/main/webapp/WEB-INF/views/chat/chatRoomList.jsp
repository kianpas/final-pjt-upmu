<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
	<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<h1>챗 화면</h1>

    <div class="container" id="app">
        <div class="row">
            <div class="col-md-12">
                <h3>채팅방 리스트</h3>
            </div>
        </div>
        
        <div class="input-group">
           
          
           <!--  <div class="input-group-append">
                <button class="btn btn-primary" type="button" @click="createRoom">채팅방 개설</button>
            </div> -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
 			 채팅방 개설
			</button>
        </div>
      
    </div>
   
  <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 380px;">
    <div class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
      <svg class="bi me-2" width="30" height="24"><use xlink:href="#bootstrap"/></svg>
      <span class="fs-5 fw-semibold">List group</span>
    </div>
    <div class="list-group list-group-flush border-bottom scrollarea">
     <c:forEach items="${chatRoomList}" var="chatRoomList">
      <div class="list-group-item list-group-item-action py-3 lh-tight" onclick="chatRoomDetail(${chatRoomList.chatroomNo})"> 
        <div class="d-flex w-80 align-items-center justify-content-between">
          <strong class="mb-1">${chatRoomList.title}</strong>
          <i id="dropdwonIcon" class='bx bx-dots-vertical-rounded bx-sm' data-bs-toggle="dropdown"></i>
		  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
		    <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#updateModal" data-no="${chatRoomList.chatroomNo}" data-title="${chatRoomList.title}" id="updateBtn">방 이름 변경</a></li>
		      <li><hr class="dropdown-divider"></li>
		    <li><a class="dropdown-item" onclick="chatRoomDelete(${chatRoomList.chatroomNo})">방 삭제</a></li>
		  </ul>
        </div>
        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
     </div> 
     </c:forEach>
     </div>
  </div>
<form id="chatRoomDeleteFrm" method="post">
	<input type="hidden" name="chatroomNo" />
</form>
<!-- createModal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">방 생성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form id="chatRoomCreateFrm" method="post" action="${pageContext.request.contextPath}/chat/room">
      <div class="modal-body">
       	  <label for="roomTitle" class="col-form-label">방 제목</label>
          <input type="text" class="form-control" name="title" id="roomTitle">
          <input type="hidden" class="form-control" name="empCreate">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary"  id="btn-create">생성</button>
      </div>
      </form>
    </div>
  </div>
</div>

<!-- updateModal -->
<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">방 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form id="chatRoomUpdateFrm" method="post">
      <div class="modal-body">
       	  <label for="roomTitle" class="col-form-label">방 제목</label>
          <input type="text" class="form-control" name="title" id="updateTitle" value="">
          <input type="hidden" class="form-control" name="chatroomNo" id="updateNo" value="">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary"  id="btn-create">수정</button>
      </div>
      </form>
    </div>
  </div>
</div>

<script>
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

//드롭다운 이벤트버블링방지
$("#dropdwonIcon, .dropdown-item").click(e => {
	e.stopPropagation();
	
}); 

//방제목 수정을 위한 이벤트
$(function(){
	const upBtn = document.querySelectorAll("#updateBtn")
	console.log(upBtn);
	$(upBtn).each((index, item)=>{
		console.log(index, item);
		$(item).click(e => {
			const title = e.target.dataset.title;
			const chatroomNo = e.target.dataset.no;
			$("#updateTitle").val(title);
			$("#updateNo").val(chatroomNo);
			
		})
	})
})

	

//수정하기
$("#chatRoomUpdateFrm").submit(e => {
	
	const $frm = $(e.target);
	console.log($frm);
	 $frm.find("[name=title]").val();
	 $frm.find("[name=chatroomNo]").val();
	$frm.attr("action", `${pageContext.request.contextPath}/chat/chatRoomUpdate`)
	
	$('#updateModal').modal('hide');
	
});

/* const chatRoomUpdate = (chatroomNo, title) => {
	console.log(chatroomNo, title);
	const $frm = $("#chatRoomUpdateFrm");
	console.log($frm);
	$frm.find("[name=title]").val(title);
	$frm.attr("action", `${pageContext.request.contextPath}/chat/chatRoomDelete/\${chatroomNo}`);
	$frm.submit();
	
}
 */

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