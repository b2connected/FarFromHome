<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ page import="java.io.PrintWriter"%>
	<%@ page import="bbs.BbsDAO"%>
	<%@ page import="bbs.Bbs"%>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import = "java.sql.Timestamp" %>

	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 <link rel="stylesheet" href="css/nav.css">
  <link rel="stylesheet" href="css/template.css">
 <!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script type="text/javascript">

function move(url){//링크 누르면 이동하게끔 해주는 함수
	location.href=url;
}

//function find(){
//	if(document.searchFrm.keyWord.value ==""){
//		alert("검색어를 입력하세요.");
//		document.searchFrm.keyWord.focus();
//		return;
//	}
//	document.searchFrm.submit();
//}
</script>

<title>게시판 메인 화면</title>

</head>
<body style="height:1500px">
<%@ include file="./nav.jsp" %>
<%

			int pageNumber = 1; //기본 페이지 넘버
	
			//페이지넘버값이 있을때
			if (request.getParameter("pageNumber") != null) {
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}
		%>

<!-- 게시판이 출력되는 부분 -->

<!-- 여기 부분을 수정하려고 해놓은 부분

<center>
<form method = "post" action = "search.jsp"> 
	&nbsp;<input type = "text" name = "search" placeholder = "작성자를 입력하세요.">
	&nbsp;<button type = "submit">검색</button>
</form>




</center> -->
<br>
<div class = "container">
	<div class = "row">
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr height="5"><td width="5"></td></tr>
  
 <thead>
 <tr style = "text-align:center">
   <td width="5"></td>
   <td width="73">번호</td>
   <td width="379">제목</td>
   <td width="73">작성자</td> <!-- ID가 들어갈 부분 -->
   <td width="164">작성일</td>
<!--    <td width="58">조회수</td>--> <!-- 우선 조회수는 블러 처리! -->
   <td width="7"></td>
  </tr>
  </thead>
  
  <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></tr>
  
 <tbody>
 <%
 	BbsDAO bbsDAO = new BbsDAO();
 	ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
 	for (int i = 0; i < list.size();i++){
 %>
<tr height="25" align="center">
	<td width = "5"></td>
	<td width = "73"><%=list.get(i).getBbsID()%></td>
	<td width = "379"><a href = "view.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle() %></a></td>
	<td width = "73"><%=list.get(i).getUserID() %></td>
	<td width = "164"><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13)+ "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
	<td width="7"></td>
</tr>
<% } %>
  <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></tr>

 <tr height="1" bgcolor="#82B5DF"><td colspan="6" width="752">
 
 </tr>
 </tbody>
 </table>

 
 <!-- 페이지 넘기기 -->
	<%
	if (pageNumber != 1) {
	%>
	<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
	class="btn btn-success btn-arrow-left">이전</a>
	<%
	}
	if (bbsDAO.nextPage(pageNumber)) {
	%>
	<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>"
	class="btn btn-success btn-arrow-left">다음</a>
	<%
	}
	%>
				
  <!-- 만약 로그인 정보가 없이 null 값이면 글쓰기 페이지로 안넘어가고 경고문을 띄운 후 로그인 창으로 넘겨준다. -->
  
  <% if (session.getAttribute("userID")!=null){ %>
  <table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr><td colspan="4" height="5"></td></tr>
  <tr align="center">
   <td><input type=button value="글쓰기" onclick = "window.location='post.jsp'"></td> <!--글쓰기를 누르면 글쓰는 내용의 post.jsp로 넘어감 -->
  </tr>
</table>

<% } else{ %>

  <table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr><td colspan="4" height="5"></td></tr>
  <tr align="center">
	<td><input type=button value="글쓰기" onclick = "if(confirm('로그인 하세요'))location.href='login.jsp'"></td> <!--글쓰기를 누르면 글쓰는 내용의 post.jsp로 넘어감 -->
  </tr>
  </table>
  <%} %>	
	</div>
</div>

	<br>
					
	<!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<%@ include file="./footer.jsp" %>
</body>
</html>