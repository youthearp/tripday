<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>


<div class="container" style="float: left; width: 400px; overflow:hidden; height:auto; margin-left: 10px;">
	<div class="col-sm-10">
		<h2>About Me</h2>
		<p>${principal.user.nickname}</p>
		<p>${principal.user.email }</p>
		<ul class="nav nav-pills flex-column">
			<li class="nav-item"><a class="nav-link active" href="#">Active</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="/user/prefer">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="/user/updateUser">비밀번호 수정</a></li>
		</ul>
	</div>
</div>
<div class="container" style="margin: auto;">
	<input type="hidden" value="${principal.user.id}" id="userId">
	<hr>
	<b>날짜 선택 : </b><input type="date" id="s_date-prefer">
	<button class="bt_css" onclick="location.reload();" style="height:33px; width:45px; font-size: 0.7em;">모든일정</button>
	<hr>
	<div class="col-sm-9">
	<c:forEach items="${prefers}" var="prefer">
      <h2>관광지 : ${prefer.title}</h2>
      <h5 >선택날짜 : ${prefer.s_date}</h5>
      <img alt="${prefer.title}" src="${prefer.img==''||prefer.img==null?res/img/unnamed.jpg:prefer.img}" style="width: 690px; height:460;">
      <p>주소 : ${prefer.addr}</p>
      <div class="ccc text-center" style="width:690px;">
      <button class="bt_css bt_black" id="btn-trip-detail" style="margin: 10px;">상세보기</button>
      <button class="bt_css" id="btn-trip-delete">삭제</button>
      <input type="hidden" value="${prefer.contentid}" id="contentid">
      <input type="hidden" value="${prefer.id}" id="id">
      <input type="hidden" value="${prefer.s_date}" id="s_date-select">
      </div>
      <hr>
	</c:forEach>
</div>
</div>

<script src="../res/js/tripInfo.js"></script>
<%@ include file="../layout/footer.jsp"%>
