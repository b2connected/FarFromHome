<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="util.SHA256"%>
<%@page import="util.Gmail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
UserDAO userDAO = new UserDAO();
String userID=null;
if(session.getAttribute("userID")!=null){
	userID=(String) session.getAttribute("userID");
}

boolean emailChecked = userDAO.getUserEmailChecked(userID);

if(emailChecked == true) {

	PrintWriter script = response.getWriter();

	script.println("<script>");

	script.println("alert('이미 인증 된 회원입니다.');");

	script.println("location.href = 'index.jsp'");

	script.println("</script>");

	script.close();		

	return;

}

//사용자에게 보낼 메시지를 기입합니다.
	String host = "http://localhost:8080/ffh/";
	String from = "a72625057";
	String to = userDAO.getUserEmail(userID);
	String subject = "회원가입을 위한 이메일 확인 메일입니다.";
	String content = "다음 링크에 접속하여 이메일 확인을 진행하세요." +
		"<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";
	
	// SMTP에 접속하기 위한 정보를 기입합니다.
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	 
	try{
	    Authenticator auth = new Gmail();
	    Session ses = Session.getInstance(p, auth);
	    ses.setDebug(true);
	    MimeMessage msg = new MimeMessage(ses); 
	    msg.setSubject(subject);
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr);
	    Address toAddr = new InternetAddress(to);
	    msg.addRecipient(Message.RecipientType.TO, toAddr);
	    msg.setContent(content, "text/html;charset=UTF-8");
	    Transport.send(msg);
	} catch(Exception e){

	    e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류가 발생했습니다..');");
		script.println("history.back();");
		script.println("</script>");
		script.close();		
	    return;
	}
%>
<head>
<meta charset="UTF-8">
<meta name ="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css?after">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript">
	function getUnread(){
		$.ajax({
			type: "POST",
			url: "./chatUnread",
			data:{
				userID: encodeURIComponent('<%=userID%>'),
			},
			success: function(result){
				if(result>=1){
					showUnread(result);
				} else{
					showUnread('');
				}
			}
		});
	}
	function getInfiniteUnread(){
		setInterval(function(){
			getUnread();
		}, 4000);
	}
	function showUnread(result){
		$('#unread').html(result);
	}
</script>
</head>
<body>
<nav class="navbar navbar-default">
<div class="navbar-header">
<button type="button" class="navbar-toggle collapsed"
data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
aria-expanded="false">
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
<a class="navbar-brand" href="index.jsp">로고자리</a>
</div>
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	<ul class="nav navbar-nav">
		<li><a href="index.jsp">메인</a>
		<li><a href="find.jsp">친구찾기</a></li>
		<li><a href="box.jsp">메시지함<span id = "unread" class ="label label-info"></span></a></li>				
	</ul>
	<%
		if(userID == null){
	%>
	<ul class="nav navbar-nav navbar-right">
		<li class="dropdown">
			<a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">접속하기<span class="caret"></span> <!-- 접속하기 옆에 조그만한 삼각형이 caret임 -->
			</a>
			<ul class="dropdown-menu">
				<li><a href="login.jsp">로그인</a></li>
				<li><a href="join.jsp">회원가입</a></li>				
			</ul>
		</li>
	</ul>
	<%
		}else{
	%>
		<ul class="nav navbar-nav navbar-right">
		<li class="dropdown">
			<a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">회원관리<span class="caret"></span> <!-- 접속하기 옆에 조그만한 삼각형이 caret임 -->
			</a>
			<ul class="dropdown-menu">
				<li><a href="logoutAction.jsp">로그아웃</a></li>			
			</ul>
		</li>
	</ul>
	<%
		}
	%>
</div>
</nav>
<%
String messageContent=null;
if (session.getAttribute("messageContent")!=null){
	messageContent = (String) session.getAttribute("messageContent");
}
String messageType = null;
if (session.getAttribute("messageType")!=null){
	messageType = (String) session.getAttribute("messageType");
}
if (messageContent !=null){
%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content <% if(messageType.equals("오류메시지")) out.println("panel-warning"); else out.println("panel-success"); %>">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%= messageType %>
						
						</h4>
					</div>
					<div class="modal-body">
						<%= messageContent %>
					</div>
					<div class = "modal-footer">
						<button type="button" class ="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#messageModal').modal("show");
	</script>
	<%
		if(userID != null){
	%>
		<script type="text/javascript">
			$(document).ready(function(){ //웹문서가 실행준비가 되면 해당 함수를 실행한다.
				getInfiniteUnread();
			});
		</script>
	<%		
		}
	%>
<%
session.removeAttribute("messageContent");
session.removeAttribute("messageType");
}
%>
<section class="container mt-5" style="max-width:800px;">
	<div class="container">
	    <div class="alert alert-success mt-4" role="alert">
		  이메일 주소 인증 메일이 전송되었습니다.
		</div>
    </div>
</section>
</body>
</html>