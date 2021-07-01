<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- security사용을 위한 태그 --%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<style>
.list-group-item {
	margin-bottom: 0px;
}
</style>

<main class="responsive-wrapper">

<div class="row justify-content-center">
	<div class="col-xl-3">
		<!-- nav -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">메뉴</h6>
			</div>
			
			<!--  Body -->
			<div class="card-body">
			
				<nav id="docNav">
					<a href="${pageContext.request.contextPath}/document/docMain">임시 메인버튼</a>
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
			</div>

		</div>
	</div>
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
	var empNo = '<sec:authentication property="principal.empNo"/>';
	location.href = `${pageContext.request.contextPath}/document/docList?empNo=\${empNo}&type=\${this.id}`;
});

$("#docEditorMenu>button").click(function(){
	location.href = `${pageContext.request.contextPath}/document/\${this.id}`;
});

</script>

