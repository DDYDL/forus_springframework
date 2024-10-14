<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이병원-진료시간설정</title>
<link rel="stylesheet" href="css/button.css" />
<style>
.manage {
	font-weight: bold;
	color: #03C75A;
}
</style>
<!-- 캘린더 라이브러리 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<link rel="stylesheet" href="css/hmy/request.css" />
<link rel="stylesheet" href="css/hmy/list.css" />
<link rel="stylesheet" href="css/hmy/containerbox.css" />
<link rel="stylesheet" href="css/hmy/weekbutton.css" />
<link rel="stylesheet" href="css/my/button.css" />
</head>
<body>
	<%@ include file="../mainhmypage.jsp"%>

	<div class="mypage-content">

		<div class="bodybox">
			<div>
				<h3 align="left" text-align="left">예약 일정 관리</h3>
			</div>

			<div style="padding-bottom: 20px;">
				예약간격 <select name="intervalTime">
					<option value="10">10분</option>
					<option value="20">20분</option>
					<option value="30">30분</option>
					<option value="40">40분</option>
					<option value="50">50분</option>
					<option value="60">60분</option>
				</select>

			</div>

			<div>
				<div>
					<table class="styled-table">
						<thead>
							<tr>
								<td>
									<div class="check">
										<label> <input type="checkbox" id="mon" name="mon"
											value="월"> <span>월</span>
										</label>
									</div>
								</td>
								<td>영업시간
								<td><input type="time" id="input" name="htime_opening_mon"
									value="htime_opening"> ~ <input type="time" id="input"
									name="htime_closing_mon" value="htime_closing"></td>

							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<div class="check">
										<label> <input type="checkbox" id="mon" name="tue"
											value="화"> <span>화</span>
										</label>
									</div>
								</td>
								<td>영업시간
								<td><input type="time" id="input" name="htime_opening_tue"
									value="htime_opening"> ~ <input type="time" id="input"
									name="htime_closing_tue" value="htime_closing"></td>
								</td>

							</tr>
							<tr>
								<td>
									<div class="check">
										<label> <input type="checkbox" id="mon" name="wed"
											value="수"> <span>수</span>
										</label>
									</div>
								</td>
								<td>영업시간
								<td><input type="time" id="input" name="htime_opening_wed"
									value="htime_opening"> ~ <input type="time" id="input"
									name="htime_closing_wed" value="htime_closing"></td>


							</tr>
							<tr>
								<td>
									<div class="check">
										<label> <input type="checkbox" id="mon" name="thur"
											value="목"> <span>목</span>
										</label>
									</div>
								</td>
								<td>영업시간
								<td><input type="time" id="input" name="htime_opening_thr"
									value="htime_opening"> ~ <input type="time" id="input"
									name="htime_closing_thr" value="htime_closing"></td>
								</td>

							</tr>
							<tr>
								<td>
									<div class="check">
										<label> <input type="checkbox" id="mon" name="fri"
											value="금"> <span>금</span>
										</label>
									</div>
								</td>
								<td>영업시간
								<td><input type="time" id="input" name="htime_opening_fri"
									value="htime_opening"> ~ <input type="time" id="input"
									name="htime_closing_fri" value="htime_closing"></td>
								</td>
							</tr>
							<tr>
								<td>
									<div class="check">
										<label> <input type="checkbox" id="mon" name="sat"
											value="토"> <span>토</span>
										</label>
									</div>
								</td>
								<td>영업시간
								<td><input type="time" id="input" name="htime_opening_sat"
									value="htime_opening"> ~ <input type="time" id="input"
									name="htime_closing_sat" value="htime_closing"></td>
								</td>
							</tr>
							<tr>
								<td>
									<div class="check">
										<label> <input type="checkbox" id="mon" name="sun"
											value="일"> <span>일</span>
										</label>
									</div>
								</td>
								<td>영업시간
								<td><input type="time" id="input" name="htime_opening_sun"
									value="htime_opening"> ~ <input type="time" id="input"
									name="htime_closing_sun" value="htime_closing"></td>
								</td>

							</tr>

						</tbody>
					</table>
				</div>

				<div>
					<br> <br> <br>
					<button type="button" title="Button fade blue/green"
						class=" btn btnFade btnBlueGreen find-btn1"
						onclick="location.href='#.jsp'">수정</button>

				</div>


			</div>
		</div>
	</div>
</body>
</html>