<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.sql.Timestamp"%>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="article" scope="page" class="board.BoardVO">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String flag = request.getParameter("flag");
	String category = request.getParameter("category");
	String comBoardSearchCode = request.getParameter("com_board_search_code")==null?"":new String(request.getParameter("com_board_search_code").getBytes("ISO-8859-1"),"UTF-8");
	String comBoardSearchValue = request.getParameter("com_board_search_value")==null?"":new String(request.getParameter("com_board_search_value").getBytes("ISO-8859-1"),"UTF-8");

	BoardDAO dbPro = BoardDAO.getInstance();
    int check = dbPro.updateArticle(article);

    if(check==1){
%>
    <script language="JavaScript">   
	<!-- 
		alert("글이 수정되었습니다.");
		location.href="/main/board/list.jsp?category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>&com_board_search_code=<%=comBoardSearchCode%>&com_board_search_value=<%=comBoardSearchValue%>";
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