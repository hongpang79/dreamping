<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="admin.MainBoardVO"%>
<%@ page import="admin.MainDAO"%>
<%
request.setCharacterEncoding("UTF-8");

String cmd = request.getParameter("cmd")==null?"list":request.getParameter("cmd");
String step = request.getParameter("step")==null?"insert":request.getParameter("step");
int num = request.getParameter("num")==null?0:Integer.parseInt(request.getParameter("num"));
int boardNo = request.getParameter("boardNo")==null?1:Integer.parseInt(request.getParameter("boardNo"));
String msg = "";

String category = "site";
String zoneNo = "";
String subject = "";
String imgUrl = "";

String useYn = "Y";
String contents = "";

MainBoardVO board = null;
if(cmd.equals("list")&&step.equals("update")){
	board = MainDAO.getInstance().getContent(num);
	num = board.getNum();
	zoneNo = board.getZoneNo();
	subject = board.getSubject();
	imgUrl = board.getImgUrl();
	boardNo = board.getBoardNo();
	useYn = board.getUseYn();
}
%>
<html>
<head>
<title></title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
</head>
<script language=javascript>
$(document).ready(
		function() {
			if($("#msg").val().length > 0){
				alert($("#msg").val());
				opener.parent.window.location.reload();
				self.close();
		}
	});	


function formCheck()
{
	var sform = document.addform;
	
	if(sform.subject.value.length == 0)
	{
		alert('Zone명을 입력하세요.');
		sform.subject.focus();
		return false;
	}

	if(sform.imgUrl.value.length == 0)
	{
		alert('Image URL을 입력하세요.');
		sform.imgUrl.focus();
		return false;
	}
	
	if(sform.contents.value.length == 0)
	{
		alert('설명를 입력하세요.');
		sform.contents.focus();
		return false;
	}
	
	if(confirm('저장하시겠습니까?') == true) {
		var s = sform.subject.value;
		sform.zoneNo.value=s.substring(0,8);
		//alert(zoneNo.value);
		sform.action="/admin/homepage/writeProcess.jsp";
		if(sform.step.value=="update"){
			sform.action="/admin/homepage/modifyProcess.jsp";
		}
		sform.submit();
	}
}

function numnberCheck()
{


	if(event.keyCode == 109 || event.keyCode == 189)
	{
		return true;
	}
	else{
		var inp=String.fromCharCode(event.keyCode);
		if (isNaN(inp)) {
			if((event.keyCode < 96 || event.keyCode > 105) ) {
				//event.keyCode 8 => Back Space , 37 = (<-방향키) ,  39 = (->방향키)
				if( (event.keyCode !=8) && (event.keyCode !=37) && (event.keyCode !=39) ) {
					alert("숫자 또는 '-'만  입력해주세요!");
						event.returnValue=false;
				}
			}
		}
		else{
			return true;
		}
	}
}


</script>
<body bgcolor='#FFFFFF' topmargin='0' leftmargin='0'>
	<!--본문 내용 시작--------------------------------------------------------->
	<table border='0' cellspacing='0' cellpadding='0' >
	<tr height='56'>
		<td style="padding:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>■ Site 추가/수정</strong></td>
	</tr>
	<tr>
		<td align="center">
			<table border='1' cellpadding='0' cellspacing='0' width='540' style='border-collapse:collapse' bordercolor='cccccc'>
				<form name='addform' method='post'>
					<input type='hidden' name='cmd' value='<%=step%>'/>
					<input type='hidden' name='step' value='<%=step%>'/>
					<input type='hidden' name='msg' id='msg' value="<%=msg %>"/>
					<input type='hidden' name='category' id='category' value="<%=category %>"/>
					<input type='hidden' name='zoneNo' id='zoneNo' value="<%=zoneNo %>"/>
					<input type='hidden' name='boardNo' id='boardNo' value="<%=boardNo %>"/>
				<tr height='28'>
					<td class='tbsbj' width='100'>Zone명</td>
					<td class='tbcont'>
					<% if(boardNo==0){ %>
						<input type='text' id='subject' size='30' name='subject' value="<%=subject %>">
					<%}else{ %>
						<input type='text' id='subject' size='30' name='subject' value="<%=subject %>" READONLY>
					<%} %>
					</td>
					<td class='tbsbj'>사용여부</td>
					<td class='tbcont'>
						<input type="radio" name="useYn" value="Y" <% if(useYn.equals("Y")){ %> checked <%} %>/>Yes
						<input type="radio" name="useYn" value="N" <% if(useYn.equals("N")){ %> checked <%} %>/>No
					</td>
				<tr height='28'>
					<td class='tbsbj'>Image URL</td>
					<td colspan='3' height='28' class='tbcont'>
						http://urbanslowcity.cdn3.cafe24.com/images/site/<input title="input" type='text' id='imgUrl' name="imgUrl" style="border:1px solid #EAEAEA;height:20px;" size="18" value="<%=imgUrl%>"/>
					</td>
				</tr>
				<tr height='28'>
					<td class='tbsbj' width='100'>이미지 설명</td>
					<td colspan='3' class='tbcont'><input type='text' id='contents' size='66' name='contents' value="<%=contents %>"></td>					
				</tr>
			</table>
			<br>
			<div style='width:600' align='center'>
				<input type="button" name="add_submit" value="저장하기" style="cursor:hand" onclick="javascript:formCheck();">
			</div>

			</form>
		</td>
	</tr>
	</table>
</body>
</html>