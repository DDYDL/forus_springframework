<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이병원-오늘예약일정</title>

    <style>
        .todays {
            font-weight: bold;
            color: #03C75A;
        }

        .myhospital {
            font-weight: bold;
            color: #03C75A;
        }

        #reservationStatus {
            border-radius: 5px;
            width: 150px;
            height: 35px;
        }
    </style>

    <style>
        table td.reserv-status-completed {
            background-color: #03C75A !important;
            color: white !important;
        }

        table td.reserv-status-cancelled {
            background-color: rgb(128, 128, 128) !important;
            color: white !important;
        }

        table td.reserv-status-missed {
            background-color: yellow !important;
            color: #262627 !important;
        }

        table td.reserv-status-reserved {
            background-color: blue !important;
            color: white !important;
        }

        .todayreservSide {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        .todayreservSide th, .todayreservSide td {
            padding: 10px;
            text-align: left;
            vertical-align: top;
            width: 40%;
        }

        .todayreservHeader {
            width: 30%;
            background-color: #f9f9f9;
            font-weight: bold;
        }

        .todayreservRow td {
            width: 70%;
        }

        .todayreservRow {

        }

        .todayreservSideContentAndTime {
            /* width: 100%; */
            /* border-collapse: collapse; */
            /* margin: 20px 0; */
            width: 104%;
            border-collapse: collapse;
            margin: -17px 0px;

        }

        .todayreservSideContentAndTime th, .todayreservSideContentAndTime td {
            padding: 10px;
            text-align: left;
            vertical-align: top;
            width: 40%;
        }

        #reservationStatus {
            border-radius: 5px;
            width: 150px;
            height: 35px;
        }

        #todayreservSide {
            font-size: 18px;
            font-weight: bold;
            text-align: left;
            margin: 0;
        }

    </style>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="css/hmy/doctorCalendar.css">

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


    <link rel="stylesheet" href="css/hmy/font.css"/>
    <link rel="stylesheet" href="css/hmy/list.css"/>
</head>
<body>
<%@ include file="../mainhmypage.jsp" %>


<div id="overlay" onclick="closeSidebar()"></div>
<div id="sidebar">
    <p id="todayreservSide" align="center">예약 상세 정보</p>
    <%--	<p><strong>예약자 이름:</strong> <span id="reserverName"></span></p>--%>
    <%--	<p><strong>동물:</strong> <span id="animalType"></span></p>--%>
    <%--	<p><strong>종:</strong> <span id="animalBreed"></span></p>--%>
    <%--	<p><strong>펫이름:</strong> <span id="animalName"></span></p>--%>

    <table class="todayreservSide">
        <tr class="todayreservRow">
            <th class="todayreservHeader">예약자 이름</th>
            <td><span id="reserverName"></span></td>
        </tr>
        <tr class="todayreservRow">
            <th class="todayreservHeader">동물</th>
            <td><span id="animalType"></span></td>
        </tr>
        <tr class="todayreservRow">
            <th class="todayreservHeader">종</th>
            <td><span id="animalBreed"></span></td>
        </tr>
        <tr class="todayreservRow">
            <th class="todayreservHeader">펫 이름</th>
            <td><span id="animalName"></span></td>
        </tr>
    </table>

    <p id="eventContent"></p>


    <label for="vetNote"></label>
    <textarea id="vetNote" placeholder="메모를 입력하세요..."></textarea>
    <button id="saveNoteButton" onclick="saveNote()">메모 저장</button>
    <button id="closeSidebarButton" onclick="closeSidebar()">닫기</button>
</div>


<div class="mypage-content-list">
    <div>
        <p class="mypage-content-title" align="center">오늘 예약 일정</p>
    </div>
    <div style="text-align: left;padding:30px 10px 3px 0;">

        <div>

	<c:choose>
            <c:when test="${not empty reservList}">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th></th>
                        <th>예약번호</th>
                        <th>보호자</th>
                        <th>연락처</th>
                        <th>시간</th>
                        <th>펫 이름</th>
                        <th>신청 날짜</th>
                        <th>사항</th>
                        <th>상태</th>
                    </tr>
                    </thead>
                    <c:forEach items="${reservList }" var="reservation">
                        <c:set var="i" value="${i+1 }"/>
                        <tr onclick="getReservationDetails(this)"
                            data-reservation-id="${reservation.reserv_id}"
                            data-reservation-memo="${reservation.reserv_memo}"
                            data-reservation-content="${reservation.reserv_content}"
                            data-reservation-time="${reservation.reserv_time}"
                            data-reservation-status="${reservation.reserv_status}"
                        >

                            <td>${i }</td>
                            <td>${reservation.reserv_id }</td>
                            <td>${reservation.name }</td>
                            <td>${reservation.phone }</td>
                            <td>${reservation.reserv_time}</td>
                            <td>${reservation.pet_name }</td>
                            <td>${reservation.reserv_apply_time}</td>
                            <td>${reservation.reserv_content }</td>
                            <c:set var="statusClass">
                                <c:choose>
                                    <c:when test="${reservation.reserv_status == '예약'}">reserv-status-reserved</c:when>
                                    <c:when test="${reservation.reserv_status == '진료완료'}">reserv-status-completed</c:when>
                                    <c:when test="${reservation.reserv_status == '예약취소'}">reserv-status-cancelled</c:when>
                                    <c:when test="${reservation.reserv_status == '미방문'}">reserv-status-missed</c:when>
                                </c:choose>
                            </c:set>

                            <td class="${statusClass}">
                                    ${reservation.reserv_status}
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>

            <c:otherwise>
                <div align="center">
                <br><br><br>
	           <img src="https://img.icons8.com/?size=100&id=61080&format=png">
                <br><br>
                <p>오늘은 예약된 일정이 없습니다</p>
                </div>
            </c:otherwise>
		</c:choose>
        </div>
    </div>
</div>


<script>
    function openSidebar() {
        document.getElementById('sidebar').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';
    }

    function closeSidebar() {
        document.getElementById('sidebar').style.display = 'none';
        document.getElementById('overlay').style.display = 'none';
    }

    function getReservationDetails(row) {

        var reservationId = $(row).data('reservation-id');
        var reservationMemo = $(row).data('reservation-memo');
        var reservationContent = $(row).data('reservation-content');
        var reservationTime = $(row).data('reservation-time');
        var reservationStatus = $(row).data('reservation-status');

        $.ajax({
            url: 'doctorCalendarDetail',
            type: 'get',
            dataType: 'json',
            data: {
                reservationId: reservationId
            },
            success: function (data) {
                generateReservationDetails(data, reservationId, reservationMemo, reservationContent, reservationTime, reservationStatus);
                openSidebar();
            },
            error: function () {
                alert('예약 상세 정보를 불러오는데 실패했습니다.');
            }
        });
    }

    function generateReservationDetails(data, reservationId, reservationMemo, reservationContent, reservationTime, reservationStatus) {
        $('#eventContent').empty();

        document.getElementById('reserverName').textContent = data.userName;
        document.getElementById('animalType').textContent = data.petSpecies;
        document.getElementById('animalBreed').textContent = data.petBreed;
        document.getElementById('animalName').textContent = data.petName;

        $('#vetNote').val(reservationMemo || '');

        var statusSelect =
            '<strong>예약상태</strong>:' +
            '<select id="reservationStatus">' +
            '<option value="예약"' + (reservationStatus == '예약' ? ' selected' : '') + '>예약</option>' +
            '<option value="진료완료"' + (reservationStatus == '진료완료' ? ' selected' : '') + '>진료완료</option>' +
            '<option value="예약취소"' + (reservationStatus == '예약취소' ? ' selected' : '') + '>예약취소</option>' +
            '<option value="미방문"' + (reservationStatus == '미방문' ? ' selected' : '') + '>미방문</option>' +
            '</select><br><br>';


        // $('#eventContent').append(detailsTable);
        var detailsTable = `
       <table class="todayreservSideContentAndTime">
            <tr>
                <th>예약 상태</th>
                <td>
                    <select id="reservationStatus">
                        <option value="예약"${"${reservationStatus}" == '예약' ? ' selected' : ''}>예약</option>
                        <option value="진료완료"${"${reservationStatus}" == '진료완료' ? ' selected' : ''}>진료완료</option>
                        <option value="예약취소"${"${reservationStatus}" == '예약취소' ? ' selected' : ''}>예약취소</option>
                        <option value="미방문"${"${reservationStatus}" == '미방문' ? ' selected' : ''}>미방문</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>${"${reservationContent}"}</td>
            </tr>
            <tr>
                <th>시간</th>
                <td>${"${reservationTime}"}</td>
            </tr>
        </table>
    `;

        $('#eventContent').append(detailsTable);


        $('#eventContent').data('reservationId', reservationId);
        $('#reservationStatus').val(reservationStatus);


    }


</script>

<script>
    function updateReservationStatus($element) {
        var newStatus = $element.val();
        var originalStatus = $element.data('originalStatus');
        var reservationId = $('#eventContent').data('reservationId');

        if (confirm(newStatus + " 상태로 변경하시겠습니까?")) {
            $.ajax({
                url: 'updateReservationStatus',
                type: 'POST',
                data: {
                    reservationId: reservationId,
                    reservationStatus: newStatus
                },
                success: function (response) {
                    alert('예약 상태가 변경되었습니다.');

                    var $td = $('tr[data-reservation-id="' + reservationId + '"]').find('td:last');

                    // 기존 상태 클래스를 제거
                    $td.removeClass('reserv-status-reserved reserv-status-completed reserv-status-cancelled reserv-status-missed');

                    // 새로운 상태에 맞는 클래스를 추가
                    if (newStatus === '예약') {
                        $td.addClass('reserv-status-reserved');
                    } else if (newStatus === '진료완료') {
                        $td.addClass('reserv-status-completed');
                    } else if (newStatus === '예약취소') {
                        $td.addClass('reserv-status-cancelled');
                    } else if (newStatus === '미방문') {
                        $td.addClass('reserv-status-missed');
                    }

                    // 테이블의 상태 텍스트도 업데이트
                    $td.text(newStatus);


                    // 테이블의 data-reservation-status 값을 업데이트하여 사이드바에서 열릴 때 최신 상태가 유지되도록 함
                    $('tr[data-reservation-id="' + reservationId + '"]').data('reservation-status', newStatus);

                    $element.data('originalStatus', newStatus);

                },
                error: function () {
                    alert('예약 상태 변경에 실패했습니다.');
                    $element.val(originalStatus);
                }
            });
        } else {
            $element.val(originalStatus);
        }
    }


    $(document).ready(function () {
        $(document).on('change', '#reservationStatus', function () {
            updateReservationStatus($(this));
        });
    });


</script>


<script>
    function saveNote() {
        var reservationId = $('#eventContent').data('reservationId');

        if (!reservationId) {
            alert('Reservation ID가 올바르지 않습니다.');
            return;
        }
        var memo = $('#vetNote').val();

        $.ajax({
            url: 'doctorCalendarDetail',
            type: 'post',
            dataType: 'json',
            data: {
                reservationId: reservationId,
                memo: memo
            },
            success: function (response) {
                alert('메모가 저장되었습니다.');

                // 메모 입력창에 입력한 메모를 표시
                $('#vetNote').val(memo);

                // 메모를 저장한 row의 메모 데이터를 업데이트
                $('tr[data-reservation-id="' + reservationId + '"]').data('reservation-memo', memo);
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
                alert('메모 저장에 실패했습니다.');
            }
        });
    }
</script>


</body>
</html>

