<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="admin.MainDAO"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="article" class="admin.MainBoardVO" scope="page">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>

<%
	article.setDisplayStartDay(new Timestamp(System.currentTimeMillis()));
	article.setDisplayEndDay(new Timestamp(System.currentTimeMillis()));
	int rtn = MainDAO.getInstance().updateContent(article);
	if(rtn>0){
		String category = article.getCategory();
		String url = "/admin/homepage/main_content.jsp";
		if(category.equals("about")){
			url = "/admin/homepage/about_content.jsp";
		}else if(category.equals("contact")){
			url = "/admin/homepage/contact_content.jsp";
		}else if(category.equals("content")){
			String zoneNo = request.getParameter("zoneNo");
			url = "/admin/homepage/content_manager.jsp?zoneNo="+zoneNo;
		}
		response.sendRedirect(url);
	}else{ %>
	<script>
	  alert("수정 중 오류가 발생하였습니다!");
	  history.go(-1);
	</script>
<%}	%>