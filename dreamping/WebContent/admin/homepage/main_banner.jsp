<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="admin.MainBoardVO" %>
<%@ page import="admin.MainDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	NumberFormat nf = NumberFormat.getInstance();
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy/MM/dd");
		
	String step = request.getParameter("step")==null?"list":request.getParameter("step");
	String msg = "";
	
	if(!step.equals("list")){
		msg = MainDAO.getInstance().processBanner(request);	
	}
%>
<html>
<head>
<title>홈페이지 관리 > 메인 Banner 관리</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
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
	function deleteBanner( idx )
	{
		if( !confirm( '삭제하시겠습니까?' ) ) return;

		var cmd = document.createElement( 'input' );
		cmd.type = 'hidden';
		cmd.name = 'step';
		cmd.value = 'delete';

		var key = document.createElement( 'input' );
		key.type = 'hidden';
		key.name = 'bannerNo';
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
	
	function modifyBanner( idx, useYn )
	{
		if( !confirm( '수정하시겠습니까?' ) ) return;

		var cmd = document.createElement( 'input' );
		cmd.type = 'hidden';
		cmd.name = 'step';
		cmd.value = 'modify';

		var key = document.createElement( 'input' );
		key.type = 'hidden';
		key.name = 'bannerNo';
		key.value = idx;
		
		if(useYn == "Y"){
			useYn = "N";
		}else{
			useYn = "Y";
		}
		var use = document.createElement( 'input' );
		use.type = 'hidden';
		use.name = 'useYn';
		use.value = useYn;

		var f = document.createElement( 'form' );
		f.style.display = 'none';
		f.setAttribute( 'method' , 'post' );
		f.setAttribute( 'action' , '/admin/homepage/main_banner.jsp');
		document.body.appendChild( f );
		f.appendChild( cmd );
		f.appendChild( key );
		f.appendChild( use );

		f.submit();
	}

	


</script>


<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>메인 Banner 목록</li>
	<li class="location">공지/게시관리>홈페이지 관리>메인 Banner 관리</li>
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
			<th>NO</th>
			<th>Banner명</th>
			<th>image path<br>[링크공지제목]</th> 
			<!-- <th>Display<br>기간</th> -->
			<th>사용여부</th>
			<th>선택</th>
		</tr>
	</thead>
	<tbody>
<%
	Vector<MainBoardVO> vBoard = MainDAO.getInstance().selectMainBannerList();
	int count = vBoard.size();
	if( count == 0 ){
%>
		<tr><td colspan="5"> <br/>등록된 Banner가 없습니다<br/><br/></td></tr>
<%
	}else{
		int bannerNo = 0;
		String bannerName = "";
		String imagePath = "";
		int boardNo = 0;
		String boardSubject = "";
		//String displayStartDay = "";
		//String displayEndDay = "";
		String useYn = "";
		String btnName = "변경(N→Y)";
		
		MainBoardVO board = null;
		for(int i=0; i<count; i++){
			board = vBoard.get(i);
			bannerNo = board.getNum();
			bannerName = board.getSubject();
			imagePath = board.getImgUrl();
			boardNo = board.getBoardNo();
			boardSubject = board.getBoardSubject();
			//displayStartDay = board.getDisplayStartDay()==null?"":transFormat.format(board.getDisplayStartDay()); 
			//displayEndDay = board.getDisplayEndDay()==null?"":transFormat.format(board.getDisplayEndDay()); 
			useYn = board.getUseYn();
%>
		<tr>
			<td><%= i+1 %></td>
			<td><%=bannerName %></td>
			<td><%=imagePath %><br>[<%=boardSubject %>]</td>
			<!-- <td>~</td> -->
			<td><%=useYn %>&nbsp;<% if(useYn.equals("Y")){ btnName="변경(Y→N)"; }else{ btnName = "변경(N→Y)"; } %>
				<input type="button" value="<%=btnName %>" onClick="javascript:modifyBanner('<%= bannerNo %>','<%=useYn %>');" /></td>
			<td>
				<!-- <input type="button" value="수정" onClick="javascript:modifyBanner(<%= bannerNo %>);" /> -->
				<input type="button" value="삭제" onClick="javascript:deleteBanner(<%= bannerNo %>);" />
			</td>
		</tr>
<%					
		}
	}
%>
	</tbody>
</table>

<div style='width:800' align='center'>
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="Banner추가하기" class="bt_a32 tmb22" onclick="location.href='/admin/homepage/main_banner_modify.jsp';">
</div>

<table border='3' cellpadding='7' cellspacing='0' width='800' bordercolor='ECD08A' style='margin-top:20'>
	<tr><Td style='color:585858;line-height:180%;padding-left:20'>
			<b>[사용안내]</b><br>
			<b class=ol>ㆍ</b>메인화면의 배너를 관리합니다.<br>
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
