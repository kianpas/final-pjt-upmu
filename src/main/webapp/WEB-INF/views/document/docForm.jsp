<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<c:import url="/document/docMenu"></c:import>

<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">
<style>
.note-editable {
	background-color: white; 
}
</style>

<div class="col-xl-9">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">새 문서 작성</h6>
		</div>
		<!--  Body -->
		<div class="card-body ">

<section>
	<article>
		<div id="container">
		<form:form 
			name="documentFrm" 
			action="${pageContext.request.contextPath}/document/docInsert?${_csrf.parameterName}=${_csrf.token}" 
			method="post" 
			enctype="multipart/form-data"
			onsubmit="return documentValidate();">

			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<label class="input-group-text" for="inputGroupSelect01">문서양식</label>
				</div>
				<select class="custom-select" id="docFrmSelect">
					<option selected>문서양식을 선택하세요</option>
					<c:forEach items="${docFormList }" var="docForm">
					<option value="${docForm.no}">${docForm.title}</option>
					</c:forEach>
				</select>
			</div>
			
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup-sizing-default">문서제목</span>
				</div>
				<input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
				placeholder="제목을 입력하세요" name="title" id="title" >
			</div>
			
			<div class="input-group mb-3">
				<!-- 임시기안자 1(홍길동) -->
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup-sizing-default">기안자</span>
				</div>
				<%--기안자 writer는 empNo로 표시, 화면에 표시할때는 이름으로 표시 --%>
				<input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
				name="writerName" value='<sec:authentication property="principal.empName"/>' readonly required>
				<input type="hidden" name="writer" value='<sec:authentication property="principal.empNo"/>'/>
			</div>
			
			<!-- <button type="button" onclick="testBtn();">testBtn</button> -->
			<!-- 결재선 -->
			<button type="button" class="btn btn-info" name="docLineBtn" id="docLineBtn" >결재선 설정</button>
			<br />
			
			<div id="docLineDiv">
				<table class="table table-sm" id="docLineTable">
					<tr>
						<th scope="col">결재종류</th>
						<th scope="col">직위</th>
						<th scope="col">이름</th>
					</tr>
				</table>
			</div>
			
			
			<!-- summernote. 작성 안하면 제출불가. -->
			<textarea class="form-control" id="summernote" name="content"></textarea>
			<br />

			<button type="button" class="btn btn-success" style="margin-bottom: 5px;" onclick="fileFormAdd();">파일 폼 추가</button>
			
			<div class="input-group mb-3" style="padding:0px;">
			  <div class="input-group-prepend" style="padding:0px;">
			    <span class="input-group-text">첨부파일</span>
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple>
			    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
			  </div>
			  <button type="button" class="btn btn-danger" name="fileFormDelBtn">파일삭제</button>
			</div>

			<div id="fileFormAddArea"></div>
			
			<input type="submit" class="btn btn-outline-success" value="제출" >
		</form:form>
	</div>
	</article>
</section>

		</div>
	</div>
</div>
</div>
		
</main>

<script>
function bootAlert(str,dest){
	var html = `
		<div class="alert alert-danger alert-dismissible fade show" role="alert">
			<strong>\${str}</strong>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
			 <span aria-hidden="true">&times;</span>
			</button>
		</div>
		`;
	dest.before(html)
	//alert로 화면 이동
	var offset = $('.alert').offset();
	$('html').scrollTop(offset.top);
	//알람창 자동제거
    $(".alert").fadeTo(2000, 500).slideUp(500, function() {
        $(this).slideUp(500);
        $(this).remove();
    });
}

/* Validation */
function documentValidate(){
	
	if ($('#title').val()=='') {
		bootAlert('문서제목을 입력해주세요',$('#title').closest('div'));
		return false;
	}	
	
	if ($('#summernote').summernote('isEmpty')) {
		bootAlert('문서내용을 입력해주세요',$('#summernote'));
		return false;
	}
	
	$div = $("#docLineDiv>table>tbody>tr");
	if($div.length==1){
		bootAlert('결재선을 선택해주세요',$('#docLineDiv'));
		return false;
	}	

	return true;
}


/* bring docForm */ 
$("#docFrmSelect").change(function(e) {

	$.ajax({
		url: `${pageContext.request.contextPath}/document/docFormSelect?no=\${this.value}`,
		success(data){
			console.log(data);

			if(data){
				$('.note-editable').html(data.content);
				$('#summernote').summernote('insertText', '');
			}
		},
		error(xhr, statusText, err){
			console.log(xhr, statusText, err);

			const {status} = xhr;
			status == 404 && alert("해당 양식이 존재하지 않습니다.");
			$("[name=id]", e.target).select();
		}
	});
	
});

/* summernote option */
$(document).ready(function() {
	$('#summernote').summernote({
		  height: 500,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  //placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
          
	});
});
/* fileAttach delBtn */
$(document).on('click', '[name=fileFormDelBtn]', function(e) {
	$parent = $(e.target).closest("div");
	console.log($parent);
	$parent.remove();
});

/* fileAttach addBtn */
function fileFormAdd(){
	let html = `
		<div class="input-group mb-3" style="padding:0px;">
			<div class="input-group-prepend" style="padding:0px;">
				<span class="input-group-text">첨부파일</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple>
				<label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
			</div>
			<button type="button" class="btn btn-danger" name="fileFormDelBtn">파일삭제</button>
		</div>`;
	$("#fileFormAddArea").before(html);
}

$(document).on('change', '[name=upFile]', function(e) {
	//파일명 가져오기
	var file = $(e.target).prop('files')[0];
	console.log(file);
	var $label = $(e.target).next();
	//label 적용
	$label.html(file ? file.name : "파일을 선택하세요.");
});

/* docLine Popup */
$("#docLineBtn").click(function(){
	// 새창에 대한 세팅(옵션)
    var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=520,width=970,left=0,top=0';
    // 자식창을 열고 자식창의 window 객체를 windowObj 변수에 저장
    windowObj = window.open("${pageContext.request.contextPath}/employeeList/eListForDoc","자식창",settings);
    
    windowObj.onbeforeunload = function(){
        //자식창 닫힐때 이벤트감지
    };
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	