<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title"/>
</jsp:include>
<body>

 <div class="sign-wrap">
    <div class="sign_up">Sign</div>
    <div class="sign_up_">Up</div>
    <div class="sign-in-html">
      <div class="sign-form">
        <div class="sign-up-htm">
         <form action="${pageContext.request.contextPath}/employee/empEnroll.do" name="form" id="form" method="post">
          <div class="emp_email">
            <label for="emp_email" class="emp_email_">이메일</label>
            <input id="emp_email" name="empEmail" type="text" class="emp_email_input" required>
            <span class="guide ok" style="display: none;">이 이메일은 사용가능합니다.</span>
            <span class="reg error" style="display: none;">유효한 이메일 주소가 아닙니다.</span>
            <span class="guide error" style="display: none;">이메일이 중복됩니다.</span>
            <input type="hidden" id="idValid" value="0"/>
          </div>
          <div class="emp_pw">
            <label for="emp_pw" class="emp_pw_">비밀번호</label>
            <input id="emp_pw" name="empPw" type="password" class="emp_pw_input" required>
            <span class="pwError1" style="display: none;">비밀번호는 최소 8자, 최소 하나의 문자, 숫자 및 특수 문자 포함입니다.</span>
            <input type="hidden" id="pwValid" value="0"/>
          </div>
          <div class="emp_pw_re">
            <label for="re_emp_pw_check" class="emp_pw_re_">비밀번호확인</label>
            <input id="re_emp_pw_check" type="password" class="emp_pw_re_input" required>
            <span class="pwError2" style="display: none;">비밀번호를 확인해주세요.</span>
            
          </div>
          <div class="emp_name">
            <label for="emp_name" class="emp_name_">이름</label>
            <input id="emp_name" name="empName" type="text" class="emp_name_input" required>
          </div>
          <div class="emp_phone">
            <label for="emp_phone" class="emp_phone_">휴대폰</label>
            <input id="emp_phone" name="empPhone" type="text" class="emp_phone_input" placeholder="(-없이)01012345678" required>
          </div>
         
	          <div class="emp_addr">
	            <label for="emp-addr" class="emp_addr_">주소</label>
	            <img src="https://pics.gmkt.kr/pc/ko/myg/find_address.png" alt="주소찾기" class="addr-search" class="addr-search" onclick="jusoPop();">
	            <input id="zipNo" name="zipNo" type="text" class="emp_addr_input" readonly>
	            <input id="roadAddrPart1" name="roadAddrPart1" type="text" class="emp_addr_input2" readonly>
	            <input id="addrDetail" name="addrDetail" type="text" class="emp_addr_input2" placeholder="상세주소">
	            <input id="roadFullAddr" type="hidden" name="empAddr" value="테스트용">
	          </div>
          
          <div class="emp_birth">
              <label for="emp-birth" class="emp_birth_">생년월일</label>
            <input id="emp-birth" type="date" name="empBirth" class="birth" required>
          </div>
          <div class="hr"></div>
          <div class="sign_up_button">
            <input type="submit" class="sign_up_button_" value="Sign Up">
          </div>
          </form>
        </div>
      </div>
    </div>
  </div>
<script>
//css 동적 추가
var cssUrl = "${pageContext.request.contextPath}/resources/css/index.css";
var head = document.getElementsByTagName("head")[0];
var link = document.createElement("link");
link.rel = "stylesheet";
link.type = "text/css";
link.href = cssUrl;
document.head.appendChild(link);
cssUrl = "${pageContext.request.contextPath}/resources/css/empEnroll.css";
link.href = cssUrl;
document.head.appendChild(link);

function jusoPop(){
	var pop = window.open("${pageContext.request.contextPath}/employee/jusoPopup.do","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}

function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, 
		rnMgtSn, bdMgtSn , detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, 
		buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo){
		 document.form.roadFullAddr.value = roadFullAddr;
		 document.form.roadAddrPart1.value = roadAddrPart1;
		 document.form.addrDetail.value = addrDetail;
		 document.form.zipNo.value = zipNo;
}



//아이디 유효성 검사
$("#emp_email").keyup(e => {
	const id = $(e.target).val();
	const $error = $(".guide.error");
	const $regError = $(".reg.error");
	const $ok = $(".guide.ok");
	const $idValid = $("#idValid"); // 0 -> 1(중복검사 성공시)

	var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		/* /^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i; */

	if(id.length < 4 && id.indexOf("@")) {
		$regError.hide();
		$ok.hide();
		return;
	}
	else {
		if(!regEmail.test(id)){
			$error.hide();
			$ok.hide();
			$idValid.val(0);
			$regError.show();
			console.log("비유효");
			return;
		}
		$regError.hide();
	}
	$.ajax({
		url: "${pageContext.request.contextPath}/employee/checkIdDuplicate.do",
		data: {id},
		success: (data) => {
			console.log(data);
			const {available} = data;
			if(available){
				$error.hide();
				$idValid.val(1);
				$ok.show();
			}
			else {
				$ok.hide();
				$idValid.val(0);
				$error.show();
			}
		},
		error: (xhr, statusText, err) => {
			console.log(xhr, statusText, err);
		}
	});
});

//비밀번호 유효성 검사
const $pwValid = $("#pwValid");

$("#emp_pw").keyup(e => {
	const pw = $(e.target).val();
	console.log(pw);
	const $pwError2 = $(".pwError2");
	const $pwError1 = $(".pwError1");

	var regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
	
	if(pw.length < 8) {
		$pwError1.show();
		return;
	}
	else {
		if(!regPw.test(pw)){
			$pwError1.show();
			$pwValid.val(0);
			return;
		}
		$pwError1.hide();
	}
});
//비밀번호 확인
$("#re_emp_pw_check").blur(function(){
	var $password = $("#emp_pw"), $passwordCheck = $("#re_emp_pw_check");
	if($password.val() != $passwordCheck.val()){
		$(".pwError2").show();
		$("#re_emp_pw_check").val('');
		$password.select();
	}
	else {
		$pwValid.val(1);
		$(".pwError2").hide();
	}
});

$("#signUp").submit(function(){
	console.log("asdasdasd");
});
</script>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>