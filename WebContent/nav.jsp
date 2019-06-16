<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="css/template.css">
<link rel="stylesheet" href="css/nav.css">
 <!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<title>HOME</title>
</head>
<body style="height:600px">
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
/* 	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();	
	} */
%>	
<div class="topnav">
	<a class="active" href="index.jsp" >Far From Home</a>
		<div class="topnav-right">
<%
	if(userID == null) {
%>
	   		<a class="nav-link active" href="login.jsp">로그인</a>
        	<a class="nav-link active" href="join.jsp">회원가입</a>
<%
	} else {
%>
        	<a class="nav-link active" href="logoutAction.jsp">로그아웃</a>
        	<a class="nav-link active" href="box.jsp">메시지</a>
        	<a class="nav-link active" href="toGoList2.jsp">마이페이지</a>
<%
	}
%>   
		</div>
</div>
<nav class="navbar navbar-expand-lg navbar-light bg-light navbar-fixed " >
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	게시판
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="faq.jsp">공지사항</a>
          <a class="dropdown-item" href="bbs.jsp">여행 게시판</a>
        </div>
      </li>  
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	여행정보
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="info.jsp">지도</a>
          <a class="dropdown-item" href="weather.jsp">날씨</a>
          <a class="dropdown-item" href="exchange.jsp">환율</a>
        </div>
      <li class="nav-item">
        <a class="nav-link" href="guide.jsp">사이트 이용안내</a>
      </li>
    </ul>
  </div>
  
</nav>
</body>
</html>