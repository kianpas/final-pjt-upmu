<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />
<body>

</body>
<script>

$("#input").keyup(e => {
	const input = $(e.target).val();
	const $error = $(".guide.error");
	const $ok = $(".guide.ok");
	const $inputValid = $("#inputValid");

	if(input.length < 4) {
		$(".guide").hide();
		$inputValid.val(0); // 다시 작성하는 경우 대비
		return;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkemp_noDuplicate3.do",
		data: {input},
		success: (data) => {
			console.log(data);
			const {available} = data;
			if(available){
				$ok.show();
				$error.hide();
				$inputValid.val(1);
			}
			else {
				$ok.hide();
				$error.show();
				$inputValid.val(0);
			}
		},
		error: (xhr, statusText, err) => {
			console.log(xhr, statusText, err);
		}
	});
});
$("#passwordCheck").blur(function() {
	var $password = $("#password"), $passwordCheck = $("#passwordCheck");
	if($password.val() != $passwordCheck.val()){
		alert("비밀번호가 일치하지 않습니다.");
		$password.select();
	}
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
