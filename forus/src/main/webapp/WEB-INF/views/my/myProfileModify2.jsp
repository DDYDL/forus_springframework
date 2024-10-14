<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-프로필수정</title>
<link rel="stylesheet" href="css/my/containerprofile.css" />
<link rel="stylesheet" href="css/my/profile.css" />
<link rel="stylesheet" href="css/my/input.css" />
<link rel="stylesheet" href="css/my/button.css" />
<link rel="stylesheet" href="css/hmy/font.css" />
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
			oncomplete : function(data) {
				var roadAddr = data.roadAddress;
				var extraRoadAddr = '';

				// 참고 항목 변수를 설정한다
				// ~동/로/가 로 끝나는 주소 넣기
				if (data.bulidingName !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 빌딩, 아파트 이름 넣기
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 참고 항목이 있으면 괄호 안에 넣는다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				// 선택한 주소를 필드에 넣는다.
				document.getElementById("address").value = roadAddr
						+ extraRoadAddr;
			}
		}).open();
	}
</script>

<link href="css/my/mycommon.css" rel="stylesheet" type="text/css">

<style>
.my {
	font-weight: bold;
	color: #03C75A;
}

.mypage {
	font-weight: bold;
	color: #03C75A;
}
</style>

</head>
<body>
	<%@ include file="../mainmypage.jsp"%>
	<form action="myProfileModify" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="id" value="${user.id}">
		<div class="mypage-content">

			<div>
				<h2 align="center">내 프로필</h2>
			</div>

			<div style="text-align: right; padding: 30px 10px 3px 0;">
				<c:if test="${user.ishospital eq 0 }">
					<span id="authentication">병원관계자라면?&nbsp; <a
						href="./hmyNewHospital"><img src="./img/play.png" width="16px">&nbsp;병원인증하기</a>
					</span>
				</c:if>
			</div>
			<table class="containerprofile">
				<tbody>
					<tr>
						<td style="text-align: center;" colspan="2">
						<img src="image?file=${user.picture eq null? 'userdefault.png': user.picture}&type=user"
							class="img-icon" alt="이미지 선택" id="preview"
							onclick="document.getElementById('file').click();"
							style="width=130px; margin-bottom: 20px;">
							<input type="file" name="file" id="file" accept="image/*" onchange="readURL(this);" style="display: none;"></td>
					</tr>

					<tr>
						<td><label for="name" class="title">이름</label></td>
						<td><input type="text" class="underline" name="name"
							value=${user.name }></td>
					</tr>

					<tr>
						<td><label for="nickname" class="title">닉네임 </label></td>
						<td><input type="text" class="underline" name="nickname"
							value=${user.nickname }></td>
					</tr>

					<tr>
						<td><label for="emailid" class="title">이메일</label></td>
						<td><input type="text" class="underline" name="email"
							readonly="readonly" value=${user.email }></td>
					</tr>

					<tr>
						<td><label for="password" class="title">비밀번호 </label></td>
						<td><input type="password" class="underlinesmall"
							name="password" value=${user.password }>
							<button class="minibutton minibtnFade minibtnBlueGreen">변경하기</button></td>
					</tr>

					<tr>
						<td><label for="tel" class="title">휴대전화번호</label></td>
						<td><input type="text" class="underline" name="phone"
							value=${user.phone }></td>
					</tr>

					<tr>
						<td><label for="address" class="title">주소</label></td>
						<td><input type="address" id="address" placeholder=" 주소"
							class="underlinesmall" name="address" value="${user.address }">  <button type="button" onclick="daumPostcode()"
							class="minibutton minibtnFade minibtnBlueGreen" value="주소 검색">주소 검색</button></td>
					</tr>

					<tr>
						<td><label for="birth" class="title">생년월일</label></td>
						<td class="setting_td2"><div id="calendar" class="col-6">
								<input class="form-control" id="dayOfTheWeek" name="birthday"
									type="text" required="required" value="${user.birthday }">
							</div></td>

					</tr>
				</tbody>

			</table>


			<br> <br>
			<div class="find-btn">
				<div class="find-btn">
					<input type="submit" title="Button push blue/green"
						class=" btn btnPush btnBlueGreen find-btn1" value="수정완료">

				</div>
				<br> <br>
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