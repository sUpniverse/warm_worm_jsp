<%@page import="com.warm.dao.userDAO"%>
<%@page import="com.warm.dto.userDTO"%>
<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.warm.dto.userDTO" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
    
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
			writer.println("</script>");
			response.sendRedirect("main.jsp");
		}
		
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
		|| user.getUserGender() == null || user.getUserEmail() == null) {
		PrintWriter writer = response.getWriter();		
		writer.println("<script>");
		writer.println("alert('빈칸이있습니다')");
		writer.println("history.back()");
		writer.println("</script>");
		} else {
			userDAO userDAO = new userDAO();
			int result = userDAO.join(user);
			if(result == -1) {
				PrintWriter writer = response.getWriter();		
				writer.println("<script>");
				writer.println("alert('데이터베이스 오류')");
				writer.println("history.back()");
				writer.println("</script>");
			} else {
				session.setAttribute("userID", user.getUserID());
				response.sendRedirect("main.jsp");
			}
			
		}	
	
	%>

</body>
</html>