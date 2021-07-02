<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/empIdPwSearch.css" />
<body>
 <div class="sign-wrap">
    <div class="sign-in-html">
      <div class="sign-form">
        <div class="sign-up-htm">
        <form:form method="POST">
         <span class="id-search">비밀번호 재설정</span>
         <div class="hr id-search"></div>
         <div class="emp_pw">
            <label for="emp_pw" class="emp_pw_">비밀번호</label>
            <input id="emp_pw" name="empPw" type="password" class="emp_pw_input" required>
            <span class="pwError1" style="display: none;">비밀번호는 최소 8자, 최소 하나의 문자, 숫자 및 특수 문자 포함입니다.</span>
          </div>
          <div class="emp_pw_re">
            <label for="re_emp_pw_check" class="emp_pw_re_">비밀번호확인</label>
            <input id="re_emp_pw_check" type="password" class="emp_pw_re_input" required>
            <span class="pwError2" style="display: none;">비밀번호를 확인해주세요.</span>
          </div>
          <div class="hr"></div>
          <div class="sign_up_button">
          	<input id="authVal" name="authVal" type="hidden">
            <input id="searchId" type="submit" class="sign_up_button_" value="보내기" formaction="${pageContext.request.contextPath}/employee/empPwSearch.do">
          </div>
        </form:form>
        </div>
      </div>
    </div>
  </div>
<script>
//url에서 값 가져오기
var url = location.href;
var val = url.split('=');

$("#authVal").val(val[1]);

//비밀번호 유효성 검사
const $pwValid = $("#pwValid");

$("#emp_pw").keyup(e => {
	const pw = $(e.target).val();
	console.log(pw);
	const $pwError2 = $(".pwError2");
	const $pwError1 = $(".pwError1");

	var regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
	
	if(pw.length < 8) {
		$pwError1.show();
		return;
	}
	else {
		if(!regPw.test(pw)){
			$pwError1.show();
			return;
		}
		$pwError1.hide();
	}
});

//비밀번호 확인
$("#re_emp_pw_check").blur(function(){
	var $password = $("#emp_pw"), $passwordCheck = $("#re_emp_pw_check");
	if($password.val() != $passwordCheck.val()){
		$(".pwError2").show();
		$("#re_emp_pw_check").val('');
		$password.select();
	}
	else {
		$pwValid.val(1);
		$(".pwError2").hide();
	}
});
</script>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>