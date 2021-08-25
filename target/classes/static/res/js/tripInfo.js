
let index = {
	init: function() {
		//날짜 선택 안하고 디테일 진입시 오늘 날짜 입력하여 날씨 출력
		$(".weather").ready(() => {
			let today = new Date();
			today = getFormatDate(today);
			if ($('#s_date-detail').val() < today.valueOf()) {
				$('#s_date-detail').val(today);
			}
			this.getWeather();
		});
		$("#s_date-detail").on("change", () => {
			this.getWeather();
		});
		
		//즐겨찾기 저장
		$("#btn-trip-save").on("click", () => { //function(){}, ()=>{} this를 바인딩하기 위해서 사용
			this.save();
		});
		//즐겨찾기 페이지 날짜 변경시 해당 날짜 목록 불러옴
		$("#s_date-prefer").on("change", () => {
			this.getList();
		});
		//즐겨찾기에서 상세보기 클릭시 디테일 페이지로 이동
		$("body").on("click", "#btn-trip-detail", function() {
			let contentid = $(this).closest('div').find('#contentid').val();
			let s_date = $(this).closest('div').find('#s_date-select').val();
			
			location.href = "/detail?currentPage=&areacode=&sigungucode=&arrange=R&numOfPage=&s_date="+s_date+"&contentid=" + contentid;
		});
		// 즐겨찾기 삭제
		$("body").on("click", "#btn-trip-delete", function() {
			let id = $(this).closest('div').find('#id').val();
			preferDelete(id);
		});
		
	},
	
	//즐겨찾기 저장
	save: function() {
		let data = {
			contentid: $("#contentid").val(),
			img: $("#img").val(),
			s_date: $("#s_date-detail").val(),
			title: $("#title").text(),
			addr: $("#addr").text()
		};
		if (data.s_date == 20) {
			alert('검색화면에서 날짜를 선택해 주세요.');
			return false;
		}
		$.ajax({
			type: "POST",
			url: "/user/prefer",
			data: JSON.stringify(data),
			contentType: "application/json;charset=utf-8",
			dataType: "json"
		}).done(function(resp) {
			alert("즐겨찾기 완료!");

		}).fail(function(error) {
			alert(JSON.stringify(error));
		}); //ajax 통신을 이용해서 3개의 데이터를 json 형식으로 받음 
	},
	
	//즐겨 찾기 목록 불러오기
	getList: function() {
		let data = {
			userId: $("#userId").val(),
			s_date: $("#s_date-prefer").val(),
		};

		$.ajax({
			type: "GET",
			url: "/user/prefer/" + data.userId + "/" + data.s_date,
			contentType: "application/json;charset=utf-8",
			dataType: "json"
		}).done(function(resp) {
			$('.col-sm-9').empty();
			$.each(resp, function(id, item) {
				$('.col-sm-9').append('<h2>관광지 : ' + item.title + '</h2>'
					+ '<h5>선택날짜 : ' + item.s_date + '</h5>'
					+ '<img alt="' + item.title + '" src="' + imgValdCheck(item.img) + '" style="width: 690px; height:460;">'
					+ '<p>주소 : ' + item.addr + '</p>'
					+ '<div class="text-center" style="width:690px;">'
					+ '<button class="bt_css bt_black" id="btn-trip-detail" style="margin:10px;">상세보기</button>'
					+ '<button class="bt_css" id="btn-trip-delete">삭제</button>'
					+ '<input type="hidden" value="' + item.contentid + '" id="contentid">'
					+'<input type="hidden" value="' + item.id + '" id="id">'
					+'<input type="hidden" value="${prefer.s_date}" id="s_date-select"><div><hr>'
				);
			});
		}).fail(function(error) {
			alert(JSON.stringify(error));
		}); //ajax 통신을 이용해서 3개의 데이터를 json 형식으로 받음 
	},
	
	//날짜 정보 등록
	getWeather: function() { 
		validCheck($("#s_date-detail").val()); //0~10일 내 날짜 체크
		let data = {
			areacode: $("#areacode").val(),
			s_date: $("#s_date-detail").val()
		};
		if (data.s_date == 20) {
			alert('날짜를 선택해 주세요.');
			return false;
		}
		$.ajax({
			type: "POST",
			url: "/search_date",
			data: JSON.stringify(data),
			contentType: "application/json;charset=utf-8",
			dataType: "json"
		}).done(function(resp) {
			$('.weather').empty();
			$('.weather').html('<div style="margin:auto; text-align:center;"><h3>' + resp.s_date + '<br>날씨 정보</h3>'
				+ '<img alt="날씨" src="' + imgValdCheck(resp.img) +   '"><b>'
				+ '<h3>' + resp.temp + '도</h3></div>');

		}).fail(function(error) {
			alert(JSON.stringify(error));
		});
	}
}

index.init();


//즐겨찾기 삭제
function preferDelete(id) {
	$.ajax({
		type: "DELETE",
		url: "/user/prefer/" + id
	}).done(function(resp) {
		alert("즐겨찾기 삭제 완료!");
		refreshMemList();
	}).fail(function(error) {
		alert(JSON.stringify(error));
	}); //ajax 통신을 이용해서 3개의 데이터를 json 형식으로 받음 
}

//이미지 체크
function imgValdCheck(img) {
	if (img == null || img == "") {
		img = "res/img/unnamed.jpg"
	}
	return img;
}

//즐겨찾기 삭제후 페이지 재 로딩
function refreshMemList() {
	location.reload();
}

//날짜 체크
function validCheck(s_date) {
	var today = new Date();
	var endDate = addDate(today, 10);
	endDate = getFormatDate(endDate);
	today = getFormatDate(today);
	if (s_date < today.valueOf()) {
		$('#s_date-detail').val(today);
		alert("오늘 날짜 이후를 선택하세요.");
	}
	if (s_date > endDate.valueOf()) {
		$('#s_date-detail').val(endDate);
		alert("오늘날짜 부터 10일 전까지 조회 가능합니다.");	
	}
	return true;
}
function getFormatDate(date) {
	var year = date.getFullYear();
	var month = (1 + date.getMonth());
	month = month >= 10 ? month : '0' + month;
	var day = date.getDate();
	day = day >= 10 ? day : '0' + day;
	return year + '-' + month + '-' + day;
}
function addDate(date, days) {
	var clone = new Date(date);
	clone.setDate(date.getDate() + days);
	return clone;
}