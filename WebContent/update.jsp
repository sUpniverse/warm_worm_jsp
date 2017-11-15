<%@page import="com.warm.dao.boardDAO"%>
<%@page import="com.warm.dto.boardDTO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name = "viewport" content="width-device-width", initial-scale="1">
<link rel ="stylesheet" href="css/bootstrap.css">
<link rel ="stylesheet" href="css/custom.css"> 

<title>Insert title here</title>
</head>
<body>
	
	<% 
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = session.getAttribute("userID").toString();
	}	
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");			
		script.println("alert('로그인을 하세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");				
	}
	
	int boardID = 0;
	if(request.getParameter("boardID") != null) {
		boardID = Integer.parseInt(request.getParameter("boardID"));
	}
	if(boardID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");			
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("history.back()");
		script.println("</script>");			
	}
	
	boardDTO boardDTO = new boardDAO().read(boardID);
	
	if(!userID.equals(boardDTO.getBoardUserID()) ) {
		PrintWriter script = response.getWriter();
		script.println("<script>");			
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");		
	}
	request.setAttribute("board", boardDTO);
		
	%>			
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">			
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>			
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>		
		</div>
		<div class="collapse navbar-collapse" id="#bs-example-navbar-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li  class="active"><a href="board.jsp">게시판</a>
			</ul>
			
			<c:choose>
				<c:when test="${empty userID}">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
							ara-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a>
							<a href="join.jsp">회원가입</a>					
					</ul>
				</c:when>
				<c:otherwise>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
							ara-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">					
							<a href="logoutAction.jsp">로그아웃</a>
						</ul>
						</li>														
					</ul>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
	
	<div class="container">
		<form method="post" action="updateAction.jsp?boardID=${board.boardID}">
			<table class="table table-default">
					<thead>
						<tr>
							<th colspan="2" text-align="center"><h2>게시판 글쓰기 양식</h2></th>							
						</tr>
					</thead>
					<tbody>						
						<tr>
							<td> <input type="text" class="form-control" value="${board.boardTitle}" name="boardTitle" placeholder="글제목" maxlength="50"> </td>
						</tr>
						<tr>
							<td> <textarea class="form-control" placeholder="글 내용" name="boardContent" maxlength="2048" style="height: 350px;" >${board.boardContent}</textarea>
					</tbody>					
			</table>
			<input type="submit" class="btn btn-default" value="수정하기">
			<input type="button" class="btn btn-default" value="돌아가기" onclick="history.back()">
		</form>					
	</div>		
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>		
</body>
</html>