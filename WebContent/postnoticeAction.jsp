<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@page import = "notice.NoticeDAO" %>
 <!-- BbsDAO.java Class -->
 <%//@page import ="file.//FileDAO"  %>
   
 <%@page import = "java.io.PrintWriter" %>
 <!-- java Class -->
 
 <%//@page import = "file.FileDAO" %>
 <%//@page import = "java.io.File" %>
 <%//@page import = //"com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
 <%//@page import = "com.oreilly.servlet.MultipartRequest" %>
 <!-- 파일 업로드. 다운로드를 위해 우선 import 시켜놓음 -->
 
 
 <%
 	request.setCharacterEncoding("UTF-8");
 	response.setContentType("text/html; charset = UTF-8");
 %>
 
 <jsp:useBean id = "notice" class = "notice.Notice" scope = "page"/>
 
 <jsp:setProperty name = "notice" property = "noticeTitle"/>
 <jsp:setProperty name = "notice" property = "noticeContent"/>

 <%
 	System.out.println(notice);
 %>
 
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>공지사항에 넣고 빼고 하는 페이지</title>

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

			if (notice.getNoticeTitle() == null || notice.getNoticeContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				NoticeDAO NoticeDAO = new NoticeDAO();
				int result = NoticeDAO.write(notice.getNoticeTitle(), userID, notice.getNoticeContent());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='faq.jsp'");
					script.println("</script>");
				}

			}

		}
	%>


</body>
</html>