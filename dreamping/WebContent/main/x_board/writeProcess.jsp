<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="article" class="board.BoardVO" scope="page">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>

<%
	article.setRegDate(new Timestamp(System.currentTimeMillis()) );
	BoardDAO dbPro = BoardDAO.getInstance();
	dbPro.insertArticle(article);
	String category = article.getCategory();
	String url = "/main/board/list.jsp?category="+category;
	response.sendRedirect(url);
%>