<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/my/containerprofile.css" />
<link rel="stylesheet" href="css/my/profile.css" />
<link rel="stylesheet" href="css/my/input.css" />
<link rel="stylesheet" href="css/my/button.css" />

</head>

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
<body>
	<%@ include file="../mainmypage.jsp"%>

	<form action="./myPetModify" method="post"
		enctype="multipart/form-data">
		<div class="mypage-content">

			<div>
				<h2 align="center">반려동물 프로필 수정</h2>
			</div>
			<input id="petn" type="hidden" value="${pet.pet_neutering}">
			<div class="containerprofile">
				<input type="hidden" name="pet_id" value="${pet.pet_id}">

				<div>
					<ul>
						<li>프로필 사진</li>
						<li><img
							src="image?file=${pet.pet_picture eq null? 'petdefault.png': pet.pet_picture}&type=pet"
							class="img-icon" alt="이미지 선택" id="preview" width="100px"
							onclick="document.getElementById('file').click();"> <input
							type="file" name="file" id="file" accept="image/*"
							onchange="readURL(this);" style="display: none"></li>



						<li>반려동물 이름</li>
						<li><input type="text" class="underline" name="pet_name"
							value="${pet.pet_name }"></li>

						<li>종류</li>
						<li><input type="text" class="underline" name="pet_species"
							value="${pet.pet_species }"></li>

						<li>품종</li>
						<li><input type="text" class="underline" name="pet_breed"
							value="${pet.pet_breed }"></li>

						<li>동물등록번호</li>
						<li><input type="text" class="underline" name="pet_num"
							value="${pet.pet_num }"></li>

						<li class="title">성별</li>
						<br>
						<br>
						<li><input type="radio" name="pet_gender" value="M"
							<c:if test="${pet.pet_gender eq 'M'}">checked</c:if>> 남 <input
							type="radio" name="pet_gender" value="F"
							<c:if test="${pet.pet_gender eq 'F'}">checked</c:if>> 여 <input
							type="checkbox" name="pet_neutering" value="pet_neutering" <c:if test="${pet.pet_neutering eq true}"> checked</c:if>>
							중성화 여부</li>
						<script>
							console.log(document.getElementById('petn').value);
						</script>

						

						<li class="title">나이</li>
						<br>
						<br>
						<li><select name="pet_age" id="pet_age">
								<option value="0">0살</option>
								<option value="1">1살</option>
								<option value="2">2살</option>
								<option value="3">3살</option>
								<option value="4">4살</option>
								<option value="5">5살</option>
								<option value="6">6살</option>
								<option value="7">7살</option>
								<option value="8">8살</option>
								<option value="9">9살</option>
								<option value="10">10살</option>
								<option value="11">11살</option>
								<option value="12">12살</option>
								<option value="13">13살</option>
								<option value="14">14살</option>
								<option value="15">15살</option>
								<option value="16">16살</option>
								<option value="17">17살</option>
								<option value="18">18살</option>
								<option value="19">19살</option>
								<option value="20">20살</option>
								<option value="20+">20살 이상</option>
						</select></li>
						<input id="post_form" type="hidden" value="${pet.pet_age}">

						<script>
							var post_form = document
									.getElementById('post_form').value;
							console.log(post_form);
							$('#pet_age').val(post_form).prop("selected", true);
						</script>

						<li class="title">특이사항</li>
						<br>
						<br>
						<li><textarea resize:none; class="tdinput" id="input_box" cols="30"
								rows="4" name="pet_memo">${pet.pet_memo } </textarea></li>
						<br>
						<br>
						<br>

					</ul>
					<br> <br> <br> <br>
				</div>
			</div>
			<br> <br>
			<div class="find-btn">
				<input type="submit" title="Button push blue/green"
					class=" btn btnPush btnBlueGreen find-btn1" value="수정완료">

			</div>
			<br> <br>

		</div>
	</form>
</body>
</html>
