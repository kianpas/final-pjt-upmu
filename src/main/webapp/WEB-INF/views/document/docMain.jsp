<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Main에 집어넣을 부분 -->
<div class="list-group" id="docTypeMenu">
	<button type="button" class="list-group-item list-group-item-action" id="notdecided">
		<span>대기중</span> 
		<span class="badge bg-secondary badge-menu">${menuCounter.notdecided}</span>
	</button>
	<button type="button" class="list-group-item list-group-item-action" id="approved">
		<span>진행중</span>
		<span class="badge bg-secondary badge-menu">${menuCounter.approved}</span>
	</button>
	<button type="button" class="list-group-item list-group-item-action" id="completed">
		<span>결재완료</span>
		<span class="badge bg-secondary badge-menu">${menuCounter.completed}</span>
	</button>
	<button type="button" class="list-group-item list-group-item-action" id="afterview">
		<span>열람</span>
		<span class="badge bg-secondary badge-menu">${menuCounter.afterview}</span>
	</button>
	<button type="button" class="list-group-item list-group-item-action" id="rejected">
		<span>반려</span>
		<span class="badge bg-secondary badge-menu">${menuCounter.rejected}</span>
	</button>
</div>
<!-- 로그인이전 -->
<sec:authorize access="isAnonymous()">
<script>
$("#docTypeMenu>button").click(function(){
	location.href = `${pageContext.request.contextPath}/document/docForm`;
});
</script>
</sec:authorize>
<!-- 로그인이후 -->
<sec:authorize access="isAuthenticated()">
<script>
$("#docTypeMenu>button").click(function(){
	var empNo = '<sec:authentication property="principal.empNo"/>';
	location.href = `${pageContext.request.contextPath}/document/docList?empNo=\${empNo}&type=\${this.id}`;
});
</script>
</sec:authorize>

