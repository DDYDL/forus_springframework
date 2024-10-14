<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>


<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=94ab9074f87bbed0edf5b0d9cb32cdbd&libraries=services"></script>

<!-- 캘린더 라이브러리 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<link rel="stylesheet" href="css/hmy/containerbox.css" />
<link rel="stylesheet" href="css/hmy/input.css" />
<link rel="stylesheet" href="css/hmy/font.css" />
<link rel="stylesheet" href="css/hmy/time.css" />
<link rel="stylesheet" href="css/hmy/button.css" />
<link rel="stylesheet" href="css/my/profile.css" />


<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">

	</script>


<script>
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('preview').src = e.target.result;
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	function(e){
		
	}
	
	
</script>


</head>


<body>
	<%@ include file="../mainmypage.jsp"%>

	<div class="mypage-content">

		<form action="hmyNewHospital" method="post"
			enctype="multipart/form-data">


			<div>
				<h2 align="center">신규 병원 등록</h2>
			</div>

			<h3 style="text-align: left">기본 정보</h3>

			<table class="container">

				<tbody>
					<tr>
						<td><label for="name">대표자 이름</label></td>
						<td class="tdinput"><input type="text" id="input"
							name="h_exponent_name" required></td>
						<td></td>
					</tr>

					<tr>
						<td><label for="name">사업자 등록번호</label></td>
						<td class="tdinput"><input type="text" id="input"
							name="h_num" required></td>
					</tr>
					<tr>
						<td><label for="name">의사 면허증</label></td>
						<td class=" tdinput filebox"><input class="upload-name"
							value="첨부파일" placeholder="첨부  파일"> <label for="file">파일찾기</label>
							<input type="file" id="file" name="h_license"></td>

					</tr>
					<script>
								$("#file").on('change', function() {
									var fileName = $("#file").val();
									$(".upload-name").val(fileName);
								});
							</script>


					<tr>
						<td><label for="name">병원 이름</label></td>
						<td class="tdinput"><input type="text" id="input"
							name="h_name" required></td>
					</tr>
					<tr>
						<td><label for="name">병원장 이름</label></td>
						<td class="tdinput"><input type="text" id="input"
							name="h_manager_name" required></td>
					</tr>
					<tr>
						<td><label for="name">병원 연락처</label></td>
						<td class="tdinput"><input type="tel" id="tel" name="h_phone"
							required></td>
					</tr>

					<tr>
						<td>병원 주소</td>
						<td><input type="text" id="postcode" placeholder=" 우편번호"
							class="user-input join-input-short">&nbsp; <input
							onclick="daumPostcode()" class="minibtn" value="주소 검색">
					</tr>
					<tr>
						<td></td>
						<td><input type="text" id="h_address" placeholder=" 주소"
							class="user-input join-input" name="h_address"></td>

					</tr>

					<tr>

						<td class="setting_td1"><label for="time">점심시간</label></td>
						<td class="setting_td2"><input type="time" class="time_start"
							id="timepicker" name="h_lunch_time_start"> ~ <input
							type="time" class="time_end" id="timepicker"
							name="h_lunch_time_end"></td>

					</tr>


				</tbody>
			</table>

			<h3 style="text-align: left">진료 가능한 동물 목록</h3>

			<table class="container">

				<div id="demo2" class="collapse">
					<thead>
						<tr>
							<th>종</th>
							<th>동물종</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="tabletd"><select size="5">
									<option value="mammalia" data-bs-toggle="collapse"
										data-bs-target="#mammalia" onclick="speciesClick(mammalia)">포유류</option>
									<option value="bird" data-bs-toggle="collapse"
										data-bs-target="#bird" onclick="speciesClick(bird)">조류</option>
									<option value="reptile" data-bs-toggle="collapse"
										data-bs-target="#reptile" onclick="speciesClick(reptile)">파충류</option>
									<option value="amphibian" data-bs-toggle="collapse"
										data-bs-target="#amphibian" onclick="speciesClick(amphibian)">양서류</option>
									<option value="pisces" data-bs-toggle="collapse"
										data-bs-target="#pisces" onclick="speciesClick(pisces)">어류</option>
							</select></td>
							<td id="speciestd" class="tabletd"><div id="mammalia"
									class="collapse"></div></td>




						</tr>
						<tr>
							<div id="search_btnSpecies"></div>
						</tr>
				</div>
				</tbody>
			</table>


			<h3 style="text-align: left">병원 대표 사진 등록</h3>
			<table class="container">
				<tbody>
					<tr>
						<td><label for="name">대표 사진 등록</label></td>
						<td class="tdinput filebox"><img
							src="image?file=${hospital.h_picture eq null? 'default.png': hospital.h_picture}&type=hospital"
							alt="이미지 선택" id="preview" width="400px"> <label for="file">파일찾기</label>
							<input type="file" id="file" accept="image/*"
							onchange="readURL(this); "
							style="display: none; vertical-align: top;" name="h_picture"></td>

					</tr>
				</tbody>
			</table>

			<h3 style="text-align: left">추가 사항</h3>
			<table class="container">
				<tbody>
					<tr>
						<td style="vertical-align: top"><label for="name">상세
								설명</label></td>
						<td><textarea style="resize: none" class="tdinput"
								id="input_box" cols="30" rows="4" name="h_memo"
								placeholder="  방문자들의 편의를 위해 진료 가능한 동물 종류를  &#10;다양하게 또는 가능한 업무(진료, 미용, 엑스레이, 수술) 등을 작성해주세요"></textarea></td>
					</tr>
					<tr>
						<td style="vertical-align: top"><label for="name">찾아오는
								길</label></td>
						<td><textarea style="resize: none" id="input_box" cols="30"
								rows="4" name="h_memo_road"
								placeholder="  골목 또는 2층 이상의 찾기 어려운 위치일 경우  &#10; 상세 입력 부탁합니다."></textarea></td>
					</tr>

					<tr>
						<td><label for="name"> SNS / Blog </label></td>
						<td class="tdinput"><input type="text" id="input"
							name="h_sns" value="https://"></td>

					</tr>

					<tr>
						<td><label for="name"> 결제수단 </label></td>
						<td class="tdinput"><input type="checkbox" name="h_pay"
							value="현금"> 현금 <input type="checkbox" name="h_pay"
							value="카드"> 카드 <input type="checkbox" name="h_pay"
							value="제로페이"> 제로페이</td>
					</tr>

					<tr>
						<td><label for="name"> 주차 가능 여부 </label></td>
						<td class="tdinput"><input type="radio" name="h_parking"
							value="true"> 가능 <input type="radio" name="h_parking"
							value="false"> 불가능</td>
					</tr>

				</tbody>
			</table>
			<div class="rowwrite">
				<p>
					<b>주의사항</b>
				</p>
				<p>1. 병원 정보는 즉시 등록됩니다.</p>
				<p>2. 병원정보는 등록 된 이후 '마이병원'을 통해 언제든 수정이 가능합니다.</p>
				<p>3. 잘못된 장소는 강제로 삭제될 수 있습니다.</p>
				<p>4. 병원 등록 후 진료 시간은 '마이병원'탭에서 설정해야합니다.</p>

			</div>
			<div>
				<input type="checkbox" required> 위 사항에 동의합니다.<br>
			</div>

			<input type="hidden" id="hospital_latitude" name="latitude">
			<input type="hidden" id="hospital_longitudeH" name="longitude">


			<br> <br> <br>
			<div class="row">
				<div class="find-btn">
					<input type="submit" title="Button push blue/green"
						class="btn btnPush btnBlueGreen find-btn1" value="병원 등록"
						onclick="submitForm(event);">
				</div>
			</div>

		</form>

	</div>

</body>
<script>
	flatpickr("#timepicker", {
		noCalendar : true,
		allowInput : true, // 직접 입력 허용
		enableTime : true, // 시간 사용
		dateFormat : "H:i",
		time_24hr : true,
		defaultHour : 12,
		defaultMinute : 0,
	});
</script>
</html>

<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {

						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						if (data.userSelectedType === 'R') {
							if (data.bname !== ''
									&& /[동|로|가]$/g
											.test(data.bname)) {
								extraAddr += data.bname;
							}
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName
										: data.buildingName);
							}
							if (extraAddr !== '') {
								extraAddr = ' ('
										+ extraAddr
										+ ')';
							}
							document
									.getElementById("sample6_detailAddress").value = extraAddr;
						} else {
							document
									.getElementById("sample6_detailAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document
								.getElementById('sample6_postcode').value = data.zonecode;
						document
								.getElementById("sample6_address").value = addr;

						getLatLngFromAddress(addr);

						// 커서를 상세주소 필드로 이동한다.
						document
								.getElementById(
										"sample6_detailAddress")
								.focus();
					}
				}).open();
	}
</script>

<script>


	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('preview').src = e.target.result;
			}
			reader.readAsDataURL(input.files[0]);
		}
	}

	// 카카오(다음) 주소 입력
	function daumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				document.getElementById("postcode").value = data.zonecode;
				document.getElementById("h_address").value = roadAddr
						+ extraRoadAddr;
			}
		}).open();
	}
</script>

<script>
	//위도 경도 코드
	function getLatLngFromAddress(address) {
		var geocoder = new kakao.maps.services.Geocoder();

		geocoder.addressSearch(address, function(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var coords = result[0];
				var latitude = coords.y; // 위도
				var longitude = coords.x; // 경도


				console.log('Latitude:', latitude, 'Longitude:', longitude);

				// 예시: 위도와 경도를 숨겨진 input에 저장
				document.getElementById('hospital_latitude').value = latitude;
				document.getElementById('hospital_longitudeH').value = longitude;

				console.log('Hidden Field Values:',
						'Latitude:', document.getElementById('hospital_latitude').value,
						'Longitude:', document.getElementById('hospital_longitudeH').value);



			} else {
				alert('주소로 위도와 경도를 찾을 수 없습니다.');
			}
		});
	}



</script>
<script>
var species=new Array();

function selectSearch_specie() {
	var specie = document.getElementById("species").value; // 선택한 동물 이름
	for(var i=0; i<species.length; i++) {
		if(species[i] === specie) { return; } // 기존에 같은게 있으면 안 넣음
	}
	species.push(specie);
	
	$('#search_btnSpecies').append(`<button class="make_btn minibutton minibtnFade minibtnBlueGreen" onclick="deleteBtn_species(this)">\${specie}</button>`);
	btn_click();
}
function deleteBtn_area(btn) { // 버튼 클릭시 삭제
	for(let i=0; i<areas.length; i++) {
		if(areas[i]===btn.innerHTML) {
			areas.splice(i, 1); // 해당하는 버튼 배열에서 삭제
		}
	}
	btn.remove(); // 버튼 요소 삭제
	btn_click();
}
function deleteBtn_species(btn) {
	for(let i=0; i<species.length; i++) {
		if(species[i]===btn.innerHTML) {
			species.splice(i, 1); // 해당하는 버튼 배열에서 삭제
		}
	}
	btn.remove();
	btn_click();
}

    	var mammalia = ['강아지','고양이','햄스터','토끼','페럿','다람쥐','','','양','염소','알파카','돼지','소','말','당나귀','노새','고슴도치'];
    	var bird = ['거위','공작','닭','비둘기','앵무새','오리','타조'];
    	var reptile = ['거북이','도마뱀','뱀','악어'];
    	var amphibian = ['도롱뇽','개구리'];
    	var pisces = ['어류'];
    	
    	
    	// 동물 선택시 실행되는 함수
    	function speciesClick(animal) {
    		var td = $('#speciestd');
    		td.empty();
    		td.append(`<select id="species" onclick="selectSearch_specie()" size="5">`);
			var select = $('#species');
        	
        	console.log(animal);
        	for(var i=0; i<animal.length; i++) {
        		select.append(`<option class="species" value="\${animal[i]}">\${animal[i]}</option>`);
        	}
    		
    	}
    	
    	function selectSearch_specie() {
    		var specie = document.getElementById("species").value; // 선택한 동물 이름
    		for(var i=0; i<species.length; i++) {
    			if(species[i] === specie) { return; } // 기존에 같은게 있으면 안 넣음
    		}
    		species.push(specie);
    		
    		$('#search_btnSpecies').append(`<button class="make_btn minibutton minibtnFade minibtnBlueGreen" onclick="deleteBtn_species(this)">\${specie}</button>`);
    		btn_click();
    	}
    	
    </script>
