<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="board.BoardDAO"%>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String flag = request.getParameter("flag");
	String category = request.getParameter("category");
	String comBoardSearchCode = request.getParameter("com_board_search_code")==null?"":new String(request.getParameter("com_board_search_code").getBytes("ISO-8859-1"),"UTF-8");
	String comBoardSearchValue = request.getParameter("com_board_search_value")==null?"":new String(request.getParameter("com_board_search_value").getBytes("ISO-8859-1"),"UTF-8");
	String password = request.getParameter("password");

	BoardDAO dbPro = BoardDAO.getInstance();
	int check = dbPro.deleteArticle(num, password);

	if(check==1){
%>
	<script language="JavaScript">   
	<!-- 
		alert("글이 삭제되었습니다.");
		location.href="/admin/board/list.jsp?category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>&com_board_search_code=<%=comBoardSearchCode%>&com_board_search_value=<%=comBoardSearchValue%>";
		self.close();
	-->
	</script>      
<% }else{%>
       <script language="JavaScript">     
       <!--     
         alert("삭제를 실패했습니다.");
         history.go(-1);
       -->
      </script>
<%
  }
%>