<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
<title>${param.title}</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- 조직도 테이블 관련 -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@300&display=swap" rel="stylesheet">

<!-- popper 추가 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />

<!-- bootstrap -->
<%-- <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script> --%>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

<%-- <c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script> 
</c:if>--%>
</head>
<body>
	<header class="header responsive-wrapper">
  <a class="header-left" href="${pageContext.request.contextPath}/index.jsp">
  <img alt="logo" src="${pageContext.request.contextPath }/resources/images/logo1.png"  width="200" height="150">
  </a>
  <nav class="navbar navbar-expand-lg navbar-light bg-ligh" style="display: flex; width: 60%; background-color: #f8f3eb;">
    <div class="container-fluid" >
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page"
              href="${pageContext.request.contextPath}/attendance/attendanceManage.do">게시판</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page"
              href="${pageContext.request.contextPath}/document/docMain.do">전자결재</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page"
              href="${pageContext.request.contextPath}/board/boardList.do">근태관리</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page"
              href="${pageContext.request.contextPath}/chat/chatRoomList.do">채팅</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown"
              aria-expanded="false">
              조직도
            </a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
              <li><a class="dropdown-item" href="${pageContext.request.contextPath}/employeeList/eList.do">페이지이동</a>
              </li>
              <li><input value="새창으로이동" onclick="eListPop();" class="dropdown-item" /></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown"
              aria-expanded="false">
              메일함
            </a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
              <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mail/sendMailList.do">보낸 메일함</a>
              </li>
              <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mail/receiveMailList.do">받은 메일함</a>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <div class="header-right">
    <nav class="header-nav">
      <!-- 로그인이전 -->
      <sec:authorize access="isAnonymous()">
      <a href="${pageContext.request.contextPath}/employee/empLogin.do" class="header-link">Login</a>
      <a href="${pageContext.request.contextPath}/employee/empEnroll.do" class="header-link header-link--button">Sign Up</a> 
      </sec:authorize>
      <!-- 로그인이후 -->
      <sec:authorize access="isAuthenticated()">
		    <a href="${pageContext.request.contextPath}/member/memberDetail.do">
		   	<sec:authentication property="principal.username"/></a>님, 안녕하세요.			    
		   		&nbsp;
			   	<form:form class="d-inline" action="${pageContext.request.contextPath}/employee/empLogout.do" method="POST">
			   		<button class="btn btn-outline-success my-2 my-sm-0" type="submit">로그아웃</button>
			   	</form:form>
    	</sec:authorize>
    </nav>
  </div>
</header>
