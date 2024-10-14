<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- 라이브러리 (SweetAlert2, Flatpickr -->

<%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>--%>
<%--<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>--%>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>



<style>
    #loading-spinner {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 9999;
    }

    .spinner {
        border: 8px solid #f3f3f3;
        border-top: 8px solid #3498db;
        border-radius: 50%;
        width: 60px;
        height: 60px;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% {
            transform: rotate(0deg);
        }
        100% {
            transform: rotate(360deg);
        }
    }
</style>

<div id="loading-spinner" style="display: none;">
    <div class="spinner"></div>
</div>


<!-- 예약 모달 초기화 및 Swalfire 처리 -->
<script>
    function initializeReservationModal() {
        Swal.fire({
            title: `병원 예약 - ${hospital.h_name}`,
            html: `
<!--                <div id="reservation-modal-content">-->
<!--                    <input type="text" id="reservation-date-picker" placeholder="예약 날짜를 선택하세요">-->
<!--                    <div id="time-slots-container"></div>-->
<!--                </div>-->
                 <div id="reservation-modal-content">
                    <div id="date-picker-container">
                        <div id="reservation-date-picker"></div>  <!-- 달력 위치 -->
                    </div>
<!--                    <input type="text" id="reservation-input" placeholder="예약 날짜를 선택하세요" >  &lt;!&ndash; 텍스트 박스를 달력 아래에 &ndash;&gt;-->
                      <div id="reservation-date-badge" class="badge-date" style="display: none;">예약 날짜를 선택하세요</div>
                    <div id="time-slots-container"></div>
                </div>

            `,
            showCancelButton: true,
            confirmButtonText: '다음',
            cancelButtonText: '취소',
            preConfirm: () => {
                // const selectedDate = $('#reservation-date-picker').val();
                // const selectedDate = $('#reservation-date-badge').val(); // 텍스트 박스에서 선택된 날짜 가져오기
                const selectedDate = $('#reservation-date-badge').text();
                const selectedTime = $('input[name="timeSlot"]:checked').val();

                if (!selectedDate) {
                    alert('요일을 선택해주세요.');
                    return false;
                }
                if (!selectedTime) {
                    alert('예약 시간을 선택해주세요.');
                    return false;
                }

                return {selectedDate, selectedTime};
            }
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: 'reservationInfo',
                    dataType: 'json',
                    method: 'GET',
                    success: function (response) {
                        const user = response.user;
                        const pet = response.pet;

                        if (!pet || pet.length === 0) {
                            Swal.fire({
                                icon: 'warning',
                                title: '예약 불가',
                                text: '등록된 펫이 없습니다. 펫을 먼저 등록한 후 예약을 진행해주세요.',
                                confirmButtonText: '확인'
                            });
                            return;
                        }

                        Swal.fire({
                            title: '예약 정보 확인',
                            html: generateReservationHtml(result.value, user, pet),
                            confirmButtonText: '예약 완료',
                            cancelButtonText: '취소',
                            showCancelButton: true,

                            preConfirm: () => {
                                const form = document.getElementById('reservationForm');
                                const reservationContent = document.querySelector('input[name="reservationContent"]:checked');
                                const selectedPet = document.querySelector('input[name="selectedPetId"]:checked');
                                const otherText = document.getElementById('otherText');
                                const otherRadio = document.getElementById('radioOther');

                                if (!selectedPet) {
                                    alert('펫을 선택하세요.');
                                    return false;
                                }


                                if (!reservationContent) {
                                    alert('예약 항목을 선택하세요.');
                                    return false;
                                }

                                if(otherRadio.checked && otherText.value.trim() === '') {
                                    alert('기타 항목을 입력하세요.');
                                    return false;
                                }

                                if (form) {
                                    $.ajax({
                                        url: form.action,
                                        method: form.method,
                                        data: $(form).serialize(),
                                        success: function (response) {
                                            Swal.close();
                                            alert('예약이 완료되었습니다.');
                                        },
                                        error: function () {
                                            alert('예약을 완료하는 중 오류가 발생했습니다. 다시 시도해 주세요.');
                                        },
                                    });
                                    return false;  // 폼의 기본 제출 동작 방지
                                } else {
                                    Swal.showValidationMessage('예약 정보를 찾을 수 없습니다. 다시 시도해 주세요.');
                                }
                            }

                        });
                    }, error: function (jqXHR, textStatus, errorThrown) {
                        // 요청이 실패할 경우 오류 메시지 표시
                        Swal.fire({
                            icon: 'error',
                            title: '오류 발생',
                            text: '예약 정보를 가져오는 중 오류가 발생했습니다. 다시 시도해 주세요.'
                        });
                    }
                });
            }
        });
        initializeDatePicker();
    }
</script>

<!-- Flatpickr 및 디바운스 처리 -->
<script>
    function showLoadingSpinner() {
        $('#loading-spinner').show();
    }

    function hideLoadingSpinner() {
        $('#loading-spinner').hide();
    }

    const debouncedFetch = _.debounce(function (dateStr) {
        showLoadingSpinner();
        getAvailableTimeSlots(dateStr);
    }, 300);

    function initializeDatePicker() {
        // 플리피커(Flatpickr) 초기화
        flatpickr("#reservation-date-picker", {
            inline: true,
            dateFormat: "Y-m-d",
            minDate: "today",
            maxDate: new Date().fp_incr(7),
            onChange: function (selectedDates, dateStr) {
                // updateAvailableTimeSlots(dateStr);
                // $('#reservation-input').val(dateStr);
                const badge = document.getElementById('reservation-date-badge');
                badge.textContent = dateStr;
                badge.style.display = "inline-block"; // 배지를 보이게 설정
                debouncedFetch(dateStr);
            }
        });
    }

</script>

<!-- 예약 가능한 시간 슬롯 요청 -->
<script>
    function getAvailableTimeSlots(dateStr) {
        const hospitalId = ${hospital.h_id};
        $.ajax({
            url: 'reservation',
            dataType: 'json',
            type: 'GET',
            data: {hospitalId, dateStr},
            success: function (response) {

                const availableTimes = response.availableTimeSlots;
                const $timeSlotContainer = $('#time-slots-container');
                $timeSlotContainer.html(generateTimeSlotHTML(availableTimes));
                hideLoadingSpinner();
            }
        });
    }

    function updateAvailableTimeSlots(dateStr) {
        getAvailableTimeSlots(dateStr);
    }
</script>

<!-- 시간 슬롯 생성 및 HTML 생성 관련 함수 -->
<script>
    function generateTimeSlotHTML(availableTimes) {
        return availableTimes.map(time => createTimeSlotLabel(time)).join('');
    }

    function createTimeSlotLabel(time) {
        const hour = String(time.time.hour).padStart(2, '0');
        const minute = String(time.time.minute).padStart(2, '0');
        const timeLabel = `${"${hour}"}:${"${minute}"}`;
        const disabledAttribute = getDisabledAttribute(time.isAvailable);
        return `
             <label class="time-slot-label">
                <input type="radio" name="timeSlot" value="${"${timeLabel}"}" ${"${disabledAttribute}"}>
                <span class="time-slot-button">${"${timeLabel}"}</span>
            </label>
        `;
    }

    function getDisabledAttribute(isAvailable) {
        return !isAvailable ? 'disabled' : '';
    }
</script>


<script>
    // function initializeCheckboxHandler() {
    //     $(document).on('change', '.reservation-check', function () {
    //         if ($('#radioOther').is(':checked')) {  // 기타 옵션 체크
    //             $('#otherText').prop('disabled', false);  // 입력 필드 활성화
    //         } else {
    //             $('#otherText').prop('disabled', true).val('');  // 다른 옵션 선택 시 비활성화 및 초기화
    //         }
    //     });
    //
    //     // 폼이 제출될 때 텍스트 입력이 비활성화되지 않도록 설정
    //     $(document).on('submit', '#reservationForm', function () {
    //         $('#otherText').prop('disabled', false);  // 폼 제출 시 입력 필드를 활성화 상태로 유지
    //     });
    // }
    function initializeCheckboxHandler() {
        $(document).on('change', '.reservation-check', function () {
            if ($('#radioOther').is(':checked')) {
                $('#otherText').show();  // 기타 선택 시 텍스트 입력 필드 보이기
            } else {
                $('#otherText').hide().val('');  // 다른 옵션 선택 시 텍스트 입력 필드 숨기기 및 초기화
            }
        });

        // 폼이 제출될 때 텍스트 입력이 비활성화되지 않도록 설정
        $(document).on('submit', '#reservationForm', function () {
            $('#otherText').prop('disabled', false);  // 폼 제출 시 입력 필드를 활성화 상태로 유지
        });
    }


    function generatePetHtml(pets) {
        // if (!pets || !pets.length) {
        //     return `<p><strong>등록된 펫이 없습니다.</strong></p>`;
        if (!pets || pets.length === 0) {
            return `<p><strong>등록된 펫이 없습니다. 등록 후 예약해주세요.</strong></p>`;
        } else {
            return pets.map(pet => `
            <%--  <div class="pet-selection">--%>
            <%--  <label>--%>
            <%--        <input type="radio" name="selectedPetId" value="${"${pet.pet_id}"}">--%>
            <%--        &lt;%&ndash;<img src="${"${pet.pet_picture}"}" alt="${"${pet.pet_name}"}">&ndash;%&gt;--%>
            <%--          <img src="image?file=${"${pet.pet_picture}" == null ? 'petdefault.png' : "${pet.pet_picture}"}&type=pet" alt="${"${pet.pet_name}"}">--%>

            <%--    </label>--%>
            <%--</div>--%>
        <%--<div class="pet-selection">--%>
        <%--  <label>--%>
        <%--      <img src="image?file=${"${pet.pet_picture}" == null ? 'petdefault.png' : "${pet.pet_picture}"}&type=pet" alt="${"${pet.pet_name}" == null ? '펫' : "${pet.pet_name}"}">--%>
        <%--      <input type="radio" name="selectedPetId" value="${"${pet.pet_id}"}">--%>
        <%--       <span class="pet-name">${"${pet.pet_name}"}</span>--%>
        <%--  </label>--%>
        <%--</div>--%>
     <div class="pet-selection">
        <img src="image?file=${"${pet.pet_picture}" == null ? 'petdefault.png' : "${pet.pet_picture}"}&type=pet" alt="${"${pet.pet_name}" == null ? '펫' : "${pet.pet_name}"}">
    <input type="radio" class="pet-radio-btn" name="selectedPetId" id="pet-${"${pet.pet_id}"}" value="${"${pet.pet_id}"}" autocomplete="off">
    <label class="pet-selection-button" for="pet-${"${pet.pet_id}"}">
        <span class="pet-name">${"${pet.pet_name}"}</span>
    </label>
</div>

        `).join('');

        }
    }


    function generateReservationHtml(result, user, pets) {
        const petHtml = generatePetHtml(pets);

        return `
        <form id="reservationForm" action="reservation" method="POST">

            <div class="reservation-summary">
                  <h3>펫 선택</h3>
                 ${"${petHtml}"}

            <div class="reservation-items">
                <h3>예약 항목</h3>
                <div class="btn-group" role="group" aria-label="Reservation options">
                    <input type="radio" class="reservation-check" name="reservationContent" id="radioMedical" value="진료" autocomplete="off">
                    <label class="reservation-button" for="radioMedical">진료</label>

                    <input type="radio" class="reservation-check" name="reservationContent" id="radioConsulting" value="상담" autocomplete="off">
                    <label class="reservation-button" for="radioConsulting">상담</label>

                    <input type="radio" class="reservation-check" name="reservationContent" id="radioBeauty" value="미용" autocomplete="off">
                    <label class="reservation-button" for="radioBeauty">미용</label>

                    <input type="radio" class="reservation-check" name="reservationContent" id="radioOther" value="기타" autocomplete="off">
                    <label class="reservation-button" for="radioOther">기타</label>
                </div>

                <!-- '기타' 선택 시 활성화되는 입력 필드 -->
            <input type="text" id="otherText" name="customContent" placeholder="직접 입력하기" class="form-control mt-2" style="display: none;">
            </div>

                <br>

            <div class="reservation-date">
              <h3>예약 정보 </h3>
              <p>예약 날짜: ${"${result.selectedDate}"}</p>
              <input type="hidden" name="selectedDate" value="${"${result.selectedDate}"}">
              <p>예약 시간:${"${result.selectedTime}"}</p>
              <input type="hidden" name="selectedTime" value="${"${result.selectedTime}"}">
            </div>

            <br>

            <div class="guardian-info">
                <h3>보호자 정보</h4>
                <p>예약자 이름: ${"${user.name}"}</p>
                <p>예약자 번호 : ${"${user.phone}"}</p>
                <p>예약자 메일: ${"${user.email}"}</p>
                <input type="hidden" name="userName" value="${"${user.name}"}">
                <input type="hidden" name="userId" value="${"${user.id}"}">
            </div>
              <input type="hidden" name="hospitalId" value="${hospital.h_id}">
        </div>
        </form>

        `;
    }


    $(document).ready(function () {
        initializeCheckboxHandler();
    });
</script>

