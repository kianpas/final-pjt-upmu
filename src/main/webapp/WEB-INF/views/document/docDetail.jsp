<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/document/docMenu.jsp"></jsp:include>
<style>
#title{
	text-align: center;
}
#docColumn{
	width: 300px;
}
table{
	border: 2px solid black;
}
th, td{
	border: 1px solid black;
}

#docLineTable{
	text-align: center;
}
.tableDiv{
	display: inline-block;
}
#docLineDiv{
	float: right;
}
article{
	background-color: white;
	padding: 10px;
}
#attach-container{
	width: 500px;
}
#reply-container{
	overflow: hidden;
}
textarea{
	width: 100%;
	display: block;
}
#replyBtn{
	float: right;
}
</style>

<section>
	<article>
		<h1 id="title">${document.title}</h1>
		<br />
		<div class="tableDiv" id="docColumn">
			<table class="table table-sm">
				<tr>
					<td class="table-secondary" style="width: 100px;">기안자</td><td>${document.writerName}</td>
				</tr>
				<tr>
					<td class="table-secondary">소속</td><td>${document.depName}</td>
				</tr>
				<tr>
					<td class="table-secondary">직위</td><td>${document.jobName}</td>
				</tr>
				<tr>
					<td class="table-secondary">기안일</td><td>${document.requestDate}</td>
				</tr>
				<tr>
					<td class="table-secondary">문서번호</td><td>${document.docNo}</td>
				</tr>
			</table>
		</div>
		
		<div class="tableDiv" id="docLineDiv">
			<table id="docLineTable">
				<tr>
					<td rowspan="4" align="center" class="table-secondary">결<br/>재</td>
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
								<td>
									<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#approvalModal">결재</button>
									<input type="hidden" id="maxAuthority" value="${docLine.maxAuthority}"/>
									<input type="hidden" id="lv" value="${docLine.lv}"/>
								</td>
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
							<c:when test="${docLine.status eq 'afterview' }">
								<td>후열</td>
							</c:when>
						</c:choose>
						<td>${docLine.empName}</td>
					</tr>
					</c:if>
				</c:forEach>
				
				<tr>
					<td rowspan="4" align="center" class="table-secondary">협<br/>의</td>
				</tr>
				<c:forEach items="${document.docLine}" var="docLine">
					<c:if test='${docLine.approverType eq "agreer"}'>
					<tr>
						<td>${docLine.jobName}</td>
						<td>${docLine.status}</td>
						<td>${docLine.empName}</td>
					</tr>
					</c:if>
				</c:forEach>
				<tr>
					<td rowspan="4" align="center" class="table-secondary">시<br/>행</td>
				</tr>
				<c:forEach items="${document.docLine}" var="docLine">
					<c:if test='${docLine.approverType eq "enforcer"}'>
					<tr>
						<td>${docLine.jobName}</td>
						<td>${docLine.status}</td>
						<td>${docLine.empName}</td>
					</tr>
					</c:if>
				</c:forEach>
				<tr>
					<td rowspan="4" align="center" class="table-secondary">수<br/>신<br/>참<br/>조</td>
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
		</div>
		<div style="width: 793px;">
			${document.content}
		</div>

		<div id="attach-container">
		
		<c:forEach items="${docAttachList}" var="attach">
		<button type="button" 
				class="btn btn-outline-success btn-block"
				onclick="location.href='${pageContext.request.contextPath}/document/fileDownload.do?no=${attach.no}';">
			첨부파일 - ${attach.originalFilename }
		</button>
		</c:forEach>
		</div>
		

	</article>
	<footer>
		<div id="reply-container">
			댓글창<br />
			<ul class="list-group">
				
			<c:forEach items="${docReplyList}" var="docReply" varStatus="">
			<li class="list-group-item">
				<div class="d-flex w-100 justify-content-between">
					<p class="mb-1 font-weight-bold" >
						${docReply.depName }
						${docReply.jobName }
						${docReply.writerName }
					</p>
					<small><fmt:formatDate value="${docReply.regDate }" pattern="yyyy-MM-dd hh:mm:ss"/></small>
				</div>
				<p class="mb-1">${docReply.content }</p>
			</li>
			</c:forEach>
			</ul>
			
			새 댓글 작성
			<form id="replyFrm" 
				action="${pageContext.request.contextPath}/document/docReply"
				method="post">
			<!-- no docNo writer content regDate -->
			<input type="hidden" name="docNo" value="${document.docNo}"/>
			<!-- writer:댓글작성자 loginMember.getId -->
			<input type="hidden" name="writer" value="1"/>
			<textarea class="form-control" name="content"></textarea>
			
			<button type="submit" id="replyBtn" class="btn btn-primary">댓글등록</button>
			</form>
		</div>
	</footer>
</section>

<script>

$("#docLineTable").each(function() {
    var $this = $(this);
    var newrows = [];
    $this.find("tr").each(function(){
        var i = 0;
        $(this).find("td").each(function(){
            i++;
            if(newrows[i] === undefined) { newrows[i] = $("<tr></tr>"); }
            newrows[i].append($(this));
        });
    });
    $this.find("tr").remove();
    $.each(newrows, function(){
        $this.append(this);
    });
});

$(document).ready(function(){       
    $('#approvalModal').on('hidden.bs.modal', function () {
        console.log("숨겨짐");
    });

	$("#save").click(function(event){
		//event.preventDefault();
		var maxAuthority = $("#maxAuthority").val();
		var lv = $("#lv").val();

		$("#docLineFrm").find("[name=maxAuthority]").val(maxAuthority);
		$("#docLineFrm").find("[name=lv]").val(lv);

	});
});
 

</script>

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
      <form 
      		id="docLineFrm"
      		action="${pageContext.request.contextPath}/document/docDetail"
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
      <%--원래 로그인한 사람 사번 제출. 여기선 홍길동=1 --%>
      <input type="hidden" name="approver" value="1"/>
      <input type="hidden" name="maxAuthority" value=""/>
      <input type="hidden" name="lv" value=""/>
      </form>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	