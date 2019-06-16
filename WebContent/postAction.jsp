<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@page import = "bbs.BbsDAO" %>
 <!-- BbsDAO.java Class -->
   
 <%@page import = "java.io.PrintWriter" %>
 <!-- java Class -->
 
 <%//@pag//e import = "file.FileDAO" %>
 <%//@page import = "java.io.File" %>
 <%//@page import = //"com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
 <%//@page import = "com.oreilly.servlet.MultipartRequest" %>
 <!-- 파일 업로드. 다운로드를 위해 우선 import 시켜놓음 -->
  
 <%
 	request.setCharacterEncoding("UTF-8");
 	response.setContentType("text/html; charset = UTF-8");
 %>
 
  <jsp:useBean id = "bbs" class = "bbs.Bbs" scope = "page"/>
 
 <jsp:setProperty name = "bbs" property = "bbsTitle"/>
 <jsp:setProperty name = "bbs" property = "bbsContent"/>
 
 <%
 	System.out.println(bbs);
 %>
 
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기 디비에 넣고 빼고 하는 페이지</title>

</head>
<body>
<%
		String userID = null;
		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
		}
		
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			
		} else {

			if (bbs.getBbsTitle() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목이 입력되지 않았습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if (bbs.getBbsContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용이 입력되지 않았습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			
			if (bbs.getBbsTitle() == null && bbs.getBbsContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력된 사항이 없습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				BbsDAO BbsDAO = new BbsDAO();
				int result = BbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='bbs.jsp'");
					script.println("</script>");
				}

			}

		}
	%>



</body>
</html>