<%@page import="com.warm.dao.boardDAO"%>
<%@page import="com.warm.dao.userDAO"%>
<%@page import="com.warm.dto.userDTO"%>
<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="board" class="com.warm.dto.boardDTO" scope="page" />
<jsp:setProperty name="board" property="boardTitle" />
<jsp:setProperty name="board" property="boardContent" />


    
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
		
		if(userID == null) {
			PrintWriter writer = response.getWriter();
			writer.println("<script>");
			writer.println("alert('로그인을 해주세요')");
			writer.println("</script>");
			response.sendRedirect("login.jsp");
		} else {
			
			if(board.getBoardTitle() == null || board.getBoardContent() == null){
				PrintWriter writer = response.getWriter();		
				writer.println("<script>");
				writer.println("alert('빈칸이있습니다')");
				writer.println("history.back()");
				writer.println("</script>");
				} else {
					boardDAO boardDAO = new boardDAO();
					int result = boardDAO.write(board.getBoardTitle(), session.getAttribute("userID").toString(), board.getBoardContent());
					if(result == -1) {
						PrintWriter writer = response.getWriter();		
						writer.println("<script>");
						writer.println("alert('데이터베이스 오류')");
						writer.println("history.back()");
						writer.println("</script>");
					} else {
						response.sendRedirect("board.jsp");
					}
					
				}	
			
		}
		
			
	%>

</body>
</html>