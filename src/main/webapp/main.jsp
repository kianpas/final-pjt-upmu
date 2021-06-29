<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<body>
	<div class="UPMU">
		<a href="${pageContext.request.contextPath}#" id="UPMU_logo">
			<img src="${pageContext.request.contextPath}/resources/images/logo1.png" alt="UPMU-logo" />
		</a>
	</div>

	<!-- FORM SEARCH -->
	<div class="form"></div>

	<!-- BUTTONS -->
	<div class="buttons">
		<a href="${pageContext.request.contextPath}/employee/empLogin.do" id="upmu_login">Login</a>
		<a href="${pageContext.request.contextPath}/employee/empEnroll.do" id="upmu_sign_up">Sign Up</a>
	</div>
</body>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>