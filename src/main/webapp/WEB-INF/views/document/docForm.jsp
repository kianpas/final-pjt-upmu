<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/document/docMenu.jsp"></jsp:include>
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
			<label class="" for="title">문서제목</label>
			<input type="text" class="form-control" placeholder="문서제목" name="title" id="title" required>
			<br />
			<!-- 임시기안자 1(홍길동) -->
			<label class="" for="writer">기안자</label>
			<input type="text" class="form-control" name="writer" value="1" readonly required>
			<br />
			
			<!-- 결재선 -->
			<button type="button" name="docLineBtn" id="docLineBtn" >결재선 설정</button>
			<br />
			
			<div id="docLineDiv"></div>
			
			
			<textarea class="form-control" name="content" placeholder="내용" required></textarea>
			<br />

			<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
			<div class="input-group mb-3" style="padding:0px;">
			  <div class="input-group-prepend" style="padding:0px;">
			    <span class="input-group-text">첨부파일1</span>
			  </div>
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple>
			    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
			  </div>
			</div>

			
			<input type="submit" class="btn btn-outline-success" value="제출" >
		</form>
	</div>
	</article>
</section>

<script>
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
	