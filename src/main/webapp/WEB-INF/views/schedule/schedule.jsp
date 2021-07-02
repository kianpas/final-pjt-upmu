<%@page import="java.util.ArrayList"%>
<%@page import="com.fpjt.upmu.schedule.model.vo.Schedule"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/cal.min.css" />
<script src="<%= request.getContextPath() %>/resources/js/calendar/main.min.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/calendar/ko.js"></script>

<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.39.0/js/tempusdominus-bootstrap-4.min.js" integrity="sha512-k6/Bkb8Fxf/c1Tkyl39yJwcOZ1P4cRrJu77p83zJjN2Z55prbFHxPs9vN7q3l3+tSMGPDdoH51AEU8Vgo1cgAA==" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.39.0/css/tempusdominus-bootstrap-4.min.css" integrity="sha512-3JRrEUwaCkFUBLK1N8HehwQgu8e23jTH4np5NHOmQOobuC4ROQxFwFgBLTnhcnQRMs84muMh0PnnwXlPq5MGjg==" crossorigin="anonymous" />
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />

<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>

<%
	List<Schedule> list = (ArrayList<Schedule>)request.getAttribute("list");
	Schedule s = null;
%>

<c:if test="${not empty msg}">
<script>							
	alert("${msg}");
</script> 
</c:if>
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

var calendar = null;

//
let selectDate;

$(document).ready(function() {
	var calendarEl = document.getElementById('calendar');

	calendar = new FullCalendar.Calendar(calendarEl, {
    	initialView: 'dayGridMonth',
    	headerToolbar: {
        left: 'prevYear,prev,next,nextYear today',
        center: 'title',
        right: 'dayGridMonth,dayGridWeek,dayGridDay'
      	},
	    locale: 'ko',
	    selectable: true,
	    navLinks: true, // can click day/week names to navigate views
	    editable: true,
	    dayMaxEvents: true, // allow "more" link when too many events
	
	    dateClick: function(info){
		      selectDate = new Date(info.dateStr);
		      
		      $('#schStart').val(moment(selectDate).format('YYYY-MM-DD HH:mm'));
			  $('#schEnd').val(moment(selectDate.setHours(selectDate.getHours()+1)).format('YYYY-MM-DD HH:mm'));

			  $('#sch-modal').modal("show");
			  $('.modal-title').html('일정 추가');
		      $('.btn-addEvent').show();
		      $('.btn-modifyEvent').hide();

		},

		events: [
<%
		for(int i = 0; i < list.size(); i++){
			s = list.get(i);
%>
		{
			title: '<%= s.getSchTitle() %>',
			start: '<%= s.getSchStart() %>',
			end: '<%= s.getSchEnd() %>',
			description: '<%= s.getSchContent() %>',
			type: '<%= s.getSchType() %>',
			color: colorType('<%= s.getSchType() %>'),
			no: '<%= s.getSchNo() %>'
			
<% if(i == list.size()-1){ %>
		}
<%	}
	else {
%>
		},
<% } %>

<%
		}
%>
		],

	    eventClick: function(info){
			
	    	$('#schTitle').val(info.event.title);
	    	$('#schContent').val(info.event.extendedProps.description);

	    	//1일 하루종일
	    	if(isNaN(moment(info.event.end))){
	    		$('#schStart').val(info.event.startStr);
	    		$('#schEnd').val(info.event.startStr);
	    		$('#schAllDay').prop('checked', true);
		    }
		    //n일 하루종일
	    	else if((info.event.endStr).indexOf("T") == -1){
	    		$('#schStart').val(info.event.startStr);
	    		//하루 뺴줘야 함
	    		$('#schEnd').val(moment(info.event.endStr).subtract(1, 'days').format('YYYY-MM-DD'));
	    		$('#schAllDay').prop('checked', true);
		    }
	    	else {
	    		$('#schStart').val(moment(info.event.start).format('YYYY-MM-DD HH:mm'));
	    		$('#schEnd').val(moment(info.event.end).format('YYYY-MM-DD HH:mm'));
		    }

			$('#schType').val(info.event.type);
			$('#schType').val(info.event.extendedProps.type).attr("selected", "selected");
			$('#sch-no').val(info.event.extendedProps.no);

			$('#sch-modal').modal("show");
			$('.modal-title').html('일정 조회');
			$('.btn-modifyEvent').show();
			$('.btn-addEvent').hide();
		},
		
		eventResize: function(event){

			$('#schStart').val(event.event.startStr);
			$('#schEnd').val(event.event.endStr);

			schDateUpdate(event);

		},
		
		eventDrop: function(event){
			console.log(event.event);

			//1일 하루종일
	    	if(isNaN(moment(event.event.end))){
	    		$('#schStart').val(event.event.startStr);
	    		$('#schEnd').val(event.event.startStr);
		    }
	    	//n일 하루종일
	    	else if((event.event.endStr).indexOf("T") == -1){
	    		$('#schStart').val(event.event.startStr);
	    		$('#schEnd').val(event.event.endStr);
		    }
			else {
				$('#schStart').val(moment(event.event.startStr).format('YYYY-MM-DD HH:mm'));
				$('#schEnd').val(moment(event.event.endStr).format('YYYY-MM-DD HH:mm'));
			}

			schDateUpdate(event);
		}
	    
	  });

		$('#schStart, #schEnd').datetimepicker({
			format: 'YYYY-MM-DD HH:mm',
			locale: 'ko'
		});

		$('.modal').on('hidden.bs.modal', function (e) {
		    $('#schFrm')[0].reset();
		    $('#schAllDay').prop('checked', false);
		});

		calendar.render();
	
});

function chkAllday(){
	// 1 ~ n일
	if($('#schAllDay').is(':checked')){
		$('#schStart').val(moment(selectDate).format('YYYY-MM-DD'));
    	$('#schEnd').val(moment(selectDate).format('YYYY-MM-DD'));
    	
//    	$('#schStart').attr('readonly', true);
//    	$('#schEnd').attr('readonly', true);
	}
//	else {
//    	$('#schStart').attr('readonly', false);
//    	$('#schEnd').attr('readonly', false);
//    }
}

function schDateUpdate(event){
	//resize, drag
	var schDateMap= {
			"start": $('#schStart').val(),
			"end": $('#schEnd').val(),
			"no": event.event._def.extendedProps.no
	};

	$.ajax({
		url: "${pageContext.request.contextPath}/schedule/schDateUpdate.do",
		type: 'POST',
		traditional: true,
		data: schDateMap,
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
		success: function(data){
			alert("일정을 수정하였습니다.");
			location.reload();
		},
		error: function(error){
			alert("일정 수정 실패하였습니다.");
			location.reload();
		}
	});
}

function schDel(){

	var chk = confirm("정말 삭제하시겠습니까?");
	if(chk){
		$.ajax({
			url: "${pageContext.request.contextPath}/schedule/scheduleDelete.do",
			type: 'POST',
			traditional: true,
			data: {
				schNo: $('#sch-no').val()
			},
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success: function(data){
				alert("일정 삭제하였습니다.");
				location.reload();
			},
			error: function(error){
				alert("일정 삭제 실패하였습니다.");
				location.reload();
			}
		});
	}
}

function schUpdate(){

	var schMap= {
			"empNo": '<sec:authentication property="principal.empNo"/>',
			"title": $('#schTitle').val(),
			"content": $('#schContent').val(),
			"start": $('#schStart').val(),
			"end": $('#schEnd').val(),
			"type": $('#schType').val(),
			"no": $('#sch-no').val()
	};
	
	$.ajax({
		url: "${pageContext.request.contextPath}/schedule/scheduleUpdate.do",
		data: schMap,
		type: 'POST',
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
		},
		success: function(data){
			alert("일정을 수정하였습니다.");
			$('#sch-modal').modal('hide');
			location.reload();
		}
	});
}

function colorType(str){
	if(str == '회의'){
		return 'red';
	}
	else if(str == '출장') {
		return 'green';
	}
	else if(str == '프로젝트'){
		return 'blue';
	}
	else {
		return 'purple';
	}
	
}

function beforeSubmit(){

	if(($('#schStart').val()) > ($('#schEnd').val())){
		alert("끝나는 날짜가 시작 날짜보다 먼저입니다.");
		return false;
	}

	if($('#schAllDay').is(':checked')){
		//연속 하루종일은 +1일을 해줘야 제대로 나타난다.
//		console.log(moment($('#schEnd').val()).add(1, 'days').format('YYYY-MM-DD'));
		$('#schStart').val(moment($('#schStart').val()).format('YYYY-MM-DD'));
		$('#schEnd').val(moment($('#schEnd').val()).add(1, 'days').format('YYYY-MM-DD'));
	}

}
</script>

<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }

</style>
</head>
<body>
<div class="container">
	<div class="card">
		<div class="card-body">
			<div id='calendar'></div>
		</div>
	</div>
</div>
	
<div class="modal fade" tabindex="-1" role="dialog" id="sch-modal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="headerLabel">일정 추가</h5>
				<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
  			
			<div class="modal-body">
				<form:form
					name="schFrm"
					id="schFrm"
					action="${pageContext.request.contextPath}/schedule/scheduleEnroll.do"
					method="post"
					onsubmit="return beforeSubmit();">
				<table class="table">
					<tr>
						<td>하루 종일</td>
						<td>
							<input class="allDayNewEvent" type="checkbox" name="schAllDay" id="schAllDay" onclick="chkAllday();"/>
						</td>
					</tr>
					<tr>
						<td>시작</td>
						<td colspan="3"><input class="inputModal" type="text" name="schStart" id="schStart" data-toggle="datetimepicker" data-target="#schStart"/></td>
					</tr>
					<tr>
						<td>끝</td>
						<td colspan="3"><input class="inputModal" type="text" name="schEnd" id="schEnd" data-toggle="datetimepicker" data-target="#schEnd"/></td>
					</tr>
					<tr>
						<td>구분</td>
						<td colspan="3">
							<select class="inputModal" type="text" name="schType" id="schType">
								<option value="회의" style="color:red;" selected>회의</option>
								<option value="출장" style="color:green;">출장</option>
								<option value="프로젝트" style="color:blue;">프로젝트</option>
								<option value="기타" style="color:purple;">기타</option>
						</select>
						</td>
					</tr>
					<tr>
						<td>일정 제목</td>
						<td colspan="3"><input class="inputModal" type="text" id="schTitle" name="schTitle" required/></td>
					</tr>
					<tr>
						<td>일정 내용</td>
						<td colspan="3"><textarea rows="7" cols="50" class="inputModal" id="schContent" name="schContent" style="resize: none"></textarea></td>
					</tr>
				</table>
			</div>
			
			<div class="modal-footer btn-addEvent">
				<input type="submit" class="btn btn-outline-primary" value="저장" >
				<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
			<div class="modal-footer btn-modifyEvent">
				<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-outline-primary" onclick="schUpdate();">저장</button>
				<button type="button" class="btn btn-outline-danger" onclick="schDel();">삭제</button>
			</div>
			</form:form>
			<input type="hidden" id="sch-no" name="sch-no" value=""/>
		</div>
	</div>  
</div>
</body>
</html>
