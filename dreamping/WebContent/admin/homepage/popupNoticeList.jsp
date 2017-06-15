<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<%@ page import="java.util.List" %>
<%
request.setCharacterEncoding("UTF-8");
List articleList = null;
BoardDAO dbPro = BoardDAO.getInstance();
articleList = dbPro.getArticles(1, 10, "notice");
%>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<title>공지글목록</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<link rel='stylesheet' type='text/css' href='/css/template.css'>
<link rel="StyleSheet" href="/css/board_6.css" type="text/css">
<script>
	function selectNotice(num, subject){
		window.opener.document.mainModifyForm.boardNo.value=num;
		window.opener.document.mainModifyForm.boardSubject.value=subject;
	   	self.window.close();
	}
</script>
</head>
<body>
<table width="520">
	<tr><td height="30px"><strong>&nbsp;공지사항 최신글 10</strong></td></tr>
	<tr>
	<td align="center">
	<table border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse" width="500" bordercolor="#E5E5E5" class="board">
		<colgroup>
			<col width="40px" />
			<col width="*" />
		</colgroup>
		
		<tr bgcolor="#F7F7F7" align="center">
			<th><font size="2">번호</font></th>
			<th><font size="2">제목</font></td>
		</tr>
<%
for(int i=0; i<articleList.size(); i++) {
	BoardVO article = (BoardVO)articleList.get(i);
	
%>
		<tr align='center' height='18' onclick="javascript:selectNotice('<%=article.getNum()%>','<%=article.getSubject()%>');" style='cursor:pointer;' style="cursor:pointer" >
			<td class="bbsno"><%=article.getNum()%></td>
			<td class='bbsnewf5' align='left'><%=article.getSubject()%></td>
		</tr>
<%
}
%>		
	</table>
	</td></tr>
	<tr><td align="center"><img src="/admin/img/btn_cancel.gif" onClick="javascript:self.close();"/></td>
</table>		
</body>
</html>