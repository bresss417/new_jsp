<%-- 
    Document   : map
    Created on : Sep 19, 2019, 3:52:18 PM
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
if (user_id == null) {
	response.sendRedirect("login.jsp");
}

Connection connect = null;
Statement statement = null;

try {
	Class.forName("com.mysql.jdbc.Driver");
	connect =  DriverManager.getConnection("jdbc:mysql://" + host + "/" + db + "" +"?user=" + username + "&password=" + password);
	statement = connect.createStatement();
	ResultSet user_data = statement.executeQuery("SELECT * FROM `userjsp` WHERE `id` = '" + user_id.toString() + "';");
	if (!user_data.next()) {
		session.removeAttribute("user_id");
		response.sendRedirect("login.jsp");
	}
}  catch (Exception e) {
	out.println(e.getMessage());
	e.printStackTrace();
}
try {
	if (statement != null){
		statement.close();
		connect.close();
	}
} catch (SQLException e) {
}

%>

<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>แผนที่</title>
   
    <style>
        
            body{
            margin: 0;
            padding: 0;
            background-color: bisque;
        }
       
       
        .menu ul.topnav{
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
            line-height: 60px;
        }
        ul.topnav li{float: left;}
        ul.topnav li a{
            display: block;
            color: white;
            text-align: center;
            padding: 24px 28px;
            font-size: 18px;
            font-family: sans-serif;
            text-decoration: none;
            letter-spacing: 2.5px;
        }
        ul.topnav li a:hover:not(.lhome){
            background-color: blueviolet;
            font-size: 18px;
            opacity: 0.7;
        }
        ul.topnav li a.lhome{
            background-color: #4CAF50;
        }
        ul.topnav li.llog{
            float: right;
        }
        @media screen and (max-width: 600px) {
          ul.topnav li.llog, 
           ul.topnav li {float: none;}
}
.ptt{
    text-align: center;
    font-size: 40px;
    color: black;
}
.mappcon{
    text-align: center;
}
.likh{
      font-size: 30px;
    text-align: right;
    color: yellow;
    font-family: serif;
    margin-right: 20px;
    margin-top: 80px;
}
        
    </style>
	
</head>

<body>
		<div class="menu">
			
				<ul class="topnav">
					<li>
						<a class="lhome" href="home.jsp">&nbsp;home</a>
					</li>
					<li>
						<a class="llist" href="tabs.jsp">&nbsp; list_user</a>
					</li>
					<li>
                                            <a class="lmap" href="#">&nbsp;map</a>
					</li>
					<li class="llog">
						<a href="logout.jsp">&nbsp; logout</a>
					</li>
				</ul>
			</div>
		
	
	<main role="main" class="container">
		<h2 class="ptt">&nbsp; วิทยาลัยการอาชีพปัตตานี</h2>
		<div class="mappcon" style="height: 550px">
			<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15844.810689096115!2d101.242661!3d6.8663!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x7b7a2c64604e80ef!2z4Lin4Li04LiX4Lii4Liy4Lil4Lix4Lii4LiB4Liy4Lij4Lit4Liy4LiK4Li14Lie4Lib4Lix4LiV4LiV4Liy4LiZ4Li1!5e0!3m2!1sth!2sth!4v1568971147442!5m2!1sth!2sth" width="800" height="450" frameborder="0" style="border:0;" allowfullscreen=""></iframe>
		</div>
	</main>
	<p class="likh">&copy; 2019 Likeprogrammer</p>
	
</body>

</html>