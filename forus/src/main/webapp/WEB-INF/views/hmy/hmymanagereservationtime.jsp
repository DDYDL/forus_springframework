<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이병원-진료시간</title>
<style>
.manage {
	font-weight: bold;
	color: #03C75A;
}

.myhospital {
	font-weight: bold;
	color: #03C75A;
}
</style>

<!-- 캘린더 라이브러리 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<link rel="stylesheet" href="css/hmy/list.css" />
<link rel="stylesheet" href="css/hmy/containerbox.css" />
<link rel="stylesheet" href="css/hmy/weekbutton.css" />
<link rel="stylesheet" href="css/my/button.css" />
<link rel="stylesheet" href="css/hmy/font.css" />

<link href="./css/recruit/calendar.css?after" rel="stylesheet"
	type="text/css">
</head>
<body>
	<%@ include file="../mainhmypage.jsp"%>
	<form action="modifyHospitalTime" method="post">
		<div class="mypage-content">
			<div class="divtable">

				<p class="mypage-content-title" align="center">병원 진료시간 관리</p>
				<div style="padding-bottom: 20px;padding-top:30px;">
					예약간격 <select name="intervalTime" id="interval">

						<option value="10"
							<c:if test='${hospital.h_interval_time eq "10"}'>selected="selected"</c:if>>10분</option>
						<option value="20"
							<c:if test='${hospital.h_interval_time eq "20"}'>selected="selected"</c:if>>20분</option>
						<option value="30"
							<c:if test='${hospital.h_interval_time eq "30"}'>selected="selected"</c:if>>30분</option>
						<option value="40"
							<c:if test='${hospital.h_interval_time eq "40"}'>selected="selected"</c:if>>40분</option>
						<option value="50"
							<c:if test='${hospital.h_interval_time eq "50"}'>selected="selected"</c:if>>50분</option>
						<option value="60"
							<c:if test='${hospital.h_interval_time eq "60"}'>selected="selected"</c:if>>60분</option>
					</select>

				</div>


				<div>
					<table class="styled-table">
						<tbody>
							<c:forEach items="${hospitalTimeList}" var="hospitalTime">
								<c:if test="${hospitalTime.htime_week eq 'Monday'}">
									<tr>
										<td>
											<div class="check">
												<label> <input type="checkbox" id="mon" name="mon"
													value="월"
													<c:if test='${hospitalTime.htime_isable eq "true"}'>checked="checked"</c:if>>
													<span>월</span>
												</label>
											</div>
										</td>
										<!-- <td>영업시간</td> -->
										<!-- 시간 고치기 -->
										<%-- <td><input type="time" class="time_start" id="timepicker"
											name="htime_opening_mon"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" id="input" name="htime_closing_mon"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}">


										</td> --%>

										<td class="setting_td1"><label for="time">영업시간</label></td>
										<td class="setting_td2"><input type="time"
											class="time_start" id="timepicker" name="htime_opening_mon"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" class="time_end" id="timepicker"
											name="htime_closing_mon"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}"></td>

									</tr>
								</c:if>


								<c:if test="${hospitalTime.htime_week eq 'Tuesday'}">
									<tr>
										<td>
											<div class="check">
												<label> <input type="checkbox" id="tue" name="tue"
													value="화"
													<c:if test='${hospitalTime.htime_isable eq true}'>checked="checked"</c:if>>
													<span>화</span>
												</label>
											</div>
										</td>
										<%-- <td>영업시간
										<td><input type="time" id="input"
											name="htime_opening_tue"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" id="input" name="htime_closing_tue"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}">
										</td> --%>


										<td class="setting_td1"><label for="time">영업시간</label></td>
										<td class="setting_td2"><input type="time"
											class="time_start" id="timepicker" name="htime_opening_tue"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" class="time_end" id="timepicker"
											name="htime_closing_tue"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}"></td>


									</tr>
								</c:if>
								<c:if test="${hospitalTime.htime_week eq 'Wednesday'}">
									<tr>
										<td>
											<div class="check">
												<label> <input type="checkbox" id="wed" name="wed"
													value="수"
													<c:if test='${hospitalTime.htime_isable eq true}'>checked="checked"</c:if>>
													<span>수</span>
												</label>
											</div>
										</td>
										<%-- <td>영업시간
										<td><input type="time" id="input"
											name="htime_opening_wed"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" id="input" name="htime_closing_wed"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}">
											</td> --%>

										<td class="setting_td1"><label for="time">영업시간</label></td>
										<td class="setting_td2"><input type="time"
											class="time_start" id="timepicker" name="htime_opening_wed"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" class="time_end" id="timepicker"
											name="htime_closing_wed"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}"></td>


									</tr>
								</c:if>
								<c:if test="${hospitalTime.htime_week eq 'Thursday'}">
									<tr>
										<td>
											<div class="check">
												<label> <input type="checkbox" id="thur" name="thur"
													value="목"
													<c:if test='${hospitalTime.htime_isable eq true}'>checked="checked"</c:if>>
													<span>목</span>
												</label>
											</div>
										</td>
										<%-- <td>영업시간
										<td><input type="time" id="input"
											name="htime_opening_thur"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" id="input" name="htime_closing_thur"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}">
											</td> --%>

										<td class="setting_td1"><label for="time">영업시간</label></td>
										<td class="setting_td2"><input type="time"
											class="time_start" id="timepicker" name="htime_opening_thur"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" class="time_end" id="timepicker"
											name="htime_closing_thur"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}"></td>



									</tr>
								</c:if>
								<c:if test="${hospitalTime.htime_week eq 'Friday'}">
									<tr>
										<td>
											<div class="check">
												<label> <input type="checkbox" id="fri" name="fri"
													value="금"
													<c:if test='${hospitalTime.htime_isable eq true}'>checked="checked"</c:if>>
													<span>금</span>
												</label>
											</div>
										</td>
										<%-- <td>영업시간
										<td><input type="time" id="input"
											name="htime_opening_fri"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" id="input" name="htime_closing_fri"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}">
											</td> --%>

										<td class="setting_td1"><label for="time">영업시간</label></td>
										<td class="setting_td2"><input type="time"
											class="time_start" id="timepicker" name="htime_opening_fri"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" class="time_end" id="timepicker"
											name="htime_closing_fri"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}"></td>

									</tr>
								</c:if>
								<c:if test="${hospitalTime.htime_week eq 'Saturday'}">
									<tr>
										<td>
											<div class="check">
												<label> <input type="checkbox" id="sat" name="sat"
													value="토"
													<c:if test='${hospitalTime.htime_isable eq true}'>checked="checked"</c:if>>
													<span>토</span>
												</label>
											</div>
										</td>
										<%-- <td>영업시간
										<td><input type="time" id="input"
											name="htime_opening_sat"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" id="input" name="htime_closing_sat"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}">
											</td> --%>

										<td class="setting_td1"><label for="time">영업시간</label></td>
										<td class="setting_td2"><input type="time"
											class="time_start" id="timepicker" name="htime_opening_sat"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" class="time_end" id="timepicker"
											name="htime_closing_sat"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}"></td>

									</tr>
								</c:if>
								<c:if test="${hospitalTime.htime_week eq 'Sunday'}">
									<tr>
										<td>
											<div class="check">
												<label> <input type="checkbox" id="sun" name="sun"
													value="일"
													<c:if test='${hospitalTime.htime_isable eq true}'>checked="checked"</c:if>>
													<span>일</span>
												</label>
											</div>
										</td>
										<%-- <td>영업시간</td>
										<td><input type="time" id="input"
											name="htime_opening_sun"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" id="input" name="htime_closing_sun"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}">
											</td> --%>

										<td class="setting_td1"><label for="time">영업시간</label></td>
										<td class="setting_td2"><input type="time"
											class="time_start" id="timepicker" name="htime_opening_sun"
											value="${hospitalTime.htime_opening ne null? hospitalTime.htime_opening:'09:00'}">
											~ <input type="time" class="time_end" id="timepicker"
											name="htime_closing_sun"
											value="${hospitalTime.htime_closing ne null? hospitalTime.htime_closing:'18:00'}"></td>

									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<div>
					<br> <br>
					<div class="find-btn">
						<input type="submit" title="Button push blue/green"
							class=" btn btnPush btnBlueGreen find-btn1" value="수정">

					</div>

				</div>


			</div>
		</div>
	</form>
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