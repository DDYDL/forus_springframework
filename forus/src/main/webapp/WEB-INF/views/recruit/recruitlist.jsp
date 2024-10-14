<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Help Us</title>
<!-- 부트스트랩 드롭다운 버튼 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- jquery 라이브러리 -->
<script src="http://code.jquery.com//jquery-latest.min.js"></script>
<!-- css 파일 -->
<link href="./resources/css/recruit/recruitlist.css" rel="stylesheet"
	type="text/css">
</head>
<style>
.helpus {
	font-weight: bold;
	color: #03C75A;
}
</style>
<body>
	<%@ include file="../header.jsp"%>

	<div class="content-list">
		<p class="content-title">Help Us</p>

		<!-- 검색 기능 -->
		<div class="container mt-3">
			<div id="dropbtnArea" class="dropdown">
				<button type="button" class="btn btn-primary dropdown-toggle"
					onclick="hideTextArea()" data-bs-toggle="collapse"
					data-bs-target="#demo1">지역&nbsp;&nbsp;</button>
			</div>
			<div id="dropbtnSpecies" class="dropdown">
				<button type="button" class="btn btn-primary dropdown-toggle"
					onclick="hideTextSpecies()" data-bs-toggle="collapse"
					data-bs-target="#demo2">동물&nbsp;&nbsp;</button>
			</div>
			<div class="searchbox">
				<input id="init_text" type="text"
					style="border: none; text-align: center;"
					placeholder="검색 조건을 선택하세요" />
				<div id="demo1" class="collapse">
					<table class="table search_table">
						<thead>
							<tr>
								<th>시·도</th>
								<th>시·구·군</th>
								<th>동·읍·면</th>
							</tr>
						</thead>
						<tbody>
							<tr id="addressSearch">
								<td id="addressdido" class="tabletd tabletd1"
									style="padding: 5px 0 0 0;"></td>
								<td id="addresssigungu" class="tabletd tabletd2"
									style="padding: 5px 0 0 0;"><div class="collapse"></div></td>
								<td id="addressdongeummaen" class="tabletd"
									style="padding: 5px 0 0 0;"><div class="collapse"></div></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="demo2" class="collapse">
					<table class="table search_table">
						<thead>
							<tr>
								<th>종</th>
								<th>동물종</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="tabletd tabletd1" style="padding: 5px 0 0 0;"><select
									size="5" style="width: 100%; margin: 0px; padding: 0px;">
										<option value="mammalia" style="padding: 5px 10px;"
											data-bs-toggle="collapse" data-bs-target="#mammalia"
											onclick="speciesClick(mammalia)">포유류</option>
										<option value="bird" style="padding: 5px 10px;"
											data-bs-toggle="collapse" data-bs-target="#bird"
											onclick="speciesClick(bird)">조류</option>
										<option value="reptile" style="padding: 5px 10px;"
											data-bs-toggle="collapse" data-bs-target="#reptile"
											onclick="speciesClick(reptile)">파충류</option>
										<option value="amphibian" style="padding: 5px 10px;"
											data-bs-toggle="collapse" data-bs-target="#amphibian"
											onclick="speciesClick(amphibian)">양서류</option>
										<option value="pisces" style="padding: 5px 10px;"
											data-bs-toggle="collapse" data-bs-target="#pisces"
											onclick="speciesClick(pisces)">어류</option>
								</select></td>
								<td id="speciestd" class="tabletd" style="padding: 5px 0 0 0;"><div
										id="mammalia" class="collapse"></div></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="search_btnArea"></div>
				<div id="search_btnSpecies"></div>
				<div class="minibtndiv">
					<input id="init_btn"
						class="minibutton minibtnFade minibtnBlueGreen" type="button"
						onclick="delete_selectall()" value="초기화">
				</div>
			</div>

			<!-- SGIS 단계별 주소 조회 API -->
			<script>
    	var accessToken = 'none';
    	var errCnt=0;
    	var cd = 11;
    	var list = []; // 주소 이름을 담아올 리스트
    	var cdlist = []; // 주소 코드를 담아올 리스트
    	var bool = false; // addressGeo가 완료되었는지 확인하는 변수
    	getAccessToken();
    	
        // 유효한 accessToken 얻기
        function getAccessToken() {
        	jQuery.ajax({
         		type:'GET',
         		url: 'https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json',
         		data:{
         			consumer_key : '2985279e52a94a62bb20',
         			consumer_secret : 'f9637651c3e54864bb36',
         		},
         		success:function(data){																									
         			errCnt = 0;																									
         			accessToken = data.result.accessToken;
         			addressGeo();
         		},																													
         		error:function(data) {}																														
         	});																		
        }
        
     	// DATA API 호출(accessToken 필요)
        function addressGeo(cd, str){
         	jQuery.ajax({
         		type:'GET',
         		url: 'https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json',
         		data:{
         			accessToken : accessToken,
         			cd : cd // 시도/시군구/읍면동 정보를 숫자로 넣어준다
         		},
         		success:function(data) {
         			var addressList = [];
         			console.log(typeof(data));
         			console.log(data);
         			switch (parseInt(data.errCd)){																				
     					case 0:
     						list = [];
     						cdlist = [];
     						addressList = data.result;
     						console.log(addressList);
     						for(var i=0; i<addressList.length; i++) {
     							list.push(addressList[i].addr_name);
								cdlist.push(addressList[i].cd);
     						}
     						console.log(list);
     						console.log(cdlist);
     						if(cd == null) firstSelect();
     						if(bool == true) { // 비동기 통신이 완료되면, 즉, list가 바뀌었으면 실행
     							if(cd.toString().length === 2) {
     								secondSelect(str);
     							} else {
     								thirdSelect(str);
     							}
     						}
     						bool = false; // 다시 false
     						break;
     					case -401: errCnt ++; if(errCnt<200){ getAccessToken(); } break;
     					case -100: break;
     				}
         		},
         		error:function(data) {}
         	});
		}
        
        function firstSelect() {
        	// 1번째 select문 설정
            var td1 = $('#addressdido');
        	td1.append(`<select id="addressfirst" style="width:100%;margin:0px;padding:0px;" size="5"></select>`);
        	var select1 = $('#addressfirst');
        	console.log(list);
        	console.log(cdlist);
        	console.log(list.length);
        	for(var i=0; i<list.length; i++) {
        		select1.append(`<option value="\${list[i]}" style="padding:5px 10px;" data-bs-toggle="collapse" data-bs-target="#\${list[i]}" onclick="checkClick('\${cdlist[i]}','\${list[i]}')">\${list[i]}</option>`);
        	}
        }
        
        function checkClick(cd, str) {
        	bool = true;
        	console.log(cd,str);
        	addressGeo(cd,str);
        }
    	
        function secondSelect(gu) {
        	// 첫번째 요소 선택시 두세번째 요소 초기화 후 생성
        	var td2 = $('#addresssigungu');
        	td2.empty();
        	var td3 = $('#addressdongeummaen');
        	td3.empty();
        	
        	console.log(gu);
        	var td2 = $('#addresssigungu');
        	td2.children('div').attr('id', '\${gu}');
        	td2.append(`<select id="\${gu}s" style="width:100%;margin:0px;padding:0px;" size="5"></select>`);
        	var select2 = $(`#\${gu}s`);

        	console.log(select2);
            for(var j=0; j<list.length; j++) {
            	select2.append(`<option value="\${list[j]}" style="padding:5px 10px;" data-bs-toggle="collapse" data-bs-target="#\${list[j]}" onclick="checkClick('\${cdlist[j]}','\${list[j]}')">\${list[j]}</option>`);
        	}
        }
        
        function thirdSelect(dong) {
        	// 두번째 요소 선택시 세번째 요소 초기화 후 생성;
        	var td3 = $('#addressdongeummaen');
        	td3.empty();
        	
        	// 3번째 select문 설정
    		var td3 = $('#addressdongeummaen');
    		td3.children('div').attr('id', '\${dong}');
        	td3.append(`<select id="areas" style="width:100%;margin:0px;padding:0px;" onclick="selectSearch_area()" size="5"></select>`);
        	var select3 = $('#areas');
        	
        	console.log(list);
        	
        	// 동에서 숫자 제거 후 넣기 위함
        	var str = [];
        	for(var l=0; l<list.length; l++) {
        		// 숫자가 들어간 주소에서 숫자 지우기
        		var str2 = list[l].replace(/[0-9]/g, "");
        		str.push(str2);
        		str.push(list[l]);
        	}
        	// 중복제거
        	var set = new Set(str);
        	list = [...set];
        	
        	for(var k=0; k<list.length; k++) {
        		select3.append(`<option class="areas" style="padding:5px 10px;" value="\${list[k]}">\${list[k]}</option>`);
        	}
        }
    </script>

			<script>
    	var mammalia = ['강아지','고양이','햄스터','토끼','페럿','다람쥐','기니피그','카피바라','양','염소','알파카','돼지','소','말','당나귀','노새','고슴도치'];
    	var bird = ['거위','공작','닭','비둘기','앵무새','오리','타조'];
    	var reptile = ['거북이','도마뱀','뱀','악어'];
    	var amphibian = ['도롱뇽','개구리'];
    	var pisces = ['어류'];
    	
    	// 동물 선택시 실행되는 함수
    	function speciesClick(animal) {
    		var td = $('#speciestd');
    		td.empty();
    		td.append(`<select id="species" style="width:100%;margin:0px;padding:0px;" onclick="selectSearch_specie()" size="5">`);
			var select = $('#species');
        	
        	console.log(animal);
        	for(var i=0; i<animal.length; i++) {
        		select.append(`<option class="species" style="padding:5px 10px;" value="\${animal[i]}">\${animal[i]}</option>`);
        	}
    		
    	}
    </script>

			<!-- 글 목록 -->
			<br>
			<div class="list-header">
				<div class="list-count">
					<p id="count"></p>
				</div>
				<div class="list-btn btndiv">
					<c:if test="${user ne null}">
						<a href="recruitWriting"
							class="minibutton minibtnFade minibtnBlueGreen a_btn">구인등록</a>
					</c:if>
				</div>
			</div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th class="recruit_th1">지역</th>
						<th class="recruit_th2">제목</th>
						<th class="recruit_th3">급여(원)</th>
						<th class="recruit_th4">근무시간</th>
						<th class="recruit_th5">등록일</th>
					</tr>
				</thead>
				<tbody id="recruitlist_body"></tbody>
			</table>
			<div class="btndiv">
				<button id="moreBtn" class="minibutton minibtnFade minibtnBlueGreen">
					<img src="./resources/img/plus.png" style="width: 20px">
				</button>
			</div>
		</div>
	</div>

	<script>
    	var page=0;
    	var maxPage=0;
    	var areas=new Array();
    	var species=new Array();
    	var clickCnt = 0;
    	
    	// 지역, 동물 버튼 클릭시 안내 문구 삭제하는 함수
    	function hideTextArea() {
    		// 드롭다운 버튼 화살표 방향 바꾸기
    		var dropbtnA = document.getElementById("dropbtnArea");
    		if(dropbtnA.className == "dropdown") {
    			dropbtnA.className = "dropup";
    			document.getElementById("init_text").style.display = 'none'; // 버튼 누르면 화살표 위로 올리고, 안내 문구 안 보이게 한다.
    		}
    		else {
    			dropbtnA.className = "dropdown";
    			if(areas.length <= 0 && species.length <= 0) { document.getElementById("init_text").style.display = 'block'; } // 아무것도 없을 때만 띄우기
    		}
    	}
    	
    	function hideTextSpecies() {
    		var dropbtn = document.getElementById("dropbtnSpecies");
    		if(dropbtn.className == "dropdown") {
    			dropbtn.className = "dropup";
    			document.getElementById("init_text").style.display = 'none';
    		}
    		else {
    			dropbtn.className = "dropdown"
    			if(areas.length <= 0 && species.length <= 0) { document.getElementById("init_text").style.display = 'block'; }
    		}
    	}
    	
    	// recruit_post 리스트를 가져와서 페이지 수에 맞게 보여주는 함수
    	function requestData() {
    		if(areas.length > 0 || species.length > 0) {
    			// 하나라도 조건이 선택되어 있으면 초기화 버튼 보이게 함
    			document.getElementById("init_btn").style.visibility = 'visible';
    		} else {
    			document.getElementById("init_btn").style.visibility = 'hidden';
    		}
    		
    		console.log(areas);
    		console.log(species);
    		var param = {areas:areas, species:species, page:page+1}
    		
    		$.ajax({
    			url:'recruitBypage',
    			type:'post',
    			async:true,
    			data:{param:JSON.stringify(param)}, // 객체를 JSON 문자열로 변환
    			success:function(result) { // recruitBypage 서블릿에서 넘어온 recruit_post 리스트가 result에 담겨옴(JSON 문자열 형식)
    				console.log(result);
    				console.log(typeof(result)); // result는 String 타입
    				if(result === "") {
    					document.getElementById("recruitlist_body").innerHTML = "글이 없습니다";
    					document.getElementById("count").innerHTML = "총 0건";
    					return;
    				}
    				var res = JSON.parse(result); // JSON 문자열을 객체로 변환
    				res.recruit_postList.forEach(function(recruit_post) {
    					console.log(recruit_post);
    					// 초 단위 자르기
    					var post_time = recruit_post.post_time.slice(0,16);
    					var start_time = recruit_post.post_start_time.slice(0,5);
    					var end_time = recruit_post.post_end_time.slice(0,5);
    					
    					// 숫자 3자리마다 ,찍기
    					var pay = Number(recruit_post.post_pay).toLocaleString('ko-KR');
    					
    					// 테이블 안에 recruit_post 한 행을 추가
    					$('#recruitlist_body').append(`<tr onclick="location.href='./recruitDetailpage?post_id=\${recruit_post.post_id}'"><td class="recruit_td1">\${recruit_post.post_address}</td>
    												   <td class="recruit_td2">\${recruit_post.post_title}</td>
    												   <td class="recruit_td3">\${pay}원&nbsp;&nbsp;<button class="form_btn" <c:set var="form" value="${recruit_post.post_form}"/><c:if test="${fn:contains(form,'일급')}">style="border:1px solid #58ACFA;"</c:if> disabled>\${recruit_post.post_form}</button></td>
    												   <td class="recruit_td4">\${start_time}~\${end_time}</td><td class="recruit_td5">\${post_time}</td></tr>`);
    					
    				})
    				maxPage = res.maxPage; // 넘어온 페이지로 설정
    				page = res.page;
    				// 전체 페이지 수 설정
    				document.getElementById("count").innerHTML = "총 " + res.postCount + "건";
    				
    				// 현재 페이지수가 최대 페이지수와 같거나 크면 더보기 버튼 안 보이게 함
    				if(page>=maxPage) {
    					document.getElementById("moreBtn").style.visibility = 'hidden';
    				} else {
    					document.getElementById("moreBtn").style.visibility = 'visible';
    				}
    				
    			}
    		})
    	}
    	
    	// 더보기 버튼 눌리면 함수 한 번 실행
    	document.getElementById("moreBtn").onclick = function() {
    		requestData();
    	}
    	
    	
    	// 검색 조건 선택 시 실행되는 함수, 검색바에서 마지막 select 누르면 버튼 생김
    	function selectSearch_area() {
    		var area = document.getElementById("areas").value; // 선택한 지역 이름
    		for(var i=0; i<areas.length; i++) {
    			if(areas[i] === area) { return; } // 기존에 같은게 있으면 안 넣음
    		}
    		areas.push(area);
    		
    		$('#search_btnArea').append(`<button class="make_btn minibutton minibtnFade minibtnBlueGreen" onclick="deleteBtn_area(this)" style="background:#D1D1D1;">\${area}</button>`); // 버튼 생성
    		btn_click();
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
    	// 모든 버튼 삭제
    	function delete_selectall() {
    		document.getElementById("search_btnArea").replaceChildren(); // 모든 버튼 삭제
    		document.getElementById("search_btnSpecies").replaceChildren(); // 모든 버튼 삭제
			
    		areas=new Array(); // 배열 초기화
        	species=new Array();
        	btn_click();
    	}
    	
    	// 버튼이 눌렸을 때 실행되는 함수들
    	function btn_click() {
    		// 페이지가 첫 페이지면 기존의 리스트 삭제
    		document.getElementById("recruitlist_body").replaceChildren();
    		page=0; // 페이지 수 초기화
        	maxPage=0;
    		requestData(); // 리스트 다시 가져오기
    	}
    	
    	// 처음 한 번 실행
    	requestData();
    </script>
</body>
</html>