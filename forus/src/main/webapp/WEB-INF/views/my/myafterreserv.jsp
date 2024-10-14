<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약내역-이후예약</title>
<!-- table -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath}/css/my/mycommon.css" rel="stylesheet" type="text/css">
</head>
<style>
.reserv {
	font-weight: bold;
	color: #03C75A;;
}

.mypage {
	font-weight: bold;
	color: #03C75A;
}
</style>
<body>
	<%@ include file="../mainmypage.jsp" %>
	<div class = "mypage-content-list">
		<div class="mytitle">
			<a href="${pageContext.request.contextPath}/myAfterReserv">이후 예약</a>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="${pageContext.request.contextPath}/myBeforeReserv">지난 예약</a>
		</div>
		
			<c:choose>
            <c:when test="${not empty afterReservList}">
			<div class="listcnt">
				<p>총 ${afterReservList.size() }건</p>
			</div>
				<table class="table table-hover mytable">
						<tr>
							<th id="date">날짜</th>
							<th id="time">시간</th>
							<th id="petname" colspan="2">반려동물</th>
							<th id="hospitalname">병원</th>
						</tr>
						<c:forEach items="${afterReservList }" var="reserv">
						<tr onclick="location.href='./reservDetail?reserv_id=${reserv.reserv_id}'">
							<td onclick="event.cancelbubble = true;" class="center">${reserv.reserv_date }</td>
							<td class="center">${reserv.reserv_time }</td>
							<td class="center">
								<c:choose>			
									<c:when test="${reserv.pet_picture eq null}">
									<img src="upload/pet/petdefault.png" class="pet_img-small"></c:when>
									<c:otherwise><img src="image?file=${reserv.pet_picture}&type=pet" class="pet_img-small"></c:otherwise>
								</c:choose>
							</td>
							<c:choose>
								<c:when test="${reserv.pet_name eq null}"><td>삭제된 펫입니다!</td></c:when>
								<c:otherwise><td class="textalign_left">${reserv.pet_name }</td></c:otherwise>
							</c:choose>
							<td class="center">${reserv.h_name }</td>
						</tr>
						</c:forEach>
				</table>
            </c:when>
            <c:otherwise>
            <div align="center">
                <br><br><br>
                <img src="https://img.icons8.com/?size=100&id=106514&format=png">
                <br><br>
                <p>남은 예약이 없습니다</p>
                </div>
            </c:otherwise>
		</c:choose>
</div>
</body>
</html>