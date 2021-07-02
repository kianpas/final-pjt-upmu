<%@page import="com.fpjt.upmu.employeeList.model.vo.Employee"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/eList.css" />
<div class="search-form">
		<label class="keyLabel"for="keyword"></label>
		<select id="keyword">
			<option value="emp_no" selected>사번</option>
			<option value="emp_name">이름</option>
			<option value="emp_job">직급</option>
			<option value="emp_dept">부서</option>
		</select>
	    <input id="search" name="p" type="search" autocomplete="off" spellcheck="false" placeholder="검색" onkeypress="if( event.keyCode == 13) {colorReset();search()};">
	    <input id="search-submit" type="submit" value="검색" onclick="search();">
</div>
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
</div>

<script>
//css 동적 추가
/* var cssUrl = "${pageContext.request.contextPath}/resources/css/eList.css";
var head = document.getElementsByTagName("head")[0];
var link = document.createElement("link");
link.rel = "stylesheet";
link.type = "text/css";
link.href = cssUrl;
document.head.appendChild(link); */

//색상 초기화
function colorReset() {	
	$(".dept").each((i, item) => {
		if($(item).attr("id") === "depNoChecked")		
			$(item).css("background-color", "");
	});
}

$(".keyLabel").hide();
	//목록에서 employee불러오기
	var getClass;
	
	$(".dept").click((e) => {
		getClass = {"depNo" : ($(e.target).attr('class').split(' '))[0]};
		var $depNo = $("." + getClass.depNo);

		colorReset();

		//부서선택 시 컬러 변환 이벤트
		if($depNo.css("background-color")==="rgb(220, 220, 220)") {
			$depNo.css("background-color" ,"rgb(180, 229, 255)");
			$depNo.attr("id", "depNoChecked");
		}
		else {
			$depNo.css("background-color");
		}
		
		$.ajax({
			url: "${pageContext.request.contextPath}/employeeList/selectOneDeptEmp.do",
			method: "GET",
			data: getClass,
			success(data){
				console.log(data.eList);
				displayTable(data.eList);
				$(document).ready( function () {
				    $('#eListTable').DataTable({
				        paging: false,
				        language : {
					        emptyTable:"결과가 없습니다.",
					        info:"",
					        infoEmpty:""
						}
				    });
				    $('#eListTable_wrapper label').hide();

					document.cookie = "safeCookie1=foo; SameSite=Lax"; document.cookie = "safeCookie2=foo"; document.cookie = "crossCookie=bar; SameSite=None; Secure";
				} );
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
				$(document).ready( function () {
				    $('#eListTable').DataTable({
				        paging: false,
				        language : {
					        emptyTable:"결과가 없습니다.",
					        info:"",
					        infoEmpty:""
						}
				    });
				    $('#eListTable_wrapper label').hide();

					document.cookie = "safeCookie1=foo; SameSite=Lax"; document.cookie = "safeCookie2=foo"; document.cookie = "crossCookie=bar; SameSite=None; Secure";
				} );
			},
			error: console.log
		})
	}

	//DB에서 불러온 데이터 테이블에 추가하는 함수
	function displayTable(data) {
		let html = "<table id='eListTable'><thead><tr><th>사번</th><th>이름</th><th>직급</th><th>부서</th><th>연락처</th><th>이메일</th></tr></thead><tbody>";
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
			html += `</tbody>`
		}
		html += "</table>";
		$(".employee-list").html(html).trigger("create");
	}
	
	//마우스 오른쪽 버튼 끄기
	$(".dept").on('contextmenu', () => {
  		return false;
	});

	//부서 마우스 오른쪽 클릭 이벤트
	var depNo;
	$(".dept").on('mousedown', (e) => {
		if(e.button == 2 || e.which == 3){
			const ctxMenu = document.getElementById('context-menu');
	        depNo = $(e.target).attr('class').split(' ')[0];
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
	
	//부서삭제, 관리자, 담당자 권한 추가해야함.
	function deleteDept() {
		var yn = confirm("정말 삭제하시겠습니까?");
		if(yn==true) {
			location.href="${pageContext.request.contextPath}/employeeList/deleteDept.do?depNo=" + depNo;
		}
	}

	//부서수정, 관리자, 담당자 권한 추가해야함.
	function modifyDept() {
		var positionX = $(".employee-list").offset().left;
		var positionY = $(".employee-list").offset().top; 
		var option = "width=160, height=140, left=" + positionX + ", top=" + positionY;
		
		window.open("${pageContext.request.contextPath}/employeeList/modifyPop?depNo=" + depNo, "", option);
	}


</script>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>