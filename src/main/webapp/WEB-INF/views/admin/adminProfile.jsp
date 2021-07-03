<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myProfile.css" />
</head>
<body>
<form:form action="${pageContext.request.contextPath}/admin/adminProfile.do" id="form" method="POST">
<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">내 정보</h4>
          <div class="row">
            <div class="col-md-3 mb-3">
              <label for="name"></label>
              <img id="photo" alt="프로필사진" src="${pageContext.request.contextPath}/resources/images/증명사진.jpg">
              <div class="invalid-feedback">
                프로필 사진 자리
              </div>
            </div>
            <div class="col-md-4.5 mb-3">
			<label for="email">이메일</label>
              <input type="text" class="form-control" id="email" name="empEmail" value="${employee.empEmail}" readonly>
              <div class="invalid-feedback">
                이메일을 입력해주세요.
              </div>
              <div class="pwErrorNow" style="display: none; color: red;">비밀번호 사용불가</div>
              <label for="emp_pw">변경 비밀번호</label>
              <input type="password" class="form-control" id="emp_pw" name="changePw">
              <div class="invalid-feedback">
                변경 비밀번호를 입력해주세요.
              </div>
              <div class="pwError1" style="display: none; color: red;">비밀번호 사용불가</div>
              <label for="re_emp_pw_check">변경 비밀번호 확인</label>
              <input type="password" class="form-control" id="re_emp_pw_check">
              <div class="invalid-feedback">
                변경 비밀번호를 다시 입력해주세요.
              </div>
              <span class="pwError2" style="display: none; color: red;">비밀번호 불일치</span>
            </div>
            <div class="col-md-5 mb-3">
              <label for="name">이름</label>
              <input type="text" class="form-control" id="name" name="empName" value="${employee.empName}" required>
              <div class="invalid-feedback">
                이름을 입력해주세요.
              </div>
              <label for="phone">연락처</label>
              <input type="text" class="form-control" id="phone" name="empPhone" value="${employee.empPhone}" required>
              <div class="invalid-feedback">
                연락처를 입력해주세요.
              </div>
              <label for="addr">주소</label>
              <input type="text" class="form-control" id="addr" name="empAddr" value="${employee.empAddr}" required>
              <div class="invalid-feedback">
                주소을 입력해주세요.
              </div>
              <label for="birth">생년월일</label>
              <input type="date" class="form-control" id="nickname" name="empBirth" value="${employee.empBirth}" required>
              <div class="invalid-feedback">
                별명을 입력해주세요.
              </div>
              <label for="job">직급</label>
                  <select id="job" name="empJob" class="form-control">
                  		<c:forEach items="${jList}" var="job">
                      		<c:if test="${job.jobName == employee.empJob}">
                      			<option value="${job.jobNo}" selected>${employee.empJob}</option>
                      		</c:if>
							<c:if test="${job.jobName != employee.empJob}">
							   <option value="${job.jobNo}">${job.jobName}</option>
							</c:if>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">
                        직급을 입력해주세요.
                    </div>
              <label for="dept">부서</label>
                <select id="dept" name="empDept" class="form-control">
                    <c:forEach items="${dList}" var="dept">
                    	<c:if test="${dept.depName == employee.empDept}">
                    		<option value="${dept.depNo}" selected>${employee.empDept}</option>
                    	</c:if>
                        <c:if test="${dept.depName != employee.empDept}">
                            <option id="empDept" value="${dept.depNo}">${dept.depName}</option>
                        </c:if>
                    </c:forEach>
			    </select>
              <div class="invalid-feedback">
                부서을 입력해주세요.
              </div>
              <label for="hireDate">입사일</label>
              <input type="date" class="form-control" id="hireDate" name="empHiredate" value="${employee.empHiredate}" required readonly>
              <div class="invalid-feedback">
                입사일을 입력해주세요.
              </div>
            </div>
          </div>
          <hr class="mb-4">
          <div class="mb-4"></div>
          <button class="btn btn-primary float-right" type="submit" onclick="window.close()">취소</button>
          <button class="btn btn-primary float-right" type="submit" id="delete-emp" formaction="${pageContext.request.contextPath}/admin/empDelete.do">삭제</button>
          <button class="btn btn-primary float-right" type="submit">수정</button>
      </div>
    </div>
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; 2021 UPMU</p>
    </footer>
  </div>
</form:form>
<script>
//절취선
  window.addEventListener('load', () => {
    const forms = document.getElementsByClassName('validation-form');

    Array.prototype.filter.call(forms, (form) => {
      form.addEventListener('submit', function (event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }

        form.classList.add('was-validated');
      }, false);
    });
  }, false);

//변경 비밀번호 유효성 검사
var pwValid2 = 0;
$("#emp_pw").keyup(e => {
	const pw = $(e.target).val();
	const $pwError1 = $(".pwError1");

	var regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
	
	if(pw.length < 8) {
		$pwError1.show();
		pwValid2 = 0;
		return;
	}
	else {
		if(!regPw.test(pw)){
			$pwError1.show();
			pwValid2 = 0;
			return;
		}
		$pwError1.hide();
	}
});

//변경 비밀번호 확인
$("#re_emp_pw_check").blur(function(){
	var $password = $("#emp_pw"), $passwordCheck = $("#re_emp_pw_check");
	if($password.val() != $passwordCheck.val()){
		$(".pwError2").show();
		$("#re_emp_pw_check").val('');
		pwValid2 = 0;
		$password.select();
	}
	else {
		pwValid2 = 1;
		$(".pwError2").hide();
	}
});

//비밀번호 입력 확인
$("#form").submit(function(e){
		if(pwValid2 == 0){
			alert("변경 비밀번호를 확인해주세요.");
			e.preventDefault();
		}
	}
});
</script>
</body>
</html>