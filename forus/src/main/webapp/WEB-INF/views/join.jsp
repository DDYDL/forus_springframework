<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function() {
    var pwReg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$/;
    var emailReg = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
    var nameReg = /^[가-힣]{2,6}$/;
    var pnReg = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;

    $("#joinBtn").click(function(e) {
        e.preventDefault();
        if ($("#email").val() === "") {
            alert("이메일을 입력해주세요.");
            $("#email").focus();
            return false;
        } else if (!emailReg.test($("#email").val())) {
            alert("이메일 형식이 올바르지 않습니다.");
            $("#email").focus();
            return false;
        } else if ($("#password").val() === "") {
            alert("비밀번호를 입력해주세요.");
            $("#password").focus();
            return false;
        } else if (!pwReg.test($("#password").val())) {
            alert("비밀번호는 영문, 숫자포함 최소 8자리 이상 입력해주세요.");
            $("#password").focus(); // 'password' -> '#password'
            return false;
        } else if ($("#passwordCheck").val() === "" || $("#passwordCheck").val() != $("#password").val()) {
            alert("비밀번호가 일치하지 않습니다.");
            $("#passwordCheck").focus();
            return false;
        } else if ($("#name").val() === "") {
            alert("이름을 입력해주세요.");
            $("#name").focus();
            return false;
        } else if (!nameReg.test($("#name").val())) {
            alert("이름을 확인해주세요.(한글 2~6자 이내)");
            $("#name").focus();
            return false;
        } else if ($("#nickname").val() === "") {
            alert("닉네임을 입력해주세요.");
            $("#nickname").focus();
            return false;
        } else if ($("#phone").val() === "") {
            alert("휴대폰번호를 입력해주세요.");
            $("#phone").focus();
            return false;
        } else if (!pnReg.test($("#phone").val())) {
            alert("휴대폰번호를 확인해주세요.");
            $("#phone").focus();
            return false;
        } else if ($("#address").val() === "") {
            alert("주소를 입력해주세요.");
            $("#address").focus();
            return false;
        }

        $("#join").submit();
    });

    $("#doubleEmail").click(function(e) {
        e.preventDefault();
        if (!emailReg.test($("#email").val())) {
            alert("이메일 형식이 올바르지 않습니다.");
            $("#email").focus();
            return false;
        }
        $.ajax({
            url: 'userDoubleEmail',
            type: 'post',
            dataType: 'text',
            data: { email: $("#email").val() },
            success: function(result) {
                if (result == 'true') {
                    alert("이미 가입된 이메일입니다.");
                } else {
                    alert("사용가능한 이메일입니다.");
                }
            },
            error: function(err) {
                console.log(err);
            }
        });
    });
});

// 카카오(다음) 주소 입력
function daumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수
            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }
            if (data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            if (extraRoadAddr !== '') {
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            document.getElementById("postcode").value = data.zonecode;
            document.getElementById("address").value = roadAddr + extraRoadAddr;
        }
    }).open();
}

document.addEventListener('DOMContentLoaded', function() {
    // form 내 Enter 키 submit 방지
    document.getElementById('join').addEventListener('keydown', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault(); // 기본 동작(폼 제출) 방지
        }
    });
});
</script>

<link href="css/my/mycommon.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@ include file="mainpage.jsp"%>
	<div class="content user-content">
		<form action="join" method="post" id="join">
			<p class="content-title">회원가입</p>
			<br>
			<br>
			<table class="join-table">
				<tr>
					<td class="columnsize-title">이메일<br></td>
					<td class="columnsize">
					<input type="text" placeholder="이메일을 입력해주세요" name="email" id="email"
						class="input join-input-short cursorpadding">&nbsp;&nbsp;
					<button type="button" id="doubleEmail" class="minibtn">중복 확인</button></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" placeholder="비밀번호를 입력해주세요 (*영문,숫자 포함 최소 8자리 이상)" name="password" id="password"
					class="input join-input cursorpadding"></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" placeholder="비밀번호 다시 입력해주세요" name="passwordCheck" id="passwordCheck"
					class="input join-input cursorpadding"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" placeholder="이름을 입력해주세요" name="name" id="name"
					class="input join-input cursorpadding"></td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td><input type="text" placeholder="닉네임을 입력해주세요" name="nickname" id="nickname"
					class="input join-input cursorpadding"></td>
				</tr>
				<tr>
					<td>휴대전화번호</td>
					<td><input type="text" placeholder="휴대전화번호를 입력해주세요" name="phone" id="phone"
					class="input join-input cursorpadding">
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input id="justDate" type="text" placeholder="날짜를 선택해주세요" name="birthday" id="birthday"
					class="input join-input cursorpadding"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
					<input type="radio" name="gender" id="male" value="M" class="radio-hidden">&nbsp;
					<label class="label-btnstyle" for="male">남</label>&nbsp;&nbsp;
					<input type="radio" name="gender" id="female" value="F" class="radio-hidden">&nbsp;
					<label class="label-btnstyle" for="female">여</label>&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" id="postcode" placeholder="우편번호" class="input join-input-short cursorpadding">&nbsp;&nbsp;
						<input onclick="daumPostcode()" class="minibtn" value="주소 검색" type="button">
						<input type="text" id="address" placeholder="주소" class="input join-input cursorpadding" name="address" id="address">
					</td>
				</tr>
			</table>
			<br>
			<br>
			<div>
				<input type="submit" value="가입하기" class="bigbtn" id="joinBtn">
			</div>
		</form>
	</div>
	<br>
	<br>
	<br>
</body>
<script>
	flatpickr("#justDate", {
		"locale" : "ko",
		"dateFormat" : "Y-m-d",
	});
</script>
</html>