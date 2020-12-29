<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
.sunday {
	color: #FF0000;
}
.saturday{
	color: #0000FF;
}

th{
	width:${100/7}%;
}
td{
	height: 80px;
	vertical-align:top;
}
.nTable td{
	vertical-align:middle;
}
td{
	font-family: 'Noto Sans JP', sans-serif;
}
tr{
	font-family: 'Noto Sans JP', sans-serif;
}
</style>

</head>
<script>
	var memberCountConTxt1= ${sumIn};
	
	$({ val : 0 }).animate({ val : memberCountConTxt1 }, {
	 duration: 2000,
	step: function() {
	  var num = numberWithCommas(Math.floor(this.val));
	  $(".memberCountCon1").text(num);
	},
	complete: function() {
	  var num = numberWithCommas(Math.floor(this.val));
	  $(".memberCountCon1").text(num);
	}
	});

var memberCountConTxt2= ${sumOut};
	
	$({ val : 0 }).animate({ val : memberCountConTxt2 }, {
	 duration: 2000,
	step: function() {
	  var num = numberWithCommas(Math.floor(this.val));
	  $(".memberCountCon2").text(num);
	},
	complete: function() {
	  var num = numberWithCommas(Math.floor(this.val));
	  $(".memberCountCon2").text(num);
	}
	});
	
	function numberWithCommas(x) {
	  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>
<body>
<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
	<div class="container-xl">
		<h2 class="text-center">CALENDAR</h2>
		<!-- 다이어리 -->
		<div class="d-table w-100 mb-5">
			<div class="d-table-row">
				<div class="d-table-cell">
					<table class="table table-sm text-primary text-center w-75 mx-auto">
						<tr>
							<td class="font-weight-bold">이번달 수입</td>
						</tr>
						<tr>
							<td>${sumIn}</td>
						</tr>
					</table>
				</div>
				<div class="d-table-cell text-center">
					<h5>
						<a href="${pageContext.request.contextPath}/admin/cashbookByMonth/${currentYear}/${currentMonth - 1}" class="text-info text-decoration-none"><<</a>
						<span>${currentYear} - ${currentMonth}</span>
						<a href="${pageContext.request.contextPath}/admin/cashbookByMonth/${currentYear}/${currentMonth + 1}" class="text-info text-decoration-none">>></a>
					</h5>
				</div>
				<div class="d-table-cell">
					<table class="table table-sm text-danger text-center w-75 mx-auto">
						<tr>
							<td class="font-weight-bold">이번달 지출 </td>
						</tr>
						<tr>
							<td>${sumOut}</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		
		<div class="row font-weight-bold text-center w-100 px-4">
			<div class="col border-bottom py-2 mb-2">SUN</div>
			<div class="col border-bottom py-2 mb-2">MON</div>
			<div class="col border-bottom py-2 mb-2">TUE</div>
			<div class="col border-bottom py-2 mb-2">WED</div>
			<div class="col border-bottom py-2 mb-2">THU</div>
			<div class="col border-bottom py-2 mb-2">FRI</div>
			<div class="col border-bottom py-2 mb-2">SAT</div>
		</div>
		<div class="row w-100 px-4">
			<c:forEach var="i" begin="1" end="${lastDay+(firstDayOfWeek-1)}" step="1">
				<c:if test="${i-(firstDayOfWeek-1) < 1}">
					<div class="col">&nbsp;</div>
				</c:if>
				<c:if test="${i-(firstDayOfWeek-1) > 0}">
					<div class="col" style="min-height: 5rem">
						<!-- FIXME 토요일 및 일요일은 파랑, 빨강으로 표시 -->
						<div><!-- 날짜 -->
							<a href="${pageContext.request.contextPath}/admin/cashbookByDay/now/${currentYear}/${currentMonth}/${i-(firstDayOfWeek-1)}" class="font-weight-bold text-secondary">
								${i-(firstDayOfWeek-1)}
							</a>
						</div>
						<!-- 지출/수입 목록이 있는 날짜를 cashList에서 검색 -->
						<c:forEach var="c" items="${cashList}">
							<c:if test="${i-(firstDayOfWeek-1) == c.dday}">
								<c:if test="${c.cashbookKind == '수입'}">
									<div class="text-primary small">수입 : ${c.cashbookPrice}</div>
								</c:if>
								<c:if test="${c.cashbookKind == '지출'}">
									<div class="text-danger small">지출 : ${c.cashbookPrice}</div>
								</c:if>
							</c:if>
						</c:forEach>
					</div>
				</c:if>
				<c:if test="${i%7 == 0}">
					</div><div class="row w-100 px-4">
				</c:if>
			</c:forEach>
			
			<c:if test="${(lastDay+(firstDayOfWeek-1)) % 7 != 0}">
				<c:forEach begin="1" end="${7- ((lastDay+(firstDayOfWeek-1)) % 7)}" step="1">
					<div class="col">&nbsp;</div>
				</c:forEach>
			</c:if>
		</div>
	</div>
</body>
</html>