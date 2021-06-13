<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서수정</title>
<style>
#dep_name{
	display: block;
	width: 120px;
}
#dep_no{
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
	<form action="${pageContext.request.contextPath}/employeeList/modifyDept.do" method="post">
		<label for="dep_name">부서명</label>
		<input id="dep_name" name="depName" type="text" autocomplete="off" spellcheck="false">
		<label for="dep_no">부서코드</label>
		<input id="dep_no" name="depNo" type="text" autocomplete="off" spellcheck="false">
		<input id="modify-dept" type="hidden">
		<input id="modify-button" type="submit" value="제출">
		<input id="modify-button" type="button" value="취소">
	</form>
<script>
	var modifyDept = location.search.split('=')[1];
	console.log(modifyDept);
	document.querySelector('#modify-dept').setAttribute('name', modifyDept);
</script>
</body>
</html>