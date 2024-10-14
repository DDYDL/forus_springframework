<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약내역-지난예약</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- calendar -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
	<!-- table -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<link href="${pageContext.request.contextPath}/css/my/mycommon.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/my/mybeforereserv.css" rel="stylesheet" type="text/css">

<style>
.reserv {
	font-weight: bold;
	color: #03C75A;
}

.mypage {
	font-weight: bold;
	color: #03C75A;
}
</style>


</head>
<body>
	<%@ include file="../mainmypage.jsp"%>
    <form id="searchform" name="searchform" action="myBeforeReserv" method="get">
	<div class="mypage-content-list">
		<div class="mytitle">
			<a href="${pageContext.request.contextPath}/myAfterReserv">이후 예약</a>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="${pageContext.request.contextPath}/myBeforeReserv">지난 예약</a>
		</div>
			<c:choose>
            <c:when test="${not empty reservList}">
   <div class="overflow">
         <div class="listcnt" id="listcnt" ></div>
         <div class="over"></div>
         <div class="isConsult">
            <input type="checkbox" id="isConsult" name="isConsult" class="radio-hidden" autocomplete="off">
            <label for="isConsult" class="label-btnstyle btnsize1">진료완료만 보기</label>
         </div>
         <div class="petSelect">
            <select id="pet_id" name = "pet_id" class="petdropdown">
               <option value=""  class="center petSelect" selected>반려동물별</option>
            <c:forEach items="${petList }" var="pet">
               <option value="${pet.pet_id}" class="center petSelect">${pet.pet_name}</option>
            </c:forEach>
         </select>
         </div>
         <div class="dateSelect">
               <input class="datecalendar cursorpadding" id="dateRange" name="dateRange" type="text" placeholder=" 기간 입력">
         </div>
      </div>
		<table class="table table-hover mytable">
			<thead>
				<tr>
					<th id="reserv_date">날짜</th>
					<th id="pet_name" colspan="2">반려동물</th>
					<th id="h_name">병원</th>
					<th id="reserv_status">상태</th>
				</tr>
			</thead>
			<tbody id="resultBody">

			</tbody>
		</table>
		<br>
	<div id="paging">
	</div>
	            </c:when>
            <c:otherwise>
            <div align="center">
                <br><br><br>
                <img src="https://img.icons8.com/?size=100&id=106514&format=png">
                <br><br>
                <p>이전 예약이 없습니다</p>
                </div>
            </c:otherwise>
		</c:choose>
		<br>
		<br>
</div>
</form>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    let datecalendar = document.querySelector('.datecalendar');
    flatpickr(datecalendar, {
      mode: 'range',
      dateFormat: 'Y-m-d',
      locale: 'ko',
    });
  });
</script>

<script>
//$(document).ready(function() {
	
	$('#pet_id').change(function(e) {
		submitForm(1);
	})
    $('#isConsult').change(function(e) {
		submitForm(1);
	})
    $('#dateRange').change(function(e) {
		submitForm(1);
	})
    function submitForm(page) {
    	const isChecked = $('#isConsult').is(':checked'); // 체크박스 상태 가져오기
        console.log('isConsult 체크박스 상태:', isChecked);
        var vIsChecked = 'false';
        if (isChecked) {
            vIsChecked = 'true';
        } else {
            vIsChecked = 'false';
        }
 		var param = {pet_id:$("#pet_id").val(), isConsult:vIsChecked, dateRange:$("#dateRange").val(), page:+page};
		console.log(param)
        $.ajax({
            url: 'myBeforeReserv',
            method: 'POST',
            async:true,
            data : {param:JSON.stringify(param)},
            success: function(data) {
            	const result = data.result;
            	const pageInfo = data.pageInfo;
            	
            	const listcnt = $('#listcnt');
            	listcnt.empty();
            	listcnt.html(`<p>총 \${data.listcnt }건</p>`);
            	
                const resultBody = $('#resultBody');
                resultBody.empty(); // 기존 결과 삭제
                
                for(let reserv of result) {
                    const row = $('<tr></tr>');
                    row.click(function() {
                        window.location.href = `./reservDetail?reserv_id=\${reserv.reserv_id}`;
                    });

                    row.html(`<td>\${reserv.reserv_date}</td>`)
                    if (reserv.pet_picture == null) { row.append(`<td><img src="upload/pet/petdefault.png" class="pet_img-small"></td>`);}
                    else { row.append(`<td><img src="image?file=${reserv.pet_picture}&id=${pet_id}&type=pet" class="pet_img-small"></td>`);}
                    row.append(`<td class="textalign_left">\${reserv.pet_name}</td>
                        		<td>\${reserv.h_name}</td>
                        		<td>\${reserv.reserv_status}</td>
                    			`);
                    resultBody.append(row);
                }

                 const paging = $('#paging');
                 paging.empty();
                 
                 if (pageInfo.curPage>1) {
                	 paging.html(`<a class="pagenum" onclick="submitForm(\${pageInfo.curPage-1});">&lt;</a>&nbsp;`);
                 } else { 
                	 paging.html(`<a class="pagenum">&lt;</a>&nbsp;`); 
                 }
                 
                 for (var i = pageInfo.startPage; i <= pageInfo.endPage; i++) {
                	 console.log(pageInfo.curPage);
                	 if(i === pageInfo.curPage ){
                		 paging.append(`<a href="#" onclick="submitForm(\${i});" class="pagenum select">\${i }</a>`);
                	 } else {
                		 paging.append(`<a href="#" onclick="submitForm(\${i});" class="pagenum btn">\${i }</a>`);
                	 }
                 }
                 if(pageInfo.curPage < pageInfo.allPage){
                	 paging.append(`&nbsp;<a class="pagenum"  onclick="submitForm(\${pageInfo.curPage+1});">&gt;</a>&nbsp;`);
                 } else {
                	 paging.append(`&nbsp;<a class="pagenum">&gt;</a>`);
                 }
                 
            },
            error: (function(xhr, status, error) {
                console.error('Error:', error);
            })
        });
    }
    
    submitForm(1);

//});
</script>
</body>
</html>