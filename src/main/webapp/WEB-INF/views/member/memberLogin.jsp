<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberLogin.css" />
<body>
  <div class="login-wrap">
    <div class="login-html">
      <div class="login-form">
        <div class="sign-in-htm">
          <div class="group">
            <label for="user" class="label">사원아이디</label>
            <input id="user" type="text" class="input">
          </div>
          <div class="group">
            <label for="pass" class="label">사원비밀번호</label>
            <input id="pass" type="password" class="input" data-type="password">
          </div>
          <div class="group">
            <input id="check" type="checkbox" class="check" checked>
            <label for="check"><span class="icon"></span> 아이디 저장</label>
          </div>
          <div class="group">
            <input type="submit" class="button" value="Sign In">
          </div>
          <div class="hr"></div>
          <div class="foot-lnk">
            <a href="#forgot">비밀번호를 잊어버리셨습니까?</a>
          </div>
        </div>
        <br /><br /><br />
      </div>
    </div>
  </div>
  <br /><br /><br />
</body>
<script>
$("#emp_no1").keyup(e => {
	const emp_no = $(e.target).val();
	const $error = $(".guide.error");
	const $ok = $(".guide.ok");
	const $emp_noValid = $("#emp_noValid");
	
	if(emp_no.length <4) {
		$(".guide").hide();
		$emp_noValid.val(0);
		return;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkemp_noDuplicate3.do",
		data: {emp_no},
		success: (data) => {
			console.log(data);
			const {available} = data;
			if(available){
				$ok.show();
				$error.hide();
				$emp_idValid.val(1);
			}
			else {
				$ok.hide();
				$error.show();
				$emp_idValid.val(0);
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
