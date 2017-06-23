<%@ page contentType="text/html;charset=UTF-8" %>


<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String flag = request.getParameter("flag");
	String category = request.getParameter("category");
	String comBoardSearchCode = request.getParameter("com_board_search_code")==null?"":new String(request.getParameter("com_board_search_code").getBytes("ISO-8859-1"),"UTF-8");
	String comBoardSearchValue = request.getParameter("com_board_search_value")==null?"":new String(request.getParameter("com_board_search_value").getBytes("ISO-8859-1"),"UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<TITLE>Urban Slow City </TITLE>
	<link rel='stylesheet' type='text/css' href='/css/company.css'>
	<script language='javascript' src='/js/common.js'></script>
	<script language="JavaScript">         
	  	function confirm(){   
	    	if(document.delForm.password.value==''){
	    		alert("비밀번호를 입력하십시요.");
	    		document.delForm.password.focus();
	    		return false;
	 		}
		}        
	</script>
	<style type="text/css">
		/*
		   .board_bgcolor 테이블 제목 컬럼 스타일 지정
		   .board_desc    테이블 제목 옆 내용 컬럼 스타일 지정
		   $com_board.table_size :: 관리자가 지정한 전체 사이즈
		   .border : textboxLine
		*/
		.board_bgcolor
		{
		  width:107px;
		  text-align:center;
		}
		.board_desc
		{
			padding:3 0 3 10;
			line-height:150%;
			/*width:1093px;*/
		}
		/*input .border {
			border:1px solid #EAEAEA;
			height:20px;
		}*/
	</style>
</HEAD>
<body>
	<form method="POST" name="delForm"  action="/main/board/deleteProcess.jsp" onsubmit="return confirm()">
		<input type="hidden" name="category" value="<%=category%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="flag" value="<%=flag%>">
		<input type="hidden" name="com_board_search_code" value="<%=comBoardSearchCode%>">
		<input type="hidden" name="com_board_search_value" value="<%=comBoardSearchValue%>">
		<input type="hidden" name="num" value="<%=num%>">
 		<table border="0" align="center" cellspacing="0" cellpadding="0" width="280">
  			<tr height='30'>
				<td class="board_bgcolor"><span style="color:#000000;font-size:12px;">비밀번호</span></td>
				<td class="board_desc"><input title="input" type='password' id='border' name='password' maxlength='20' size='20' /></td>
			</tr>
 			<tr height="30" align=center>
    			<td colspan="2">
    				<input type='image' id="submitbtn" src='/images/board/confirm.gif' vspace='7' border='0'><!-- 확인버튼 -->
    				<a href="javascript:self.close();"><img src='/images/board/cancel.gif' vspace='7' border='0'></a><!-- 취소버튼 -->
   				</td>
 			</tr> 
		</table>
	</form>
</body>
</html>

