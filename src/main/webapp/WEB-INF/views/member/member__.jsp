<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="UPMU" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css" />
<body>
	<div class="login-wrap">
		<div class="login-html">
			<input id="tab-1" type="radio" name="tab" class="sign-in" checked>
			<label for="tab-1" class="tab" onclick="location.href=`${pageContext.request.contextPath}/member/memberLogin.do">Sign In</label>
			<input id="tab-2" type="radio" name="tab" class="sign-up">
			<label for="tab-2" class="tab" onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do">Sign Up</label>
			<div class="login-form">
				<div class="sign-in-htm">
					<div class="group">
						<label for="user" class="label" id="emp_no">사원아이디</label>
						<input id="user" type="text" class="input">
					</div>
					<div class="group">
						<label for="pass" class="label">사원비밀번호</label>
						<input id="pass" type="password" class="input" data-type="password">
					</div>
					<div class="group">
						<input id="check" type="checkbox" class="check" checked>
						<label for="check"> <span class="icon"></span> 아이디 저장
						</label>
					</div>
					<div class="group">
						<input type="submit" class="button" value="Sign In">
					</div>
					<div class="hr"></div>
					<div class="foot-lnk">
						<a href="#forgot">비밀번호를 잊어버리셨습니까?</a>
					</div>
				</div>




				<div class="sign-up-htm">
					<div class="group" id="emp__no">
						<label for="user" class="label" id="emp_no">사번</label>
						<input id="en_emp_no" type="text" class="input">
						<span class="guide ok">이 사번은 가능합니다.</span>
						<span class="guide error">사번이 중복됩니다.</span>
						<input type="hidden" id="inputValid" value="0" />
					</div>
					<div class="group">
						<label for="pass" class="label">사원비밀번호</label>
						<input id="password" type="password" class="input" data-type="password">
					</div>
					<div class="group">
						<label for="pass" class="label">비밀번호 재입력</label>
						<input id="passwordCheck" type="password" class="input" data-type="password">
					</div>
					<div class="group">
						<label for="pass" class="label">사원이름</label>
						<input id="emp_name" type="text" class="input">
					</div>
					<div class="group">
						<label for="pass" class="label">주소</label>
						<input id="emp_addr" type="text" class="input">
					</div>
					<div class="group">
						<label for="pass" class="label">이메일</label>
						<input id="emp_email" type="text" class="input">
					</div>

					<div class="group">
						<h3 class="join_title">
							<label for="yy" class="label">생년월일</label>
						</h3>
						<div id="bir_wrap">
							<!-- BIRTH_YY -->
							<div id="bir_yy">
								<span class="box">
									<input type="text" id="yy" class="int" maxlength="4" placeholder="년(4자)">
								</span>
							</div>

							<!-- BIRTH_MM -->
							<div id="bir_mm">
								<span class="box">
									<select id="mm" class="sel">
										<option>월</option>
										<option value="01">1</option>
										<option value="02">2</option>
										<option value="03">3</option>
										<option value="04">4</option>
										<option value="05">5</option>
										<option value="06">6</option>
										<option value="07">7</option>
										<option value="08">8</option>
										<option value="09">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</select>
								</span>
							</div>

							<!-- BIRTH_DD -->
							<div id="bir_dd">
								<span class="box">
									<input type="text" id="dd" class="int" maxlength="2" placeholder="일">
								</span>
							</div>

						</div>
						<span class="error_next_box"></span>
					</div>

					<div class="group">
						<label for="pass" class="label">입사일</label>
						<input id="emp_hiredate" type="text" class="input">
					</div>
					<div class="group">
						<label for="pass" class="label">부서</label>
						<input id="department" type="text" class="input">
					</div>
					<div class="hr"></div>
					<div class="group">
						<input type="submit" class="button" value="Sign Up">
					</div>
				</div>
			</div>
		</div>
	</div>
	<br />
	<br />
	<br />
	<script>
$(".en_emp_no").keyup(e => {
	const input = $(e.target).val();
	const $error = $(".guide.error");
	const $ok = $(".guide.ok");
	const $inputValid = $("#inputValid");

	if(en_emp_no.length < 4) {
		$(".guide").hide();
		$inputValid.val(0); // 다시 작성하는 경우 대비
		return;
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/checkemp_noDuplicate3.do",
		data: {input},
		success: (data) => {
			console.log(data);
			const {available} = data;
			if(available){
				$ok.show();
				$error.hide();
				$inputValid.val(1);
			}
			else {
				$ok.hide();
				$error.show();
				$inputValid.val(0);
			}
		},
		error: (xhr, statusText, err) => {
			console.log(xhr, statusText, err);
		}
	});
});
$("#passwordCheck").blur(function() {
	var $password = $("#password"), $passwordCheck = $("#passwordCheck");
	if($password.val() != $passwordCheck.val()){
		alert("비밀번호가 일치하지 않습니다.");
		$password.select();
	}
});
</script>

</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
