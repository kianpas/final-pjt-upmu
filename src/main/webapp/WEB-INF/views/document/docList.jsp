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
		<table class="table">
			<tr>
				<th scope="col">문서번호</th>
				<th scope="col">제목</th>
				<th scope="col">기안자</th>
				<th scope="col">기안일</th>
			</tr>
			
			<c:forEach items="${docList}" var="document">
			<tr onclick="location.href=`${pageContext.request.contextPath}/document/docDetail?docNo=${document.docNo }`">
				<td>${document.docNo }</td>
				<td>${document.title }</td>
				<td>${document.writerName }</td>
				<td>${document.requestDate }</td>
			</tr>
			</c:forEach>
		</table>
	</article>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	