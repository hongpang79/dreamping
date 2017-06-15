<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	request.setCharacterEncoding("UTF-8");
	String path = application.getRealPath("/SE2/upload");
	MultipartRequest mr = new MultipartRequest(request, path, 1024*1024*5, "utf-8", new DefaultFileRenamePolicy());
	
	File s_file = mr.getFile("Filedata");
	String thumbImgUrl = "/SE2/upload/"+s_file.getName();
	String target = mr.getParameter("target");
	out.print(target);
%>
	<script language="JavaScript">   
	<!-- 
		
	 	opener.addform.<%= target %>.value='<%= thumbImgUrl %>';
		self.close();
	-->
	</script>   