<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Help지원 목록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="./resources/css/recruit/recruitapplylist.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@ include file="../mainmypage.jsp" %>
	
	<div class="mypage-content-list">
		<p class="mypage-content-title">지원자 목록</p>
	
	<div>총 ${fn:length(recruit_applyList)}명
	<table class="table table-hover"> 
        <thead>
           <tr>
                <th></th><th></th><th>프로필</th><th>지원일</th>
           </tr>
        </thead>
        <tbody>
        	<c:forEach items="${recruit_applyList}" var="recruit_apply">
        		<c:forEach items="${userList}" var="userAp">
		            <tr onclick="location.href='./recruitApplyDetailpage?apply_id=${recruit_apply.apply_id}'">
		            	<c:if test="${recruit_apply.user_id eq userAp.id}">
		            		<c:choose>
		            			<c:when test="${recruit_apply.apply_status eq '채용'}">
		            				<td class="apply_td"><p>${recruit_apply.apply_status}&nbsp;<img src="resources/img/recruit.png" class="icon" ></p></td>
		            			</c:when>
		            			<c:otherwise><td></td></c:otherwise>
		            		</c:choose>
		            	<td class="user_img_div"><img src="image?file=${userAp.picture eq null? 'userdefault.png': userAp.picture}&type=user" class="img-icon user_img"></td>
		                <td><div>
		    			<p class="content-inner-title">${userAp.name}&nbsp;(${userAp.birthday},&nbsp;${userAp.gender eq "M"? "남":"여"})</p>
		    			<p class="content-document">${recruit_apply.apply_title}</p>
		    			</div></td>
		    			<td>${recruit_apply.apply_time}</td>
		    			</c:if>
		            </tr>
	            </c:forEach>
            </c:forEach>
        </tbody>
    </table>
    </div>
    </div>
</body>
</html>