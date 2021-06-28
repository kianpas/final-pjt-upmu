<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/document/docMenu.jsp"></jsp:include>

<section>
	<article>
	<!-- Notice 임시출력 -->
	<table>
		<tr>
			<th>알림</th>
		</tr>
	<c:forEach items="${noticeList}" var="notice">
		<tr>
			<td>
			<a href="${pageContext.request.contextPath}${notice.linkAddr}">
			<c:choose>
				<c:when test="${notice.notiType eq 'docReply'}">
				내 결재문서에 댓글이 달렸습니다.
				</c:when>
				<c:when test="${notice.notiType eq 'docLine'}">
				확인이 필요한 결재문서가 추가되었습니다.
				</c:when>
			</c:choose>
			</a>
			</td>
		</tr>
	</c:forEach>
	</table>
	
	</article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	