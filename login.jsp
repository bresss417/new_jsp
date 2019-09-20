<%-- 
    Document   : login
    Created on : Sep 14, 2019, 3:58:06 PM
    Author     : hyon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@include file="conf.jsp" %>

<% 

   Object user_id = session.getAttribute("user_id");
if (user_id != null) {
	response.sendRedirect("home.jsp");
}
   String user = null;
    if(request.getParameter("register") !=null) {
      user = request.getParameter("register");
    }
    if(request.getParameter("user") !=null){
       user = request.getParameter("user");
    }
    
Connection connet = null;
Statement statement = null;

String error_err = null;

if ("POST".equalsIgnoreCase(request.getMethod())) {
	try {
		Class.forName("com.mysql.jdbc.Driver");
		connet =  DriverManager.getConnection("jdbc:mysql://" + host + "/" + db + "" +"?user=" + username + "&password=" + password);
		statement = connet.createStatement();
		ResultSet result = statement.executeQuery("SELECT * FROM `userjsp` WHERE `user` = '" + request.getParameter("user") + "' AND `password` = '" + request.getParameter("password") + "';");
		if (result.next()) {
			session.setAttribute("user_id", result.getString("id"));
			if (request.getParameter("remember_me") != null) {
				session.setMaxInactiveInterval(86400);
			} else {
				session.setMaxInactiveInterval(900);
			}
			response.sendRedirect("home.jsp");
		} else {
			error_err = "The username or password is incorrect.";
		}
	}  catch (Exception e) {
		error_err = e.getMessage();
	}
	try {
		if (statement != null){
			statement.close();
			connet.close();
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
    <title>login</title>
    
    <style>
        body{
            margin: 0;
            padding: 0;
           background-color: palegreen;
               
            background-size: cover ;
            background-position: center;
            font-family: sans-serif;
        }
        form{
            border: 3px solid#f1f1f1;
        }
        .block{
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
        .h-3{
            font-size: 40px;
            color: mediumslateblue;
        }
        .container{
            padding: 16px;
        }
       
        
        input[type=text], input[type=password] {
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
          .warning {
            border-color: #ff9800;
             color: orange;
          }

         .warning:hover {
         background: #ff9800;
         color: white;
          }
        
    </style>
   
</head>

<body><br>
    <form action="login.jsp" method="POST" class="block">
        <div class="textcenter">
            
            <h1 class="h-3">welcome</h1>
            <p>login</p>
        </div>
		<%
		if (error_err != null) {
		%>
		<div class="loginbox" role="alert">
			<i class="fas fa-exclamation-triangle"></i>&nbsp; <%=error_err%>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<%
		} else if (request.getParameter("registered") != null) {
		%>
		<div class="alert alert-success alert-dismissible fade show" role="alert">
			<i class="fas fa-info-circle"></i>&nbsp; New user successfully applied
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<%
		}
		%>
        <div class="container">
            <label for="username"><b>username</b></label>
            <input type="text" name="user" id="user" class="form-control" placeholder="username" value="<% if (user != null) { out.print(username); } %>" required <% if (request.getParameter("register") == null) { out.print("autofocus"); } %>>
            
            <label for="password"><b>password</b></label>
            <input type="password" name="password" id="password" class="form-control" placeholder="password" required <% if (request.getParameter("register") != null) { out.print("autofocus"); } %>>
            
        </div>

        <div class="checkbox mb-3">
            <label>
                <input type="checkbox" name="remember_me" value="true" <% if (request.getParameter("remember_me") != null) { out.print("checked"); } %>> Remember my account
            </label>
        </div>
            <div class="sabmit">
            <button class="btn warning" type="submit">login</button>
            </div>
		<p class="mt-2 small text-center">No account<a href="register.jsp">Sign up for new users</a></p>
        <p class="mt-3 small text-muted text-center">&copy; 2019 Like_programmer</p>
    </form>
	<script defer src="assets/js/jquery-3.4.1.min.js"></script>
	<script defer src="assets/js/bootstrap.min.js"></script>
</body>

</html>
