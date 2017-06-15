<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.MainBoardVO"%>
<%@ page import="admin.MainDAO"%>
<%
request.setCharacterEncoding("UTF-8");

String category = "about";

MainBoardVO board = MainDAO.getInstance().getContent(category);
int num = board.getNum();
String zoneNo = "about";
String subject = "소개글 및 가이드";
String imgUrl = "";
int boardNo = 0;
String useYn = "Y";
String contents = board.getContents();   
%> 
<html>
<head>
<title>공지/게시관리</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
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
				
<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>About Page관리</li>
	<li class="location">공지/게시관리>홈페이지 관리>About page관리</li>
</ul>

<!--본문 내용 시작--------------------------------------------------------->
<table border=0 cellpadding=0 cellspacing=0>
	<tr><td height=20></td></tr>
</table>
	<link rel='stylesheet' type='text/css' href='/css/company.css'>
	<script language='javascript' src='/js/common.js'></script>
	<!-- 게시판 시작 -->
	<link rel="StyleSheet" href="/css/board_6.css" type="text/css">
	<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
	<script type="text/javascript" src="/js/HuskyEZCreator.js" charset="utf-8"></script>
	<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.0.min.js"></script>
	<script type="text/javascript">
		var oEditors = [];
		$(function(){
		      nhn.husky.EZCreator.createInIFrame({
		          oAppRef: oEditors,
		          elPlaceHolder: "contents", //textarea에서 지정한 id와 일치해야 합니다. 
		          //SmartEditor2Skin.html 파일이 존재하는 경로
		          sSkinURI: "/SmartEditor2Skin.html",  
		          htParams : {
		              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		              bUseToolbar : true,             
		              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		              bUseVerticalResizer : true,     
		              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		              bUseModeChanger : true,         
		              fOnBeforeUnload : function(){
		                   
		              }
		          }, 
		          fOnAppLoad : function(){
		              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
		              oEditors.getById["contents"].exec("PASTE_HTML", [""]);
		          },
		          fCreator: "createSEditor2"
		      });
		      
		      //저장버튼 클릭시 form 전송
		      $("#submitbtn").click(function(){
		          oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
		          $("#com_board").submit();
		      });    
		});
		 
		 
		 
	</script>
	<style type="text/css">
		.board_bgcolor
		{
		  text-align:center;
		}
		.board_desc
		{
			padding:3 0 3 10;
			line-height:150%;
			width:1093px;
		}
	</style>
	<!-- 게시판 시작 -->
	<form name='com_board' method='post' action='/admin/homepage/modifyProcess.jsp' >
		<input type="hidden" name="category" value="<%=category%>">
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="zoneNo" value="<%=zoneNo%>">
		<input type="hidden" name="subject" value="<%=subject%>">
		<input type="hidden" name="imgUrl" value="<%=imgUrl%>">
		<input type="hidden" name="boardNo" value="<%=boardNo%>">
		<input type="hidden" name="useYn" value="<%=useYn%>">
		<table border="0" cellspacing="0" cellpadding="0" width="800" bgcolor="#ffffff" background="">
			<tr>
				<td>
				    <table border="1" cellpadding="3" cellspacing="0" width="100%" style="border-collapse:collapse" bordercolor="#E5E5E5">
					<!-- 본문 -->	
						<tr height='30'>
							<td colspan='2' align='center' width='100%'>
								<textarea title="input" name='contents' id='contents' style='display:none;' ><%=contents %></textarea>
							</td>
						</tr>
					<!-- //본문 -->
					</table>
					<table border='0' cellpadding='0' cellspacing='0' width='100%'>
						<tr>
							<td height='1' bgcolor='#E5E5E5'></td>
						</tr>
					</table>
					<table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>
						<tr>
							<td width='62'></td>
							<td class='bbsnewf5' height='34' align='center'>
								<input type='image' id="submitbtn" src='/images/board/confirm.gif' vspace='7' border='0'><!-- 확인버튼 -->
				      			<a href="javascript:document.com_board.reset();"><img src='/images/board/cancel.gif' vspace='7' border='0'></a><!-- 취소버튼 -->
						    </td>
						    <td width='62'></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
<!-- 게시판 끝 -->
<table border='3' cellpadding='7' cellspacing='0' width='800' bordercolor='ECD08A' style='margin-top:20'>
	<tr><Td style='color:585858;line-height:180%;padding-left:20'>
			<b>[사용안내]</b><br>
			<b class=ol>ㆍ</b>about page를 관리합니다.<br>
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
