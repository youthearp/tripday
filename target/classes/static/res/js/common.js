$(function() {
	$("[data-url]").click(function() {
		let url = $(this).attr("data-url");
		location.href = url;
	})
	$("[data-confirm-delete]").click(function() {
		return confirm("삭제하시겠습니까?");
	})
	$("[data-confirm-update]").click(function() {
		return confirm("수정하시겠습니까?");
	})
	$("[data-confirm-join]").click(function() {
		return confirm("회원가입을 진행하시겠습니까?");
	})
})
