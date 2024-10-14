<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>예약상세정보</title>
<link href="${pageContext.request.contextPath}/css/my/mycommon.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@ include file="../mainmypage.jsp" %>
<div id="reservationDetail" class="mypage-content">
	<div class="mytitle">
		<p>예약 상세 정보</p>
	</div>
    <p class="box-title">반려동물</p>
  <div class="pet-selection box mybox">
  <table class="center">
  	<tr>
  		<td class="pet_profile-td1"> <c:choose>			
			<c:when test="${reserv.pet_picture eq null}">
			<img src="upload/pet/petdefault.png" class="pet_img-big""></c:when>
			<c:otherwise><img src="image?file=${reserv.pet_picture}&type=pet" class="pet_img-big"></c:otherwise>
		</c:choose> </td>
		<td class="pet_profile-td2">${reserv.pet_name}&nbsp;&nbsp;</td>
		<td class="pet_profile-td3">(${reserv.pet_age}살, &nbsp;${reserv.pet_gender eq 'M'? '남':'여'})&nbsp;&nbsp;</td>
	    <td class="pet_profile-td3">${reserv.pet_species}&nbsp;&nbsp;</td>
	  	<td>${reserv.pet_breed}</td>
  	</tr>
  </table>
  </div>
    <br>
    <p class="box-title">예약 정보</p>
  <div class="reserve-item box mybox">
      	<table class="reserv_table">
    		<tr>
    			<td class="firstcloumn">병원 이름</td>
    			<td class="user_td2">${reserv.h_name}</td>
    		</tr>
    		<tr>
    			<td><label for="reserv_date">날짜</label></td>
    			<td>${reserv.reserv_date}<br>
</td>
    		</tr>
    		<tr>
    			<td><label for="reserv_time">시간</label></td>
    			<td>${reserv.reserv_time}<br>
</td>
    		</tr>
    		<tr>
    			<td>예약내용</td>
    			<td>
    			<div class="radio-align" >
    			<input type="radio" class="radio-hidden" id="consult" name="reserv_content"
               <c:choose>
                   <c:when test="${reserv.reserv_content eq '진료'}">checked</c:when>
                   <c:otherwise>unchecked</c:otherwise>
               </c:choose> disabled>
               <label for="consult" class="label-btnstyle btnstyle2" >진료</label>
        		<input type="radio" class="radio-hidden" id="counseling" name="reserv_content"
               <c:choose>
                   <c:when test="${reserv.reserv_content eq '상담'}">checked</c:when>
                   <c:otherwise>unchecked</c:otherwise>
               </c:choose> disabled>
               <label for="counseling" class="label-btnstyle btnstyle2">상담</label>
        	<input type="radio" class="radio-hidden" id="beauty" name="reserv_content"
               <c:choose>
                   <c:when test="${reserv.reserv_content eq '미용'}">checked</c:when>
                   <c:otherwise>unchecked</c:otherwise>
               </c:choose> disabled>
               <label for="beauty" class="label-btnstyle btnstyle2">미용</label>
        	<input type="radio" class="radio-hidden" id="etc" name="reserv_content"
               <c:choose>
                   <c:when test="${reserv.reserv_content ne '진료' && reserv.reserv_content ne '상담' && reserv.reserv_content ne '미용'}">checked</c:when>
                   <c:otherwise>unchecked</c:otherwise>
               </c:choose> disabled> 
               <label for="etc" class="label-btnstyle btnstyle2">기타</label>
               <c:if test="${reserv.reserv_content ne '진료' && reserv.reserv_content ne '상담' && reserv.reserv_content ne '미용'}"> - "${reserv.reserv_content}"</c:if>
  			</div>
  			</td>
    		</tr>
    	</table>
    </div>
    <br>
    <p class="box-title">보호자 정보</p>
  <div class="guardian-info box mybox">
  <table class="reserv_table">
    <tr>
	    <td class="firstcloumn"><label for="name">이름</label></td>
	    <td>${user.name }</td>
    </tr>
    <tr>
	    <td><label for="phone">휴대폰</label></td>
	    <td>${user.phone }</td>
    </tr>
    <tr>
	    <td><label for="email">이메일</label></td>
	    <td>${user.email }</td>
  	</tr>
  	</table>
  </div>
  <br>
  <div class="btn-box">
  <a href="javascript:window.history.back();" id="back" class="button btnPush btnBlueGreen">목록으로</a>
  </div>
  <br>
</div>

</body>
</html>