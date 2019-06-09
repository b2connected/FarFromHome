<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="guide.css">
<link rel="stylesheet" href="template.css">
 <!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<title>HOME</title>
</head>
<body style="height:700px">
<%@ include file="./nav.jsp" %>

<section id="brand_mission">
	<h2>Brand Mission</h2>
		<div class="contents_container">
			<h3 class="mission_title">쉼 없이 달려가는 일상 속에서
				잠시 휴식과 영감을 얻기 위해
				놀고 싶은 순간</h3>
			<ul class="mission_column">
			 	<li>
					<h4>누구나</h4>
					<div class="mission_underline"></div>
					<div class="mission_circle"></div>
					다양한 여행 정보 
					모든 지역 / 내국인 &amp; 외국인</li>
			 	<li>
					<h4>마음 편히</h4>
					<div class="mission_underline"></div>
					<div class="mission_circle"></div>
					지도와 경로 제공  &amp; 환율 정보 제공  
					&amp; 비행기 정보 제공
				</li>
			 	<li>
					<h4>놀 수 있게</h4>
					<div class="mission_underline"></div>
					<div class="mission_circle"></div>
					todolist를 통해 내가 계획하는 여행</li>
			</ul>
		</div>
</section>
<!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<%@ include file="./footer.jsp" %>
</body>
</html>