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

<div class="container" style="width: 500px;  margin-top: 220px; margin-bottom:220px;border: solid 1px blue; padding:30px; border-radius: 30px;">
	<form>
		<input type="hidden" id="id" value="${principal.user.id}" /> <%-- <input
			type="hidden" id="username" value="${principal.user.username}" />  --%>
		<input
			type="hidden" id="password" value="${principal.user.password}" />
		<div class="form-group">
			<label for="nickname">Nickname</label> <input type="text"
				value="${principal.user.nickname }" class="form-control"
				placeholder="Enter nickname" id="nickname">
		</div>


	</form>
	<button id="btn-nicknameUpdate" class="btn btn-primary">수정</button>

</div>

<script src="${R}/res/js/user.js"></script>

<%@ include file="../layout/footer.jsp"%>
