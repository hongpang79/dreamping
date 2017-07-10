<%@ page contentType="text/html;charset=UTF-8" %>
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
<jsp:useBean id="article" scope="page" class="board.BoardVO">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
	String action = mr.getParameter("action");
	String category = mr.getParameter("category");
	String url = "/board/list.jsp?action=board&category="+category;
	String thumbImgUrl = "";
	if("photo".equals(category)||"event".equals(category)){
		File s_file = mr.getFile("thumbImgUrl");
		System.out.println(s_file);
		if(s_file == null){
			thumbImgUrl = mr.getParameter("thumbImgUrlOrg");
		}else{
			thumbImgUrl = "/SE2/upload/"+s_file.getName();
		}
		url = "/board/gallerylist.jsp?action=review&category="+category;
	}
	
	article.setCategory(category);
	article.setNum(Integer.parseInt((String) mr.getParameter("num")));
	article.setWriter(mr.getParameter("writer"));
	article.setEmail(mr.getParameter("email"));
	article.setSubject(mr.getParameter("subject"));
	article.setPassword(mr.getParameter("password"));
	article.setThumbImgUrl(thumbImgUrl);
	article.setDescription(mr.getParameter("description"));
	
	BoardDAO dbPro = BoardDAO.getInstance();
    int check = dbPro.updateArticle(article);

    if(check==1){
%>
    <script language="JavaScript">   
	<!-- 
		alert("글이 수정되었습니다.");
		location.href='<%=url%>';
	-->
	</script> 
<% }else{%>
      <script language="JavaScript">     
      <!--     
        alert("비밀번호가 맞지 않습니다");
        history.go(-1);
      -->
     </script>
<%
    }
%>