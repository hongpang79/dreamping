<%@ page contentType="text/html;charset=UTF-8" %>
<% 
request.setCharacterEncoding("UTF-8");
session.invalidate();
response.sendRedirect("/admin/login.jsp");
%>
