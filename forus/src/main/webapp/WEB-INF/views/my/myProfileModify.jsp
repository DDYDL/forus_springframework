<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/my/containerprofile.css" />
<link rel="stylesheet" href="css/my/profile.css" />
<link rel="stylesheet" href="css/my/input.css" />
<link rel="stylesheet" href="css/my/button.css" />
<style>
.my {
	font-weight: bold;
	color: #03C75A;
}
</style>
</head>
<!-- 캘린더 라이브러리 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<!-- 주소검색 -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
            oncomplete: function(data) {
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                document.getElementById("postcode").value = data.zonecode;
                document.getElementById("address").value = roadAddr + extraRoadAddr;
            }
        }).open();
    }
</script>
<link href="css/my/mycommon.css" rel="stylesheet" type="text/css">
<body>
	<%@ include file="../mainmypage.jsp"%>

	<form action="myProfileModify" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="id" value="${user.id}">
		<div class="mypage-content">
			<div>
				<h2 align="center">내 프로필 수정</h2>
			</div>
			<div class="containerprofile">
				<ul>
					<li>프로필 사진</li>
					<li><img
						src="image?file=${user.picture eq null? 'userdefault.png': user.picture}&type=user"
						class="img-icon" alt="이미지 선택" id="preview" width="100px"
						onclick="document.getElementById('file').click();"> <input
						type="file" name="file" id="file" accept="image/*"
						onchange="readURL(this);" style="display: none"></li>

					<li class="title">이름 <input type="text" class="underline" name="name"
						value=${user.name }></li>

					<li class="title">닉네임</li>

					<li><input type="text" class="underline" name="nickname"
						value=${user.nickname }></li>

					<li class="title">이메일</li>

					<li><input type="text" class="underline" name="email"
						readonly="readonly" value=${user.email }></li>

					<li class="title">비밀번호</li>
					<br>
					<br>
					<li><input type="password" class="underlinesmall"
						name="password" value=${user.password }>
						<button class="minibutton minibtnFade minibtnBlueGreen">변경하기</button></li>

					<li class="title">휴대전화번호</li>
					<br>
					<li><input type="text" class="underline" name="phone"
						value=${user.phone }></li>

					<li class="title">주소</li>
					<li><input type="text" id="postcode" placeholder=" 우편번호" class="user-input join-input-short">&nbsp;
						<input onclick="daumPostcode()" class="minibtn" value="주소 검색">
						<input type="text" id="address" placeholder=" 주소" class="user-input join-input" name="address" value="${user.address }">
					</li>
					<br>
					<br>
					<li class="title">생년월일</li>

					<li class="setting_td2" colspan="2"><div class="col-6">
							<input class="form-control" id="dayOfTheWeek" name="birthday"
								type="text" required="required" value="${user.birthday }">
						</div></li>


				</ul>
			</div>
			<br> <br>
			<div class="find-btn">
				<input type="submit" title="Button push blue/green"
					class=" btn btnPush btnBlueGreen find-btn1" value="수정완료"> <br>
				<br> <br> <br>

			</div>


		</div>
	</form>
</body>

<script>
	flatpickr("#dayOfTheWeek", {
		"locale" : "ko", // 한국어 설정
		"enableTime" : false, // 시간 선택 비활성화
		"dateFormat" : "Y-m-d", // 요일 형식 설정 (요일만 출력) - 달력을 선택하면 요일로
		"inline" : false
	// 페이지 로드 시 자동으로 표시 안 함

	});
</script>
</html>