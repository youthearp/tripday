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
<div class="board_wrap">
	<div class="board_title">
		<strong>후기 게시판</strong>
	</div>
	<div class="board_view_wrap">
		<div class="board_view">
			<div class="title">${board.title}</div>
			<div class="info">
				<dl>
					<dt>번호</dt>
					<dd id = "id">${board.id}</dd>
				</dl>
				<dl>
					<dt>글쓴이</dt>
					<dd>${board.user.nickname}</dd>
				</dl>
				<dl>
					<dt>작성일</dt>
					<dd>${board.regDate}</dd>
				</dl>
				<dl>
					<dt>조회</dt>
					<dd>${board.boardCount }</dd>
				</dl>
			</div>
			<div class="cont">${board.content}</div>
		</div>

		<div style="margin-top: 30px">
			<c:if test="${board.user.id == principal.user.id}">
				<a href="/board/${board.id}/updateBoard" class="bt_css bt_black">수정</a>
				<button id="btn-delete" class="bt_css" data-confirm-delete>삭제</button>
			</c:if>
			<button class="bt_css" onclick="history.back()">돌아가기</button>
			<a href="/boardList?${pagination.queryString}" class="bt_css">목록으로</a>
		</div>
	</div>
</div>


<div class="board_sub">
	<div class="card-header" style="font-size: 14px">댓글 리스트</div>
	<ul id="reply-box" class="list-group">
		<c:forEach var="reply" items="${board.replys}">

			<li id="reply-${reply.id}"
				class="list-group-item d-flex justify-content-between">
				<div style="font-size: 14px;">${reply.content}</div>
				<div class="d-flex">
					<div class="font-italic" style = "font-size: 14px;">작성자 : ${reply.user.nickname} &nbsp;</div>
					<c:if test="${reply.user.id eq principal.user.id}">
						<button onClick="index.replyDelete(${board.id}, ${reply.id})"
							class="bt_css_small bt_black" data-confirm-delete>삭제</button>
					</c:if>

				</div>
			</li>

		</c:forEach>
	</ul>
</div>


<div class="board_sub">
	<form>
		<input type="hidden" id="userId" value="${principal.user.id}" /> <input
			type="hidden" id="boardId" value="${board.id}" />
		<div>
			<textarea id="reply-content"
				style="margin : auto; width: 1000px; height: 50px; resize: none; font-size: 12px;"></textarea>
		</div>
		<div class="cont" style = "text-align: right">
			<button type="button" id="btn-reply-save" class="bt_css_small">등록</button>
		</div>

	</form>
</div>



<script src="${R}/res/js/board.js"></script>

<%@ include file="../layout/footer.jsp"%>
