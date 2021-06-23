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
	<ul>
		<li><a href="${pageContext.request.contextPath}/document/docForm">새 문서 작성</a></li>
		<li><a href="${pageContext.request.contextPath}/document/docFormAdd">새 문서양식 추가</a></li>
		<li><a href="${pageContext.request.contextPath}/document/docFormEdit">기존 문서양식 수정</a></li>
	</ul>

	<hr />
	결재 문서 목록
	<hr />
	<ul id="ver2">
		<li><span id="notdecided">대기중(결재를 기다리는 문서)</span></li>
		<li><span id="approved">진행중(나는 결재했지만 종결되지 않은 문서)</span></li>
		<li><span id="completed">결재완료(결재가 최종승인된 문서)</span></li>
		<li><span id="afterview">열람</span></li>
		<li><span id="rejected">반려</span></li>
	</ul>
</nav>

<script>
$("#ver2>li>span").click(function(){
	location.href = `${pageContext.request.contextPath}/document/docList?type=\${this.id}`;
});
</script>

