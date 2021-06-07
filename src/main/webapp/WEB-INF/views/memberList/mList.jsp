<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title"/>
</jsp:include>
<body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
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
.department-list {
	overflow-x:auto; 
	width:200px; 
	height:500px;
}
.member-list {
	display: hidden;
	overflow-x:auto; 
	width:700px; 
	height:500px;
}

summary {
	list-style: none;
    cursor: pointer;
 }
</style>
<div class="list-form">
	<div class="department-list list">
		<details>
	        <summary class="dList-all">
	        	전체 목록
	        </summary>
		    <p class="depart HR">인사팀</p>
		    <p class="depart accounting">회계팀</p>
    	</details>
	</div>
	<div class="member-list list">
		<p class="HR">최한성</p>

		<p class="accounting">심철수</p>
		<p class="accounting">우이영</p>
		<p class="accounting">이순신</p>
	</div>
</div>

<script>
	var getClass;
	
	$(".member-list p").hide();
	
	console.log($(".list p.HR").val());
	
	$(".depart").click(() => {
		getClass = $(event.target).attr('class').split(' ');
		var showVal = ".member-list p > ." + getClass[1];
		
		$(".member-list p").show();
		
		console.log(getClass[1]);
		console.log(showVal);
		console.log(getClass);
	});
	
</script>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>