<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>	
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글 작성" name="title"/>
</jsp:include>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
	crossorigin="anonymous"></script>
	

<script>
/* textarea에도 required속성을 적용가능하지만, 공백이 입력된 경우 대비 유효성검사를 실시함. */
function boardValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}

$(() => {
	$("[name=upFile]").change(e => {
		//파일명 가져오기
		var file = $(e.target).prop('files')[0];
		console.log(file);
		var $label  = $(e.target).next();
		
		//label 적용
		$label.html(file ? file.name : "파일을 선택하세요.");
		
	});
});


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
				<input type="text" class="form-control" placeholder="제목" name="title" id="title" required>
				<input type="hidden" class="form-control" name="empNo" value="${principal.empNo}" readonly required>
			</td>
		</tr>
		<tr>
			<td style="width: 10%">첨부</td>
			<td>
				  <div class="input-group mb-3">
					  <input type="file" class="form-control" name="upFile" id="inputGroupFile01">
					</div>
					<div class="input-group mb-3">
					  <input type="file" class="form-control" name="upFile" id="inputGroupFile02">
					</div>
			</td>
		</tr>
		<tr>
			<td colspan="2"><textarea class="form-control" name="content" rows="10"></textarea></td>
		</tr>
		</table>
			
		<div class="text-right">
			<input type="submit" class="btn btn-outline-success" value="저장" >
			<button type="button" class="btn btn-outline-danger" onclick="goBack();">취소</button>
		</div>

	</form:form>
</div>




<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
