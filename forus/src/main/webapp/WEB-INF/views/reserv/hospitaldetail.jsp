<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>

<head>

    <link href="css/reserv/hospital.css" rel="stylesheet">
    <link href="css/reserv/hospitalModal.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- SweetAlert2 라이브러리 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

    <!-- flatpickr 라이브러리 추가 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>병원상세정보</title>



</head>
<style>
.reservation {
	font-weight: bold;
	color: #03C75A;
}
</style>
<body>
<%@ include file="../header.jsp" %>

<script>
    const isLongedIn = ${not empty sessionScope.user};
</script>




<div id="hospital-detail-content-container">

    <section id="hospital-gallery-section">
        <div id="hospital-gallery-container">
            <div id="hospital-gallery">
                <button id="prev-gallery-image" class="gallery-carousel-button">‹</button>
                <div id="main-gallery-image-container">
                    <!-- 메인 이미지를 위한 img 태그 -->
                    <img id="main-gallery-image" src="" alt="${hospital.h_name}" class="gallery-image active">
                </div>
                <button id="next-gallery-image" class="gallery-carousel-button">›</button>
            </div>
            <div id="thumbnail-gallery-container">
                <!-- 썸네일을 위한 곳  이미지는 밑에 자바스크립트에서 동적으로 추가 -->
            </div>
        </div>
    </section>



    <!-- 병원 정보 섹션 -->
    <section id="hospital-info-section">
        <div id="hospital-detail-container" class="flex-container">
            <h3 id="hospital-detail-hospitalName">${hospital.h_name}</h3>

            <!-- 예약하기 버튼 -->
            <button id="hospital-detail-reserve-button" class="btn btn-primary" onclick="handleReservationClick()">
                예약하기
            </button>
            <!-- 모달 섹션  -->
            <%@ include file="hospitalmodal.jsp" %>

            <div id="hospital-detail-info" class="hospital-info">
                <p><i class="fas fa-info-circle"></i><strong> 소개:</strong>
                    <c:choose>
                        <c:when test="${not empty hospital.h_memo}">
                            ${hospital.h_memo}
                        </c:when>
                        <c:otherwise>
                            정보 없음
                        </c:otherwise>
                    </c:choose>
                </p>

                <p><i class="fas fa-user-md"></i><strong> 수의사 이름:</strong>
                    <c:choose>
                        <c:when test="${not empty hospital.h_manager_name}">
                            ${hospital.h_manager_name}
                        </c:when>
                        <c:otherwise>
                            정보 없음
                        </c:otherwise>
                    </c:choose>
                </p>

                <p><i class="fas fa-phone-alt"></i><strong> 전화번호:</strong>
                    <c:choose>
                        <c:when test="${not empty hospital.h_phone}">
                            ${hospital.h_phone}
                        </c:when>
                        <c:otherwise>
                            정보 없음
                        </c:otherwise>
                    </c:choose>
                </p>

                <p><i class="fas fa-map-marker-alt"></i><strong> 주소:</strong>
                    <c:choose>
                        <c:when test="${not empty hospital.h_address}">
                            ${hospital.h_address}
                        </c:when>
                        <c:otherwise>
                            정보 없음
                        </c:otherwise>
                    </c:choose>
                </p>

                <p><i class="fas fa-directions"></i><strong> 길찾기 메모:</strong>
                    <c:choose>
                        <c:when test="${not empty hospital.h_memo_road}">
                            ${hospital.h_memo_road}
                        </c:when>
                        <c:otherwise>
                            정보 없음
                        </c:otherwise>
                    </c:choose>
                </p>

                <p><i class="fas fa-credit-card"></i><strong> 결제 방법:</strong>
                    <c:choose>
                        <c:when test="${not empty hospital.h_pay}">
                            ${hospital.h_pay}
                        </c:when>
                        <c:otherwise>
                            정보 없음
                        </c:otherwise>
                    </c:choose>
                </p>

                <p><i class="fas fa-parking"></i><strong> 주차 가능 여부:</strong>
                    <c:choose>
                        <c:when test="${hospital.h_parking == 'true'}">
                            가능
                        </c:when>
                        <c:otherwise>
                             불가능
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            <div id="hospital-operation-time" class="operation-time">
                <p><i class="fas fa-clock"></i><strong> 운영 시간</strong></p>
                <c:choose>
                    <c:when test="${not empty hospitalTimes}">
                        <c:forEach var="hospitalTime" items="${hospitalTimes}">
                            <p>
                                <c:choose>
                                    <c:when test="${hospitalTime.htime_opening != null && hospitalTime.htime_closing != null}">
                                        ${hospitalTime.htime_week}: ${hospitalTime.htime_opening} ~ ${hospitalTime.htime_closing}
                                    </c:when>
                                    <c:otherwise>
                                        ${hospitalTime.htime_week}: 휴무
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>운영 시간 정보 없음</p>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </section>

<%--    <hr id="hospital-detail-divider">--%>

    <!-- QnA 섹션  -->
    <%@ include file="hospitalqna.jsp" %>


</div>


<script>

    var pictureString = '${hospital.h_picture}';
    var pictures = pictureString ? pictureString.split(',') : [];

    // 썸네일을 표시할 컨테이너
    var thumbnailGalleryContainer = document.getElementById('thumbnail-gallery-container');

    // 썸네일 이미지와 메인 이미지를 업데이트하는 함수
    function updateGalleryImages(pictures) {
        // 메인 이미지 설정 (첫 번째 이미지 또는 기본 이미지)
        var mainImage = document.getElementById('main-gallery-image');
        mainImage.src = pictures.length > 0 ? `image?file=${"${pictures[0]}"}&type=hospital` : 'image?file=hospitaldefault.png&type=hospital';

        // 썸네일 이미지 설정
        for (var i = 0; i < 3; i++) {
            var imgSrc = pictures[i] ? `image?file=${"${pictures[i]}"}&type=hospital` : 'image?file=hospitaldefault.png&type=hospital';
            var thumbnailImage = document.createElement('img');
            thumbnailImage.src = imgSrc;
            thumbnailImage.alt = '${"${hospital.h_name}"}';
            thumbnailImage.className = 'thumbnail-gallery-image';
            thumbnailImage.dataset.index = i;
            thumbnailGalleryContainer.appendChild(thumbnailImage);
        }
    }

    updateGalleryImages(pictures);
</script>




<script>
    function handleReservationClick() {
        if (!isLongedIn) {
            // 로그인하지 않은 경우 알림을 표시
            alert('로그인 후 이용해주세요.');
        } else {
            // 로그인된 경우 예약 모달 열기
            initializeReservationModal();
        }
    }
</script>



<!-- 이미지 갤러리 관련 스크립트 -->
<script>
    $(document).ready(function () {
        const $mainImage = $("#main-gallery-image");
        const $thumbnails = $(".thumbnail-gallery-image");
        const $prevButton = $("#prev-gallery-image");
        const $nextButton = $("#next-gallery-image");
        let currentIndex = 0;

        function updateMainImage(index) {
            const $selectedThumbnail = $thumbnails.eq(index);
            $mainImage.attr("src", $selectedThumbnail.attr("src"));
            $thumbnails.removeClass("active").eq(index).addClass("active");
        }

        $thumbnails.each(function (index) {
            $(this).on("click", function () {
                currentIndex = index;
                updateMainImage(index);
            });
        });

        $prevButton.on("click", function () {
            currentIndex = (currentIndex === 0) ? $thumbnails.length - 1 : currentIndex - 1;
            updateMainImage(currentIndex);
        });

        $nextButton.on("click", function () {
            currentIndex = (currentIndex === $thumbnails.length - 1) ? 0 : currentIndex + 1;
            updateMainImage(currentIndex);
        });

        // 초기 설정
        updateMainImage(0);
    });
</script>

</body>
</html>