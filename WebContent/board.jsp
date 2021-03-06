<%@page import="com.warm.dto.boardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.warm.dao.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name = "viewport" content="width-device-width", initial-scale="1">
<link rel ="stylesheet" href="css/bootstrap.css">
<link rel ="stylesheet" href="css/custom.css"> 

<title>Insert title here</title>
<style type="text/css">
	a, a:hover {
		color : #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	
	<% 			
		
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = session.getAttribute("userID").toString();
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
		<table class="table table-default">
				<thead>
					<tr>
						<th text-align="center"> 번호 </th>
						<th text-align="center"> 제목 </th>
						<th text-align="center"> 작성자 </th>
						<th text-align="center"> 조회수 </th>						 
						<th text-align="center"> 작성일자 </th>					
					</tr>
				</thead>
				<tbody>
					<%
						boardDAO boardDAO = new boardDAO();
						ArrayList<boardDTO> list = boardDAO.getlist(pageNumber);
						request.setAttribute("list", list);
					%>
					<c:forEach items="${list}" var="notice"> 
				 <tr>										
					<td>${notice.boardID}</td>							
					<td><a href="view.jsp?boardID=${notice.boardID}">${notice.boardTitle}</a></td>
					<td>${notice.boardUserID }</td>						
					<td>${notice.boardCount}</td>
					<td>${notice.boardDate}</td>					
				</tr>			
					</c:forEach>
			</tbody>		 						
		</table>			
		<c:choose test=${pageNumber not eq 1}>
			<a href="bbs.jsp?pageNumber=${pageNumber -1 }" class="btn btn-success btn-arraw-left">이전</a>		
		</c:choose>
		<c:choose test=${ }></c:choose>
		
		<a href="write.jsp" class="btn btn-default">글쓰기</a>		
	</div>	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>		
</body>
</html>