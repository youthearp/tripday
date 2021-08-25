
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>
<%-- <head>
	<meta name="_csrf" content="${_csrf.token}"/>
	<!-- default header name is X-CSRF-TOKEN -->
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<!-- ... -->
</head>
<script>
$(function () {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(header, token);
	});
	});

</script> --%>
<script src="${R}/res/js/common.js"></script>
<sec:authorize access="isAuthenticated()">
	<script>
	alert("로그인 된 사용자");
	location.href = "/";
	</script>
</sec:authorize>
<sec:authorize access="not authenticated">

<div class="container" style="width: 500px;  margin-top: 90px; margin-bottom: 90px; border: solid 2px blue; padding:30px; border-radius: 30px;">
	<div class="board_title">
		<strong style="font-size: 38px">회원 가입</strong>
	</div>
	<form:form method="post" id="regi" modelAttribute="userRegistration" acceptCharset="UTF-8">
		<div class="form-group" style="margin: 25px 10px;">
			<div class="label" style="font-size: 18px;">아이디</div>
			<form:input class="form-control" path="username" />
			<form:errors path="username" class="error" />
		</div>
		<div class="form-group" style="margin: 25px 10px;">
			<div class="label" style="font-size: 18px;">비밀번호</div>
			<form:password class="form-control" path="passwd1" />
			<form:errors path="passwd1" class="error" />
		</div>
		<div class="form-group" style="margin: 25px 10px;">
			<div class="label" style="font-size: 18px;">비밀번호 확인</div>
			<form:password class="form-control" path="passwd2" />
			<form:errors path="passwd2" class="error" />
		</div>
		<div class="form-group" style="margin: 25px 10px;">
			<div class="label" style="font-size: 18px;">닉네임</div>
			<form:input class="form-control" path="nickname" />
			<form:errors path="nickname" class="error" />
		</div>
		<div class="form-group" style="margin: 25px 10px;">
			<div class="label" style="font-size: 18px;">이름</div>
			<form:input class="form-control" path="name" />
			<form:errors path="name" class="error" />
		</div>
		<div class="form-group" style="margin: 25px 10px;">
			<div class="label" style="font-size: 18px;">이메일</div>
			<form:input class="form-control" path="email" />
			<form:errors path="email" class="error" />
		</div>


	  <button type="submit" class="btn btn-primary" style="width: 130px;" data-confirm-join>회원가입</button>
      <a href="${R}" class="btn btn-secondary" style="width: 130px;">취소</a>
	</form:form>

</div>

</sec:authorize>
<%@ include file="../layout/footer.jsp"%>
