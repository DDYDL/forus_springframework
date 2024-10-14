<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이병원-내병원정보</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="https://cdn.rawgit.com/harvesthq/chosen/gh-pages/chosen.jquery.min.js"></script>
<link
	href="https://cdn.rawgit.com/harvesthq/chosen/gh-pages/chosen.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="css/hmy/containerbox.css" />
<link rel="stylesheet" href="css/hmy/input.css" />
<link rel="stylesheet" href="css/hmy/font.css" />
<link rel="stylesheet" href="css/hmy/time.css" />
<link rel="stylesheet" href="css/hmy/button.css" />
<!-- <script>
	$(function(e) {
		e.preventDefault();
	});
	document.addEventListener('DOMContentLoaded', function() {
		// form 내 Enter 키 submit 방지
		document.getElementById('join').addEventListener('keydown',
				function(e) {
					if (e.key === 'Enter') {
						e.preventDefault(); // 기본 동작(폼 제출) 방지
					}
				});
	});
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('preview').src = e.target.result;
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
</script> -->



<style>
.myhos {
	font-weight: bold;
	color: #03C75A;
}

.myhospital {
	font-weight: bold;
	color: #03C75A;
}

</style>
</head>


<body>
	<%@ include file="../mainhmypage.jsp"%>

	<div class="mypage-content">


		<div class="containerbox">
			<p class="mypage-content-title" align="center">내 병원 정보</p>

			<h3 style="text-align: left">기본 정보</h3>

			<table class="container">
				<tbody>
					<tr>
						<td class="size"><label for="name">대표자 이름</label></td>
						<td><span>${hospital.h_exponent_name  }</span></td>
						<td></td>
					</tr>

					<tr>
						<td><label for="name">사업자 등록번호</label></td>
						<td><span>${hospital.h_num }</span></td>
					</tr>
					<tr>
						<td><label for="name">병원 이름</label></td>
						<td><span>${hospital.h_name }</span></td>
					</tr>
					<tr>
						<td><label for="name">병원장 이름</label></td>
						<td><span>${hospital.h_manager_name }</span></td>
					</tr>
					<tr>
						<td><label for="name">병원 연락처</label></td>
						<td><span>${hospital.h_phone }</span></td>
					</tr>

					<tr>
						<td><label for="name">병원 주소</label></td>
						<td><span>${hospital.h_address}</span></td>

					</tr>
					<tr>
						<td><label for="name">점심 시간</label></td>
						<td><span>${hospital.h_lunch_time_start } ~
								${hospital.h_lunch_time_end } </span></td>
					</tr>
				</tbody>
			</table>

			<h3 style="text-align: left">진료 가능 동물 목록</h3>
			<table class="container">
				<tbody>
					<tr>
						<td class="size"></td>
						<td class="tdinput"><span>${hospital.h_animal_type }</span>
					</tr>

				</tbody>
			</table>


			<h3 style="text-align: left">병원 대표 사진</h3>
			<table class="container">
				<tbody>
					<tr>
						<td><label for="name">등록된 대표 사진</label></td>
						<td><img
							src="image?file=${hospital.h_picture eq null? 'hospitaldefault.png': hospital.h_picture}
								&id=${hospital_h_id}&type=hospital"
							style="width: 500px; height: 300px;"></td>

					</tr>
				</tbody>
			</table>

			<h3 style="text-align: left">추가 사항</h3>
			<table class="container">
				<tbody>
					<tr>
						<td class="size"><label for="name">상세 설명</label></td>
						<td><span>${hospital.h_memo }</span></td>
					</tr>
					<tr>
						<td><label for="name">찾아오는 길</label></td>
						<td><span>${hospital.h_memo_road }</span></td>
					</tr>


					<tr>
						<td><label for="name"> SNS / Blog </label></td>
						<td><span>${hospital.h_sns }</span></td>

					</tr>

					<tr>
						<td><label for="name"> 결제수단 </label></td>
						<td><span>${hospital.h_pay }</span></td>

					</tr>

					<tr>
						<td><label for="name"> 주차 가능 여부 </label></td>
						<td><c:choose>
								<c:when test='${hospital.h_parking eq true }'> 가능</c:when>
								<c:when test='${hospital.h_parking eq false }'> 불가능</c:when>
							</c:choose></td>

					</tr>

				</tbody>
			</table>

			<br> <br>
			<div class="row">
				<div class="find-btn">
					<button type="button" title="Button push blue/green"
						class=" btn btnPush btnBlueGreen find-btn1"
						onclick="location.href='./hmyHospitalModify'">수정</button>

				</div>
			</div>
		</div>
	</div>
</body>
</html>

