<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="board.BoardDAO"%>

<%
	request.setCharacterEncoding("UTF-8");
	String path = application.getRealPath("/SE2/upload");
	MultipartRequest mr = new MultipartRequest(request, path, 1024*1024*5, "utf-8", new DefaultFileRenamePolicy());
%>
<jsp:useBean id="article" class="board.BoardVO" scope="page">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
	String category = mr.getParameter("category");
	String thumbImgUrl = "";
	if("photo".equals(category)){
		File s_file = mr.getFile("thumbImgUrl");
		thumbImgUrl = "/SE2/upload/"+s_file.getName();	
	}
	article.setCategory(category);
	article.setNum(Integer.parseInt((String) mr.getParameter("num")));
	article.setReadCount(Integer.parseInt((String) mr.getParameter("readcount")));
	article.setRef(Integer.parseInt((String) mr.getParameter("ref")));
	article.setReStep(Integer.parseInt((String) mr.getParameter("re_step")));
	article.setReLevel(Integer.parseInt((String) mr.getParameter("re_level")));
	article.setWriter(mr.getParameter("writer"));
	article.setPassword(mr.getParameter("password"));
	article.setEmail(mr.getParameter("email"));
	article.setSubject(mr.getParameter("subject"));
	article.setDescription(mr.getParameter("description"));
	article.setThumbImgUrl(thumbImgUrl);
	article.setRegDate(new Timestamp(System.currentTimeMillis()) );
	BoardDAO dbPro = BoardDAO.getInstance();
	dbPro.insertArticle(article);
	
	String url = "/admin/board/list.jsp?category="+category;
	response.sendRedirect(url);
%>