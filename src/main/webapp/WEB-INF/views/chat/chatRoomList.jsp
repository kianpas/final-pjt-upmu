<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>	
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatRoomList.css" />
<sec:authentication property="principal" var="principal"/>
    <div class="container" id="app">
        <div class="row">
            <div class="col-md-12">
                <h3>채팅방 리스트</h3>
            </div>
        </div>
        
        <div class="input-group">
            <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#exampleModal">
 			 채팅방 개설
			</button>
        </div>
      
    </div>
   
  <%-- div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 380px;">
    <div class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
      <svg class="bi me-2" width="30" height="24"><use xlink:href="#bootstrap"/></svg>
      <span class="fs-5 fw-semibold">List group</span>
    </div>
    <div class="list-group list-group-flush border-bottom scrollarea">
     <c:forEach items="${chatRoomList}" var="chatRoomList">
      <div class="list-group-item list-group-item-action py-3 lh-tight" onclick="chatRoomDetail(${chatRoomList.chatroomNo})"> 
        <div class="d-flex w-80 align-items-center justify-content-between">
          <strong class="mb-1">${chatRoomList.title}</strong>
          <sec:authentication property="principal.empNo" var="empNo"/>
          <c:if test="${chatRoomList.empCreate eq principal.empNo}">
          <i id="dropdwonIcon" class='bx bx-dots-vertical-rounded bx-sm' data-bs-toggle="dropdown"></i>
		  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
		    <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#updateModal" data-no="${chatRoomList.chatroomNo}" data-title="${chatRoomList.title}" id="updateBtn">방 이름 변경</a></li>
		      <li><hr class="dropdown-divider"></li>
		    <li><a class="dropdown-item" onclick="chatRoomDelete(${chatRoomList.chatroomNo})">방 삭제</a></li>
		  </ul>
		  </c:if>
        </div>
     </div> 
     </c:forEach>
     </div>
  </div> --%>
<form:form id="chatRoomDeleteFrm" method="post">
	<input type="hidden" name="chatroomNo" />
 </form:form>
<!-- createModal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">방 생성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form:form id="chatRoomCreateFrm" method="post" action="${pageContext.request.contextPath}/chat/room">
      <div class="modal-body">
       	  <label for="roomTitle" class="col-form-label">방 제목</label>
          <input type="text" class="form-control" name="title" id="roomTitle">
          <input type="hidden" class="form-control" name="empCreate" value="${principal.empNo}">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary"  id="btn-create">생성</button>
      </div>
      </form:form>
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
      <form:form id="chatRoomUpdateFrm" method="post">
      <div class="modal-body">
       	  <label for="roomTitle" class="col-form-label">방 제목</label>
          <input type="text" class="form-control" name="title" id="updateTitle" value="">
          <input type="hidden" class="form-control" name="chatroomNo" id="updateNo" value="">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary"  id="btn-create">수정</button>
      </div>
       </form:form>
    </div>
  </div>
</div>


<div class="page-content container note-has-grid">
    <!-- <ul class="nav nav-pills p-3 bg-white mb-3 rounded-pill align-items-center">
        <li class="nav-item">
            <a href="javascript:void(0)" class="nav-link rounded-pill note-link d-flex align-items-center px-2 px-md-3 mr-0 mr-md-2 active" id="all-category">
                <i class="icon-layers mr-1"></i><span class="d-none d-md-block">All Notes</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="javascript:void(0)" class="nav-link rounded-pill note-link d-flex align-items-center px-2 px-md-3 mr-0 mr-md-2" id="note-business"> <i class="icon-briefcase mr-1"></i><span class="d-none d-md-block">Business</span></a>
        </li>
        <li class="nav-item">
            <a href="javascript:void(0)" class="nav-link rounded-pill note-link d-flex align-items-center px-2 px-md-3 mr-0 mr-md-2" id="note-social"> <i class="icon-share-alt mr-1"></i><span class="d-none d-md-block">Social</span></a>
        </li>
        <li class="nav-item">
            <a href="javascript:void(0)" class="nav-link rounded-pill note-link d-flex align-items-center px-2 px-md-3 mr-0 mr-md-2" id="note-important"> <i class="icon-tag mr-1"></i><span class="d-none d-md-block">Important</span></a>
        </li>
        <li class="nav-item ml-auto">
            <a href="javascript:void(0)" class="nav-link btn-primary rounded-pill d-flex align-items-center px-3" id="add-notes"> <i class="icon-note m-1"></i><span class="d-none d-md-block font-14">Add Notes</span></a>
        </li>
    </ul> -->
    <div class="tab-content bg-transparent">
        <div id="note-full-container" class="note-has-grid row">
  			<c:forEach items="${chatRoomList}" var="chatRoomList">
            <div class="col-md-4 single-note-item all-category note-important" style="">
                <div class="card card-body">
                    <span class="side-stick"></span>
                    <h5 class="note-title  w-75 mb-1" onclick="chatRoomDetail(${chatRoomList.chatroomNo})">${chatRoomList.title} <!-- <box-icon name='chevrons-right' class="align-text-top" animation='fade-right-hover'></box-icon> --></h5>
                    <p class="note-date font-12 text-muted"><fmt:formatDate value="${chatRoomList.regDate}"/></p>
                    <div class="note-content">
                       <!--  <p class="note-inner-content text-muted" data-notecontent="Blandit tempus porttitor aasfs. Integer posuere erat a ante venenatis."></p> -->
                    </div>
                    <div class="d-flex align-items-center" style="height:24px;">      
                     <c:if test="${chatRoomList.empCreate eq principal.empNo}">
				          <i id="dropdwonIcon" class='bx bx-dots-horizontal-rounded bx-sm' data-bs-toggle="dropdown"></i>
						  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
						    <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#updateModal" data-no="${chatRoomList.chatroomNo}" data-title="${chatRoomList.title}" id="updateBtn">방 이름 변경</a></li>
						      <li><hr class="dropdown-divider"></li>
						    <li><a class="dropdown-item" onclick="chatRoomDelete(${chatRoomList.chatroomNo})">방 삭제</a></li>
						  </ul>
					 </c:if>             
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
    </div>

    <!-- Modal Add notes -->
    <div class="modal fade" id="addnotesmodal" tabindex="-1" role="dialog" aria-labelledby="addnotesmodalTitle" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content border-0">
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title text-white">Add Notes</h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="notes-box">
                        <div class="notes-content">
                            <form action="javascript:void(0);" id="addnotesmodalTitle">
                                <div class="row">
                                    <div class="col-md-12 mb-3">
                                        <div class="note-title">
                                            <label>Note Title</label>
                                            <input type="text" id="note-has-title" class="form-control" minlength="25" placeholder="Title" />
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="note-description">
                                            <label>Note Description</label>
                                            <textarea id="note-has-description" class="form-control" minlength="60" placeholder="Description" rows="3"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btn-n-save" class="float-left btn btn-success" style="display: none;">Save</button>
                    <button class="btn btn-danger" data-dismiss="modal">Discard</button>
                    <button id="btn-n-add" class="btn btn-info" disabled="disabled">Add</button>
                </div>
            </div>
        </div>
    </div>
</div>


<script>

$("#chatRoomCreateFrm").submit(e => {
	//e.preventDefault();
	const $frm = $(e.target);
	console.log($frm);
	
	const empCreate =  $frm.find("[name=empCreate]").val();
	console.log(empCreate)
	//return true;
	
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