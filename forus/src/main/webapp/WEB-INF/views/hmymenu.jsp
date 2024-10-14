<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/css/common/menu.css" rel="stylesheet" type="text/css">
</head>
<body>
	<aside id="left">
		<hr id="menuhr">
		<ul>
			<li><img src="img/icon/today-icon.png" class="icon">&nbsp;&nbsp;<a href="./hmyTodaysReservation" class="todays">오늘 예약일정</a></li>
			<li><img src="img/icon/treatment-icon.png" class="icon">&nbsp;&nbsp;<a href="./doctorCalendar" class="managereserv">예약 관리</a></li>
			<li><img src="img/icon/hospital-icon.png" class="icon">&nbsp;&nbsp;<a href="./hmyHospital" class ="myhos">내 병원정보</a></li>
			<li><img src="img/icon/time-icon.png" class="icon">&nbsp;&nbsp;<a href="./hmyManagerReservationTime" class ="manage">진료시간 설정</a></li>
		</ul>
	</aside>
</body>
</html>