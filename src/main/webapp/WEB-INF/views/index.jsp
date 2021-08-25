<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
</sec:authorize>
<!DOCTYPE HTML>
<!--
	Aerial by Pixelarity
	pixelarity.com | hello@pixelarity.com
	License: pixelarity.com/license
-->
<html>
	<head>
		<title>TripDay</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="res/css/main.css" />
		<noscript><link rel="stylesheet" href="res/css/noscript.css" /></noscript>
	</head>
	<body class="is-preload">
		<div id="wrapper">
			<div id="bg"></div>
			<div id="overlay"></div>
			<div id="main">

				<!-- Header -->
					<header id="header">
						<h1>Trip Day</h1>
						<p>ㄱㅎㅈ &nbsp;&bull;&nbsp; ㅈㄱㅎ &nbsp;&bull;&nbsp; ㅂㅇㅈ</p>
						<nav>
							<ul>
								<li><a href="/list" class="icon brands fa-galactic-republic"><span class="label">List</span></a></li>
								<c:if test="${empty principal.user}">
								<li><a href="/login" class="icon far fa-address-card"><span class="label">Login</span></a></li>
								<li><a href="/oauth2/authorization/google" class="icon brands fa-google"><span class="label">Google</span></a></li>
								</c:if>
								<li><a href="/boardList" class="icon brands fa-stack-exchange"><span class="label">Board</span></a></li>
								<li><a href="자기 깃허브 링크 넣으세요." class="icon brands fa-github"><span class="label">GibHub</span></a></li>
								<sec:authorize access="isAuthenticated()">
<li><a href="/logout_processing" class="icon brands fa-grav"><span class="label">Logout</span></a></li>
</sec:authorize>
								
								
								
								
							</ul>
					

						</nav>
					</header>
				<!-- Footer -->
					<footer id="footer">
						<span class="copyright">&copy; 2021 ㅂㅇㅈ|ㄱㅎㅈ|ㅈㄱㅎ. </span>
					</footer>

			</div>
		</div>
		<script>
			window.onload = function() { document.body.classList.remove('is-preload'); }
			window.ontouchmove = function() { return false; }
			window.onorientationchange = function() { document.body.scrollTop = 0; }
		</script>
	</body>
</html>