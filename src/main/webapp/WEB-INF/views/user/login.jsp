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
<sec:authorize access="isAuthenticated()">
	<script>
	alert("로그인 된 사용자");
	location.href = "/";
	</script>
</sec:authorize>
<sec:authorize access="not authenticated">.




<div class="container"
	style="width: 500px; margin-top: 220px; margin-bottom: 220px; border: solid 2px blue; padding: 30px; border-radius: 30px;">
	<form action="${R}login_processing" method="post">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<div class="form-group">
			<label for="username" style="font-size: 16px;">아이디</label> <input
				type="text" name="username" class="form-control"
				placeholder="Enter username" id="username">
		</div>

		<div class="form-group">
			<label for="password" style="font-size: 16px;">패스워드</label> <input
				type="password" name="password" class="form-control"
				placeholder="Enter password" id="password">
		</div>


		<button type="submit" class="btn btn-primary" style="width: 150px">로그인</button>
		<a href="/oauth2/authorization/google"><img height="37px"
			src="${R}/res/img/glogin.png" /></a>
	</form>

</div>
</sec:authorize>
<%@ include file="../layout/footer.jsp"%>

