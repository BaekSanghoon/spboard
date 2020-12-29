<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#id').focus();
	$('#id').blur(function(){
		if($('#id').val==''){
			$('#id').focus();
			return;
		}
		$.ajax({
			url:'/admin/idCheck',
			type:"post",
			data:{id:$('#id').val()},
			success:function(data){
				if(data == 'yes'){
					alert($('#id').val()+'는 사용 가능한 아이디입니다.');
					$('#pw').focus();
				}else{
					alert($('#id').val()+'는 중복된 아이디 입니다.');
					$('#id').select();
					$('#id').focus();
					}
				}
			});
		});
});
</script>
</head>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 구글 css 폰트 숫자 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100&display=swap" rel="stylesheet">
<body>
	<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
	<form method="post" action="${pageContext.request.contextPath}/admin/addMember">
		<div>
			ID:<input type="text" id="id" name="id">
		</div>
		<div>
			PW:<input type="password" id="pw" name="pw">
		</div>
		<button type="submit" id="addMember">추가</button>
	</form>
</body>
</html>