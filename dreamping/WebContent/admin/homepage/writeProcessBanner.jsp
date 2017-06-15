<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="admin.MainDAO"%>

<%
	request.setCharacterEncoding("UTF-8");
	String path = application.getRealPath("/images/main");
	MultipartRequest mr = new MultipartRequest(request, path, 1024*1024*5, "utf-8", new DefaultFileRenamePolicy());
%>
<jsp:useBean id="article" class="admin.MainBoardVO" scope="page">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
	File s_file = mr.getFile("imgUrl");
	String imgUrl = "/images/main/"+s_file.getName();
	String url = "/admin/homepage/main_banner.jsp";
	
	article.setCategory(mr.getParameter("category"));
	article.setZoneNo("banner");
	article.setBoardNo(Integer.parseInt((String) mr.getParameter("boardNo")));
	article.setNum(Integer.parseInt((String) mr.getParameter("num")));
	article.setSubject(mr.getParameter("subject"));
	article.setImgUrl(imgUrl);
	//article.setDisplayStartDay(mr.getParameter("displayStartDay"));
	//article.setDisplayEndDay(mr.getParameter("displayEndDay"));
	article.setUseYn(mr.getParameter("useYn"));
	
	MainDAO dbPro = MainDAO.getInstance();
	dbPro.insertArticle(article);
	
	System.out.println("url : " + url);
	response.sendRedirect(url);
%>