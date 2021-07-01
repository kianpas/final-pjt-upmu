<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
 <meta name="_csrf" content="${_csrf.token}"/>
 <meta name="_csrf_header" content="${_csrf.headerName}"/>
<style>
div#board-container {
	width: 800px;
}

input, button, textarea {
	margin-bottom: 15px;
}

button {
	overflow: hidden;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label {
	text-align: left;
}
.card-body{
font-size: 0.8rem
}
box-icon{
font-size: 10px!important;
}

#btn-container button{
	margin-bottom: 0;
}
</style>
<sec:authentication property="principal" var="principal" />
<div class="container">
	<div class="row justify-content-center">
		<div class="card shadow mb-4 col-10  px-0">
			<div class="card-header py-3">
				<h6 class="m-0 fw-bold text-primary">${board.title}
					(${board.cmtCount})</h6>
			</div>
			<div class="card-body">
				<table class="table">
					<tbody>
						<tr>
							<td>작성자</td>
							<td>${board.empName}</td>
						</tr>
						<tr>
							<td>첨부파일</td>
							<td>
								<c:forEach items="${board.attachList}" var="attach" varStatus="row">
									<c:if test="${attach.originalFilename != null}">
									<span class="me-3">
										<a href="#" onclick="location.href='${pageContext.request.contextPath}/board/fileDownload.do?no=${attach.no}';">
										${attach.originalFilename}
										</a>
										</span>
									</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td>등록일</td>
							<td><fmt:formatDate value="${board.regDate}" type="date"
									dateStyle="full" /></td>
						</tr>
						<tr>
							<td>조회수</td>
							<td>${board.readCount}</td>
						</tr>
						<tr>
							<td colspan="2" class="p-3" style="font-size:1rem; height: 50vh; overflow: auto">
								<p>${board.content}</p>
							</td>
						</tr>
					</tbody>
				</table>

				<c:if test="${board.empNo eq principal.empNo}">
					<button type="button" class="btn btn-primary btn-sm"
						onclick="boardUpPage(${board.no});"><box-icon name='edit-alt' color='#ffffff' ></box-icon></button>
					<button type="button" class="btn btn-danger btn-sm"
						onclick="boardDelete(${board.no});"><box-icon name='eraser' color='#ffffff' ></box-icon></button>
				</c:if>

				<div class="card mb-2">
					<div class="card-header bg-light">댓글</div>
					<div class="card-body">
						<ul class="list-group list-group-flush">
							<li class="list-group-item">
								<div class="form-inline mb-2">
									<textarea class="form-control" id="comment" rows="3"></textarea>
									<button type="button" class="btn btn-primary"
										onClick="addComment(${board.no});">comment</button>
								</div>

							</li>
						</ul>
					</div>
					<div class="card-body">
						<ul class="list-group list-group-flush" id="cmt-container">

						</ul>
					</div>
				</div>
			</div>

		</div>

	</div>

</div>

<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");


const boardUpPage =(no)=>{
	
	location.href = "${pageContext.request.contextPath}/board/boardUpdate.do?no=" + no;
		
}
const boardDelete =(no)=>{
	console.log(no)
	$.ajax({
		url : `${pageContext.request.contextPath}/board/boardDelete/\${no}`,
		method:'POST',
		beforeSend: function (xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: data =>{
			console.log(data)
			 location.href = "${pageContext.request.contextPath}/board/boardList.do";
		},
		error:console.log,

	})
	
}

const commentList = (boardNo) =>{

	 $.ajax({
			url : `${pageContext.request.contextPath}/comment/commentList/\${boardNo}`,
			method:'GET',
			success: data =>{
				console.log(data)
				let html ='';
				$.each(data, (key, value)=>{

					console.log(value)
					const {cmtNo, cmtContent, empNo, empName} = value;
					console.log(cmtNo, cmtContent, empNo, empName)
					
					html += `<li class="list-group-item">
							<p class="fw-bold">\${empName}</p>
							<p id="cmt\${cmtNo}">\${cmtContent}</p>`;
						if(empNo == ${principal.empNo})	{
						html +=	`<p id="btn-container" class="mb-0">
							<button type="button" id="edit-btn" class="btn btn-primary btn-sm" onClick="editComment(\${cmtNo});">
								<box-icon name='edit-alt'  color='#ffffff' ></box-icon>
							</button>
							<button type="button" class="btn btn-danger btn-sm" onClick="delComment(\${cmtNo});">
								<box-icon name='eraser' color='#ffffff' >
							</button>
							</p>`;
						}
					   html+= `</li>`;
				})
				
				$("#cmt-container").html(html);
			},
			error:console.log,

		}) 

	
}

const addComment = (boardNo) => {
	
	const cmtContent = $("#comment").val();
	const empNo = ${principal.empNo};
	const cmt = {boardNo, empNo, cmtContent};
	console.log(cmt)
	
	 $.ajax({
		url : `${pageContext.request.contextPath}/comment/addComment`,
		method:'POST',
		data:JSON.stringify(cmt),
		contentType:"application/json; charset=utf-8",
		beforeSend: function (xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: data =>{
			console.log(data)
			commentList(${board.no})
			$("#comment").val('');
			
		},
		error:console.log,

	}) 
}

const delComment = (cmtNo) => {
	
	 $.ajax({
		url : `${pageContext.request.contextPath}/comment/delComment`,
		method:'POST',
		data:JSON.stringify(cmtNo),
		contentType:"application/json; charset=utf-8",
		beforeSend: function (xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: data =>{
			console.log(data)
			commentList(${board.no})
			
		},
		error:console.log,

	})  
}


const editComment = cmtNo =>{
	const beforeContent = $("#cmt"+cmtNo+"").text();
	
	$("#cmt"+cmtNo+"").html(`<textarea class="form-control" id="edit-comment" rows="3">\${beforeContent}</textarea>`);
	const editBtn = `<button class="btn btn-success btn-sm" onClick="editCommentReal(\${cmtNo});">등록</button>`;
	$("#edit-btn").hide();
	$("#btn-container").append(editBtn)
}


const editCommentReal = (cmtNo) =>{
	
	const cmtContent = $("#edit-comment").val();
	const cmt = {cmtNo, cmtContent};	
	console.log(cmt)
	  $.ajax({
		url : `${pageContext.request.contextPath}/comment/editComment`,
		method:'POST',
		data:JSON.stringify(cmt),
		contentType:"application/json; charset=utf-8",
		beforeSend: function (xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: data =>{
			console.log(data)
			$("#edit-btn").show();
			commentList(${board.no})
			
			
		},
		error:console.log,

	})   
	
}


commentList(${board.no})
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
