<%-- 
    Document   : datajsp
    Created on : Sep 14, 2019, 12:06:15 AM
    Author     : hyon
--%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8" %>
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
%>

<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>list_user</title>
    <style>
        
              body{
            margin: 0;
            padding: 0;
            background-color: bisque;
        }
       
       
        .menu ul.navbar{
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
            line-height: 60px;
        }
        ul.navbar li{float: left;}
        ul.navbar li a{
            display: block;
            color: white;
            text-align: center;
            padding: 24px 28px;
            font-size: 18px;
            font-family: sans-serif;
            text-decoration: none;
            letter-spacing: 2.5px;
        }
        ul.navbar li a:hover:not(.lhome){
            background-color: blueviolet;
            font-size: 18px;
            opacity: 0.7;
        }
        ul.navbar li a.lhome{
            background-color: #4CAF50;
        }
        ul.navbar li.llog{
            float: right;
        }
        @media screen and (max-width: 600px) {
          ul.navbar li.llog, 
           ul.navbar li {float: none;}
}
        
    </style>
</head>

<body>

			<div class="menu">
				<ul class="navbar">
					<li>
						<a class="lhome" href="home.jsp">&nbsp; home</a>
					</li>
					<li>
						<a class="llist" href="#"> &nbsp; list_user</a>
					</li>
					<li>
                                            <a class="lmap" href="map.jsp">&nbsp; map</a>
					</li>
					<li class="llog">
						<a href="logout.jsp">&nbsp; logout</a>
					</li>
				</ul>
			</div>	
	<main role="main" class="container">
		<h2 class="pt-1 pb-2"><i class="fas fa-list"></i>&nbsp; list user</h2>
		<div class="card">
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered">
						<thead>
							<tr class="text-center">
								<th scope="col" width="10%">Order</th>
                                                                <th scope="col"> user</th>
                                                                <th scope="col">email_address</th>
                                                                <th scope="col">Name_Surname</ht>
							</tr>
						</thead>
						<tbody>
							<%
							try {
								ResultSet result = statement.executeQuery("SELECT * FROM `userjsp` ORDER BY `id` ASC;");
								while (result.next()) {
							%>
									<tr>
										<td class="text-center"><%=result.getString("id")%></td>
										<td><%=result.getString("user")%></td>
										<td><%=result.getString("email")%></td>
										<td><%=result.getString("name")%></td>
									</tr>
							<%
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
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>
	<p class="mt-4 small text-muted text-center">&copy; 2019 Like programmer</p>
	<script defer src="assets/js/jquery-3.4.1.min.js"></script>
	<script defer src="assets/js/bootstrap.min.js"></script>
</body>

</html>