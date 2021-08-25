<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>
<script src="${R}/res/js/common.js"></script>
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

</script>
 --%>
<div class="board_wrap">
	<form>

		<input type="hidden" id="id" value="${board.id}" />
		<div class="board_title">
			<strong>후기 게시판</strong>
		</div>
		<div class="board_write_wrap">
			<div class="board_write">
				<div class="title">
					<dl>
						<dt>수정</dt>
						<dd>
							<input type="text" value = "${board.title}" placeholder="제목 입력" id="title">
						</dd>
					</dl>
				</div>

				<div class="form-group">
					<textarea class="form-control summernote" rows="5" id="content">${board.content}</textarea>
				</div>
			</div>

		</div>
	<div class="bt_wrap">
	<button id="btn-update" class="bt_css bt_black" data-confirm-update>수정</button>
	<a onclick="history.back();" class="bt_css">취소</a>
	</div>
	</form>

</div>
<script src="${R}/res/js/board.js"></script>
<script>
	$('.summernote').summernote({
		tabsize : 2,
		height : 300
	});
</script>
<%@ include file="../layout/footer.jsp"%>
