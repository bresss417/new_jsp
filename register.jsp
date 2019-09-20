

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@include file="conf.jsp" %>

<% 

 Object user_id = session.getAttribute("user_id");
 if(user_id !=null){
    response.sendRedirect("home.jsp");
 }
 
Connection connect = null;
Statement statement = null;

String error_err = null;

 if("POST".equalsIgnoreCase(request.getMethod())){
     
   try {
      Class.forName("com.mysql.jdbc.Driver");
      connect = DriverManager.getConnection("jdbc:mysql://" + host + "/" + db + "" +"?user=" + username + "&password=" + password);
      statement = connect.createStatement();
      
     if (!statement.executeQuery("SELECT * FROM `userjsp` WHERE `user` = '" + request.getParameter("user") + "';").next()) {
			if (request.getParameter("password").equals(request.getParameter("confirm_password"))) {
				statement.execute("INSERT INTO `userjsp` (`id`, `user`, `password`, `email`, `name`) VALUES (NULL, '" + request.getParameter("user") + "', '" + request.getParameter("password") + "', '" + request.getParameter("email") + "', '" + request.getParameter("name") + "');");
				response.sendRedirect("login.jsp?registered=" + request.getParameter("user"));
			} else {
				error_err = "Both passwords don't match";
		}
                        } else {
			error_err = "มีชื่อผู้ใช้นี้อยู่ในระบบอยู่แล้ว";
	 }
                     }  catch (Exception e) {
		error_err = e.getMessage();
	  }
                     try {
		if (statement != null){
			statement.close();
			connect.close();
	}
	        } catch (SQLException e) {
    }
 }
%>


<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>register</title>
    <style>
        body{
            font-family: sans-serif;
            background-color: yellow;
        }
         form{
            border: 3px solid#f1f1f1;
        }
        .formregis{
             background-color: yellowgreen;
            margin: auto;
            width: 40%;
            border: 3px solid #73AD21;
            padding: 20px;
        }
        .textcenter{
            text-align: center;
            margin: 24px 0 12px 0;
        }
        .htext{
            font-size: 40px;
            color: mediumslateblue;
        }
        .regisfrom{
            padding: 16px;
        }
         input[type=text], input[type=password], input[type=email] {
          width: 100%;
          padding: 12px 20px;
          margin: 8px 0;
          display: inline-block;
          border: 1px solid #ccc;
          box-sizing: border-box;
        }
        .sabmit{
            text-align: center;
        }
         .btn {
           border: 2px solid black;
           background-color: white;
           color: black;
           padding: 14px 68px;
          font-size: 16px;
          cursor: pointer;
          
          }
          .gogo {
            border-color: #ff9800;
             color: orange;
          }

         .gogo:hover {
         background: #ff9800;
         color: white;
          }
        
    </style>
</head>

<body>
    <form action="register.jsp" method="POST" class="formregis">
        <div class="textconten">
            
            <h1 class="htext">Newregister</h1>
        </div>
		<%
		if (error_err != null) {
		%>
		<div class="alert alert-danger alert-dismissible fade show" role="alert">
			<i class="fas fa-exclamation-triangle"></i>&nbsp; <%=error_err%>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<%
		}
		%>
        <div class="regisfrom">
            <input type="text" name="username" id="user" class="form-control" placeholder="username" value="<% if (request.getParameter("username") != null) { out.print(request.getParameter("username")); } %>" required autofocus>
            <label for="username">ชื่อผู้ใช้</label>
        
            <input type="email" name="email" id="email" class="form-control" placeholder="email" value="<% if (request.getParameter("email") != null) { out.print(request.getParameter("email")); } %>" required>
            <label for="email">ที่อยู่อีเมล</label>
       
            <input type="text" name="name" id="name" class="form-control" placeholder="neme" value="<% if (request.getParameter("name") != null) { out.print(request.getParameter("name")); } %>" required>
            <label for="name">ชื่อ-นามสกุล</label>
       
            <input type="password" name="password" id="password" class="form-control" placeholder="password" required>
            <label for="password">รหัสผ่าน</label>
       
            <input type="password" name="confirm_password" id="confirm_password" class="form-control" placeholder="confirmpassword" required>
            <label for="confirm_password">ยืนยันรหัสผ่าน</label>
        </div>
            <div class="sabmit">
        <button class="btn gogo" type="submit">สมัครผู้ใช้ใหม่</button>
            </div>
            <p class="mt-2 small text-center">มีบัญชีอยู่แล้ว? <a href="login.jsp">goto login</a></p>
        <p class="mt-3 small text-muted text-center">&copy; 2019 Likeprogrammer</p>
    </form>
	
</body>

</html>
