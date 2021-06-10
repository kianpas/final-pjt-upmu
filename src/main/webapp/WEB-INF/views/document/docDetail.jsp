<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/document/docMenu.jsp"></jsp:include>

<section>
	<article>
		<table>
			<tr>
				<td>기안자(임시:사번)</td><td>${document.writer }</td>
			</tr>
			<tr>
				<td>문서번호</td><td>${document.docNo }</td><td>기안일</td><td>${document.requestDate }</td>
			</tr>
			
		</table>
		
		<span>결재선</span>
		<table>
		<tr>
				<td>직책</td>
				<td>결재여부</td>
				<td>결재자명</td>
				<td>결재자레벨</td>
			</tr>
			<tr>
				<td colspan="3" align="center">결재</td>
			</tr>
			<c:forEach items="${document.docLine}" var="docLine">
				<c:if test='${docLine.approverType eq "approver"}'>
				<tr>
					<td>${docLine.jobName}</td>
					<c:choose>
						<c:when test="${docLine.status eq 'notdecided' }">
							<%-- 
								결재자가 본인인 경우만 링크 활성화
								임시로 1로 설정. 실제로는 loginMember.getId라고 생각하면 됨
							--%>
							<c:if test="${docLine.approver == '1' }">
							<td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#approvalModal">결재</button></td>
							</c:if>
							<c:if test="${docLine.approver != '1' }">
							<td>미결재</td>
							</c:if>
						</c:when>
						<c:when test="${docLine.status eq 'approved' }">
							<td>결재완료(도장)</td>
						</c:when>
						<c:when test="${docLine.status eq 'rejected' }">
							<td>반려</td>
						</c:when>
					</c:choose>
					
					
					<td>${docLine.empName}</td>
					
					<td>${docLine.lv}</td>
				</tr>
				</c:if>
			</c:forEach>
			
			<tr>
				<td colspan="3" align="center">협의</td>
			</tr>
			<tr>
				<td colspan="3" align="center">시행</td>
			</tr>
			<tr>
				<td colspan="3" align="center">수신참조</td>
			</tr>
			<c:forEach items="${document.docLine}" var="docLine">
				<c:if test='${docLine.approverType eq "referer"}'>
				<tr>
					<td>${docLine.jobName}</td>
					<td>${docLine.status}</td>
					<td>${docLine.empName}</td>
				</tr>
				</c:if>
			</c:forEach>
		</table>
		
		<p>
			<label for="title">문서제목</label>
			<input type="text" id="title" value="${document.title}">
		</p>
		<p>
			<label for="content">세부내용</label>
			<textarea rows="" cols="" id="content">${document.content}</textarea>
		</p>
		<p>
			첨부파일
		</p>


	</article>
</section>

<script>
$(document).ready(function(){       
    $('#approvalModal').on('hidden.bs.modal', function () {
        console.log("숨겨짐");
    });
 
});
 

</script>
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#approvalModal">
  Launch demo modal
</button>
<!-- Modal -->
<div class="modal fade" id="approvalModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">결재여부 선택</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form action="${pageContext.request.contextPath}/document/docDetail"
			method="POST">
      <div class="modal-body">
      <input type="radio" name="status" value="approved"/>승인
      <br />
      <input type="radio" name="status" value="rejected"/>반려
      <br />
      <input type="radio" name="status" value="notdecided"/>미정
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" id="save">Save changes</button>
      </div>
      <input type="hidden" name="docNo" value="${document.docNo}"/>
      <%--원래 로그인한 사람 사번 제출 --%>
      <input type="hidden" name="approver" value="1"/>
      </form>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	