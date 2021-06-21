<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myProfile.css" />
</head>
<body>

<div id="profile-form">
	<div id="photo-form">
		<img id="photo" alt="프로필사진" src="${pageContext.request.contextPath}/resources/images/7.jpg">
		
	</div>
	<div id="profile">
		<h1>사원정보</h1>
		
			<label for="emp_name">이름  
			<input name="emp_name" type="text" value="${employee.empName}">
			</label>
			
			<label for="emp_phone">전화번호  
			<input name="emp_phone" type="text" value="${employee.empPhone}">
			</label>
			
			<label for="emp_email">EMAIL  
			<input name="emp_email" type="text" value="${employee.empEmail}">
			</label>
			
			<label for="emp_addr">주소  
			<input name="emp_addr" type="text" value="${employee.empAddr}">
			</label>
			
			<label for="emp_birth">생년월일  
			<input name="emp_birth" type="date" value="${employee.empBirth}">
			</label>
			
			<label for="emp_job">직급  
			<select id="emp_job">
				<option value="emp_job" selected>${employee.empJob}</option>
				<c:forEach items="${jList}" var="job">
					<c:if test="${job.jobName != employee.empJob}">
						<option value="emp_job">${job.jobName}</option>
					</c:if>
				</c:forEach>
			</select>
			</label>
			
			<label for="emp_dept">부서  
			<select id="emp_dept">
				<option value="emp_dept" selected>${employee.empDept}</option>
				<c:forEach items="${dList}" var="dept">
					<c:if test="${dept.depName != employee.empDept}">
						<option id="empDept" value="emp_dept">${dept.depName}</option>
					</c:if>
				</c:forEach>
			</select>
			</label>
			
			<label for="emp_hiredate">입사일  
			<input name="emp_hiredate" type="date" value="${employee.empHiredate}">
			</label>
			
	</div>
</div>
<div id="btn-form">
	<input type="button" value="변경" onclick="checkInfo();">
	<input type="button" value="삭제" onclick="deleteProfile();">
	<input type="button" value="취소">
</div>
<script>
function checkInfo(){
	var empInpo = document.getElement
	if(true) {
		console.log("${employee.empDept}");
		console.log($empInpo);
	}
}
</script>
</body>
</html>