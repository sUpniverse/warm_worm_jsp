<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content ="width=device-width", initial-scale="1">
<link rel = "stylesheet" href="css/bootstrap.css">
<title>Insert title here</title>
</head>
<body>
	<!-- header -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>			
			</button>
			<a class="navbar-brand" href="main.jsp">Jsp 게시판 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="#bs-example-navbar-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">사이트 소개</a></li>
				<li><a href="board.jsp">게시판</a>			
			</ul>
		</div>
		</nav>
		<!-- //header -->
		<!-- container -->
		<div class="container">
			<div class="col-lg-4"></div>
			<div class="jumbotron" style="padding-top: 20px">
				<form method="post" action="joinAction.jsp">
					<h2 style="text-align: center;">회원가입 화면</h2>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="패스워드" name="userPassword" maxlength="20">
					</div>
					<div class="form-group" >
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>				
					<div class="form-group" style="text-align: center;"">
						<input type="radio" name="userGender" value="남자">남자
						<input type="radio" name="userGender" value="여자">여자
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="userEmail"> 
					</div>
					<input type="submit" class="btn btn-default" value="가입하기">
					<input type="button" class="btn btn-default" value="돌아가기 ">
				</form>		
			</div>
			<div class="col-lg-4"></div>
		</div>	
		<!-- //container -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>