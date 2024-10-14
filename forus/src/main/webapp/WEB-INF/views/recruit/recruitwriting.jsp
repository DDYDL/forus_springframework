<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Help요청 작성하기</title>
<!-- 부트스트랩 네비게이션 바 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 캘린더 라이브러리 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<!-- 카카오 주소 검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- css 파일 -->
<link href="./resources/css/recruit/recruitwriting.css?after" rel="stylesheet" type="text/css">
<link href="./resources/css/recruit/calendar.css?after" rel="stylesheet" type="text/css">
</head>
<style>
.helpus {
	font-weight: bold;
	color: #03C75A;
}
</style>
<body>
	<%@ include file="../header.jsp" %>
	
	<div class="content-list">
		<form action="recruitWriting" method="post">
    		<p class="content-title">구인 등록</p>
			<br>
			<p class="content-inner-title">해당하는 동물을 선택해주세요</p>
    		<!-- 동물 프로필 가져오기 -->
    		<div class="box"><table id="pet_profile" class="pet_profile"></table></div>
			<br>
			<p class="content-inner-title">조건 설정</p>
		    <div class="box">
		    	<table class="setting">
		    		<tr>
			    		<td class="setting_td1"><label for="paytype">급여형태</label></td>
			    		<td class="setting_td2"><select name="post_form" id="paytype">
			            	<option value="시급">시급</option>
			            	<option value="일급">일급</option>
			        	</select></td>
			        	<!-- 캘린더 로드 -->
			    		<td class="setting_td1"><label class="form-label" for="dayOfTheWeek">날짜</label></td>
			    		<td class="setting_td2"><div id="calendar" class="col-6"><input class="form-control" id="dayOfTheWeek" name="post_date" type="text"></div></td>
			    	</tr>
			    	<tr>
			    		<td class="setting_td1"><label for="pay">급여</label></td>
			    		<td class="setting_td2"><input type="text" name="post_pay" id="pay">&nbsp;원</td>
			    		
			    		<td class="setting_td1"><label for="time">시간</label></td>
			    		<td class="setting_td2"><input type="time" class="time_start" id="timepicker" name="post_start_time">&nbsp;~&nbsp;<input type="time" class="time_end" id="timepicker" name="post_end_time"></td>
			    	</tr>
		    	</table>
		    </div>
			<br>
		    <p class="content-inner-title">위치</p>
		    <!-- 검색바 -->
		    <div class="address_search">
		    <nav class="navbar navbar-expand-sm">
		        <div class="container-fluid">
		            <div class="collapse navbar-collapse" id="mynavbar">
		                <button class="btns" type="button" onclick="daumPostcode()"><img src="./resources/img/search.png" style="width:20px;height:20px"></button>
		                <input id="address" class="form-control me-2" type="text" name="post_address" placeholder="지역명 검색">
		            </div>
		        </div>
		    </nav>
		    </div>
		    
		    <!-- 카카오 주소 검색 API -->
		    <script>
		    	function daumPostcode() {
		    		new daum.Postcode({
		    			oncomplete: function(data) {
		    				var roadAddr = data.roadAddress;
		    				var extraRoadAddr = '';
		    				
		    				// 참고 항목 변수를 설정한다
		    				// ~동/로/가 로 끝나는 주소 넣기
		    				if(data.bulidingName !== '' && /[동|로|가]$/g.test(data.bname)) {
		    					extraRoadAddr += data.bname;
		    				}
		    				// 빌딩, 아파트 이름 넣기
		    				if(data.buildingName !== '' && data.apartment === 'Y'){
		    	                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		    	            }
		    				// 참고 항목이 있으면 괄호 안에 넣는다.
		    				if(extraRoadAddr !== ''){
		                        extraRoadAddr = ' (' + extraRoadAddr + ')';
		                    }
		    				// 선택한 주소를 필드에 넣는다.
		                    document.getElementById("address").value = roadAddr + extraRoadAddr;
		    			}
		    		}).open();
		    	}
		    </script>
		    
			<br>
		    <p class="content-inner-title">제목</p>
		    <div>
		        <input type="text" class="title" name="post_title" placeholder="제목을 입력하세요">
		    </div>
			<br>
		    <p class="content-inner-title">내용</p>
		    <div>
		        <textarea name="post_content" class="textarea" cols="50" rows="10" placeholder="내용을 입력하세요"></textarea>
		    </div>
		    <br>
		    <div class="btndiv"><input type="submit" class="button btnPush btnBlueGreen" value="등록"/></div>
		    <br><br>
	    </form>
	</div>
	    
	<script>
		flatpickr("#dayOfTheWeek", {
			"locale": "ko", // 한국어 설정
			"enableTime": false, // 시간 선택 비활성화
			"dateFormat": "m/d(D)", // 요일 형식 설정 (요일만 출력) - 달력을 선택하면 요일로
			"inline": false, // 페이지 로드 시 자동으로 표시 안 함
			"mode" : "multiple",
			"minDate": "today"
		});
		
		flatpickr("#timepicker", {
			noCalendar: true,
			allowInput:true, // 직접 입력 허용
			enableTime: true, // 시간 사용
			dateFormat: "H:i",
		    time_24hr: true,
			defaultHour: 12,
			defaultMinute: 0,
		});
		
		// 로그인한 user의 pet 리스트 가져오기
		$.ajax({
    		url:'recruitWritingPetList',
    		type:'post',
    		async:true,
    		success:function(result) {
    			var res = JSON.parse(result);
    			console.log(res);
    			res.petList.forEach(function(pet) {
    				$('#pet_profile').append(`<tr onclick="touch_tr(event, '\${pet.pet_id}')" class="touch_tr">
    						<td class="pet_td1">
    							<img src="image?file=\${pet.pet_picture == null? 'petdefault.png': pet.pet_picture}&type=pet" class="img-icon pet_img">
    						</td>
    						<td class="pet_td2">\${pet.pet_name}</td><td class="pet_td3">(\${pet.pet_age},&nbsp;${pet.pet_gender eq 'M'? '남':'여'})</td>
    						<td class="pet_td4">\${pet.pet_species}</td><td class="pet_td5">\${pet.pet_breed}</td>
    						<td class="pet_td6"><label><input type="radio" name="pet_name" value="\${pet.pet_name}" class="radio_btn" id="\${pet.pet_id}" required="required"/></label></td></tr>`);
    			})
    		}
    	})
    	
    	// pet 리스트의 한 행 클릭시 배경색 유지
    	function touch_tr(e, pet_id) {
			var trs = document.querySelectorAll(".touch_tr");
			  trs.forEach(function (tr) {
			    if (e.currentTarget == tr) {
			    	// 선택한 행의 라디오 버튼 선택하기
			    	$(`#\${pet_id}`).prop('checked', true);
			      	tr.classList.add("active");
			    } else {
			      	tr.classList.remove("active");
			    }
			  });
			  console.log(e.currentTarget);
		}
	</script>
</body>
</html>