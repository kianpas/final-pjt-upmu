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
         <form:form action="${pageContext.request.contextPath}/employee/empEnroll.do" name="form" id="form" method="post">
         <span class="id-search">아이디 찾기</span>
         <div class="hr id-search"></div>
         <div class="emp_phone">
            <label for="emp_phone" class="emp_phone_">이름</label>
            <input id="emp_phone" name="empPhone" type="text" class="emp_phone_input" placeholder="이름" required>
          </div>
          <div class="emp_phone">
            <label for="emp_phone" class="emp_phone_">휴대폰</label>
            <input id="emp_phone" name="empPhone" type="text" class="emp_phone_input" placeholder="숫자만 입력" required>
          </div>
         
          <div class="hr"></div>
          <div class="sign_up_button">
            <input type="submit" class="sign_up_button_" value="보내기">
          </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
      <br><br><br>
   <div class="pw-wrap">
    <div class="sign-in-html">
      <div class="sign-form">
        <div class="sign-up-htm">
         <form:form action="${pageContext.request.contextPath}/employee/empEnroll.do" name="form" id="form" method="post">
         <span class="pw-search">비밀번호 찾기</span>
         <div class="hr id-search"></div>
         <div class="emp_phone">
            <label for="emp_phone" class="emp_phone_">아이디</label>
            <input id="emp_phone" name="empPhone" type="text" class="emp_phone_input" placeholder="아이디" required>
          </div>
          <div class="hr"></div>
          <div class="sign_up_button">
            <input type="submit" class="sign_up_button_" value="보내기">
          </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
  
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>