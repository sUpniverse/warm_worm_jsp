<%@page import="com.warm.dto.boardDTO"%>
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
		}else {
			
			if(board.getBoardTitle() == null || board.getBoardContent() == null){
				PrintWriter writer = response.getWriter();		
				writer.println("<script>");
				writer.println("alert('빈칸이있습니다')");
				writer.println("history.back()");
				writer.println("</script>");
				} else {
					boardDAO boardDAO = new boardDAO();
					int result = boardDAO.update(boardID,request.getParameter("boardTitle"),request.getParameter("boardContent"));
					if(result == -1) {
						PrintWriter writer = response.getWriter();		
						writer.println("<script>");
						writer.println("alert('글 수정에 실패했습니다.')");
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