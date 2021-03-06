<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100&display=swap" rel="stylesheet">
<style type="text/css">
td{
	font-family: 'Noto Sans JP', sans-serif;
}
tr{
	font-family: 'Noto Sans JP', sans-serif;
}
button{
	font-family: 'Noto Sans JP', sans-serif;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
	<div class="container">
		<h1>공지사항</h1>
		<div>
			<table class="table table-hover" style="table-layout:fixed; width:100%;">
				<thead>
					<tr class="table-active">
						<th style="width:10%">번호</th>
						<th>제목</th>
						<th>내용</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="n" items="${noticeList}">
						<tr>
							<td>
								<a href="${pageContext.request.contextPath}/admin/noticeOne/${n.noticeId}">${n.noticeId}</a>
								</td>
							<td>${n.noticeTitle}</td>
							<td style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">${n.noticeContent}</td>
							<td>${n.noticeDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div>
			<a href="${pageContext.request.contextPath}/admin/addNotice" class="btn btn-outline-success" style="float: right;">글쓰기</a>
		</div>
		<div style="text-align:center;">
			<c:if test="${currentPage>1}">
				<a href="${pageContext.request.contextPath}/admin/noticeList/${currentPage-1}">이전</a>
			</c:if>
			<c:if test="${currentPage<lastPage}">
				<a href="${pageContext.request.contextPath}/admin/noticeList/${currentPage+1}">다음</a>
			</c:if>
		</div>
	</div>
</body>
</html>