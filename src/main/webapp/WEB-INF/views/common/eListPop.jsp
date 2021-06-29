<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="_csrf" content="${_csrf.token}"/>
 <meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>조직원 리스트</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/eListPop.css" />
</head>
<body>
<sec:authentication property="principal" var="principal"/>
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
	<button onclick="saveAddress()">주소록에 추가</button>
		<form id="addressFrm" action="${pageContext.request.contextPath}/address/save" method="post">
			<input type="hidden" name="savedEmp" value=""/>
			<input type="hidden" name="byEmp" value=""/>
		</form>
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

//선택한 조직원 표시해주는 변수
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
}
//csrf
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

const saveAddress = () => {
	const selectEmp = $("#choice-emp tr td:first-child");
	$(selectEmp).each((key, value) => {
		console.log(value)
		const savedEmp = $(value).attr("id");
		const byEmp = ${principal.empNo};
		
		if(byEmp == savedEmp){
			alert("자신을 주소록에 추가할 수 없습니다.")
		} else {
			//const address = {byEmp, savedEmp};
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath}/address/addressDuplicate",
			data: {byEmp, savedEmp},
			success:data=>{
				console.log(data); //{"available":true}
				console.log(data.available);
				if(data.available){
					
					saveAddresssReal(byEmp, savedEmp);
				}else {
					const {addr:{addrNo, byEmp, savedEmp}} = data;
					console.log(data)
					console.log(savedEmp)
					alert(`\${savedEmp}은 이미 주소록에 포함되어있습니다.`);
					
				}
				
			},
			error:console.log,

		})
		
	})
}


const saveAddresssReal = (byEmp, savedEmp) => {
	const selectEmp = $("#choice-emp tr td:first-child");
	
		console.log(byEmp, savedEmp)
		/* const savedEmp2 = $(value).attr("id"); */
		
		
		const address = {byEmp, savedEmp};
		 $.ajax({
			url : `${pageContext.request.contextPath}/address/save`,
			method: 'POST',
			contentType:"application/json; charset=utf-8",
			data : JSON.stringify(address),
			beforeSend: function (xhr) {
				xhr.setRequestHeader(header, token);
			},
			success(data){
				console.log(data)

			},
			error:console.log,

		}) 
		
	
	
} 
</script>
</body>
</html>