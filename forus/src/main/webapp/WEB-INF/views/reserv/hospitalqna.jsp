<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.forus.dto.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<c:set var="sessionUser" value="${sessionScope.user}" />

<%--<html>--%>
<%--<head>--%>
<%--    <title></title>--%>

<%--</head>--%>




<div id="hospital-qna-section">
    <h3>QnA</h3>

    <div id="qna-input-container">
        <input type="text" id="qna-input" placeholder="질문을 작성해주세요">
        <button id="qna-submit-btn">QnA 등록</button>
    </div>

    <table class="qna-table">
        <thead>
        <tr>
            <th>작성자</th>
            <th>제목</th>
            <th>작성일</th>
        </tr>
        </thead>
        <tbody id="qna-list">
        <!-- 비동기적으로 QnA 항목들이 추가 -->
        </tbody>
    </table>
    <div id="load-more-container" style="text-align: center;">
        <button id="load-more-btn" class="minibutton minibtnFade minibtnBlueGreen">
            <img src="./img/plus.png" style="width:20px">
        </button>
    </div>


</div>

<%--</html>--%>


<script>
    const hospitalId = ${hospital.h_id};
    let currentPage = 1;
    const pageSize = 3;

</script>


<script>
    $(document).ready(function () {
        // QnA 등록 버튼 클릭 시
        $('#qna-submit-btn').on('click', function () {
            var qnaInput = $('#qna-input').val();

            if(!isLongedIn){
                alert('로그인 후 이용해주세요.');
                return;
            }

            if (qnaInput === '') {
                alert('질문을 입력해주세요.');
                return;
            }
            $.ajax({
                url: 'hospitalQuestion',
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded', // URL 인코딩 방식 사용
                data: {
                    qnaInput: qnaInput,
                    hospitalId: hospitalId
                },
                success: function (data) {
                    alert('QnA가 등록되었습니다.');
                    $('#qna-input').val('');
                    currentPage = 1; // 페이지를 초기화하여 처음부터 불러옵니다.
                    loadQnAList(); // 등록 후 목록을 다시 불러옵니다.
                },
                error: function () {
                    alert('QnA 등록에 실패했습니다.');
                }
            });
        });

        $(document).on('click', '.qna-title', function () {
            $(this).closest('tr').next('.qna-answer-row').toggle();
        });

        $(document).on('click', '.answer-submit-btn', function (e) {
            e.stopPropagation();
            const qnaId = $(this).data('qna-id');
            const answerText = $(this).siblings('.answer-input').val();


        });


    })

</script>

<script>
    $(document).on('click', '.answer-submit-btn', function (e) {
        e.stopPropagation();
        const qnaId = $(this).data('qna-id');
        const answerText = $(this).siblings('.answer-input').val();

        if (answerText === '') {
            alert('답변을 입력해주세요.');
            return;
        }

        $.ajax({
            url: 'hospitalAnswer',
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded',
            data: {
                qna_id: qnaId,
                a_title: answerText
            },
            success: function (response) {
                alert('답변이 등록되었습니다.');
                currentPage = 1; // 페이지를 초기화
                loadQnAList();
            },
            error: function (xhr) {
                alert('답변 등록에 실패했습니다: ' + xhr.responseText);
            }
        });
    });



</script>

<script>
    $(document).ready(function () {
        $('#load-more-btn').on('click', function () {
            currentPage++;
            loadQnAList();
        });

        loadQnAList();
    });

    function loadQnAList() {
        $.ajax({
            url: 'hospitalQuestion?hospitalId=' + hospitalId,
            type: 'GET',
            dataType: 'json',
            data: {
                page: currentPage,
                size: pageSize
            },
            success: function (data) {
                if (currentPage === 1) {
                    $('#qna-list').empty();
                }

                data.forEach(function (qna) {
                    const qnaRow = createQnATableRow(qna);
                    $('#qna-list').append(qnaRow);
                });

                // if (data.items.length < pageSize || currentPage * pageSize >= data.total) {
                if (data.length < pageSize) {
                    $('#load-more-btn').hide();
                } else {
                    $('#load-more-btn').show();
                }


                $('.qna-item').on('click', function () {
                    $(this).find('.qna-answer').slideToggle();
                });
            },
            error: function () {
                alert('QnA 목록을 불러오는데 실패했습니다.');
            }
        });
    }


</script>

<script>
    function createQnATableRow(qna) {
        const formattedTime = formatDate(qna.q_time);

        return `
        <tr class="qna-item">
            <td>${"${qna.q_writer}"}</td>
            <td class="qna-title" style="cursor: pointer; color: #007bff; text-decoration: underline;">
                ${"${qna.q_title}"}
            </td>
            <td>${"${formattedTime}"}</td>
        </tr>
        <tr class="qna-answer-row" style="display: none;">
          <td></td>
            <td colspan="3" style="padding: 10px;">
                <p><strong>ㄴ답변:</strong> ${"${qna.a_title || '답변이 없습니다.'}"}</p>

<%--                   <c:if test="${sessionUser !=null && sessionUser.ishospital == 1}">--%>
                  <%-- hospitaldetail.jsp에서 불러오는값--%>
                   <c:if test="${sessionUser.id eq managerId}">
                    <div class="answer-form">
                            <input type="text" class="answer-input form-control" data-qna-id="${"${qna.qna_id}"}" placeholder="답변을 입력하세요">
                            <button class="answer-submit-btn btn btn-outline-secondary" data-qna-id="${"${qna.qna_id}"}">답변 등록</button>
                        </div>
                   </c:if>
            </td>
        </tr>
    `;
    }

</script>


<script>
    function formatDate(dateString) {
        const date = new Date(dateString);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');

        return `${"${year}"}-${"${month}"}-${"${day}"} ${"${hours}"}:${"${minutes}"}`;
    }


</script>





