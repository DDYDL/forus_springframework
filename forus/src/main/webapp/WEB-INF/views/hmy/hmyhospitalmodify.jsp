<%@page import="com.forus.dto.Hospital"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이병원-병원정보수정</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>


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
<link rel="stylesheet" href="css/common/minibutton.css" />
<link href="./css/recruit/calendar.css?after" rel="stylesheet"
	type="text/css">


<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=94ab9074f87bbed0edf5b0d9cb32cdbd&libraries=services"></script>
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
</script>
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

		<form action="./hmyHospitalModify" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="h_id" value="${hospital.h_id }"> 
			<p class="mypage-content-title" align="center">내 병원 정보 수정</p>

			<h3 style="text-align: left">기본 정보</h3>

			<table class="container">

				<tbody>
					<tr>
						<td><label for="name">대표자 이름</label></td>
						<td class="tdinput"><input type="text" id="input"
							name="h_exponent_name" value="${hospital.h_exponent_name  }"
							required></td>
					</tr>

					<tr>
						<td><label for="name">사업자 등록번호</label></td>
						<td class="tdinput"><input type="text" id="input"
							name="h_num" value="${hospital.h_num }" required></td>
					</tr>
					<tr>
						<td><label for="name">병원 이름</label></td>
						<td class="tdinput"><input type="text" id="input"
							name="h_name" value="${hospital.h_name }" required></td>
					</tr>
					<tr>
						<td><label for="name">병원장 이름</label></td>
						<td class="tdinput"><input type="text" id="input"
							name="h_manager_name" value="${hospital.h_manager_name }"
							required></td>
					</tr>
					<tr>
						<td><label for="name">병원 연락처</label></td>
						<td class="tdinput"><input type="tel" id="tel" name="h_phone"
							value="${hospital.h_phone }" required></td>
					</tr>

					<tr>
						<td>병원 주소</td>

						<td><input type="address" id="h_address" placeholder=" 주소"
							name="h_address" value="${hospital.h_address }"> <input
							onclick="daumPostcode()"
							class="minibutton minibtnFade minibtnBlueGreen" value="주소 검색"></td>

					</tr>


					<tr>
						<%-- <td class="time"><label for="name">점심 시간</label></td>
								<td class="tdinput time"><input type="time" id="input"
									name="h_lunch_time_start"
									value="${hospital.h_lunch_time_start }"> ~ <input
									type="time" id="input" name="h_lunch_time_end"
									value="${hospital.h_lunch_time_end }"></td> --%>

						<td class="setting_td1"><label for="time">점심시간</label></td>
						<td class="setting_td2"><input type="time" class="time_start"
							id="timepicker" name="h_lunch_time_start"
							value="${hospital.h_lunch_time_start }"> ~ <input
							type="time" class="time_end" id="timepicker"
							name="h_lunch_time_end" value="${hospital.h_lunch_time_end }"></td>

					</tr>

				</tbody>
			</table>
			<h3 style="text-align: left">진료 가능한 동물 목록</h3>

			<table class="container">

				<tbody>
					<tr>
						<td>포유류</td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="강아지" value="강아지" autocomplete="off">
							<label class="pet-button" for="강아지">강아지</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="고양이" value="고양이" autocomplete="off">
							<label class="pet-button" for="고양이">고양이</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="햄스터" value="햄스터" autocomplete="off">
							<label class="pet-button" for="햄스터">햄스터</label></td>


						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="토끼" value="토끼" autocomplete="off">
							<label class="pet-button" for="토끼">토끼</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="기니피그" value="기니피그" autocomplete="off">
							<label class="pet-button" for="기니피그">기니피그</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="고슴도치" value="고슴도치" autocomplete="off">
							<label class="pet-button" for="고슴도치">고슴도치</label></td>


						<!--  
						<td><input type="checkbox" name="h_animal_type" value="강아지"
							id="강아지">강아지</td>
						<td><input type="checkbox" name="h_animal_type" value="고양이"
							id="고양이">고양이</td>
						<td><input type="checkbox" name="h_animal_type" value="햄스터"
							id="햄스터">햄스터</td>
						<td><input type="checkbox" name="h_animal_type" value="토끼"
							id="토끼">토끼</td>
						<td><input type="checkbox" name="h_animal_type" value="기니피그"
							id="기니피그">기니피그</td>
						<td><input type="checkbox" name="h_animal_type" value="고슴도치"
							id="고슴도치">고슴도치</td>		-->

					</tr>
					<tr></tr>
					<tr>
						<td></td>
						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="페럿" value="페럿" autocomplete="off">
							<label class="pet-button" for="페럿">페럿</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="다람쥐" value="다람쥐" autocomplete="off">
							<label class="pet-button" for="다람쥐">다람쥐</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="카피바라" value="카피바라" autocomplete="off">
							<label class="pet-button" for="카피바라">카피바라</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="양" value="양" autocomplete="off">
							<label class="pet-button" for="양">양</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="염소" value="염소" autocomplete="off">
							<label class="pet-button" for="염소">염소</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="알파카" value="알파카" autocomplete="off">
							<label class="pet-button" for="알파카">알파카</label></td>

						<!-- 

						<td><input type="checkbox" name="h_animal_type" value="페럿"
							id="페럿">페럿</td>
						<td><input type="checkbox" name="h_animal_type" value="다람쥐"
							id="다람쥐">다람쥐</td>

						<td><input type="checkbox" name="h_animal_type" value="카피바라"
							id="카피바라"> 카피바라</td>

						<td><input type="checkbox" name="h_animal_type" value="양"
							id="양"> 양</td>
						<td><input type="checkbox" name="h_animal_type" value="염소"
							id="염소"> 염소</td>
						<td><input type="checkbox" name="h_animal_type" value="알파카"
							id="알파카">알파카</td> -->
					</tr>
					<tr></tr>
					<tr>
						<td></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="돼지" value="돼지" autocomplete="off">
							<label class="pet-button" for="돼지">돼지</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="소" value="소" autocomplete="off">
							<label class="pet-button" for="소">소</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="말" value="말" autocomplete="off">
							<label class="pet-button" for="말">말</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="당나귀" value="당나귀" autocomplete="off">
							<label class="pet-button" for="당나귀">당나귀</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="노새" value="노새" autocomplete="off">
							<label class="pet-button" for="노새">노새</label></td>

						<!-- 
						<td><input type="checkbox" name="h_animal_type" value="돼지"
							id="돼지">돼지</td>
						<td><input type="checkbox" name="h_animal_type" value="소"
							id="소">소</td>
						<td><input type="checkbox" name="h_animal_type" value="말"
							id="말">말</td>
						<td><input type="checkbox" name="h_animal_type" value="당나귀"
							id="당나귀">당나귀</td>
						<td><input type="checkbox" name="h_animal_type" value="노새"
							id="노새">노새</td> -->
					</tr>
					<tr></tr>
					<tr>
						<td>조류</td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="거위" value="거위" autocomplete="off">
							<label class="pet-button" for="거위">거위</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="공작" value="공작" autocomplete="off">
							<label class="pet-button" for="공작">공작</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="닭" value="닭" autocomplete="off">
							<label class="pet-button" for="닭">닭</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="비둘기" value="비둘기" autocomplete="off">
							<label class="pet-button" for="비둘기">비둘기</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="앵무새" value="앵무새" autocomplete="off">
							<label class="pet-button" for="앵무새">앵무새</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="오리" value="오리" autocomplete="off">
							<label class="pet-button" for="오리">오리</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="타조" value="타조" autocomplete="off">
							<label class="pet-button" for="타조">타조</label></td>

						<!-- 
						<td><input type="checkbox" name="h_animal_type" value="거위"
							id="거위">거위</td>
						<td><input type="checkbox" name="h_animal_type" value="공작"
							id="공작">공작</td>
						<td><input type="checkbox" name="h_animal_type" value="닭"
							id="닭">닭</td>
						<td><input type="checkbox" name="h_animal_type" value="비둘기"
							id="비둘기">비둘기</td>
						<td><input type="checkbox" name="h_animal_type" value="앵무새"
							id="앵무새">앵무새</td>
						<td><input type="checkbox" name="h_animal_type" value="오리"
							id="오리">오리</td>
						<td><input type="checkbox" name="h_animal_type" value="타조"
							id="타조">타조</td> -->
					</tr>
					<tr></tr>
					<tr>
						<td>파충류</td>
						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="거북이" value="거북이" autocomplete="off">
							<label class="pet-button" for="거북이">거북이</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="도마뱀" value="도마뱀" autocomplete="off">
							<label class="pet-button" for="도마뱀">도마뱀</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="뱀" value="뱀" autocomplete="off">
							<label class="pet-button" for="뱀">뱀</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="악어" value="악어" autocomplete="off">
							<label class="pet-button" for="악어">악어</label></td>


						<!-- 	<td><input type="checkbox" name="h_animal_type" value="거북이"
							id="거북이">거북이</td>
						<td><input type="checkbox" name="h_animal_type" value="도마뱀"
							id="도마뱀">도마뱀</td>
						<td><input type="checkbox" name="h_animal_type" value="뱀"
							id="뱀">뱀</td>
						<td><input type="checkbox" name="h_animal_type" value="악어"
							id="악어">악어</td> -->
					</tr>
					<tr></tr>
					<tr>
						<td>양서류</td>
						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="도룡뇽" value="도룡뇽" autocomplete="off">
							<label class="pet-button" for="도룡뇽">도룡뇽</label></td>

						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="개구리" value="개구리" autocomplete="off">
							<label class="pet-button" for="개구리">개구리</label></td>
						<!-- 
						<td><input type="checkbox" name="h_animal_type" value="도룡뇽"
							id="도룡뇽">도룡뇽</td>
						<td><input type="checkbox" name="h_animal_type" value="개구리"
							id="개구리">개구리</td> -->
					</tr>
					<tr></tr>
					<tr>
						<td>어류</td>
						<td><input type="checkbox" class="pet-check"
							name="h_animal_type" id="어류" value="어류" autocomplete="off">
							<label class="pet-button" for="어류">어류</label></td>

						<!-- <td><input type="checkbox" name="h_animal_type" value="어류"
							id="어류">어류</td> -->
					</tr>

					<c:forEach items="${h_animal_types}" var="h_animal_types">

						<c:if test="${h_animal_types eq '강아지'}">
							<script>
								$("input[id='강아지']").prop("checked", true);
							</script>
						</c:if>

						<c:if test="${h_animal_types eq '고양이'}">
							<script>
								$("input[id='고양이']").prop("checked", true);
							</script>
						</c:if>

						<c:if test="${h_animal_types eq '햄스터'}">
							<script>
								$("input[id='햄스터']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '토끼'}">
							<script>
								$("input[id='토끼']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '기니피그'}">
							<script>
								$("input[id='기니피그']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '고슴도치'}">
							<script>
								$("input[id='고슴도치']").prop("checked", true);
							</script>
						</c:if>


						<c:if test="${h_animal_types eq '페럿'}">
							<script>
								$("input[id='페럿']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '다람쥐'}">
							<script>
								$("input[id='다람쥐']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '카피바라'}">
							<script>
								$("input[id='카피바라']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '양'}">
							<script>
								$("input[id='양']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '염소'}">
							<script>
								$("input[id='염소']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '알파카'}">
							<script>
								$("input[id='알파카']").prop("checked", true);
							</script>
						</c:if>



						<c:if test="${h_animal_types eq '돼지'}">
							<script>
								$("input[id='돼지']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '소'}">
							<script>
								$("input[id='소']").prop("checked", true);
							</script>
						</c:if>

						<c:if test="${h_animal_types eq '말'}">
							<script>
								$("input[id='말']").prop("checked", true);
							</script>
						</c:if>

						<c:if test="${h_animal_types eq '당나귀'}">
							<script>
								$("input[id='당나귀']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '노새'}">
							<script>
								$("input[id='노새']").prop("checked", true);
							</script>
						</c:if>




						<c:if test="${h_animal_types eq '거위'}">
							<script>
								$("input[id='거위']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '공작'}">
							<script>
								$("input[id='공작']").prop("checked", true);
							</script>
						</c:if>

						<c:if test="${h_animal_types eq '닭'}">
							<script>
								$("input[id='닭']").prop("checked", true);
							</script>
						</c:if>

						<c:if test="${h_animal_types eq '비둘기'}">
							<script>
								$("input[id='비둘기']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '앵무새'}">
							<script>
								$("input[id='앵무새']").prop("checked", true);
							</script>
						</c:if>

						<c:if test="${h_animal_types eq '오리'}">
							<script>
								$("input[id='오리']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '타조'}">
							<script>
								$("input[id='타조']").prop("checked", true);
							</script>
						</c:if>


						<c:if test="${h_animal_types eq '거북이'}">
							<script>
								$("input[id='거북이']").prop("checked", true);
							</script>
						</c:if>

						<c:if test="${h_animal_types eq '도마뱀'}">
							<script>
								$("input[id='도마뱀']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '뱀'}">
							<script>
								$("input[id='뱀']").prop("checked", true);
							</script>
						</c:if>

						<c:if test="${h_animal_types eq '악어'}">
							<script>
								$("input[id='악어']").prop("checked", true);
							</script>
						</c:if>


						<c:if test="${h_animal_types eq '도룡뇽'}">
							<script>
								$("input[id='도룡뇽']").prop("checked", true);
							</script>
						</c:if>
						<c:if test="${h_animal_types eq '개구리'}">
							<script>
								$("input[id='개구리']").prop("checked", true);
							</script>
						</c:if>


						<c:if test="${h_animal_types eq '어류'}">
							<script>
								$("input[id='어류']").prop("checked", true);
							</script>
						</c:if>


					</c:forEach>

				</tbody>
			</table>


			<h3 style="text-align: left">병원 대표 사진 등록</h3>
			<table class="container">
				<tbody>
					<tr>
						<td><label for="name">대표 사진 등록</label></td>
						<td class="tdinput filebox"><img
							src="image?file=${hospital.h_picture eq null? 'hospitaldefault.png': hospital.h_picture}&type=hospital"
							class="img-icon" alt="이미지 선택" id="preview" style="width: 400px;"
							onclick="document.getElementById('file').click();"></td>
						<td><label for="file">파일찾기</label> <input type="file"
							name="file" id="file" accept="image/*" onchange="readURL(this);"
							style="display: none;" name="h_picture"></td>

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
								id="input_box" cols="30" rows="4" name="h_memo">${hospital.h_memo }</textarea></td>
					</tr>
					<tr>
						<td style="vertical-align: top"><label for="name">찾아오는
								길</label></td>
						<td><textarea style="resize: none" class="tdinput"
								id="input_box" cols="30" rows="4" name="h_memo_road">${hospital.h_memo_road }</textarea></td>
					</tr>
					<tr>
						<td><label for="name"> SNS / Blog </label></td>
						<td class="tdinput"><input type="text" id="input"
							name="h_sns" value="${hospital.h_sns }"></td>

					</tr>
					<tr></tr>
					<tr>
						<td><label for="name"> 결제수단 </label></td>
						<td><input type="checkbox" class="pet-check" name="h_pay"
							id="현금" value="현금" autocomplete="off"> <label
							class="pet-button" for="현금">현금</label> <input type="checkbox"
							class="pet-check" name="h_pay" id="카드" value="카드"
							autocomplete="off"> <label class="pet-button" for="카드">카드</label>

							<input type="checkbox" class="pet-check" name="h_pay" id="제로페이"
							value="제로페이" autocomplete="off"> <label
							class="pet-button" for="제로페이">제로페이</label> <c:forEach
								items="${h_pays}" var="h_pays">
								<c:if test="${h_pays eq '현금'}">
									<script>
										$("input[id='현금']").prop("checked",
												true);
									</script>
								</c:if>
								<c:if test="${h_pays eq '카드'}">
									<script>
										$("input[id='카드']").prop("checked",
												true);
									</script>
								</c:if>
								<c:if test="${h_pays eq '제로페이'}">
									<script>
										$("input[id='제로페이']").prop("checked",
												true);
									</script>
								</c:if>
							</c:forEach></td>
					</tr>
					<tr></tr>
					<tr>

						<td class="name">주차 가능 여부</td>
						<td><input type="radio" class="radio-check" name="h_parking"
							id="radioParkingTrue" value="true" autocomplete="off"
							<c:if test="${hospital.h_parking eq true}">checked</c:if>>
							<label class="radio-button" for="radioParkingTrue">가능</label> <input
							type="radio" class="radio-check" name="h_parking"
							id="radioParkingFalse" value="false" autocomplete="off"
							<c:if test="${hospital.h_parking eq false}">checked</c:if>>
							<label class="radio-button" for="radioParkingFalse">불가능</label></td>


						<%-- 
						<td><label for="name"> 주차 가능 여부 </label></td>
						<td class="tdinput"><input type="radio" name="h_parking"
							value="true"
							<c:if test="${hospital.h_parking eq true}">checked</c:if>>
							가능 <input type="radio" name="h_parking" value="false"
							<c:if test="${hospital.h_parking eq false}">checked</c:if>>
							불가능</td> --%>
					</tr>

					<input type="hidden" id="hospital_latitude" name="latitude">
					<input type="hidden" id="hospital_longitudeH" name="longitude">
				</tbody>
			</table>


			<br> <br>
			<div class="row">
				<div class="find-btn">
					<input type="submit" title="Button push blue/green"
						class=" btn btnPush btnBlueGreen find-btn1" value="수정 완료">

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

<script>
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
				document.getElementById("h_address").value = roadAddr
						+ extraRoadAddr;
				getLatLngFromAddress(roadAddr);

			}
		}).open();
	}
</script>
<script>
	//위도 경도 코드
	function getLatLngFromAddress(address) {
		var geocoder = new kakao.maps.services.Geocoder();

		geocoder
				.addressSearch(
						address,
						function(result, status) {
							if (status === kakao.maps.services.Status.OK) {
								var coords = result[0];
								var latitude = coords.y; // 위도
								var longitude = coords.x; // 경도

								console.log('Latitude:', latitude,
										'Longitude:', longitude);

								// 예시: 위도와 경도를 숨겨진 input에 저장
								document.getElementById('hospital_latitude').value = latitude;
								document.getElementById('hospital_longitudeH').value = longitude;

								console
										.log(
												'Hidden Field Values:',
												'Latitude:',
												document
														.getElementById('hospital_latitude').value,
												'Longitude:',
												document
														.getElementById('hospital_longitudeH').value);

							} else {
								alert('주소로 위도와 경도를 찾을 수 없습니다.');
							}
						});
	}
</script>
</html>

