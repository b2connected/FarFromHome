<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.Notice"%>
<%@ page import="notice.NoticeDAO"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지 수정하기 페이지</title>
</head>
<body style="height:1500px">

<%
		String userID = null;
		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID"); //유저아이디에 해당 세션값을 넣어준다.
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} 
		//글이 유효한지 판별
		int noticeID = 0;
		if (request.getParameter("noticeID") != null) {
			noticeID = Integer.parseInt(request.getParameter("noticeID"));
		}
		if (noticeID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'faq.jsp'");
			script.println("</script>");
		}
		
		Notice notice = new NoticeDAO().getNotice(noticeID);
		
		if (!userID.equals(notice.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'faq.jsp'");
			script.println("</script>");				
		}	else {
			if (request.getParameter("noticeTitle") == null || request.getParameter("noticeContent") == null
					|| request.getParameter("noticeTitle").equals("") || request.getParameter("noticeContent").equals("") ) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				NoticeDAO noticeDAO = new NoticeDAO();
				int result = noticeDAO.update(noticeID, request.getParameter("noticeTitle"), request.getParameter("noticeContent"));
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>"); 
					script.println("alert('글 수정에 실패했습니다')");
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