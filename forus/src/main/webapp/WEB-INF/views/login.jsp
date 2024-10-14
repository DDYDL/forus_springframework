<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="resources/css/my/mycommon.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@ include file="mainpage.jsp"%>
	<div class="content user-content">
		<form action="login" method="post">
			<p class="content-title">로그인</p>
			<br> <br>
			<div>
				<input type="text" placeholder="이메일 아이디" name="email"
					class="input user-input cursorpadding"><br> <br> <input type="password"
					placeholder="비밀번호" name="password" class="input user-input cursorpadding"><br>
				<br> <br> <br>
			</div>
			<div>
					<input type="submit" value="로그인" class="bigbtn"><br> <br>
				
				<a href="join" class="bigbtn join-bigbtn">신규 회원가입</a>
			</div>
		</form>
	</div>
</body>
</html>