<%@page import="com.warm.dao.userDAO"%>
<%@page import="com.warm.dto.userDTO"%>
<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.warm.dto.userDTO" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />

    
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = session.getAttribute("userID").toString();
		}
		
		if(userID != null) {
			PrintWriter writer = response.getWriter();
			writer.println("<script>");
			writer.println("alert('이미 로그인중입니다.')");
			writer.println("location.href = 'main.jsp'");
			writer.println("</script>");
			
		}
		
	 	userDAO userDAO = new userDAO();
	 	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	 	if(result == 1) {
	 		PrintWriter writer = response.getWriter();
	 		session.setAttribute("userID", user.getUserID());
	 		response.sendRedirect("main.jsp");
	 	} else if(result == 0) {
	 		PrintWriter writer = response.getWriter();
	 		writer.println("<script>");
	 		writer.println("alert('비밀번호가 틀렸습니다.')");
	 		writer.println("history.back()");
	 		writer.println("</script>");	 				
	 	} else if(result == -1) {
	 		PrintWriter writer = response.getWriter();
	 		writer.println("<script>");
	 		writer.println("alert('아이디가 존재하지 않습니다.')");
	 		writer.println("history.back()");
	 		writer.println("</script>");
	 	} else if (result == -2) {
	 		PrintWriter writer = response.getWriter();
	 		writer.println("<script>");
	 		writer.println("alert('데이터 베이스 오류 발생')");
	 		writer.println("history.back()");
	 		writer.println("</script>");	 		
	 	}
	
	%>
</body>
</html>