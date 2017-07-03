<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="board.BoardDAO"%>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="article" scope="page" class="board.BoardVO">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
	String category = request.getParameter("category");

	BoardDAO dbPro = BoardDAO.getInstance();
	dbPro.updateReply(article);
	
	String url = "/admin/board/list.jsp?category="+category;
	response.sendRedirect(url);
%>