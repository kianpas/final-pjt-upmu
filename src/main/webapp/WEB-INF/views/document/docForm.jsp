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
</style>

<!--
		docNo : 문서번호. 양식 찾아보기.
		title : 문서제목
		writer : 기안자. 로그인 사용자의 emp_no
		content : 문서내용 by webEditor
		requestDate : sysdate
		docLine
			docNo : 위의 docNo 그대로
			approver : 조직도에서 이름선택하면 그거 value = emp_no 
			approverType : 폼의 어디에 입력했냐에 따라 value를 4개로 나눠 부여
			lv :
				특정 approverType칸에 지금까지 몇개 추가했냐에 따라 값이 증가함.
				ex) approver에 처음 입력하면 1, 2, 3, ...
					agreer에 또 입력하면 다시 1, 2, 3, ...
			status : approver, agreer -> notdecided
					enforcer, referer -> afterview
			maxAuthority 전결권자+최고레벨 결재자 둘다.
							일단은 최고레벨 결재자만 Y로 부여. 언제? 창을 닫을때.
 -->
<section>
	<article>
		<div id="container">
		<form 
			name="documentFrm" 
			action="${pageContext.request.contextPath}/document/docInsert" 
			method="post" 
			enctype="multipart/form-data">
			
			<!-- <label class="" for="docNo">문서번호</label>
			<input type="text" class="form-control" placeholder="문서번호" name="docNo" id="docNo" required>
			<br /> -->
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup-sizing-default">문서제목</span>
				</div>
				<input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
				placeholder="제목을 입력하세요" name="title" id="title" required>
			</div>

			<div class="input-group mb-3">
				<select class="custom-select" id="docFrmSelect">
					<option selected>문서양식을 선택하세요</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
					<option value="45">휴가신청서2</option>
				</select>
			</div>
			
			<div class="input-group mb-3">
				<!-- 임시기안자 1(홍길동) -->
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup-sizing-default">기안자</span>
				</div>
				<input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
				name="writer" value="1" readonly required>			
			</div>


			<!-- 결재선 -->
			<button type="button" class="btn btn-info" name="docLineBtn" id="docLineBtn" >결재선 설정</button>
			<br />
			
			<div id="docLineDiv">
				<table class="table">
					<tr>
						<th scope="col">결재종류</th>
						<th scope="col">직위</th>
						<th scope="col">이름</th>
					</tr>
				</table>
			</div>
			
			
			<!-- <textarea class="form-control" name="content" placeholder="내용" required></textarea>
			<br /> -->
			<textarea class="form-control" id="summernote" name="content" required></textarea>
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
		</form>
	</div>
	</article>
</section>

<script>
$("#docFrmSelect").change(function(e) {
	console.log(this.value);
	//$('#summernote').summernote('insertText', '<p>테스트</p>');
	//$('.note-editable').html('<p>테스트</p>');
	
	$.ajax({
		url: `${pageContext.request.contextPath}/document/docFormSelect?docNo=\${this.value}`,
		success(data){
			console.log(data);

			if(data){
				$('.note-editable').html(data.content);
			}
		},
		/*
			ResponseEntity로 검색결과 없을때 404 return하게 바꿨기 때문에
			위의 else문에 들어가지 않고 아래의 error코드로 들어가게 된다. 
		 */ 
		error(xhr, statusText, err){
			console.log(xhr, statusText, err);

			const {status} = xhr;
			status == 404 && alert("해당 양식이 존재하지 않습니다.");
			$("[name=id]", e.target).select();
		}
	});
	
});


$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  //placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
          
	});
	//$('#summernote').summernote('insertText', 'textsomething');
	//$('#summernote').summernote('enable');
});-

/* $(document).ready(function() {
	$("[name=fileFormDelBtn]").click(function() {
		console.log('clicked');
	}); 이건 동작안함
}); */

$(document).on('click', '[name=fileFormDelBtn]', function(e) {
	$parent = $(e.target).closest("div");
	console.log($parent);
	$parent.remove();
});


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

$("#docLineBtn").click(function(){
	// 새창에 대한 세팅(옵션)
    var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=800,left=0,top=0';
    // 자식창을 열고 자식창의 window 객체를 windowObj 변수에 저장
    windowObj = window.open("${pageContext.request.contextPath}/employeeList/eListForDoc","자식창",settings);
    
    windowObj.onbeforeunload = function(){
        //자식창 닫힐때 이벤트감지
        
    };

   

});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	