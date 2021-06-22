<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/employee.css" />
<body>
<div class="login-wrap">
    <div class="login-html">
      <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab" onclick="location.href=`${pageContext.request.contextPath}/employee/employeeLogin.do">Sign In</label>
      <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab" onclick="location.href='${pageContext.request.contextPath}">Sign Up</label>
      <div class="login-form">
        <div class="sign-in-htm">
          <div class="group">
            <label for="user" class="label" id="emp_no">아이디</label>
            <input id="user" type="text" class="input">
          </div>
          <div class="group">
            <label for="pass" class="label">비밀번호</label>
            <input id="pass" type="password" class="input" data-type="password">
          </div>
          <div class="group">
            <input id="check" type="checkbox" class="check">
            <label for="check"><span class="icon"></span> 아이디 저장</label>
          </div>
          <div class="group">
            <input type="submit" class="button" value="Sign In">
          </div>
          <div class="hr"></div>
          <div class="foot-lnk">
            <a href="#forgot">비밀번호를 잊어버리셨습니까?</a>
            <a href="${pageContext.request.contextPath }/employee/empEnroll.do">회원가입</a>
          </div>
        </div>
        <div class="sign-up-htm">
        <form action="${pageContext.request.contextPath}/employee/employeeEnroll.do" method="post">
          <div class="group">
            <label for="user" class="label" id="emp_no">아이디</label>
            <input id="emp_no" type="text" class="input">
          </div>
          <div class="group">
            <label for="pass" class="label">비밀번호</label>
            <input id="password" type="password" class="input" data-type="password">
          </div>
          <div class="group">
            <label for="pass" class="label">비밀번호확인</label>
            <input id="passwordCheck" type="password" class="input" data-type="password">
          </div>
          <div class="group">
            <label for="pass" class="label">이름</label>
            <input id="emp_name" type="text" class="input">
          </div>
          <div class="group">
            <label for="pass" class="label">주소</label>
            <input id="emp_addr" type="text" class="input">
          </div>
          <div class="group">
            <label for="pass" class="label">Email</label>
            <input id="emp_email" type="text" class="input">
          </div>

          <div class="group">
            <label for="birth" class="label">생년월일</label>
            <input id="emp_birth" type="date" class="input">
          </div>
          <div class="hr"></div>
          <div class="group">
            <input type="submit" class="button" value="Sign Up">
          </div>
        </form>       
        </div>
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
		url: "${pageContext.request.contextPath}/employee/checkemp_noDuplicate3.do",
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
