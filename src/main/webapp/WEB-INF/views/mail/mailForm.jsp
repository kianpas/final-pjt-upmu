<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">


<%
	String s = null; 
	if(request != null){
		s = request.getParameter("reply");
		System.out.println("reply : " + s);
	}
%>
<script>
function mailValidate(){
	var $title = $("[name=mailTitle]");
	if(/^(.|\n)+$/.test($title.val()) == false){
		alert("제목을 입력하세요");
		return false;
	}
	return true;
}

$(() => {
	$("[name=upFile]").change(e => {
		var file = $(e.target).prop('files')[0];
		console.log(file);
		var $label = $(e.target).next();
		
		$label.html(file? file.name : "파일을 선택하세요.");
	});
});
</script>
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<h4 class="page-header">메일 보내기</h4>
		</div>
		<form
			name="mailFrm"
			action="${pageContext.request.contextPath}/mail/mailEnroll.do"
			method="post"
			enctype="multipart/form-data"
			onsubmit="return mailValidate();">
			<table>
			<tr>
				<td>보내는 사람</td>
				<td>1</td> <%-- ${사번번호} --%>
			</tr>
			<tr>
				<td>받는 사람</td>
				<td>
					<input type="text" class="form-control" name="receiverNo" id="receiverNo"
					value = "<% if (s != null) { %> <%=s%> <% } else { }%>"
					required></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" class="form-control" name="mailTitle" id="mailTitle" required></td>
			</tr>
			<tr>
				<td>첨부</td>
				<td>
					<!-- <div class="input-group mb-3" style="padding:0px;"> -->
				  <div class="custom-file">
				    <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple />
				    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
				  </div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2"><textarea class="form-control" name="mailContent" rows="10"></textarea></td>
			</tr>
			</table>
			<div class="text-right">
				<input type="submit" class="btn btn-outline-primary" value="전송"/>
				<button type="button" class="btn btn-outline-danger" onclick="">취소</button>
			</div>
		</form>
	</div>
	
	<div>
	
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>