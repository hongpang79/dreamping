<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String flag = request.getParameter("flag");
	String action = request.getParameter("action");
	String category = request.getParameter("category");
	String comBoardSearchCode = request.getParameter("com_board_search_code")==null?"":new String(request.getParameter("com_board_search_code").getBytes("ISO-8859-1"),"UTF-8");
	String comBoardSearchValue = request.getParameter("com_board_search_value")==null?"":new String(request.getParameter("com_board_search_value").getBytes("ISO-8859-1"),"UTF-8");
	String password = request.getParameter("password");

	BoardDAO dbPro = BoardDAO.getInstance();
	int check = dbPro.deleteArticle(num, password);
	System.out.println("check : " + check);
	String param = "action="+action+"&category="+category+"&pageNum="+pageNum+"&flag="+flag+"&com_board_search_code="+comBoardSearchCode+"&com_board_search_value="+comBoardSearchValue;
	String url = "/board/list.jsp?"+param;
	if(category.equals("event")||category.equals("photo")){
		url = "/board/gallerylist.jsp?"+param;
	}

	if(check==1){
%>
	<script language="JavaScript">   
	<!-- 
		alert("글이 삭제되었습니다.");
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