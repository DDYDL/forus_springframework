<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>For Us</title>
    <link href="css/reserv/hospital.css" rel="stylesheet">
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=94ab9074f87bbed0edf5b0d9cb32cdbd&libraries=services"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<style>
.reservation {
	font-weight: bold;
	color: #03C75A;
}
</style>
<body>
<%@ include file="../header.jsp" %>

<%--<div id="content-container">--%>
<div class="content">
    <div id="filter-container">
        <div id="search-bar-container">
            <input type="text" placeholder="주소로 검색" id="search-input">

            <div id="suggestions" class="suggestions-container">
                <%-- 검색 자동완성 제안 목록이 여기에 추가됨 --%>
            </div>
            <button id="search-button">
                <img src="img/search.png" alt="검색">
            </button>
        </div>
    </div>

    <div id="map-container">
        <img src="#" alt="Map">
    </div>

    <div id="hospitals-container">
        <%-- 비동기로 받아온 병원 목록이 여기에 추가됨 --%>
    </div>
    <div class="btndiv">
<%--    <button id="load-more" style="display: none;">더보기</button>--%>
    <button id="load-more" style="display: none;" class="minibutton minibtnFade minibtnBlueGreen">
        <img src="./img/plus.png" style="width:20px">
    </button>

    </div>

</div>



<script>
    var map;
    var userMarker;
    var searchMarker;
    var markers = [];
    let currentLat, currentLon;
    let currentPage = 1;
    let currentKeyword = '';
    let isSearchingByKeyword = false;
    let isLoadMore = false;

</script>


<script>
    // 사용자 마커 추가 함수
    function addUserMarker(lat, lon) {
        var position = new kakao.maps.LatLng(lat, lon);
        //기존 사용자 마커 제거
        if (userMarker) {
            userMarker.setMap(null);
        }
        //새로운 마커 생성
        userMarker = new kakao.maps.Marker({
            map: map,
            position: position,
            zIndex: 2,

        });

    }
</script>


<script>
    //검색 위치가 -> 사용자 마커
    function addSearchUserMarker(lat, lon) {
        var position = new kakao.maps.LatLng(lat, lon);
        // 기존 검색 마커 제거
        if (searchMarker) {
            searchMarker.setMap(null);
        }

        searchMarker = new kakao.maps.Marker({
            map: map,
            position: position,

            zIndex: 1
        });
    }
</script>

<script>
    // 지도에 병원 마커 추가 함수
    function addHospitalMarker(hospital) {
        var position = new kakao.maps.LatLng(hospital.h_latitude, hospital.h_longitude);
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png';

        var imageSize = new kakao.maps.Size(24, 35);
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

        // 마커 생성
        var marker = new kakao.maps.Marker({
            map: map,
            position: position,
            image: markerImage
        });
        markers.push(marker);// 마커 배열에 추가 나중에 초기화 할때 사용 가능

        //  (마커에 병원 이름 표시)
        var infoWindowContent = `<div style="padding:5px; font-size:12px;">${"${hospital.h_name}"}</div>`;


        var infowindow = new kakao.maps.InfoWindow({
            content: infoWindowContent
        });

        kakao.maps.event.addListener(marker, 'mouseover', function () {
            infowindow.open(map, marker);
        });

        kakao.maps.event.addListener(marker, 'mouseout', function () {
            infowindow.close();
        });

        kakao.maps.event.addListener(marker, 'click', function () {
            window.location.href = `hospitalDetail?hospitalId=${"${hospital.h_id}"}`;
        });

    }

</script>


<script>
    // 기존 마커 초기화
    function resetMarkers() {
        markers.forEach(marker => marker.setMap(null));
        markers = [];

        // 마커 제거 부분임
        if (userMarker) {
            userMarker.setMap(null);
            userMarker = null;
        }
        if (searchMarker) {
            searchMarker.setMap(null);
            searchMarker = null;
        }
    }
</script>

<script>
    let isInitialLoad = true;
    // 사용자 위치 가져오기
    function getUserLocationAndAddMarker(updateHospitals = false) {
        console.log('getUserLocationAndAddMarker 호출, updateHospitals:', updateHospitals); // 로그 추가
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function (position) {

                    if (!currentLat || !currentLon) { // 처음 설정된 경우에만 설정
                        currentLat = position.coords.latitude;
                        currentLon = position.coords.longitude;

                        var locPosition = new kakao.maps.LatLng(currentLat, currentLon);

                        map.setCenter(locPosition); // 지도 중심을 사용자 위치로 이동

                        // 사용자의 현재 위치에 마커 생성
                        addUserMarker(currentLat, currentLon);
                    }
                    //  처음 로드 시에만 병원 목록 업데이트  , 안하면 목록이 중복 추가됨
                    if (updateHospitals && currentPage === 1 && isInitialLoad) {
                        $('#hospitals-container').empty(); // 병원 목록 초기화
                        updateHospitalList(currentLat, currentLon);
                        isInitialLoad = false; // 이후 중복 호출 방지
                    }

                },
                function (error) {
                    alert('위치를 가져올 수 없습니다: ' + error.message);
                    map.setCenter(new kakao.maps.LatLng(33.450701, 126.570667)); // 기본 위치로 설정
                },
                {
                    enableHighAccuracy: true, // 높은 정확도 사용 시도
                    timeout: 5000,
                    maximumAge: 0
                }
            );
        } else {
            alert('이 브라우저에서는 위치 정보가 지원되지 않습니다.');
        }
    }
</script>

<script>
    const loadMoreButton = document.getElementById('load-more');

    function updateHospitalList(lat, lon, page = 1) {

        console.log(`요청 보내기: 페이지 번호 ${"${page}"}, 위도: ${"${lat}"}, 경도: ${"${lon}"}`);

        $.ajax({
            url: 'hospitalList',
            type: 'GET',
            dataType: 'json',
            data: {
                latitude: lat,
                longitude: lon,
                page: page,
                ajax: 'true'
            },
            success: function (data) {
                console.log(`요청 성공: ${"${data.length}"}개의 데이터 받음`);
                if (Array.isArray(data)) {
                    let hospitalListHTML = '';
                    data.forEach(function (hospital) {
                        addHospitalMarker(hospital);
                        hospitalListHTML += generateHospitalHTML(hospital);
                    });

                    $('#hospitals-container').append(hospitalListHTML);

                    if (data.length === 0) {
                        loadMoreButton.style.display = 'none';
                    } else if (data.length < 5) {
                        loadMoreButton.style.display = 'none';
                    } else {
                        loadMoreButton.style.display = 'block';
                    }
                } else {
                    console.error("서버로부터 받은 데이터가 배열이 아닙니다:", data);
                }

            },
            error: function (xhr, status, error) {
                console.error("병원 목록을 불러오는 데 실패했습니다", error);

            }
        });
    }

    loadMoreButton.addEventListener('click', function () {
        currentPage++;
        isLoadMore = true;
        console.log('Load More 클릭 - isLoadMore:', isLoadMore);
        if (isSearchingByKeyword) {
            searchHospitalsByKeyword(currentKeyword, currentPage); // 키워드로 검색 시
        } else {
            updateHospitalList(currentLat, currentLon, currentPage); // 위치로 검색 시
        }
    });

    // 초기 병원 목록 로드
    getUserLocationAndAddMarker(true);
</script>



<script>
    // 지도 생성
    var container = document.getElementById('map-container');
    var options = { // 지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 6
    };
    // 지도를 생성
    var map = new kakao.maps.Map(container, options);

    var markers = [];
    // HTML5의 Geolocation API를 사용하여 사용자 위치를 가져오기
    getUserLocationAndAddMarker(true);

</script>

<script>
    $('#search-button').on('click', function (){
            var keyword = $('#search-input').val().trim();
            if (keyword !== '') {
                isSearchingByKeyword = true;
                currentKeyword = keyword; // 검색 키워드 저장
                currentPage = 1; // 페이지 초기화
                $('#hospitals-container').html('');
                isLoadMore = false;

                resetMarkers();
                searchHospitalsByKeyword(keyword);
            }
    });

    // Enter 키로 검색 실행
    $('#search-input').on('keypress', function (e) {
        if (e.keyCode === 13) { // 엔터키를 확인
            $('#search-button').click(); // 검색 버튼 클릭 이벤트 발생
        }
    });

    function searchHospitalsByKeyword(keyword, page) {
        if (page === 1 && !isLoadMore) {
            resetMarkers();  // 더보기 시에는 호출되지 않도록 플래그를 사용
            addUserMarker(currentLat, currentLon); // 사용자 마커를 다시 추가
        }
    $.ajax({
        url: 'hospitalList',
        type: 'GET',
        dataType: 'json',
        data: {
            keyword: keyword,
            page: page,
            ajax: 'true'
        },
        success: function (data) {
            if (Array.isArray(data)) {
                let hospitalListHTML = '';
                if (page === 1 && !isLoadMore) {
                    resetMarkers();  // 초기화는 첫 페이지 로딩 시에만
                }
                addUserMarker(currentLat, currentLon);

                getUserLocationAndAddMarker(false);
                data.forEach(function (hospital) {
                    addHospitalMarker(hospital);
                    hospitalListHTML += generateHospitalHTML(hospital);
                });
                // $('#hospitals-container').html(hospitalListHTML);
                $('#hospitals-container').append(hospitalListHTML);

                if (data.length === 5) {
                    loadMoreButton.style.display = 'block';
                } else {
                    loadMoreButton.style.display = 'none';
                }

                map.setLevel(10);
            } else {
                console.error("서버로부터 받은 데이터가 배열이 아닙니다:", data);
            }
            isLoadMore = false;
            console.log('AJAX 요청 완료 후 - isLoadMore:', isLoadMore);
        },
        error: function (xhr, status, error) {
            console.error("병원 목록을 불러오는 데 실패했습니다", error);
            isLoadMore = false;
            console.log('AJAX 요청 에러 발생 - isLoadMore:', isLoadMore);
        }


    })

    }

</script>

<script>

    // 병원 목록 HTML 생성 함수
    function generateHospitalHTML(hospital) {
        return `
        <div class="hospital-item">
            <a href="hospitalDetail?hospitalId=${"${hospital.h_id}"}" class="hospital-link">
                <%--<img src="img/hospital/kosta3.png" alt="${"${hospital.h_name}"}">--%>
               <img src="image?file=${"${hospital.h_picture}" == null ? 'hospitaldefault.png' : "${hospital.h_picture}"}&type=hospital" alt="${"${hospital.h_name}"}">
                <div class="hospital-info">
                    <strong>${"${hospital.h_name}"}</strong>
                    <p>${"${hospital.h_address}"}<br>진료동물: ${"${hospital.h_animal_type}"}</p>
                </div>
            </a>
        </div>`;
    }

</script>

</body>
</html>
