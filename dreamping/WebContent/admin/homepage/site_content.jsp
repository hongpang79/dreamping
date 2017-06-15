<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="admin.MainBoardVO"%>
<%@ page import="admin.MainDAO"%>
<%
request.setCharacterEncoding("UTF-8");
String msg = "";

String category = "site";
int num = 0;
String zoneNo = "";
String subject = "";
String imgUrl = "";
int boardNo = 0;
String useYn = "";
String contents = "";
%> 
<html>
<head>
<title>공지/게시관리</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
<script type="text/javascript" src="/js/popup.js"></script>
<script type="text/javascript" src="/js/jquery-1.10.1.min.js"></script>
<script language=javascript>
$(document).ready(
		function() {
			if($("#msg").val().length > 0){
				alert($("#msg").val());
		}
	});	
</script>
</head>

<body bgcolor='#FFFFFF' topmargin='0' leftmargin='0'>

	<!-- 상단 TOP Menu S -->
    <jsp:include page="/admin/board/menu_top.jsp" />
    <!-- 상단 TOP Menu E -->
			            
    	
	
	<table border=0 cellpadding=0 cellspacing=0 width=800>
			<tr valign=top>
				<td width=175 bgcolor=F7F7F7>
					<!--왼쪽 타이틀------------------------------------------------->
					<jsp:include page="/admin/board/menu_left.jsp" />	
					<!--//왼쪽 타이틀------------------------------------------------->
				</td>
				<td width=18><img src=/admin/img/e.gif width=18></td>
				<td width="100%">
				<td align="left" width="50%">
	


<script language=javascript>
	function deleteImage( idx )
	{
		if( !confirm( '삭제하시겠습니까?' ) ) return;

		var cmd = document.createElement( 'input' );
		cmd.type = 'hidden';
		cmd.name = 'step';
		cmd.value = 'delete';

		var key = document.createElement( 'input' );
		key.type = 'hidden';
		key.name = 'num';
		key.value = idx;

		var f = document.createElement( 'form' );
		f.style.display = 'none';
		f.setAttribute( 'method' , 'post' );
		f.setAttribute( 'action' , '/admin/homepage/main_banner.jsp');
		document.body.appendChild( f );
		f.appendChild( cmd );
		f.appendChild( key );

		f.submit();
	}
	
	function callPopup(dvsn,num){
		var step = "update";
		var boardNo = 1;
		if(dvsn == "NEW"){
			step = "insert";
			num = 0;
			boardNo = 0;
		}
		var url = "/admin/homepage/popupSiteform.jsp?step="+step+"&num="+num+"&boardNo="+boardNo;
		url = encodeURI(url);
		popup.openWindowPopup(url, 'popup', {width : '600px', height : '230px'});
	}	


</script>


<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>Site Page관리</li>
	<li class="location">공지/게시관리>홈페이지 관리>Site page관리</li>
</ul>

<!--본문---------------------------------------------------------------------->
<table border=0 cellpadding=0 cellspacing=0 width=800>
	<tr height='20'><td></td></tr>
</table>

<form name="msgForm">
	<input type="hidden" id="msg" name="msg" value="<%=msg%>">
</form>
<table id="listing_table" class="product_table">
	<thead>
		<tr>
			<th>Zone명</th>
			<th>No</th>
			<th>image path</th>
			<th>선택</th>
		</tr>
	</thead>
	<tbody>
<%
	Vector<MainBoardVO> vBoard = MainDAO.getInstance().selectContentList(category);
	int count = vBoard.size();
	if( count == 0 ){
%>
		<tr><td colspan="4"> <br/>등록된 Site image가 없습니다<br/><br/></td></tr>
<%
	}else{		
		MainBoardVO board = null;
		for(int i=0; i<count; i++){
			board = vBoard.get(i);
			num = board.getNum();
			zoneNo = board.getZoneNo();
			subject = board.getSubject();
			imgUrl = board.getImgUrl();
			boardNo = board.getBoardNo();
			useYn = board.getUseYn();
%>
		<tr>
			<td><%=subject %></td>
			<td><%= boardNo %></td>
			<td>http://urbanslowcity.cdn3.cafe24.com/images/site/<%=imgUrl %></td>
			<td>
			<% if(boardNo==0){ %>
				<input type="button" value="이미지추가" onClick="javascript:callPopup('SUB',<%= num %>);" />
			<% } %>
				<input type="button" value="수정" onClick="javascript:callPopup('MOD',<%= num %>);" />
				<input type="button" value="삭제" onClick="javascript:deleteImage(<%= num %>);" />
			</td>
		</tr>
<%					
		}
	}
%>
	</tbody>
</table>

<div style='width:800' align='center'>
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="대표Site추가하기" class="bt_a32 tmb22" onclick="javascript:callPopup('NEW','0');">
</div>

<table border='3' cellpadding='7' cellspacing='0' width='800' bordercolor='ECD08A' style='margin-top:20'>
	<tr><Td style='color:585858;line-height:180%;padding-left:20'>
			<b>[사용안내]</b><br>
			<b class=ol>ㆍ</b> 이미지는 가로사진은 가로기준 800px, 세로로찍은 사진은 세로기준 680px로 비율고정하여 축소한 후 upload 합니다.<br>
			<b class=ol>ㆍ</b> 네트웍사용량을 고려하여 CDN서버에 FTP로 이미지 파일을  upload 후 파일명을 입력합니다.<br>
			<b class=ol>ㆍ</b> CDN주소 : urbanslowcity.cdn3.cafe24.com<br>
			<b class=ol>ㆍ</b> ID : urbanslowcity<br>
			<b class=ol>ㆍ</b> /images/site/ 하위폴더에 이미지를 upload 합니다.<br>
			<b class=ol>ㆍ</b> site이미지 추가시  full path가 자동으로 입력됩니다.(http://urbanslowcity.cdn3.cafe24.com/images/site/)<br>
	    </td>
	</tr>
</table>
<table border=0 cellpadding=0 cellspacing=0>
	<tr><td height=50></td></tr>
</table>
<!--본문 끝---------------------------------------------------------------------------------------->
			</td>
	</tr>
</table>
				
	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->

</body>
</html>
