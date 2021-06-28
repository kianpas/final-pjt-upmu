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

	<div class="dropdown">
	<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		알림
	</button>
		<div class="dropdown-menu" aria-labelledby="dropdownMenu2">
			<h6 class="dropdown-header">알림 목록</h6>
			<c:forEach items="${noticeList}" var="notice">
			<div>
				<span class="dropdown-item" 
				onclick="location.href='${pageContext.request.contextPath}${notice.linkAddr}'"
				style="display: inline;">
				<c:choose>
					<c:when test="${notice.notiType eq 'docReply'}">
					내 결재문서에 댓글이 달렸습니다.
					</c:when>
					<c:when test="${notice.notiType eq 'docLine'}">
					확인이 필요한 결재문서가 추가되었습니다.
					</c:when>	
				</c:choose>
				</span>
	
				<!-- deleteBtn -->
				<button type="button" class="close" aria-label="Close" value="${notice.no }">
					<span aria-hidden="true">&times;</span>
				</button>
				<div class="dropdown-divider"></div>
			</div>
			</c:forEach>
		</div>
	</div>
	
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
			$thisRow.closest('div').remove();
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
	