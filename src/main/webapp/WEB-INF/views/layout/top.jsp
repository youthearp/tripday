<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>trip</title>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
  Kakao.init('8849659343ca7bb9d223082835140186'); // 초기화

  function sendLink() { // 카카오톡 공유하기
    Kakao.Link.sendDefault({
      objectType: 'text',
      text: '여행&날씨정보',
      link: {
        
        webUrl: 'https://developers.kakao.com/docs/js/kakaotalklink#텍스트-템플릿-보내기',
      },
    })
  }

  </script>

</head>

<body>
	<div id="fb-root"></div>
	<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v11.0" nonce="JZAuzOIL"></script>
	
<!-- 	<div class="fb-share-button"  ><a target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Flocalhost%3A8085%2F&amp;src=sdkpreparse" class="fb-xfbml-parse-ignore"><img alt="페북" src="res/img/페북.png"></a></div> -->
	<div class="logoarea" style="width: 1200px; margin: 0 auto;">
				<!--S:Logo-->
		
				<!--//E:Logo-->
				<!--S:SNS버튼모음-->
		<ul class="sns_list" style="list-style: none; float: right;">

			<li class="sns-item"><a href="javascript:sendLink()"><img alt="인스타" src="res/img/카톡.png"></a></li>
			<li class="sns-item" data-href="http://localhost:8085/"><a onclick="window.open('https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Flocalhost%3A8085%2F&amp;src=sdkpreparse','name','resizable=no width=200 height=100');return false"><img alt="페북" src="res/img/페북.png"></a></li>
			

					<!--<li class="sns03"><a href="https://www.youtube.com/channel/UCuCBPZUAgFBX0J1EVnkuXPQ" target="_BLANK">고캠핑 공식유튜브</a></li>-->
		</ul>
		<h1 id="logo">
			<a href="/list"><img alt="로고" src="res/img/logo.png"></a>
		</h1>				
	</div>
</body>
</html>
