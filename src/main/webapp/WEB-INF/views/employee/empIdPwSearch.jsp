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
<form:form action="${pageContext.request.contextPath}/employee/empIdPwSearch.do" name="form" id="form" method="post">
 <div class="sign-wrap">
    <div class="sign-in-html">
      <div class="sign-form">
        <div class="sign-up-htm">
         <span class="id-search">아이디 찾기</span>
         <div class="hr id-search"></div>
         <div class="emp_phone">
            <label for="empName" class="emp_phone_">이름</label>
            <input id="empName" name="empName" type="text" class="emp_phone_input" placeholder="이름">
          </div>
          <div class="emp_phone">
            <label for="empPhone" class="emp_phone_">휴대폰</label>
            <input id="empPhone" name="empPhone" type="text" class="emp_phone_input" placeholder="숫자만 입력">
          </div>     
          <div class="hr"></div>
          <div class="sign_up_button">
            <input id="searchId" type="submit" class="sign_up_button_" value="보내기" formaction="${pageContext.request.contextPath}/employee/empIdSearch.do">
          </div>
        </div>
      </div>
    </div>
  </div>
      <br><br><br>
   <div class="pw-wrap">
    <div class="sign-in-html">
      <div class="sign-form">
        <div class="sign-up-htm">
         <span class="pw-search">비밀번호 찾기</span>
         <div class="hr id-search"></div>
         <div class="emp_phone">
            <label for="empEmail" class="emp_phone_">아이디</label>
            <input id="empEmail" name="empEmail" type="text" class="emp_phone_input" placeholder="아이디">
          </div>
          <div class="hr"></div>
          <div class="sign_up_button">
            <input type="submit" class="sign_up_button_" value="보내기" formaction="${pageContext.request.contextPath}/employee/mailPwSearch.do">
          </div>
        </div>
      </div>
    </div>
  </div>
</form:form>
<script>
</script>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>