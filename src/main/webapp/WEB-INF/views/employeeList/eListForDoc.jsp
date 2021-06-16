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
#context-menu{
	border: 1px solid #c8c8c8;
	background-color: white;
	margin: 0px;
	z-index: 9999;
}
#context-menu ul li{
	padding-left: 14px;
	padding-right: 8px;
	cursor: default;
	font-size: 14px;
}
#context-menu ul li:hover{
	background-color: #dcdcdc;
}

.approver-list select{
	width: 120px;
}

.listBox{
	float: left;
}
button[name="approver-btn"]{
	display: block;
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
	<div id="context-menu" class="" style="display: none;">
	      <ul style="margin: 0px; padding: 0px; list-style: none;">
	        <li onclick="deleteDept()">부서삭제</li>
	        <li onclick="modifyDept()">부서수정</li>
	      </ul>
   	</div>
	<div class="depart-list list">
		<details>
	        <summary class="dList-all">
	        	부서 목록
	        </summary>
		    <c:forEach items="${dList}" var="dept">
				<p class="${dept.depNo} dept">${dept.depName}</p>
			</c:forEach>
    	</details>
	</div>
	
	<div class="right-box">
		<div class="employee-list list"></div>
		
		<!-- 결재자 선택결과 -->
		<div class="approver-list list">
			<!-- listBox는 일부만 다르므로 함수형태로. -->
			<c:set var="approverTypeArray">approver,agreer,enforcer,referer</c:set>
			<c:forEach var="approverType" items="${approverTypeArray}">
				<div class="listBox">
				<button name="approver-btn" value="${approverType}">
					<c:choose>
						<c:when test="${approverType eq 'approver'}">결재자</c:when>
						<c:when test="${approverType eq 'agreer'}">합의자</c:when>
						<c:when test="${approverType eq 'enforcer'}">시행자</c:when>
						<c:when test="${approverType eq 'referer'}">수신참조자</c:when>
					</c:choose>
				▼</button>
				<select id="${approverType}" size="6" ></select>
				<div>
					<span style="cursor: pointer;">▲</span>&nbsp&nbsp
					<span style="cursor: pointer;">▼</span>&nbsp&nbsp
					<span style="cursor: pointer;">X</span>
				</div>
			</div>
			</c:forEach>
		</div>
		
		<button type="button" onclick="saveBtn();">저장</button>
		<button type="button" onclick="window.close();">닫기</button>
	</div>
	
</div>

<script>
function saveBtn(){
	let html = `</br>`;


	
	$(opener.document).find("#docLineDiv").html(html);
	//window.close();
}

	//결재자 클릭하면 select name="approver" 에 id 추가
	$("[name=approver-btn]").click((e)=>{
		var approverType = e.target.value;
		
		var $emp = $("[name=radioBtn]:checked");
		if($emp.length==0){
			alert("선택된 인원이 없습니다");
			return;
		}
		
		empNo = $emp.data("empno");
		empName = $emp.data("empname");

		//empNo가 approver>option에 이미 존재하면 alert띄우고 추가시키면 안됨.
		var $approverList = $(".listBox>select>option");
		var flag = true;
		$approverList.each(function(index, item){
			if(empNo == item.dataset.empno){
				alert("이미 추가된 인원입니다");
				flag = false;
				return;
			}
		});
		if(flag==false)
			return;
		
		var option = `<option name="\${approverType}" data-empno="\${empNo}" data-empName="\${empName}" data-approvertype="\${approverType}">\${empName}</option>`;
		var $select = $("#"+approverType);
		$select.append(option);
				
	});
	
	//목록에서 employee불러오기
	var getClass;
	
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

	//DB에서 불러온 데이터 테이블에 추가하는 함수
	function displayTable(data) {
		let html = "<table><tr><th> </th><th>사번</th><th>이름</th><th>직급</th><th>부서</th><th>연락처</th><th>이메일</th></tr>";
		if(data.length > 0){
			$(data).each((i, eList) => {
				const {empNo, empName, empJob, empDept, empPhone, empEmail} = eList;
				html += `
					<tr>
					<td><input type="radio" name="radioBtn" data-empno="\${empNo}" data-empName="\${empName}"></td>
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

	//부서삭제
	
	//마우스 오른쪽 버튼 끄기
	$(".dept").on('contextmenu', () => {
  		return false;
	});
	
	var delDeptClass;
	$(".dept").on('mousedown', (e) => {
		if(e.button == 2 || e.which==3){
			const ctxMenu = document.getElementById('context-menu');
	        delDeptClass = $(e.target).attr('class').split(' ')[0];
	        // 노출 설정
	        ctxMenu.style.display = 'inline';
	        ctxMenu.style.position = 'absolute';
	        // 위치 설정
	        ctxMenu.style.top = e.pageY + 'px' ;
	        ctxMenu.style.left = e.pageX + 'px';
		}
	});

	//context-menu 끄기
	$(document).click(e =>{
		$("#context-menu").hide();
	})
	
	//부서삭제
	function deleteDept() {
		var yn = confirm("정말 삭제하시겠습니까?");
		if(yn==true) {
			location.href="${pageContext.request.contextPath}/employeeList/deleteDept.do?depNo=" + delDeptClass
		}
	}
</script>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>