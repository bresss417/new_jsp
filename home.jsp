<%-- 
    Document   : home
    Created on : Sep 14, 2019, 3:57:45 PM
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
   if (user_id == null){
     response.sendRedirect("login.jsp");
   }
   
 Connection connect = null;
 Statement statement = null;
 
String user = null;
String email = null;
String name = null;

 try{
   
	Class.forName("com.mysql.jdbc.Driver");
	connect =  DriverManager.getConnection("jdbc:mysql://" + host + "/" + db + "" +"?user=" + username + "&password=" + password);
	statement = connect.createStatement();
	ResultSet user_data = statement.executeQuery("SELECT * FROM `userjsp` WHERE `id` = '" + user_id.toString() + "';");
        
        if (user_data.next()) {
		user = user_data.getString("user");
		email = user_data.getString("email");
		name = user_data.getString("name");
	}
 } catch (Exception e) {
	out.println(e.getMessage());
	e.printStackTrace();
}
 try {
	if (statement != null){
		statement.close();
		connect.close();
	}
} catch(SQLException e) {
    
}
%>

<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>home</title>
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
 .topname{
            text-align: center;
            font-size: 50px;
            color: purple;
            font-family: "Lobster", serif;
        }

.mbody{
    text-align: center;
    }
   .mtname{
    font-size: 30px;
    text-align: right;
    color: yellow;
    font-family: serif;
    margin-right: 20px;
    margin-top: 90px;
    }
    .uname{
        text-align: center;
        font-size: 30px;
        font-family: sans-serif;
        color: aqua;
        padding: 0;
        margin-left:20px;
    }
        
    </style>
	
</head>

<body>
<div class="menu">
		
    <ul class="topnav">
	<li>
	  <a class="lhome" href="#"></i>&nbsp; home</a>
	</li>
	<li>
	  <a class="llist" href="tabs.jsp">&nbsp; list_user</a>
	</li>
	<li>
           <a class="lmap" href="map.jsp">&nbsp; map</a>
	</li>
						
        <li class="llog">
	  <a  href="logout.jsp">&nbsp; logout</a>
	</li>
    </ul>
</div>
 
    <div class="blockname">
        <h3 class="topname">wellcom</h3>
                   

     </div>
        <div class="col-lg-9">
                <div class="card">
                        
                      
                        <div class="mbody">
                              
                                     
                                     
                                                <div class="d-flex justify-content-between align-items-center w-100">
                                                        <strong class="text-dark">username</strong>
                                                </div>
                                                <span class="d-block"><%=user%></span>
                                       
                                
                              
                                       
                                      
                                                <div class="d-flex justify-content-between align-items-center w-100">
                                                        <strong class="text-dark">email address</strong>
                                                </div>
                                                <span class="d-block"><%=email%></span>
                                      
                                
                                
                                       
                                      
                                                <div class="d-flex justify-content-between align-items-center w-100">
                                                        <strong class="text-dark">Name Surname</strong>
                                                </div>
                                                <span class="d-block"><%=name%></span>
                                      
                                
                    </div>
            
          </div>
    </div>
                                                <div class="uname">
                                                    <p>made by</p>
                                                    <p>muhammadsobri mama</p>
                                                    <p>ilham nase </p>
                                                </div>

	<p class="mtname">&copy; 2019 Likeprogrammer</p>
	
</body>

</html>