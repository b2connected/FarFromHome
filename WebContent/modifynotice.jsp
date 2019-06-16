<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.Notice"%>
<%@ page import="notice.NoticeDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기 페이지(글 작성 양식만 넣어주면 된다!)</title>
</head>
<body style="height:1500px">
<%
//로그인 한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");

		} 
		//로그인 안한 경우
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		int noticeID = 0;
		
		if (request.getParameter("noticeID") != null) {
			noticeID = Integer.parseInt(request.getParameter("noticeID"));
		}
		if (noticeID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'notice.jsp'");
			script.println("</script>");
		}
		
		Notice notice = new NoticeDAO().getNotice(noticeID);
		
		if (!userID.equals(notice.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'faq.jsp'");
			script.println("</script>");				
		}


%>
<!-- userID 값이 없으면 상단 메뉴바에 로그인과 회원가입만 출력된다-->
<% if(userID == null){
%>
<div class="topnav">
	<a class="active" href="index.jsp" >FarFromHome</a>
		<div class="topnav-right">
	   		<a class="nav-link active" href="login.jsp">로그인</a>
        	<a class="nav-link active" href="join.jsp">회원가입</a>
       <!--	<a class="nav-link active" href="toGoList.jsp">마이페이지</a>	-->
		</div>
</div>

<!-- userID 값이 있으면 로그인이 되어있음 -->

<%}else{ %>
<div class="topnav">
	<a class="active" href="index.jsp" >FarFromHome</a>
		<div class="topnav-right">
	   		<a class="nav-link active" href="logout.jsp">로그아웃</a> <!-- 로그인을 한 후에는 로그아웃을 하게끔. 로그아웃을 누르면 null 값으로 바뀌며 메인 페이지로 이동하게 한다. -->
        <!--	<a class="nav-link active" href="join.jsp">회원가입</a> -->
       		<a class="nav-link active" href="toGoList.jsp">마이페이지</a>
		</div>
</div>
<%} %>

<!-- 이어서 nav부분 -->

<nav class="navbar navbar-expand-lg navbar-light bg-light navbar-fixed " >
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	게시판
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="faq.jsp">공지사항</a>
          <a class="dropdown-item" href="bbs.jsp">여행정보</a>
        </div>
      </li>  
      <li class="nav-item">
        <a class="nav-link" href="info.jsp">여행정보 검색</a>
      </li>
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	고객 서비스
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="Qna.jsp">Q/A</a>
          <a class="dropdown-item" href="Report.jsp">1:1 신고</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="guide.jsp">사이트 이용안내</a>
      </li>
    </ul>
  </div>
</nav>

<!-- 글 작성 양식을 넣어줘야 하는 부분 -->
<form method = "post" action = "modifynoticeAction.jsp?noticeID=<%= noticeID %>" > 
   
   <table>
   <!-- enctype = "multi -->   
     <tr>
      <td>&nbsp;</td>
      <td align="center">제 목</td>
      <td>&nbsp;<input name="noticeTitle" size=80% maxlength="50" value = "<%=notice.getNoticeTitle()%>"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
  <!--     <tr>
      <td>&nbsp;</td>
      <td align="center">이름</td>
      <td>&nbsp;<input name="name" size=10% maxlength="20"></td>
      <td>&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    -->
    
    <tr>
      <td>&nbsp;</td>
      <td align="center">파 일</td>
      <td>&nbsp;<input type = "noticefile" name="file" value = "파일 첨부"></td>
      <td>&nbsp;</td>
     </tr> 
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr> 
 
     <tr>
      <td>&nbsp;</td>
      <td align="center">내 용</td>
      <td>&nbsp;<textarea name="noticeContent" cols=80% rows=10% <%=notice.getNoticeContent()%>></textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <!--
      <tr>
      <td>&nbsp;</td>
      <td align="center">비밀번호</td>
      <td>&nbsp;<input type = "password" name = "password" size=20% maxlength="20"></td>
      <td>&nbsp;</td>
     </tr>
     -->     
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>

     <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr>
     
     <tr align="center">
      <td>&nbsp;</td>
      <td colspan="2">
      <input type=submit value="글 수정">
       <input type=button value="취소" onclick = "move('faq.jsp')">
       </td>
      <td>&nbsp;</td>
     </tr>
   </table>
   </form>

<!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<%@ include file="./footer.jsp" %>
</body>
</html>