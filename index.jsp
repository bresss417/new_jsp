<%-- 
    Document   : index
    Created on : Sep 13, 2019, 10:17:18 PM
    Author     : hyon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
  
  Object user_id = session.getAttribute("user_id");
  if(user_id != null) {
       response.sendRedirect("home.jsp");
  } else {
      response.sendRedirect("login.jsp");
  }
%>
