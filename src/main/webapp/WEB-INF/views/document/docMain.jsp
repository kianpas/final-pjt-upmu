<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%-- <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> --%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/document/docMenu.jsp"></jsp:include>
<style>
.notice-di.dropdown-item {
	cursor: pointer;
    display: inline-block;
    width: 80%;
}
.notice-di.dropdown-item:hover {
	/* dropdown-item 호버색 무효화 */
	 background-color: transparent;
}
.dropdown-row:hover{
	background-color: #dcdcdc;
}
.notice-date{
	color: darkgray;
}

button.close{
	padding: 1rem;
}

#noticeHeader{
	display: flex;
	justify-content: space-between;
}
.dropdown-header > span{
	margin: 7px;
}
</style>
<section>
	<article>

	<div class="dropdown">
	<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		알림 &nbsp<span class="badge badge-light" id="noticeCount">${noticeCount}</span>
	</button>
		<div class="dropdown-menu" aria-labelledby="dropdownMenu2">
			<h6 class="dropdown-header" id="noticeHeader">
				<span>알림 목록</span>
				<%-- empNo checked --%>
				<button type="button" 
					class="btn btn-outline-secondary btn-sm"
					data-empno='<sec:authentication property="principal.empNo"/>'
					data-checked='Y'
					>
					읽은 알림 삭제
				</button>
				<%-- empNo --%>
				<button type="button"
					class="btn btn-outline-secondary btn-sm"
					data-empno='<sec:authentication property="principal.empNo"/>'
					>
					모두 삭제
				</button>
			</h6>
			<c:forEach items="${noticeList}" var="notice">
			<div class="dropdown-row">
				<div class="dropdown-item notice-di"
					data-no="${notice.no}" data-linkaddr="${notice.linkAddr}" data-checked="${notice.checked}">
				<div class="small notice-date"><fmt:formatDate value="${notice.regDate}" pattern="yyyy-MM-dd hh:mm"/></div>
				<div
					<c:if test="${notice.checked}">
					 style="color: darkgray"
					</c:if>
				>
				<c:choose>
					<c:when test="${notice.notiType eq 'docReply'}">
					내 결재문서에 댓글이 달렸습니다.
					</c:when>
					<c:when test="${notice.notiType eq 'docLine'}">
					확인이 필요한 결재문서가 추가되었습니다.
					</c:when>	
				</c:choose>
				</div>
				</div>
				<!-- deleteBtn -->
				<button type="button" class="close" aria-label="Close" value="${notice.no}">
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


//읽은알림삭제 & 모두삭제
$(".dropdown-header>button").on('click', function(e) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	console.log(this.dataset.empno);
	console.log(this.dataset.checked);
	
	var empNo= this.dataset.empno;
	var checked = this.dataset.checked;
 	$.ajax({
		url: `${pageContext.request.contextPath}/notice/deleteNoticeList?empNo=\${empNo}&checked=\${checked}`,
		method: "DELETE",
		beforeSend : function(xhr)
        {   
			xhr.setRequestHeader(header, token);
        },
		success(data){
			console.log(data);
			var count = 0;
			//checked!=undefined인 경우 : 읽은 알림 삭제
			if(checked){
				var temp = $(".notice-di");
				$.each(temp, function(index, item) {
					if(item.dataset.checked == 'true'){
						//목록에서 바로 삭제
						$(item).closest(".dropdown-row").remove();
						count++;
					}
				});
				$("#noticeCount").text($("#noticeCount").text()-count);
			}
			//checked==undefined인 경우 : 모두 삭제 
			else{
				$(".dropdown-row").remove();
				$("#noticeCount").text(0);
			}

		},

		error(xhr, statusText, err){
			console.log(xhr, statusText, err);
			const {status} = xhr;
			status == 404 && alert("해당 알림이 존재하지 않습니다.");
		}
	});
	
});


/* dropdown 클릭해도 show 안닫히게 */
$('.dropdown-menu').click(function(e) {
    e.stopPropagation();
});

$(".dropdown-item").on('click', function(e) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

	var no = this.dataset.no;
	var linkAddr = this.dataset.linkaddr;
	//console.log(this.dataset.no, this.dataset.linkaddr);
	console.log(no, linkAddr);
	
 	$.ajax({
		url: `${pageContext.request.contextPath}/notice/updateNotice?no=\${no}`,
		method: "PUT",
		beforeSend : function(xhr)
        {
			xhr.setRequestHeader(header, token);
        },
		success(data){
			console.log(data);
			location.href=`${pageContext.request.contextPath}\${linkAddr}`;
		},

		error(xhr, statusText, err){
			console.log(xhr, statusText, err);
			const {status} = xhr;
			status == 404 && alert("해당 알림이 존재하지 않습니다.");
		}
	});
	
});
$(".close").on('click', function(e) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

	var $thisVal = $(this);
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
			//알림카운트 -1
			$("#noticeCount").text($("#noticeCount").text()-1);
			//목록에서 바로 삭제
			$thisVal.closest('div').remove();
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
	