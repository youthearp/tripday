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
<h1 id="logo" style="margin-top: 20px; margin-bottom: 20px;">
	<a href="/list"><img alt="로고" src="${R}/res/img/logo.png"></a>
</h1>
<div class="tableWrap"></div>
<%-- 		<c:if test="${empty principal.user.nickname}">
			<script>
				location.href = "user/nicknameRegister";
			</script>
		</c:if> --%>
<div class="board_wrap" style="margin-top: 30px;">
	<div class="board_title">
		<strong>후기 게시판</strong>

	</div>
	<div style="margin: 20px; margin-left: 900px;">
		<form action="/board/search" method="GET">
			<div class="btn-group" role="group" aria-label="Basic example">
				<input name="keyword" type="text" placeholder="검색어를 입력해주세요">
				<button class="btn btn-secondary">검색</button>
			</div>
		</form>
	</div>
	<div class="board_list_wrap">
		<div class="board_list">
			<div class="top">
				<div class="num">번호</div>
				<div class="title">제목</div>
				<div class="writer">글쓴이</div>
				<div class="date">작성일</div>
				<div class="count">조회</div>
			</div>

			<c:forEach var="board" items="${boards}">
				<%-- 			<div class="card m-2">
				<div class="card-body">
					<h4 class="card-title">${board.title}</h4>
					<a href="/board/${board.id}" class="btn btn-primary">상세보기</a>
				</div>
			</div> --%>
				<div>
					<div class="num">${board.id}</div>
					<div class="title">
						<a href="/board/${board.id}">${board.title}</a>
					</div>
					<div class="writer">${board.user.nickname}</div>
					<div class="date">${board.regDate}</div>
					<div class="count">${board.boardCount }</div>
				</div>

			</c:forEach>

		</div>
	</div>


</div>
<script src="${R}/res/js/board.js"></script>
<%@ include file="../layout/footer.jsp"%>