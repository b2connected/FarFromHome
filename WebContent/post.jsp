<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%//@page import = "bbs.BbsDAO" %>
 <!-- BbsDAO.java Class -->
   
 <%@page import = "java.io.PrintWriter" %>
 <!-- java Class -->
 
 <%//@page import = "file.FileDAO" %>
 <%//@page import = "java.io.File" %>
 <%//@page impo//rt = "com.oreilly.servlet.multipart.//DefaultFileRenamePolicy" %>
 <%//@page import = "com.oreilly.servlet.MultipartRequest" %>
 

 <%
 request.setCharacterEncoding("UTF-8");
 response.setContentType("text/html; charset=UTF-8");//set으로 쓰는 습관들이기
 %>
 
<!-- 한명의 회원정보를 담는 user클래스를 자바빈즈로 사용 / scope : 페이지. 현재의 페이지에서만 사용 --> 
<jsp:useBean id = "bbs" class = "bbs.Bbs" scope = "page"/>
<!-- Bbs bbs = new Bbs(); -->
<jsp:setProperty name = "bbs" property = "bbsTitle"/>
<jsp:setProperty name = "bbs" property = "bbsContent"/>
<%--  <%
 	System.out.println(bbs);
 %> --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 <link rel="stylesheet" href="nav.css">
 <!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

<!-- 자바스크립트 함수 부분 -->

<script type="text/javascript">

function move(url){//링크 누르면 이동하게끔 해주는 함수
	location.href=url;
}

function writeCheck()//다 잘 적었는지 체크하는 함수
{
 var form = document.writeform;
 
if( !form.title.value )//제목을 입력하지 않았을 경우
 {
  alert( "제목을 적어주세요" );
  form.title.focus();
  return;
 }

if( !form.memo.value )//내용을 입력하지 않았을 경우(내용이 있어야지 뭘 하든 말든 할터이니..)
 {
  alert( "내용을 적어주세요" );
  form.memo.focus();
  return;
 }
 
 //if(!form.name.value){
//	 alert("이름을 적어주세요");
//	 form.name.focus();
 //}
 
form.submit();
}
</script>

<title>게시판 글쓰기</title>

</head>

<!-- 디자인 및 세션값 받아오는 부분  -->

<body style="height:1500px">
<%@ include file="./nav.jsp" %>



<center>

<table>
  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0" align = "center">
    </td>
    </tr>
     <tr>
      <td width="5"></td>
      <td align = "center"><h2>글쓰기</h2></td>
      <td width="5"></td>
     </tr>
    </table>
    
   
  <form method = post action = "postAction.jsp" > 
   
   <table>
   <!-- enctype = "multi -->
   
     <tr>
      <td>&nbsp;</td>
      <td align="center">제 목</td>
      <td>&nbsp;<input name="bbsTitle" size=80% maxlength="50"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="1"></td></tr>
  <!--     <tr>
      <td>&nbsp;</td>
      <td align="center">이름</td>
      <td>&nbsp;<input name="name" size=10% maxlength="20"></td>
      <td>&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    -->
    
<!--     <tr>
      <td>&nbsp;</td>
      <td align="center">파 일</td>
      <td>&nbsp;<input type = "file" name="file" value = "파일 첨부"></td>
      <td>&nbsp;</td>
     </tr> 
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr> 
  -->
     <tr>
      <td>&nbsp;</td>
      <td align="center">내 용</td>
      <td>&nbsp;<textarea name="bbsContent" cols=80% rows=10%></textarea></td>
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
      <input type=submit value="등록">
       <input type=button value="취소" onclick = "move('bbs.jsp')">
       <input type=button value = "초기화" onclick = "javascript:history.back(-1)">
       </td>
      <td>&nbsp;</td>
     </tr>
   </table>
   </form>
   </td>
  </tr>
 </table>
 
 </center>

	<!--  -->			
	<!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<%@ include file="./footer.jsp" %>

</body>
</html>