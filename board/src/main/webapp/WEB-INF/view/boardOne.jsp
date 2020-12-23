<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>boardView</title>
<!-- 부트 스트랩 CDN -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<!-- js -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
</head>
<body>
<div class="alert alert-dark">
<h1>게시글 자세히보기</h1>
</div>

		  <table class="table table-dark table-striped">
				<tr><td>board_no : ${board.boardNo}</td></tr>
				<tr><td>board_title : ${board.boardTitle}</td></tr>
				<tr><td>board_content :${board.boardContent}</td></tr>
				<tr><td>board_user : ${board.boardUser}</td></tr>
				<tr><td>board_date : ${board.boardDate}</td></tr>
		 </table>	
		 	<a type="button" class="btn btn-outline-info" href="${pageContext.request.contextPath}/admin/modifyboard/${board.boardNo}">수정</a>
		 	<a type="button" class="btn btn-outline-danger" href="${pageContext.request.contextPath}/admin/removeBoard/${board.boardNo}">삭제</a>
		 	<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/admin/boardList/1">글목록</a>
</body>
</html>