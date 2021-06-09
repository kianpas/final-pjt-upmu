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
		<table>
			<tr>
				<td>여기뭘넣지</td><td></td><td>기안자(임시:사번)</td><td>${document.writer }</td>
			</tr>
			<tr>
				<td>문서번호</td><td>${document.docNo }</td><td>기안일</td><td>${document.requestDate }</td>
			</tr>
			<tr>
				<td>결재</td>
			</tr>
			<tr>
				<td>협의</td>
			</tr>
			<tr>
				<td>시행</td>
			</tr>
			<tr>
				<td>수신참조</td>
			</tr>
		</table>
		
		<p>
			<label for="title">문서제목</label>
			<input type="text" id="title" value="${document.title}">
		</p>
		<p>
			<label for="content">세부내용</label>
			<textarea rows="" cols="" id="content">${document.content}</textarea>
		</p>
		<p>
			첨부파일
		</p>


	</article>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	