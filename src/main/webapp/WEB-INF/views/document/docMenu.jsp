<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<nav>
	새 문서 작성
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

