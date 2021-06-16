<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직원 리스트</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/eListPop.css" />
</head>
<body>
	<div class="list-form">
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
		<div class="employee-list list">
		</div>
		<div class="input-box">
			<input type="button" value="+" onclick="addData();">
			<input type="button" value="-" onclick="minusData();">
		</div>
		<div class="choice-list list">
			<table>
				<thead>
					<tr>
						<th>사번</th>
						<th>이름</th>
					</tr>
				</thead>
				<tbody id="choice-emp">
				</tbody>
			</table>
		</div>
	</div>
<script>
//목록에서 employee불러오기
var getClass;
var eList;

$(".dept").click((e) => {
	getClass = {"depNo" : ($(e.target).attr('class').split(' '))[0]};

	console.log(getClass);
	$.ajax({
		url: "${pageContext.request.contextPath}/employeeList/selectOneDeptEmp.do",
		method: "GET",
		data: getClass,
		success(data){
			eList = data.eList;
			onTable(eList);
		},
		error: console.log
	})
});

function onTable(list) {
	displayTable(list);
}

//DB에서 불러온 데이터 테이블에 추가하는 함수
function displayTable(data) {
	let html = "<table><thead><tr><th>사번</th><th>이름</th></tr></thead><tbody>";
	if(data.length > 0){
		$(data).each((i, eList) => {
			const {empNo, empName} = eList;
			html += `
				<tr id='\${empNo}' onclick='getDataTable(this.id);'>
				<td>\${empNo}</td>
				<td>\${empName}</td>
				</tr>`;
		});
		html += `</tbody>`
	}
	else {
		html += "<td colspan='6'>결과가 없습니다.</td></tr>"
	}
	html += "</table>";
	$(".employee-list").html(html);
}

var saveData = new Array();

function getDataTable(id){
	if($("#"+id).css("background-color")==="rgb(220, 220, 220)"){
		$("#"+id).css("background-color","rgb(192, 192, 192)");
		$("#"+id).attr('class', 'checked');		
	}
	else {
		$("#"+id).css("background-color","");
		$("#"+id).attr('class', '');			
	}
}

let html;
function addData(){
	
	$('.checked').each(function(){
		var empNo = $(this).children(":eq(0)").text();
		var empName = $(this).children(":eq(1)").text();

		//중복체크
		$("#choice-emp tr").each(function(){	
			var check = $(this).children(":eq(0)").text();
			console.log("테스트용check : " + check);
			console.log("테스트용empNo : " + empNo);
			if(empNo === check){
				empNo = '';
				return;
			}
		});
		if(empNo === '')
			return;
		
		console.log(empNo);
		console.log(empName);
		html += `
				<tr id='c\${empNo}' onclick='getOutTable(this.id);'>
				<td id='\${empNo}'>\${empNo}</td>
				<td id='\${empName}'>\${empName}</td>
				</tr>`;
		console.log(html);
	});
	  $("#choice-emp").html(html);
}

function getOutTable(value){
	if($("#"+value).css("background-color")==="rgb(220, 220, 220)"){
		$("#"+value).css("background-color","rgb(192, 192, 192)");
		$("#"+value).attr('class', 'outChecked');		
	}
	else {
		$("#"+value).css("background-color","");
		$("#"+value).removeClass('outChecked');			
	}
}

function minusData(){
	console.log("삭제용"  + $(".outChecked").remove());
	html = $("#choice-emp").html();
	console.log(html);
}
</script>
</body>
</html>