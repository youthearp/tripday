
let index = {
		init: function(){

			$("#btn-update").on("click", ()=>{ // function(){} , ()=>{} this를 바인딩하기 위해서!! 
				this.update();
			});
			$("#btn-nicknameUpdate").on("click", ()=>{ 
				this.updateNickname();
			});
		},


		
		update: function(){
			//alert('user의 save함수 호출됨');
			let data = {
					id: $("#id").val(),
					username: $("#username").val(),
					password: $("#password").val(),
					email: $("#email").val()
			};
			console.log(password)
			$.ajax({ 
				type: "PUT",
				url: "/user",
				data: JSON.stringify(data), // http body데이터
				contentType: "application/json; charset=utf-8",// body데이터가 어떤 타입인지(MIME)
				dataType: "json" // 요청을 서버로해서 응답이 왔을 때 기본적으로 모든 것이 문자열 (생긴게 json이라면) => javascript오브젝트로 변경
			}).done(function(resp){
				alert("회원수정이 완료되었습니다.");
				//console.log(resp);
				location.href = "/";
			}).fail(function(error){
				alert(JSON.stringify(error));
			}); 
			
		},
		updateNickname: function(){
			let data = {
					id: $("#id").val(),
					password: $("#password").val(),
					nickname: $("#nickname").val()
			};
			console.log(data);
			$.ajax({ 
				type: "PUT",
				url: "/usernick",
				data: JSON.stringify(data), // http body데이터
				contentType: "application/json;charset=utf-8",// body데이터가 어떤 타입인지(MIME)
				dataType: "json" // 요청을 서버로해서 응답이 왔을 때 기본적으로 모든 것이 문자열 (생긴게 json이라면) => javascript오브젝트로 변경
			}).done(function(resp){
				console.log(resp.status);
							
				alert("닉네임 등록이 완료되었습니다.");
				location.href = "/";
				
			}).fail(function(error){
				alert(JSON.stringify(error));
				console.log(error);
			}); 
		},
}

index.init();