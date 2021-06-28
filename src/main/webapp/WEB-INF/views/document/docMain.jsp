<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> --%>

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
				
				<!-- 공통되는 삭제버튼 -->
				<button type="button" class="close" aria-label="Close" value="${notice.no }">
					<span aria-hidden="true">&times;</span>
				</button>
			</td>
		</tr>
	</c:forEach>
	</table>
	
	</article>
</section>
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<script>
$(".close").on('click', function(e) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$thisRow = $(this);
 	$.ajax({
		url: `${pageContext.request.contextPath}/notice/deleteNotice?no=\${this.value}`,
		method: "DELETE",
		beforeSend : function(xhr)
        {   
	        /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
			xhr.setRequestHeader(header, token);
        },
		success(data){
			console.log(data);
			//목록에서 바로 삭제
			$thisRow.closest('tr').remove();
		},

		error(xhr, statusText, err){
			console.log(xhr, statusText, err);
			const {status} = xhr;
			status == 404 && alert("해당 알림이 존재하지 않습니다.");
		}
	});
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	