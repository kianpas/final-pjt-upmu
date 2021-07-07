<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서수정</title>
<style>
#depart-name{
	display: block;
	width: 120px;
}
#depart-code{
	display: block;
	width: 40px;
}
#modify-button{
	margin-top: 12px;
	text-align: center;
}
</style>
</head>
<body>
	<form action="${pageContext.request.contextPath}/employeeList/modifyDept.do?${_csrf.parameterName}=${_csrf.token}" method="post">
   		<label for="depart-name">부서명</label>
		<input id="depart-name" name="depName" class="depart-name" type="text" placeholder="부서명" autocomplete="off" spellcheck="false">
		<!-- <label for="depart-code">부서코드</label>
		<input id="depart-code" name="depNo" class="depart-code" type="text" placeholder="부서코드" autocomplete="off" spellcheck="false"> -->
		<input id="modify-dept" type="hidden" name="modifyDept">
		<input id="modify-button" type="submit" value="제출">
		<input id="modify-button" type="button" value="취소" onclick="window.close();">
	</form>
<script>
	var modifyDept = location.search.split('=')[1];
	console.log(modifyDept);
	document.querySelector('#modify-dept').setAttribute('value', modifyDept);
</script>
</body>
</html>