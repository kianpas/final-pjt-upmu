<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/document/docMenu.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">
<style>
.note-editable {
	background-color: white; 
}
table {
  width: 100%;
  border: 1px solid #444444;
  border-collapse: collapse;
}
th, td {
  border: 1px solid #444444;
  text-align: center;
}
.vertical{
	writing-mode: vertical-lr;
}
.vertical-th{
	width: 40px;
}

</style>


<section>
<c:if test="${not empty msg}">
<div class="alert alert-warning alert-dismissible fade show" role="alert">
  <strong>${msg}</strong>
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
</c:if>
	<article>
		<div id="container">
		<form 
			name="documentFrm" 
			action="${pageContext.request.contextPath}/document/docFormAdd" 
			method="post" 
			enctype="multipart/form-data">
									
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup-sizing-default">양식 이름</span>
				</div>
				<input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
				name="title" id="title" required>
			</div>			
						
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup-sizing-default">양식 타입</span>
				</div>
				<input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
				name="type" id="type">
			</div>
			<!-- 테이블 임시 작성 -->
			<div id="tempDiv">



			
			</div>

			<textarea class="form-control" id="summernote" name="content" required></textarea>
			<br />
			
			<input type="submit" class="btn btn-outline-success" value="제출" >
		</form>
	</div>
	</article>
</section>

<script>

$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 500,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  //placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
          
	});
});


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	