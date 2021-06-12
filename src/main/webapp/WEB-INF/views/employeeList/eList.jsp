<%@page import="com.fpjt.upmu.employeeList.model.vo.Employee"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title"/>
</jsp:include>
<style>
body{
	position: fixed;

}
h2 {
	margin-top: 0px;
}
.list-form {
	display: flex;
}
.list {
	outline : solid 1px black;
}
.list p {
	margin: 0px;
	cursor: pointer;
}
.depart-list {
	position: relative;
	overflow-x:auto; 
	width:200px; 
	height:500px;
}
.depart-code {
	width: 60px;
}
#depart-enroll {
	position: absolute;
	outline : solid 1px black;
	width:200px; 
	height:200px;
	left: 0px;
	bottom: 0px;
}
.employee-list {
	display: hidden;
	overflow-x:auto; 
	width:700px; 
	height:500px;
}

summary {
	list-style: none;
    cursor: pointer;
}
label {
	display: block;
}
table {
          border: 1px solid black;
          border-collapse: collapse; /*경계선 설정*/
}
th, td {
    border: 1px solid black;
    padding: 5px; /*여백*/
}

.search-form{
	display: flex;
	margin-left:200px;
	position: relative;
}
.search-form label {
	margin-right: 5px; 
}
</style>
<body>

<div class="search-form">
		<label for="keyword"></label>
		<select id="keyword">
			<option value="emp_no" selected>사번</option>
			<option value="emp_name">이름</option>
			<option value="emp_job">직급</option>
			<option value="emp_dept">부서</option>
		</select>
	    <input id="search" name="p" type="search" autocomplete="off" spellcheck="false" placeholder="검색" onkeypress="if( event.keyCode == 13) {search()};">
	    <input id="search-submit" type="submit" value="검색" onclick="search();">
</div>
<div class="list-form">
	<div class="depart-list list">
		<details>
	        <summary class="dList-all">
	        	전체 목록
	        </summary>
		    <c:forEach items="${dList}" var="dept">
				<p class="${dept.depNo} dept" onclick="empShow();">${dept.depName}</p>
			</c:forEach>
    	</details>
    	<div id="depart-enroll">
    		<h2>부서 등록</h2>
    		<form action="${pageContext.request.contextPath}/employeeList/departEnroll.do" method="post">
	    		<label class="depart-name" for="depart-name">부서명</label>
	  			<input id="depart-name" name="depName" class="depart-name" type="text" placeholder="부서명">
	  			<label class="depart-code-label" for="depart-code">부서코드</label>
	  			<input id="depart-code" name="depNo" class="depart-code" type="text" placeholder="부서코드">
	  			<input id="depart-submit" type="submit" value="등록">
    		</form>
    	</div>
	</div>
	
	<div class="employee-list list"></div>
</div>

<script>
	var getClass;
	//목록에서 employee불러오기
	$(".dept").click((e) => {
		getClass = {"depNo" : ($(e.target).attr('class').split(' '))[0]};

		console.log(getClass);
		$.ajax({
			url: "${pageContext.request.contextPath}/employeeList/selectOneDeptEmp.do",
			method: "GET",
			data: getClass,
			success(data){
				console.log(data);
				displayTable(data.eList);
			},
			error: console.log
		})
	});
	
	//검색에서 employee불러오기
	
	function search(){
		var getKeyword;

		getKeyword = {"getKeyword" : $("#keyword").val(), "getSearch" : '%' + $("#search").val() + '%'};
		console.log(getKeyword);
		$.ajax({
			url: "${pageContext.request.contextPath}/employeeList/selectSearch.do",
			method: "GET",
			data: getKeyword,
			success(data){
				console.log(data);
				displayTable(data.eList);
			},
			error: console.log
		})
	}
	
/* 	$("#search-submit").click((e)=> {
		getKeyword = {"getKeyword" : $("#keyword").val(), "getSearch" : '%' + $("#search").val() + '%'};
		console.log(getKeyword);
		$.ajax({
			url: "${pageContext.request.contextPath}/employeeList/selectSearch.do",
			method: "GET",
			data: getKeyword,
			success(data){
				console.log(data);
				displayTable(data.eList);
			},
			error: console.log
		})
	}); */
	
	function displayTable(data) {
		let html = "<table><tr><th>사번</th><th>이름</th><th>직급</th><th>부서</th><th>연락처</th><th>이메일</th></tr>";
		if(data.length > 0){
			$(data).each((i, eList) => {
				const {empNo, empName, empJob, empDept, empPhone, empEmail} = eList;
				html += `
					<tr>
					<td>\${empNo}</td>
					<td>\${empName}</td>
					<td>\${empJob}</td>
					<td>\${empDept}</td>
					<td>\${empPhone}</td>
					<td>\${empEmail}</td>
					</tr>`;
			});
		}
		else {
			html += "<td colspan='6'>결과가 없습니다.</td></tr>"
		}
		html += "</table>";
		$(".employee-list").html(html);
	}


</script>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>