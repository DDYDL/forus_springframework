<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-반려동물등록</title>


<link rel="stylesheet" href="css/my/containerprofile.css" />
<link rel="stylesheet" href="css/my/profile.css" />
<link rel="stylesheet" href="css/my/input.css" />
<link rel="stylesheet" href="css/my/button.css" />
<link rel="stylesheet" href="css/hmy/font.css" />
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>

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

<style>
radio {
	background-color:
}
</style>
<body>
	<%@ include file="../mainmypage.jsp"%>

	<form action="myNewPet" method="post" enctype="multipart/form-data">
		<div class="mypage-content">

			<div>
				<h2 align="center">반려동물 프로필 등록</h2>
			</div>

			<table class="containerprofile">
				<tbody>
					<input type="hidden" name="pet_id" value="${pet.pet_id}">

					<div>
						<tr>
							<td style="text-align:center;" colspan="2"><img
								src="image?file=${pet.pet_picture eq null? 'petdefault.png': pet.pet_picture}&type=pet"
								class="img-icon" alt="이미지 선택" id="preview" width="130px"
								onclick="document.getElementById('file').click();"> <input
								type="file" name="file" id="file" accept="image/*"
								onchange="readURL(this);" style="display: none"></td>
						</tr>


						<tr>
							<td><label for="name" class="title">반려동물 이름</label></td>
							<td><input type="text" class="underline" name="pet_name"
								></td>
						</tr>

						<tr>
							<td><label for="nickname" class="title">종류 </label></td>
							<td><input type="text" class="underline" name="pet_species"></td>
						</tr>

						<tr>
							<td><label for="nickname" class="title">품종 </label></td>
							<td><input type="text" class="underline" name="pet_breed"></td>
						</tr>
						<tr>
							<td><label for="nickname" class="title">동물 등록 번호 </label></td>
							<td><input type="text" class="underline" name="pet_num"></td>
						</tr>

						<tr>
							<td class="title">성별</td>
							<td><input type="radio" class="petgender-check"
								name="pet_gender" id="radioPetgenderM" value="M"
								autocomplete="off"> <label class="petgender-button"
								for="radioPetgenderM">수컷</label>
								<input type="radio"
								class="petgender-check" name="pet_gender" id="radioPetgenderF"
								value="F" autocomplete="off"> <label
								class="petgender-button" for="radioPetgenderF">암컷</label>


								&nbsp;&nbsp;&nbsp;
								<input type="checkbox" class="checkbox-check" name="pet_neutering"
								id="checkPet_neutering" value="pet_neutering" autocomplete="off">
								<label class="checkbox-button" for="checkPet_neutering">중성화</label></td>

							<%-- <td><input type="radio" name="pet_gender" value="M"
								<c:if test="${pet.pet_gender eq 'M'}">checked</c:if>> 수컷
								<input type="radio" name="pet_gender" value="F"
								<c:if test="${pet.pet_gender eq 'F'}">checked</c:if>> 암컷

								<input type="checkbox"  class="petgender-check" name="pet_neutering"
								value="pet_neutering"
								<c:if test="${pet.pet_neutering eq true}">checked</c:if>>
								<label
								class="petgender-button" for="radioPetneutering">중성화</label></td> --%>

						</tr>

						<tr>
							<td class="title">나이</td>

							<td><select name="pet_age" id="pet_age">
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
							</select></td>
							


						</tr>
						<tr>
							<td class="title">특이사항</td>

							<td><textarea style="resize: none;" class="tdinput"
									id="input_box" cols="30" rows="4" name="pet_memo"></textarea></td>
						</tr>
				</tbody>
			</table>
			<br> <br>
			<div class="find-btn">
				<input type="submit" title="Button push blue/green"
					class=" btn btnPush btnBlueGreen find-btn1"
					onclick="location.href='/forus/myPetList'" value="프로필 등록">
			</div>
			<br> <br>
		</div>
	</form>
</body>
</html>
