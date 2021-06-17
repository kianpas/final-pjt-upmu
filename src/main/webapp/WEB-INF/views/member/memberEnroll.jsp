<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberEnroll.css" />
<body>
 <div class="sign-wrap">
    <div class="sign_up">Sign</div>
    <div class="sign_up_">Up</div>
    <div class="sign-in-html">
      <div class="sign-form">
        <div class="sign-up-htm">
          <div class="emp_no">
            <label for="user" class="emp_no_">사번</label>
            <input id="emp_no_enroll" type="text" class="emp_no_input">
          </div>
          <div class="emp_pw">
            <label for="pass" class="emp_pw_">사원비밀번호</label>
            <input id="emp_pw" type="password" class="emp_pw_input" data-type="password">
          </div>
          <div class="emp_pw_re">
            <label for="pass" class="emp_pw_re_">비밀번호 재입력</label>
            <input id="re_emp_pw" type="password" class="emp_pw_re_input" data-type="password">
          </div>
          <div class="emp_name">
            <label for="pass" class="emp_name_">사원이름</label>
            <input id="emp_name" type="text" class="emp_name_input">
          </div>
          <div class="emp_addr">
            <label for="pass" class="emp_addr_">주소</label>
            <input id="emp_addr" type="text" class="emp_addr_input">
          </div>
          <div class="emp_email">
            <label for="pass" class="emp_email_">이메일</label>
            <input id="emp_email" type="text" class="emp_email_input">
          </div>

          <div class="emp_birth">
            <h3 class="emp_birth_">
              <label for="yy" class="emp_birth_input">생년월일</label>
            </h3>
            <input type="text" class="birth_yy" maxlength="4" placeholder="년(4자)">

            <select name="birth_mm_" class=" birth_mm">
              <option>월</option>
              <option value="01">1</option>
              <option value="02">2</option>
              <option value="03">3</option>
              <option value="04">4</option>
              <option value="05">5</option>
              <option value="06">6</option>
              <option value="07">7</option>
              <option value="08">8</option>
              <option value="09">9</option>
              <option value="10">10</option>
              <option value="11">11</option>
              <option value="12">12</option>
            </select>
            <input type="text" class="birth_dd" maxlength="2" placeholder="일">
            <span class="error_next_box"></span>

          </div>

          <div class="emp_hiredate">
            <label for="pass" class="emp_hiredate_">입사일</label>
            <input id="emp_hiredate" type="text" class="emp_hiredate_input">
          </div>
          <div class="Department">
            <label for="pass" class="Department_">부서</label>
            <input id="department" type="text" class="Department_input">
          </div>
          <div class="hr"></div>
          <div class="sign_up_button">
            <input type="submit" class="sign_up_button_" value="Sign Up">
          </div>
        </div>
      </div>
    </div>
  </div>
	<br />
	<br />
	<br />
	<script>
$(".en_emp_no").keyup(e => {
	const input = $(e.target).val();
	const $error = $(".guide.error");
	const $ok = $(".guide.ok");
	const $inputValid = $("#inputValid");

	if(en_emp_no.length < 4) {
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

</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
