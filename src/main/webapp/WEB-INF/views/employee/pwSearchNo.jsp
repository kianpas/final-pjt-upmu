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
 <div class="sign-wrap find-wrap">
    <div class="sign-in-html">
      <div class="sign-form">
        <div class="sign-up-htm">
         <div class="emp_phone">
			<span class="find-id">유효하지 않은 시도입니다.</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>