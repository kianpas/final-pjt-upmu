<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title"/>
</jsp:include>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<style>
body {
	background-color: #f8f3eb;
}
/*글쓰기버튼*/
input#btn-add {
	float:right; 
	margin: 0 0 15px;
}

tr[data-no]{
	cursor: pointer;
}
</style>
<script>
function goBoardForm(){
	location.href = "${pageContext.request.contextPath}/board/boardForm.do";
}

$(() => {
	$("tr[data-no]").click(e => {
		//화살표함수안에서는 this는 e.target이 아니다.
		//console.log(e.target); // td태그클릭 -> 부모tr로 이벤트전파(bubbling)
		var $tr = $(e.target).parent();
		var no = $tr.data("no");
		location.href = "${pageContext.request.contextPath}/board/boardDetail.do?no=" + no;
	});

	$("#searchTitle").autocomplete({
		 source: function(request, response){
			//사용자 입력값 전달 ajax 요청 -> success함수안에서 response호출
			
	  		$.ajax({
		    	url:"${pageContext.request.contextPath}/board/boardSearch.do",
		    	data : {
		    			search : request.term
		    			},
		    		//메소드는 success(data)로 사용가능
		    	success : function(data) {
		    				console.log(data);
							
		    				const arr = data.map(({no, title})=>({
								label:title,
								value:title,
								no :no
						}));
						
							console.log(arr);
	    		
	    					response(arr); 
	   					 
		    			},
		    	error : function(xhr, status, err) {
		    				console.log(xhr, status, err);
		    	}

		    })
		  },
		    select:function(event, selected){
		    			console.log(selected)
		    			console.log(selected.item.no);
		    			const {item:{no}} = selected;
						console.log(no)
		    			location.href="${pageContext.request.contextPath}/board/boardDetail.do?no="+no;
		    			
		   },
		    focus:function(event, focused){
		    	return false;

			    	}
				
		    })

	
});




</script>
<section id="board-container" class="container">
	<div class="row justify-content-center">
		<div class="card shadow mb-4 col-12  px-0">
			<div class="card-header py-3">
				<h6 class="m-0 fw-bold text-primary">게시판</h6>
			</div>
			<div class="card-body">
			<input type="search" placeholder="검색" id="searchTitle" class="form-control col-3 d-inline"/>
				<div class="table-responsive">

					<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" onclick="goBoardForm();"/>
	
	<table class="table table-hover">
		<thead>
			<tr class="text-center">
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th> <!-- 첨부파일 있을 경우, /resources/images/file.png 표시 width: 16px-->
			<th>조회수</th>
		</tr>
		<c:forEach items="${list}" var="board">
			<tr data-no="${board.no}" class="text-center">
				<td>${board.no}</td>
				<td  class="text-start">${board.title} (${board.cmtCount})</td>
				<td>${board.empName}</td>
				<td><fmt:formatDate value="${board.regDate}" pattern="yy-MM-dd"/></td>
				<td>
					<c:if test="${board.hasAttachment}">
					<box-icon name='file-blank' ></box-icon>
						<%-- <img class="mx-auto" src="${pageContext.request.contextPath}/resources/images/file.png" width="16px" alt="" /> --%>
					</c:if>
				</td>
				<td>${board.readCount}</td>
			</tr>
		</c:forEach>
	</table>
		${pageBar}
				</div>
			</div>	
		</div>
	</div>
</section> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
