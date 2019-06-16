<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Contnet-Type" content = "text/html; charset=UTF-8">
  <link rel="stylesheet" href="css/nav.css">
  <link rel="stylesheet" href="css/template.css">
<title>수정하기 페이지</title>
</head>
<body style="height:1500px">
<%@ include file="./nav.jsp" %>
<%
		int bbsID = 0;
		
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		
		//여기서 오류가 발생한다는 뜻인데...
		
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");				
		}
%>
<!-- 글 작성 양식을 넣어줘야 하는 부분 -->
<form method = "post" action = "modifyAction.jsp?bbsID=<%= bbsID %>" > 
   
   <table>
   <!-- enctype = "multi -->   
     <tr>
      <td>&nbsp;</td>
      <td align="center">제 목</td>
      <td>&nbsp;<input name="bbsTitle" size=80% maxlength="50" value = "<%=bbs.getBbsTitle()%>"></td>
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
      <td>&nbsp;<input type = "file" name="file" value = "파일 첨부"></td>
      <td>&nbsp;</td>
     </tr> 
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr> 
 
     <tr>
      <td>&nbsp;</td>
      <td align="center">내 용</td>
      <td>&nbsp;<textarea name="bbsContent" cols=80% rows=10% <%=bbs.getBbsContent()%>></textarea></td>
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
       <input type=button value="취소" onclick = "move('bbs.jsp')">
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