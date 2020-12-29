<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100&display=swap" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
	<div class="container-xl">
		<h2 class="text-center">IN/OUT LIST</h2>
		
		<div class="text-center mb-5">
			<a href="${pageContext.request.contextPath}/admin/cashbookListExcel" class="font-weight-bold text-info text-decoration-none">엑셀 파일 다운로드</a>
		</div>
		
		<table class="table table-sm table-borderless">
			<thead class="border-bottom">
         <tr>
            <th>번호</th>
            <th>수입/지출</th>
            <th>카테고리</th>
            <th>가격</th>
            <th>내용</th>
            <th>사용 날짜</th>
            <th>생성 날짜</th>
            <th>수정 날짜</th>
         </tr>
      </thead>
      <tbody class="border-bottom small">
         <c:forEach var="c" items="${cashbookList}">
            <tr>
               <td>${c.cashbookId}</td>
               <td>${c.cashbookKind}</td>
               <td>${c.categoryName}</td>
               <td>${c.cashbookPrice}</td>
               <td>${c.cashbookContent}</td>
               <td>${c.cashbookDate}</td>
               <td>${c.createDate}</td>
               <td>${c.updateDate}</td>
            </tr>
         </c:forEach>
      </tbody>
   </table>
   <div style="text-align:center;">
			<c:if test="${currentPage>1}">
				<a href="${pageContext.request.contextPath}/admin/cashbookList/${currentPage-1}">이전</a>
			</c:if>
			<c:if test="${currentPage<lastPage}">
				<a href="${pageContext.request.contextPath}/admin/cashbookList/${currentPage+1}">다음</a>
			</c:if>
		</div>
	</div>
</body>
</html>