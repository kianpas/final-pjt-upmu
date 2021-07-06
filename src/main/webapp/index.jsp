<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<body style="width: 1280px;
    height: 768px;
    margin: auto;">
<main class="responsive-wrapper">
  <div class="magazine-layout">
    <div class="magazine-column" style="width: 450px;">
      <article class="article">
        <h2 class="article-title article-title--large">
          <a href="#" class="article-link">
			<iframe width="100%" height="500px" src="https://www.youtube.com/embed/Ta9bs68kB6M?autoplay=1" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</a>
        </h2>
        <div class="article-excerpt">
        </div>
        <div class="article-author">
          <div class="article-author-img">
            <img src="./resources/images/logo.png" alt="logo" />
          </div>
          <div class="article-author-info">
            <dl>
              <dt>UPMU Project</dt>
              <dd>KH정보교육원에서 파이널프로젝트로 기획했던 저희 업무팀은  <br />
              </dd>
            </dl>
          </div>
        </div>
      </article>
    </div>
    <div class="magazine-column">
      <article class="article" style="height: 400px">
        <figure class="article-img">
          <img
            src="https://images.unsplash.com/photo-1512521743077-a42eeaaa963c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1351&q=80" />
        </figure>
        <h2 class="article-title article-title--small">
          <a href="#" class="article-link">To Become <mark class="mark mark--secondary">Happier</mark>, Ask Yourself
            These Two Questions Every Night</a>
        </h2>
        <div class="article-creditation">
          <p>By Jonathan O'Connell</p>
        </div>
      </article>
      <article class="article">
        <figure class="article-img">
          <img
            src="https://images.unsplash.com/photo-1569234817121-a2552baf4fd4?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" />
        </figure>
        <h2 class="article-title article-title--small">
          <a href="#" class="article-link">10 Things I Stole From People Smarter Than Me</a>
        </h2>
        <div class="article-creditation">
          <p>By Jonathan O'Connell</p>
        </div>
      </article>
    </div>
    <div class="magazine-column" style= " width: 330px;">
      <article class="article" style="height: 400px">
        <h2 class="article-title article-title--medium">
          <a href="#" class="article-link">Traveller Visiting Ice Cave With Amazing Eye-Catching Scenes</a>
        </h2>
        <div class="article-excerpt">
          <p>Slack has become indispensible for many businesses operation remotely during the pandemic. Here's what the
            acquisition could mean for users...</p>
        </div>
        <div class="article-author">
          <div class="article-author-img">
            <img src="https://assets.codepen.io/285131/author-2.png" />
          </div>
          <div class="article-author-info">
            <dl>
              <dt>James Robert</dt>
              <dd>Editor</dd>
            </dl>
          </div>
        </div>
      </article>
      <article class="article">
      	<c:import url="/schedule/schIndex.do"></c:import>
      </article>
    </div>
  </div>
</main>
<script>
function eListPop() {
	var option = "width=500, height=600";
	
	window.open("${pageContext.request.contextPath}/common/eListPop.do", "", option);
}
</script>
</body>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>