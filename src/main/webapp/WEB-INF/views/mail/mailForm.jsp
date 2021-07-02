<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mail.css" />

<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>

<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function mailValidate(){
	var $title = $("[name=mailTitle]");
	if(/^(.|\n)+$/.test($title.val()) == false){
		alert("제목을 입력하세요");
		return false;
	}
	return true;
}

var receiverArr = [];

$(() => {
	$("[name=upFile]").change(e => {
		var file = $(e.target).prop('files')[0];
		console.log(file);
		var $label = $(e.target).next();
		
		$label.html(file? file.name : "파일을 선택하세요.");
	});
});

$(() => {
	
	let b;
	
	$("#toInput").on("propertychange change keyup paste input", function(){
		var currentVal = $(this).val();

		console.log(currentVal.indexOf(','));
		if(currentVal.indexOf(',') != -1 ){
			$("#toInput").val('');
			let c = currentVal.split(',');
			var a = c[0];

			//공백 제거
			if(a.indexOf(" ") != -1){
				a = a.replace(/ /gi,"");
			}
			
			if(a == ""){
				alert("아무것도 입력하지 않으셨습니다.");

				$(this).val("");
				return false;	
			}
			
			if(a.indexOf('@') != -1){
				b = "a" + a.replace('@', '').split('.')[0];

				for(var i = 0; i < $('.tf_edit').length; i++){
					if($('.tf_edit').eq(i).attr("value") == a){
							alert("받는 사람이 중복되었습니다.");

							$(this).val("");
							return false;
						}
				}

				$("#toInput").before(
						"<div class='box_address box_out' id=" + b + ">" + 
						"<em class='txt_address'>" + a + "</em>" + 
						"<a href='javascript:delBtn(" + b + ");' class='btn_del' title='" + a + " 삭제'>" +
							"<span> X</span>" + 
						"</a>" + 
						"<input class='tf_edit' type='hidden' value=" + a + ">" +
					"</div>"
				);
			}
			else {
				for(var i = 0; i < $('.temp').length; i++){
					if($('.temp').eq(i).attr("value") == a){
							alert("받는 사람이 중복되었습니다.");

							$(this).val("");
							return false;
						}
				}
				
				b = "a" + a;
				$("#toInput").before(
						"<div class='box_address box_invalid' id=" + b + ">" + 
						"<em class='txt_address'>" + a + "</em>" + 
						"<a href='javascript:delBtn(" + b + ");' class='btn_del' title='" + a + " 삭제'>" +
							"<span> X</span>" + 
						"</a>" + 
						"<input class='temp' type='hidden' value=" + a + " disabled>" +
					"</div>"
					);
			}
		}	
	});

	$("#toInput").autocomplete({
 		source: function(request, response){	 		

 	 	  $.ajax({
			url: "${pageContext.request.contextPath}/mail/searchReceiver.do",
			data: {
				searchReceiver: request.term
			},
			beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success(data){
				console.log(data);
				const {list} = data;
				const arr = 
					list.map(({empNo, empName, jobName, depName}) => ({ // 부서명, 직업명, 이름, 사원번호
						label: empName + ' ' + jobName + '(' + depName + ')',
						value: empName,
						empNo
					}));
				console.log(arr);
				response(arr);
			},
			error(xhr, statusText, err){
				console.log(xhr, statusText, err);
			}
 	  	  });
		},
		select: function(event, selected){
			
			const {item: {value, empNo}} = selected;

			b = value;

			for(var i = 0; i < $('.tf_edit').length; i++){
				//if($('.tf_edit').eq(i).attr("value") == empNo){
				if($('.tf_edit').eq(i).attr("value") == value){
						alert("받는 사람이 중복되었습니다.");

						$(this).val("");
						return false;
					}
			}

 			$("#toInput").before(
					"<div class='box_address' id=" + value + ">" + 
					"<em class='txt_address'>" + value + "</em>" +
					"<a href='javascript:delBtn(" + b + ");' class='btn_del' title='" + value + " 삭제'>" + 
						"<span> X </span>" + 
					"</a>" + 
					/* "<input class='tf_edit' type='hidden' value=" + empNo + ">" +  */
					"<input class='tf_edit' type='hidden' value=" + value + ">" +
					"</div>"
				);

 			$(this).val("");
			return false;

		},
		focus: function(event, focused){
		 return false;
		},
		autoFocus: true
 	});

});

function beforeSubmit(){
	var mailFrm = document.mailFrm;

	for(var i = 0; i < $('.tf_edit').length; i++){
		receiverArr.push($('.tf_edit').eq(i).attr("value"));
	}
	
	$("#receiverArr").val(receiverArr);
	
	mailFrm.submit();
}
function delBtn(b){
	$("#" + b.id).remove();
}
	
function goBack(){
	window.history.back();
	
}
</script>

<div class="container">
	<div class="card">
		<div class="card-header">
			메일 보내기
		</div>
		<form:form
			name="mailFrm"
			id="mailFrm"
			action="${pageContext.request.contextPath}/mail/mailEnroll.do?${_csrf.parameterName}=${_csrf.token}"
			method="post"
			enctype="multipart/form-data"
			onsubmit="return mailValidate();">
		<div class="card-body">
			<table class="table">
			<tr>
				<td style="width: 15%">보내는 사람</td>
				<td><sec:authentication property="principal.empName"/></td> <%-- ${이름} --%>
			</tr>
			<tr>
				<td style="width: 15%">받는 사람</td>
				<td style="height: 0.5vh">
					<div class="address_info" id="address_info" style="cursor:text;">
						<input style="width: 40%" id="toInput" class="tf-address"/>
					</div>
					<span class="s1"style="border: 1px; font-size:1px; color: #848485">사내 메일 주소는 선택, 외부 메일 주소는 ,로 구분합니다.</span>
					<input type="hidden" name="receiverArr" id="receiverArr" value=''>
				</td>
			</tr>
			<tr>
				<td style="width: 15%">제목</td>
				<td><input id="toTitle" type="text" name="mailTitle" id="mailTitle" style="width: 100%" required></td>
			</tr>
			<tr>
				<td style="width: 15%">첨부</td>
				<td>
					 <div class="custom-file">
					   <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple />
					   <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
					 </div>
				</td>
			</tr>
			<tr>
				<td colspan="2"><textarea class="form-control" name="mailContent" rows="10"></textarea></td>
			</tr>
			</table>
			
			<div class="text-right">
				<input type="button" class="btn btn-outline-primary" onclick="beforeSubmit();" value="전송"/>
				<button type="button" class="btn btn-outline-danger" onclick="goBack();">취소</button>
			</div>
		</div>
		</form:form>
	</div>	
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>