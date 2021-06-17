<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
<title>${param.title}</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
<%-- <c:if test="${not empty msg}">
<script>							
	alert("${msg}");
</script> 
</c:if>--%>
</head>
<body>
	<header class="header responsive-wrapper">
  <a class="header-left" href="${pageContext.request.contextPath}">
  <img alt="logo" src="${pageContext.request.contextPath }/resources/images/logo1.png"  width="200" height="150">
  </a>
  <div class="header-right">
    <nav class="header-nav">
      <!-- 로그인이전 -->
      <a href="${pageContext.request.contextPath }/member/memberLogin.do" class="header-link">Login</a>
      <!-- 로그인이후 -->
<%--       <a href="${pageContext.request.contextPath }/member/memberLogout.do" class="header-link"> Logout</a> --%>
	<%-- <span><a href="${pageContext.request.contextPath }/member/memberDetail.do">${loginMember.name}</a>님, 안녕하세요</span> --%>
      <a href="${pageContext.request.contextPath}/member/memberEnroll.do" class="header-link header-link--button">Sign Up</a>
      
    </nav>
    <button class="header-menu-button">Menu</button>
  </div>
</header>