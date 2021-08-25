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
<div class="board_wrap">
<form>
	<div class="board_title">
		<strong>후기 게시판</strong>
	</div>
	<div class="board_write_wrap">
		<div class="board_write">
			<div class="title">
				<dl>
					<dt>제목</dt>
					<dd>
						<input type="text" placeholder="제목 입력" id="title">
					</dd>
				</dl>
			</div>

			<div class="form-group">
				<textarea class="form-control summernote" rows="5" id="content"></textarea>
			</div>
		</div>

	</div>
	<div class="bt_wrap">
	<button id="btn-save" class="bt_css bt_black">등록</button>
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