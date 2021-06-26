<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/docMenu2.css" />

<nav id="docNav">
<%-- 	<ul class="list-group">
		<li><a href="${pageContext.request.contextPath}/document/docForm"
		 class="list-group-item list-group-item-action">새 문서 작성</a></li>
		<li><a href="${pageContext.request.contextPath}/document/docFormAdd"
		 class="list-group-item list-group-item-action">새 문서양식 추가</a></li>
		<li><a href="${pageContext.request.contextPath}/document/docFormEdit"
		 class="list-group-item list-group-item-action">기존 문서양식 수정</a></li>
	</ul> --%>
	
	<div class="list-group" id="docEditorMenu">
		<button type="button" class="list-group-item list-group-item-action" id="docForm">새 문서 작성</button>
		<button type="button" class="list-group-item list-group-item-action" id="docFormAdd">새 문서양식 추가</button>
		<button type="button" class="list-group-item list-group-item-action" id="docFormEdit">기존 문서양식 수정</button>
	</div>

	<hr />
	<h4 align="center">결재문서 목록</h4>
	<hr />

	<div class="list-group" id="docTypeMenu">
		<button type="button" class="list-group-item list-group-item-action" id="notdecided">대기중</button>
		<button type="button" class="list-group-item list-group-item-action" id="approved">진행중</button>
		<button type="button" class="list-group-item list-group-item-action" id="completed">결재완료</button>
		<button type="button" class="list-group-item list-group-item-action" id="afterview">열람</button>
		<button type="button" class="list-group-item list-group-item-action" id="rejected">반려</button>
	</div>
	
</nav>

<script>
/* button activate */
$( document ).ready(function() {
	const addr = window.location.href;
	const url = new URL(addr);
	const params = url.searchParams;

	if(addr.includes('docList')){
		const type = params.get('type');
		console.log(type);
		$("#"+type).addClass('active');
	}
	else if(addr.includes('docForm')){
		const idx = addr.lastIndexOf("/");
		const type = addr.substr(idx+1);
		console.log(type);
		$("#"+type).addClass('active');
	}
});

$("#docTypeMenu>button").click(function(){
	//empNo=1. 원래는 <sec:authentication property="principal.empNo"/>
	location.href = `${pageContext.request.contextPath}/document/docList?empNo=1&type=\${this.id}`;
});

$("#docEditorMenu>button").click(function(){
	location.href = `${pageContext.request.contextPath}/document/\${this.id}`;
});

</script>

