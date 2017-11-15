<%@page import="java.io.PrintWriter"%>
<%@page import="com.warm.dto.boardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.warm.dao.boardDAO"%>
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
		int boardID = 0;
		if(request.getParameter("boardID") != null) {
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		if(boardID == 0) {
			PrintWriter writer = response.getWriter();
			writer.println("<script>");
			writer.println("alert('게시글이 유효하지 않습니다')");
			writer.println("history.back()");
			writer.println("</script>");
			
		}		
		new boardDAO().count(boardID);
		boardDTO boardDTO = new boardDAO().read(boardID);				
		request.setAttribute("boardDTO", boardDTO);
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
		<table class="table table-default" style=" text-align: center; border : 1px solid #dddddd">
				<thead>
					<tr>
						<th col-span ="3" text-align="center" style="background-color: #eeeeee;">게시판 글 보기</th>							
					</tr>
				</thead>
				<tbody>
					<tr> 
						<td>글 제목</td>						
						<td col-span="2"><%=boardDTO.getBoardTitle().replaceAll(" ", "&nbsp;")%> </td>	
					</tr>
					<tr>
						<td>작성자 </td>
						<td>${boardDTO.boardUserID}</td>
						<td> 글 번호 </td>
						<td>${boardDTO.boardID}</td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td>${boardDTO.boardDate}</td>
						<td>조회수	 </td>
						<td>${boardDTO.boardCount}</td>
					</tr>
					<tr>
						<td>글 내용 </td>
						<td colspan=2 style="min-height: 200px; text-align: left">${boardDTO.boardContent}</td>
					</tr>						
				</tbody>		 						
		</table>			
		<a href="board.jsp" class="btn btn-default">목록</a>		
		<a href="update.jsp?boardID=${boardDTO.boardID}" class="btn btn-default">수정</a>
		<a onclick="return confirm('정말 삭제하시겠습니까?')" href="deleteAction.jsp?boardID=${boardDTO.boardID}" class="btn btn-default">삭제</a>		
	</div>	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>		
</body>
</html>