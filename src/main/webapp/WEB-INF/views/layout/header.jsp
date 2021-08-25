<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<!DOCTYPE html>
<html lang="en">
<head>

<title>날씨</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<link rel="stylesheet" href="${R}/res/boardcss.css">
<link rel="stylesheet" href="${R}/res/trip.css">
<link rel="stylesheet" href="${R}/res/common.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script defer
	src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	integrity="sha384-haqrlim99xjfMxRP6EWtafs0sB1WKcMdynwZleuUSwJR0mDeRYbhtY+KPMr+JL6f"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">

<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light"
		style="height: 35px;">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button"
				data-mdb-toggle="collapse" data-mdb-target="#navbarExample01"
				aria-controls="navbarExample01" aria-expanded="false"
				aria-label="Toggle navigation">
				<i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarExample01">
				<c:choose>
					<c:when test="${empty principal}">
						<ul class="navbar-nav ml-auto mb-2 mb-lg-0">
							<li class="nav-item"><a class="nav-link" href="/login">login</a>
							</li>
							<li class="nav-item"><a class="nav-link" href="/register">register</a>
							</li>
						</ul>
					</c:when>
					<c:otherwise>
						<ul class="navbar-nav ml-auto mb-2 mb-lg-0">
							<li class="nav-item"><a class="nav-link"
								href="${R}/user/updateNick">modNickname</a></li>
							<li class="nav-item"><a class="nav-link"
								href="${R}/user/updateUser">modPasswoard</a></li>
							<li class="nav-item"><a class="nav-link"
								href="/logout_processing">logout</a></li>
						</ul>
					</c:otherwise>
				</c:choose>

			</div>
		</div>
	</nav>
	<nav class="navbar navbar-expand-md bg-info navbar-dark"
		style="height: 100px;">
		<a class="navbar-brand " href="/"
			style="margin-left: 50px; margin-right: 50px;">여행</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">

			<c:choose>
				<c:when test="${empty principal}">
					<ul class="navbar-nav">
						<li class="nav-item"
							style="margin-left: 25px; margin-right: 25px;"><a
							class="nav-link" href="/list">TourList</a></li>
						<li class="nav-item"
							style="margin-left: 25px; margin-right: 25px;"><a
							class="nav-link" href="/boardList">후기게시판</a></li>
					</ul>
				</c:when>
				<c:otherwise>
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link"
							href="/board/boardwrite">후기 작성</a></li>
						<li class="nav-item"
							style="margin-left: 25px; margin-right: 25px;"><a
							class="nav-link" href="/user/prefer">마이페이지</a></li>
						<li class="nav-item"
							style="margin-left: 25px; margin-right: 25px;"><a
							class="nav-link" href="/list">TourList</a></li>
						<li class="nav-item"
							style="margin-left: 25px; margin-right: 25px;"><a
							class="nav-link" href="/boardList">후기게시판</a></li>
					</ul>
				</c:otherwise>
			</c:choose>

		</div>
		
	</nav>
	<br />