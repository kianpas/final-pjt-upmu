<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>	
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
 <meta name="_csrf" content="${_csrf.token}"/>
 <meta name="_csrf_header" content="${_csrf.headerName}"/>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
	crossorigin="anonymous"></script>
<style>
div#board-container {
	width: 400px;
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
</style>
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");


/* textarea에도 required속성을 적용가능하지만, 공백이 입력된 경우 대비 유효성검사를 실시함. */
function boardValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
$(()=>{
	$("[name=upFile]").change(e =>{
	//파일명 가져오기
	var file = $(e.target).prop('files')[0];
	console.log(file);
	var $label = $(e.target).next();
	//label 적용	
	$label.html(file?file.name : "파일을 선택하세요.");
	});
})
function goBack(){
	window.history.back();
	
}
</script>
<sec:authentication property="principal" var="principal"/>


<div class="container">
	<form:form 
		name="boardFrm" 
		action="${pageContext.request.contextPath}/board/boardEnroll.do?${_csrf.parameterName}=${_csrf.token}" 
		method="post"
		enctype="multipart/form-data" 
		onsubmit="return boardValidate();">
	<table class="table">
		<tr>
			<td style="width: 10%">작성자</td>
			<td>${principal.empName}</td>
		</tr>

		<tr>
			<td style="width: 10%">제목</td>
			<td>
				<input type="text" class="form-control" placeholder="제목" name="title" id="title" value="${board.title}"required>
				<input type="hidden" class="form-control" name="empNo" value="${principal.empNo}" readonly required>
			</td>
		</tr>
		<tr>
			<td style="width: 10%">첨부</td>
			<td>	
				<c:choose>
					<c:when test="${empty board.attachList}">
						<div class="input-group mb-3">
							  <input type="file" class="form-control" name="upFile" id="inputGroupFile01">
							</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${board.attachList}" var="attach">
							<button type="button" 
									class="btn btn-outline-success btn-block"
									onclick="location.href='${pageContext.request.contextPath}/board/fileDownload.do?no=${attach.no}';">
								첨부파일 - ${attach.originalFilename}
							</button>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td colspan="2"><textarea class="form-control" name="content" rows="10">${board.content}</textarea></td>
		</tr>
		</table>
			
		<div class="text-right">
			<button type="button" class="btn btn-primary" onclick="boardUpdate();">수정</button>
			<button type="button" class="btn btn-outline-danger" onclick="goBack();">취소</button>
		</div>

	</form:form>
</div>

<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");


const boardUpdate =()=>{
	const no = ${board.no};
	const title = $("[name=title]").val(); 
	const content = $("[name=content]").val();
	
	const fil = $('[name=upFile]').get(0).files[0];
	
	console.log('${board.attachList}');
	console.log(fil)
	
	var formData = new FormData();
	formData.append("no", no)
	formData.append("title", title)
	formData.append("content", content)
	
	if (fil != null){
		formData.append("hasAttachment", true);
	} else {
		formData.append("hasAttachment", false);
	}
	
	const board = {};
	//가져옴 폼데이터를 foreach 저장
	formData.forEach((value, key)=>{
		board[key] = value;
	})
	console.log(board)
	
	 $.ajax({
		url : `${pageContext.request.contextPath}/board/boardUpdate`,
		data:formData,
		contentType: false,
		processData: false,
		cache : false,
		method:'POST',
		beforeSend: function (xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: data =>{
			console.log(data)
			location.href ="${pageContext.request.contextPath}/board/boardDetail.do?no=" + no;
			
		},
		error:console.log,

	}) 
	
}


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
