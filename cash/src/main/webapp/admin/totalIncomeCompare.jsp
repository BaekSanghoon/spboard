<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100&display=swap" rel="stylesheet">
<body>
<jsp:include page="/WEB-INF/view/inc/chartMenu.jsp"></jsp:include>
<div class="container">
	<div>
		<canvas id="piechart"></canvas>
	</div>
</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script>
$.ajax({
		url : '${pageContext.request.contextPath}/admin/totalIncomeCompare',
		type : 'get',
		success : function(data) {
			console.log(data);
			let chartData = {
				type: 'pie',
				data:{
					labels:['2018년 수입','2019년 수입','2020년 수입'], // 항목
					datasets:[{
						backgroundColor:[
							'rgba(255, 128, 128 ,0.5)',
							'rgba(128, 255, 128 ,0.5)',
                            'rgba(128, 255, 192 ,0.5)'
							 
						],
						borderColor:[
							'rgba(255, 99, 132, 0.5)',
							 'rgba(153, 102, 255, 0.5)',
	                          'rgba(255, 159, 64, 0.5)'
							 
						],
						data:[data["2018year"],data["2019year"], data["2020year"]] // 데이터
					}],
					label:''
				},
				options:{}
			};

			/*chartData.data.labels.push("지출");
			console.log(chartData.data.labels);

			chartData.data.datasets[0].data.push(100);
			console.log(chartData.data.datasets[0].data);*/
			
			let pieCtx = $('#piechart');
			let pieChart = new Chart(pieCtx, chartData);
		}
	});
</script>
</html>