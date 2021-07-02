<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

<%--<div id="profile-form">
	<div id="photo-form">
		<img id="photo" alt="프로필사진" src="${pageContext.request.contextPath}/resources/images/7.jpg">
		
	</div>
	<div id="profile">
		<h1>사원정보</h1>
		
			<label for="emp_name">이름  
			<input name="emp_name" type="text" value="${employee.empName}">
			</label>
			
			<label for="emp_phone">전화번호  
			<input name="emp_phone" type="text" value="${employee.empPhone}">
			</label>
			
			<label for="emp_email">EMAIL  
			<input name="emp_email" type="text" value="${employee.empEmail}">
			</label>
			
			<label for="emp_addr">주소  
			<input name="emp_addr" type="text" value="${employee.empAddr}">
			</label>
			
			<label for="emp_birth">생년월일  
			<input name="emp_birth" type="date" value="${employee.empBirth}">
			</label>
			
			<label for="emp_job">직급  
			<select id="emp_job">
				<option value="emp_job" selected>${employee.empJob}</option>
				<c:forEach items="${jList}" var="job">
					<c:if test="${job.jobName != employee.empJob}">
						<option value="emp_job">${job.jobName}</option>
					</c:if>
				</c:forEach>
			</select>
			</label>
			
			<label for="emp_dept">부서  
			<select id="emp_dept">
				<option value="emp_dept" selected>${employee.empDept}</option>
				<c:forEach items="${dList}" var="dept">
					<c:if test="${dept.depName != employee.empDept}">
						<option id="empDept" value="emp_dept">${dept.depName}</option>
					</c:if>
				</c:forEach>
			</select>
			</label>
			
			<label for="emp_hiredate">입사일  
			<input name="emp_hiredate" type="date" value="${employee.empHiredate}">
			</label>
			
	</div>
</div>
<div id="btn-form">
	<input type="button" value="변경" onclick="checkInfo();">
	<input type="button" value="삭제" onclick="deleteProfile();">
	<input type="button" value="취소">
</div>
<script>
function checkInfo(){
	var empInpo = document.getElement
	if(true) {
		console.log("${employee.empDept}");
		console.log($empInpo);
	}
}
</script> --%>
        <form:form action="${pageContext.request.contextPath}/common/myProfile.do" class="validation-form" method="POST">
<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-9 mx-auto">
        <h4 class="mb-3 text-center">내 정보</h4>
          <div class="row">
            <div class="col-md-4 mb-3">
              <label for="name">프로필 사진 자리</label>
              <img id="photo" alt="프로필사진" src="${pageContext.request.contextPath}/resources/images/7.jpg">
              <div class="invalid-feedback">
                프로필 사진 자리
              </div>
            </div>
            <div class="col-md-8 mb-3">
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
              <label for="email">이메일</label>
              <input type="text" class="form-control" id="email" name="empEmail" value="${employee.empEmail}" required readonly>
              <div class="invalid-feedback">
                이메일을 입력해주세요.
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
          <!-- <button class="btn btn-primary float-right" type="submit">삭제</button> -->
          <button class="btn btn-primary float-right" type="submit">수정</button>
      </div>
    </div>
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; 2021 UPMU</p>
    </footer>
  </div>
        </form:form>
  <script>
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
  </script>
</body>
</html>