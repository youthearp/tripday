<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="layout/header.jsp"%>

<%@ include file="layout/top.jsp"%>

<script defer src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" integrity="sha384-haqrlim99xjfMxRP6EWtafs0sB1WKcMdynwZleuUSwJR0mDeRYbhtY+KPMr+JL6f" crossorigin="anonymous"></script>
<script type="text/javascript">
	//사용자 목록 조회 요청
	$(function() {
		tripList(${page.currentPage}, '${areacode}', '${sigungucode}', '${arrange}', ${numOfPage},'${s_date}');
		currentState();
	});
	
	function tripList(pageNo,areacode,sigunguCode, arrange, numOfPage, s_date) {
		var list = new Array();
		//관광지 api
		$.ajax({
					url : 'http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey=jiMuTvx6cLYWRrR2EKwGefsF3O966xEpgeU0UcEsuAtfzmtXVsG8pHw3JYK4uSUv6kgWiHX77rZDdjMnNaWRXQ%3D%3D'
							+ '&pageNo='+pageNo
							+ '&numOfRows='+numOfPage
							+ '&MobileApp=test'
							+ '&MobileOS=ETC'
							+ '&arrange='+arrange
							+ '&contentTypeId=12'
							+ '&areaCode='+areacode
							+ '&sigunguCode='+sigunguCode
							+ '&listYN=Y'
							+ '&_type=json',
					type : 'GET',
					dataType : 'json',
					error : function(xhr, status, msg) {
						alert("상태값 :" + status + " Http에러메시지 :" + msg);
					},
					success : function(response) {
						response = response.response.body.items.item;
						tripListResult(response);
						weather(response);
					}
				});
		function weather(result){
		if(s_date !='' && s_date != "20"){
			
			var cnt = 0;
			for(var i=0; i<result.length;i++){
			//날씨 api
			$.ajax({
				
				url : 'search_date',
				type : 'post',
				dataType : 'json',
				data : JSON.stringify({areacode : result[i].areacode, s_date : s_date}),
				contentType:'application/json',
				error : function(xhr, status, msg) {
					alert("상태값 :" + status + " Http에러메시지 :" + msg);
				},
				success : function(response) {
					list.push(response);
					if(cnt == result.length-1){
					weatherListResult(list);
					}
					cnt = cnt +1;
				}
			});
				}
			}
		}
	}
	
	//리스트 관광지 정보	출력
	function tripListResult(response) {
		$("ul.imgList").empty();
		$.each(
						response,
						function(id, item) {
							$('<li>')
									.append($('<div class="selectChek">'))
									.append(
											$('<a href="detail?currentPage=${currentPage}&areacode=${areacode}&sigungucode=${sigungucode}&arrange=${arrange}&numOfPage=${numOfPage}&s_date=${s_date}'
													+'&contentid='+ item.contentid
													+ '">'
													+ '<img alt="'+item.title+'" src="'+resize(imgValdCheck(item.firstimage))+'"/>'
													+ '<dl>' + '<dt>'
													+ item.title + '</dt>'
													+ '<dd>' + '<p>'
													+ textValdCheck(item.addr1)
													+ '</p><hr><div class="weather"></div>'
													+ '</a>'))
									.appendTo('ul.imgList');

						});//each
		
	}
	//리스트 날씨 출력
	function weatherListResult(response) {
		$('.weather').each(function(i, element) {
			$(element).html('<b>날씨</b></br><img alt="날씨" src="'+imgValdCheck(response[i].img)+'" style="height: 40px; width: 50px;"><strong>'+textValdCheck(response[i].temp)+'</strong>');
		});//each
		
	}
	//검색 조건
	function areaCode(code, vald) {
		$.ajax({
					url : 'http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?serviceKey=jiMuTvx6cLYWRrR2EKwGefsF3O966xEpgeU0UcEsuAtfzmtXVsG8pHw3JYK4uSUv6kgWiHX77rZDdjMnNaWRXQ%3D%3D'
							+ '&numOfRows=30'
							+ '&pageNo=1'
							+ '&MobileOS=ETC'
							+ '&MobileApp=AppTest'
							+ '&areaCode='+code
							+ '&sigungucode='
							+ '&_type=json',
					type : 'GET',
					dataType : 'json',
					error : function(xhr, status, msg) {
						alert("상태값 :" + status + " Http에러메시지 :" + msg);
					},
					success : function(response) {
						response = response.response.body.items.item;
						locationCode(response, vald);
					}
				});
	}
	function locationCode(response, vald) {
		$("#sigungucode").empty();
		$("#sigungucode").append($('<option value="">시군구 선택</option>'));
		if(response.length != undefined){
		$.each(response, function(id, item) {
			$('#sigungucode').append(
					$('<option value="'+item.code+'">' + item.name
							+ '</option>'));
		});//each	
		if(vald != null){
		$('#sigungucode > option[value="${sigungucode}"]').attr('selected', true);
			}	
		}
	}
	//현재 정보 저장 (날짜, 선택지역 등)
	function currentState(){
		$('#areacode > option[value="${areacode}"]').attr('selected', true);
		areaCode('${areacode}','a');
		$('option[value="${arrange}"]').attr("selected","selected");
		$('option[value="${numOfPage}"]').attr("selected","selected");
		$('#s_date').val('${s_date}');
		}
	function textValdCheck(txt) {
		if (txt == null || txt == 'undefine') {
			txt = "";
		}
		return txt;
	}
	function imgValdCheck(img){
		if(img == null || img ==""){
			img = "/res/img/unnamed.jpg"
			}
		return img;
		}
	
    //날씨 조회 가능 날짜 제한
	function validCheck(){
		var frm = document.frm;
		var today = new Date();
		var endDate = addDate(today, 10);
		endDate = getFormatDate(endDate);
		today = getFormatDate(today);
		if (frm.s_date.value.valueOf() < today.valueOf()) {
			$('#s_date').val(today);
			alert("오늘 날짜 이후를 선택하세요.");
			return;
		}
		if (frm.s_date.value.valueOf() > endDate.valueOf()) {
			$('#s_date').val(endDate);
			alert("오늘날짜 부터 10일 전까지 조회 가능합니다.");
			return;
		}
		frm.submit();
}
	function getFormatDate(date) {
		var year = date.getFullYear();
		var month = (1 + date.getMonth());
		month = month >= 10 ? month : '0' + month;
		var day = date.getDate();
		day = day >= 10 ? day : '0' + day;
		return year + '-' + month + '-' + day;
	}
	function addDate(date, days){
		var clone = new Date(date);
		clone.setDate(date.getDate()+days);
		return clone;
		}
	function resize(img){
		   // 원본 이미지 사이즈 저장
		   var width = img.width;
		   var height = img.height;

		   // 가로, 세로 최대 사이즈 설정
		   var maxWidth = 200;   // 원하는대로 설정. 픽셀로 하려면 maxWidth = 400
		   var maxHeight = 180;   // 원래 사이즈 * 0.5 = 50%
		   // 가로나 세로의 길이가 최대 사이즈보다 크면 실행
		   if(width > maxWidth || height > maxHeight){
		      // 가로가 세로보다 크면 가로는 최대사이즈로, 세로는 비율 맞춰 리사이즈
		      if(width > height){
		         resizeWidth = maxWidth;
		         resizeHeight = Math.Round((height * resizeWidth) / width);

		      // 세로가 가로보다 크면 세로는 최대사이즈로, 가로는 비율 맞춰 리사이즈
		      }else{
		         resizeHeight = maxHeight;
		         resizeWidth = Math.Round((width * resizeHeight) / height);
		      }

		   // 최대사이즈보다 작으면 원본 그대로
		   }else{
		      resizeWidth = width;
		      resizeHeight = height;
		   }
		   img.width = resizeWidth;
		   img.height = resizeHeight;
		 return img;
		}

</script>
	<section id="content"
		style="display: block; position: relative; width: 1200px; margin: 0 auto;">

		<div class="tableWrap"></div>
		<form action="list" method="get" name="frm" >
			<table class="bbsSearch" style="boarder: 0px; margin: auto; width:800px;" >
				<colgroup>
					<col style="width: 95px;">
					<col style="width: 861px!impotant;">
				</colgroup>

				<tbody>
					<tr>
						<th>날짜</th>
						<td><input type="date" id="s_date" name="s_date"></td>
						<th>지역</th>

						<td><select title="지역선택" name="areacode" id="areacode"
							onchange="areaCode(this.value);">
								<option value="" selected="selected">지역선택</option>
								<option value="1">서울</option>
								<option value="2">인천</option>
								<option value="3">대전</option>
								<option value="4">대구</option>
								<option value="5">광주</option>
								<option value="6">부산</option>
								<option value="7">울산</option>
								<option value="8">세종특별자치시</option>
								<option value="31">경기도</option>
								<option value="32">강원도</option>
								<option value="33">충청북도</option>
								<option value="34">충청남도</option>
								<option value="35">경상북도</option>
								<option value="36">경상남도</option>
								<option value="37">전라북도</option>
								<option value="38">전라남도</option>
								<option value="39">제주도</option>
						</select> <select name="sigungucode" id="sigungucode" title="시군구선택">
								<option value="">시군구 선택</option>
						</select></td>
						<td><input type="button" value="검색" class="btn btn-secondary" style="width: 100px;" onclick="validCheck()"></td>
					</tr>
				</tbody>
			</table>

			<div class="searchUtill">
				<p>
					<strong>총 데이터 수</strong><span id="number">${page.totalCount}</span>개
				</p>
				<div>
					<select name="arrange" id="arrange" title="정렬항목 선택">
						<option value="R" >최신순</option>
						<option value="O">제목순</option>
						<option value="P" selected>인기순</option>
					</select> <input type="image" id="arrangeView" src="/res/img/show.png" alt="보기" style="width: 30px;"> <select
						name="numOfPage" id="numOfPage" title="정렬개수 선택">
						<option value="10" selected>10개씩 보기</option>
						<option value="20" >20개씩 보기</option>
						<option value="30">30개씩 보기</option>
						<option value="40">40개씩 보기</option>
						<option value="50">50개씩 보기</option>
					</select> <input type="image" id="numOfPageView" src="/res/img/show.png" alt="보기" style="width: 30px;">
				</div>
			</div>
		</form>
		<div class="listWrap">
			<ul class="imgList">
			</ul>
		</div>

		<div style="text-align: center;">
			<a class="pagenum"
				href="?currentPage=1&areacode=${areacode}&sigungucode=${sigungucode}&arrange=${arrange}&numOfPage=${numOfPage}&s_date=${s_date}">&lt;&lt;</a>
			<!-- 요청url은 동일하고 파라미터만 변경됩니다. -->
			<a class="${page.startPage>1? 'pagenum':'none'}"
				href="?currentPage=${page.startPage-1}&areacode=${areacode}&sigungucode=${sigungucode}&arrange=${arrange}&numOfPage=${numOfPage}&s_date=${s_date}">&lt;</a>
			<!-- 현재페이지값을 변경 : blists.getStartPage() -1 -->

			<c:forEach var="i" begin="${page.startPage }" end="${page.endPage}">
				<!-- 페이지목록의 범위  -->
				<a class="pagenum"
					href="javascript:tripList(${i}, '${areacode}', '${sigungucode}', '${arrange}', ${numOfPage},'${s_date}');">${i}</a>
				<!-- 현재페이지 i값으로 변경  -->
			</c:forEach>

			<!-- 현재페이지값을 변경 : blists.getEndPage() +1 -->
			<a class="${page.endPage!=page.totalPage? 'pagenum':'none'}"
				href="?currentPage=${page.endPage+1}&areacode=${areacode}&sigungucode=${sigungucode}&arrange=${arrange}&numOfPage=${numOfPage}&s_date=${s_date}">&gt;</a>
			<a class="pagenum"
				href="?currentPage=${page.totalPage}&areacode=${areacode}&sigungucode=${sigungucode}&arrange=${arrange}&numOfPage=${numOfPage}&s_date=${s_date}">&gt;&gt;</a>
		</div>
	</section>
	<a href = "" class ="go_top">
			<i class="fas fa-arrow-up"></i>
		</a>

<%@ include file="layout/footer.jsp"%>