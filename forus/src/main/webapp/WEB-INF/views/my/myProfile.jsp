<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/my/containerprofile.css" />
<link rel="stylesheet" href="css/my/profile.css" />
<link rel="stylesheet" href="css/my/input.css" />
<link rel="stylesheet" href="css/my/button.css" />
<!-- 캘린더 라이브러리 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<style>
.my {
	font-weight: bold;
	color: #03C75A;
}
</style>

</head>
<body>
	<%@ include file="../mainmypage.jsp"%>

	<div class="mypage-content" >
		<p class="mypage-content-title" align="center">내 프로필</p>
		
		<div style="text-align:right;padding:30px 0 0 0;"><c:if test="${user.ishospital eq 0 }">
			<span id="authentication">병원관계자라면?&nbsp; <a
				href="./hmyNewHospital"><img src="./img/play.png" width="16px">&nbsp;병원인증하기</a>
			</span>
		</c:if></div>
		<div class="containerprofile">
			<ul>
				<li>프로필 사진</li>
				<li><img
					src="image?file=${user.picture eq null? 'userdefault.png': user.picture}&type=user"
					class="img-icon"></li>

				<li class="title">이름</li>
				<li class="line"><span>${user.name }</span></li>

				<li class="title">닉네임</li>
				<li class="line"><span>${user.nickname }</span></li>

				<li class="title">이메일</li>
				<li class="line"><span>${user.email }</span></li>

				<li class="title">비밀번호</li>
				<br>
				<li class="line"><span>수정 페이지에서 변경가능</span></li>

				<li class="title">휴대전화번호</li>
				<li class="line"><span>${user.phone }</span></li>

				<li class="title">주소</li>
				<br>
				<br>
				<li class="line"><span>${user.address }</span></li>

				<li class="title">생년월일</li>
				<br>
				<br>
				<li class="line"><span>${user.birthday }</span></li>

				<li class="title">성별</li>
				<br>
				<br>
				<li class="line"><span> <c:choose>
							<c:when test="${user.gender eq 'M' }"> 남자</c:when>
							<c:when test="${user.gender eq 'F' }"> 여자</c:when>
						</c:choose>

				</span></li>


			</ul>
		</div>

		<br>
		<br> <br>
		<div class="find-btn">
			<button type="button" title="Button push blue/green"
				class=" btn btnPush btnBlueGreen find-btn1"
				onclick="location.href='./myProfileModify?id=${user.id}'">수정</button>

		</div>
		<br> <br>

	</div>
</body>
</html>