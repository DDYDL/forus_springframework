<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>마이병원-예약일정캘린더</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- FullCalendar CSS -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet'/>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>

    <!-- FullCalendar 언어 지원 -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>

    <link rel="stylesheet" href="css/hmy/doctorCalendar.css">

</head>
<style>
.managereserv {
	font-weight: bold;
	color: #03C75A;
}

.myhospital{
	font-weight: bold;
	color: #03C75A;
}



</style>




<body>
<%@ include file="../header.jsp" %>
<%@ include file="../hmymenu.jsp" %>
<c:set var="sessionUser" value="${sessionScope.user}"/>

<%--<section>--%>
<%--    <div>--%>
<%--        <button id="reservationTimeButton">예약 시간 관리</button>--%>
<%--    </div>--%>
<%--</section>--%>

<section>
	<div class="mypage-content">
    	<div id="calendar"></div>
    </div>
</section>


<!-- 예약 상세 정보 사이드바 -->
<div id="overlay" onclick="closeSidebar()"></div>
<div id="sidebar">
    <h3>예약 상세 정보</h3>
    <p id="eventContent">내용이 여기에 표시됩니다.</p>

    <table class="reservation-details-table">
        <tr>
            <td class="reservation-label"><strong>예약자 이름</strong></td>
            <td class="reservation-value"><span id="reserverName"></span></td>
        </tr>
        <tr>
            <td class="reservation-label"><strong>동물</strong></td>
            <td class="reservation-value"><span id="animalType"></span></td>
        </tr>
        <tr>
            <td class="reservation-label"><strong>종</strong></td>
            <td class="reservation-value"><span id="animalBreed"></span></td>
        </tr>
        <tr>
            <td class="reservation-label"><strong>펫이름</strong></td>
            <td class="reservation-value"><span id="animalName"></span></td>
        </tr>
    </table>



    <label for="vetNote"></label><textarea id="vetNote" placeholder="메모를 입력하세요..."></textarea>
    <button id="saveNoteButton" onclick="saveNote()">메모 저장</button>
    <button id="closeSidebarButton" onclick="closeSidebar()">닫기</button>
</div>



<script>
    var userId = ${sessionUser.id};
    var calendar;


    document.addEventListener('DOMContentLoaded', function () {
        var calendarEl = document.getElementById('calendar');

        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridDay'
            },
            dayCellContent: function (arg) {
                return {html: arg.date.getDate()}; // 날짜 숫자만 출력
            },

            events: function (fetchInfo, successCallback, failureCallback) {
                $.ajax({
                    url: 'doctorCalendarList',
                    type: 'get',
                    dataType: 'json',
                    data: {
                        startDate: fetchInfo.startStr,
                        endDate: fetchInfo.endStr,
                        userId: userId
                    },
                    success: function (data) {
                        var events = data.map(function (reservation) {
                            var startDateTime = formatDateTime(reservation.reservDate, reservation.reservTime);
                            return {
                                title: '예약: ' + reservation.reservId,
                                start: startDateTime,
                                end: startDateTime,
                                extendedProps: {
                                    reservationStatus: reservation.reservStatus,
                                    reservationId: reservation.reservId,
                                    reservationContent: reservation.reservContent,
                                    reservationMemo: reservation.reservMemo
                                },
                                classNames: [getStatusClassName(reservation.reservStatus)]
                            }
                        });
                        successCallback(events);
                    },
                    error: function () {
                        failureCallback();
                    }
                })
            },
            views: {
                timeGridDay: {
                    slotDuration: '00:60:00',
                    slotLabelInterval: '00:60',
                    slotLabelFormat: {
                        hour: '2-digit',
                        minute: '2-digit',
                        meridiem: false,
                        hour12: false
                    }
                }
            },
            dateClick: function (info) {
                // 날짜 클릭 시 일별 보기로 전환~ 하는거
                calendar.changeView('timeGridDay', info.dateStr);
            },
            eventClick: function (info) {
                //doctorCalendarList에서 가져온 정보를 이용해서 상세보기를 만들어줌
                generateEventContent(info.event);
                // 예약자 이름, 동물, 종은 AJAX 요청으로 가져옴
                var reservationId = info.event.extendedProps.reservationId;
                getReservationDetails(reservationId);

            },
        });
        calendar.render();
    });


    function openSidebar() {
        document.getElementById('sidebar').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';
    }

    function closeSidebar() {
        document.getElementById('sidebar').style.display = 'none';
        document.getElementById('overlay').style.display = 'none';
    }

</script>

<script>
    function getReservationDetails(reservationId) {
        $.ajax({
            url: 'doctorCalendarDetail',
            type: 'get',
            dataType: 'json',
            data: {
                reservationId: reservationId
            },
            success: function (data) {
                // 예약 상세 정보를 가져와서 화면에 출력
                generateReservationDetails(data);
                openSidebar();
            },
            error: function () {
                alert('예약 상세 정보를 불러오는데 실패했습니다.');
            }
        });

    }


</script>

<script>
    function saveNote() {
      var reservationId = $('#eventContent').data('reservationId');
      console.log(reservationId);
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
                updateEventMemo(reservationId, memo);
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
                alert('메모 저장에 실패했습니다.');
            }
        });
    }

    function updateEventMemo(reservationId, memo) {
        var events = calendar.getEvents();
        var event = events.find(function (e) {
            return e.extendedProps.reservationId == reservationId;
        });
        if (event) {
            event.setExtendedProp('reservationMemo', memo);
        }
    }
</script>


<script>
    // 날짜와 시간 객체를 받아서 YYYY-MM-DDTHH:mm:ss 형식의 문자열로 변환하는 함수
    function formatDateTime(reservDate, reservTime) {
        return `${"${reservDate.year}"}-` +
            `${"${reservDate.month.toString().padStart(2, '0')}"}-` +
            `${"${reservDate.day.toString().padStart(2, '0')}"}T` +
            `${"${reservTime.hour.toString().padStart(2, '0')}"}:` +
            `${"${reservTime.minute.toString().padStart(2, '0')}"}:` +
            `${"${reservTime.second.toString().padStart(2, '0')}"}`
    }
</script>

<script>
    $(document).ready(function() {
        $('#eventContent').on('change', '#reservationStatus', function() {
            updateReservationStatus($(this));
        });
    });

    function generateEventContent(event) {
        var timeString = event.start.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

        $('#eventContent').html(
            `
    <table class="reservation-table">
        <tr class="reservation-row">
            <td class="reservation-label"><strong>예약상태</strong></td>
            <td class="reservation-value">
                <select id="reservationStatus" >
                    <option value="예약" ${"${event.extendedProps.reservationStatus === '예약' ? 'selected' : ''}"}>예약</option>
                    <option value="진료완료" ${"${event.extendedProps.reservationStatus === '진료완료' ? 'selected' : ''}"}>진료완료</option>
                    <option value="예약취소" ${"${event.extendedProps.reservationStatus === '예약취소' ? 'selected' : ''}"}>예약취소</option>
                    <option value="미방문" ${"${event.extendedProps.reservationStatus === '미방문' ? 'selected' : ''}"}>미방문</option>
                </select>
            </td>
        </tr>
        <tr class="reservation-row">
            <td class="reservation-label"><strong>예약 번호</strong></td>
            <td class="reservation-value">${"${event.extendedProps.reservationId}"}</td>
        </tr>
        <tr class="reservation-row">
            <td class="reservation-label"><strong>예약 시간</strong></td>
            <td class="reservation-value">${"${timeString}"}</td>
        </tr>
        <tr class="reservation-row">
            <td class="reservation-label"><strong>예약 항목</strong></td>
            <td class="reservation-value">${"${event.extendedProps.reservationContent}"}</td>
        </tr>
    </table>
    `
        ).data('reservationId', event.extendedProps.reservationId);

        $('#vetNote').val(event.extendedProps.reservationMemo || '');

        $('#reservationStatus').data('originalStatus', event.extendedProps.reservationStatus);

    }
</script>
<script>
    function generateReservationDetails(data) {
        $('#reserverName').text(data.userName);
        $('#animalType').text(data.petSpecies);
        $('#animalBreed').text(data.petBreed);
        $('#animalName').text(data.petName);
    }
</script>

<script>
function updateReservationStatus($element) {
     var newStatus = $element.val();// 선택한 새로운 상태 값 가져오는코드
     var originalStatus = $element.data('originalStatus');
     var reservationId = $('#eventContent').data('reservationId');

    if (confirm(newStatus + " 상태로 변경하시겠습니까?")) {
        $.ajax({
            url: 'updateReservationStatus',
            type: 'POST',
            data: {
                reservationId:reservationId,
                reservationStatus: newStatus
            },
            success: function (response) {
                alert('예약 상태가 변경되었습니다.');

                updateEventStatus(reservationId, newStatus);
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

function updateEventStatus(reservationId, newStatus) {
    var events = calendar.getEvents();
    var event = events.find(function (e) {
        return e.extendedProps.reservationId == reservationId;
    });

    if (event) {
        event.setExtendedProp('reservationStatus', newStatus);
        var classNames = getStatusClassName(newStatus);

        // 클래스 추가
        event.setProp('classNames', [classNames]);
    }
}

// 예약 상태에 따른 클래스 이름을 반환하는 함수
function getStatusClassName(status) {
    switch (status) {
        case '예약':
            return 'status-reservation';
        case '진료완료':
            return 'status-complete';
        case '미방문':
            return 'status-no-show';
        case '예약취소':
            return 'status-cancelled';
        default:
            return 'status-default';
    }
}
</script>

</body>
</html>