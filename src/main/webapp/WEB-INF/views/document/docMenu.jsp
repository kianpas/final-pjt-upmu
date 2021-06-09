<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<nav>
	새 문서 작성
	<br />
	결재 문서 목록
	<br />
	<ul>
		<li><span id="approver">결재</span></li>
		<li><span id="agreer">합의</span></li>
		<li><span id="enfocer">시행</span></li>
		<li><span id="referer">수신참조</span></li>
	</ul>
</nav>

<script>
	$("ul>li>span").click(function(){
		location.href = `${pageContext.request.contextPath}/document/\${this.id}`;
	});
</script>

