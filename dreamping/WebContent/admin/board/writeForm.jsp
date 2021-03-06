<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<%
  request.setCharacterEncoding("UTF-8");
  int num=0,readcount=0,ref=1,reStep=0,reLevel=0;
  String category=request.getParameter("category");
  String categoryName = "";
  String subject = "";
  String description = "";
  String thumbImgUrl= "";
  if (category == null){
  	category = "notice";
  	categoryName = "공지사항";
  }else if("notice".equals(category)){
  	categoryName = "공지사항";
  }else if("qna".equals(category)){
  	categoryName = "문의하기";
  	num = Integer.parseInt(request.getParameter("num"));
  	try{
		BoardDAO dbPro = BoardDAO.getInstance();
		BoardVO article = dbPro.getArticle(num);

		ref=article.getRef();
		reStep=article.getReStep();
		reLevel=article.getReLevel();
  	}catch(Exception e){}
  }else if("photo".equals(category)){
	categoryName = "갤러리";
	thumbImgUrl = request.getParameter("thumbImgUrl")==null ? "":request.getParameter("thumbImgUrl"); 
  }else if("event".equals(category)){
	categoryName = "이벤트";
	thumbImgUrl = request.getParameter("thumbImgUrl")==null ? "":request.getParameter("thumbImgUrl"); 
  }else if("group".equals(category)){
	categoryName = "제휴/단체문의";
	thumbImgUrl = request.getParameter("thumbImgUrl")==null ? "":request.getParameter("thumbImgUrl");   
  }
  
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
	<li><%=categoryName %></li>
	<li class="location">공지/게시관리><%=categoryName %></li>
</ul>

<!--본문 내용 시작--------------------------------------------------------->
<table border=0 cellpadding=0 cellspacing=0>
	<tr><td height=20></td></tr>
</table>
	<link rel='stylesheet' type='text/css' href='/admin/css/company.css'>
	<script language='javascript' src='/js/common.js'></script>
	<!-- 게시판 시작 -->
	<link rel="StyleSheet" href="/admin/css/board_6.css" type="text/css">
	<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
	<script type="text/javascript" src="/js/HuskyEZCreator.js" charset="utf-8"></script>
	<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.0.min.js"></script>
	<script type="text/javascript">
		var oEditors = [];
		$(function(){
		      nhn.husky.EZCreator.createInIFrame({
		          oAppRef: oEditors,
		          elPlaceHolder: "description", //textarea에서 지정한 id와 일치해야 합니다. 
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
		              oEditors.getById["description"].exec("PASTE_HTML", [""]);
		          },
		          fCreator: "createSEditor2"
		      });
		      
		      //저장버튼 클릭시 form 전송
		      $("#submitbtn").click(function(){
		          oEditors.getById["description"].exec("UPDATE_CONTENTS_FIELD", []);
		          $("#com_board").submit();
		      });    
		});
		 
		 
		 
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
		  /*width:107px;*/
		  text-align:center;
		}
		.board_desc
		{
			padding:3 0 3 10;
			line-height:150%;
			width:1093px;
		}
		/*input .border {
			border:1px solid #EAEAEA;
			height:20px;
		}*/
	</style>
	<!-- 게시판 시작 -->
	<link rel="StyleSheet" href="/admin/css/board_6.css" type="text/css">
	<table border="0" cellspacing="0" cellpadding="0" width="800" bgcolor="#ffffff" background="">
		<tr>
			<td>
				<form name='com_board' method='post' enctype="multipart/form-data" action='/admin/board/writeProcess.jsp' onSubmit='return com_board_writeformCheck()'>
					<input type="hidden" name="category" value="<%=category%>">
					<input type="hidden" name="num" value="<%=num%>">
				    <input type="hidden" name="readcount" value="<%=readcount%>">
				    <input type="hidden" name="ref" value="<%=ref%>">
				    <input type="hidden" name="re_step" value="<%=reStep%>">
				    <input type="hidden" name="re_level" value="<%=reLevel%>">
					<input type="hidden" name="writer" value="관리자">
					<input type="hidden" name="password" value="mnmdream" />
					<table border="1" cellpadding="3" cellspacing="0" width="100%" style="border-collapse:collapse" bordercolor="#E5E5E5">
				<!-- 본문 -->	
						<tr height='30' class='board'>
							<td class="board_bgcolor"><span style="color:#000000;font-size:12px;">제목</span></td>
							<td class="board_desc"><input title="input" type='text' class='public_input input_form' id='subject' name="subject" style="border:1px solid #EAEAEA;height:20px;" maxlength="100" size="100" value="<%=subject%>"/></td>
						</tr>
				<%if(category.equals("photo")||category.equals("event")){ %>
						<tr height='30' class='board'>
							<td class="board_bgcolor"><span style="color:#000000;font-size:12px;">목록이미지</span></td>
							<td class="board_desc"><input title="input" type='file' class='public_input input_form' id='thumbImgUrl' name="thumbImgUrl" style="border:1px solid #EAEAEA;height:20px;" maxlength="50" size="50" value="<%=thumbImgUrl%>"/>
							&nbsp;&nbsp;(가로 327px로 올려주세요.)
							</td>
						</tr>			
				<%} %>
						<tr height='30'>
							<td colspan='2' align='center' width='100%'>
								<textarea title="input" name='description' id='description' style='display:none;' ><%=description %></textarea>
							</td>
						</tr>
						<tr style='display:none' id="bn">
							<td></td>
							<td class="board_desc"><!-- 첨부 파일 --></td>
						</tr>
	<!-- 						
							<tr height='30' class='board'>
								<td class="board_bgcolor"><span style="color:#000000;font-size:12px;">비밀글</span></td>
								<td class="board_desc"><input title="input" type='checkbox' name='secret' value='비밀글'  >비밀글</td>
							</tr>
	 -->						
						<input type="hidden" id="board_id" value="6" />
						<input type="hidden" id="com_board_id" value="6">
						<input type="hidden" id="template" value="bizdemo18406">
						<input title="input" type="text" name="maybe" style="display:none" />
					<!-- //본문 -->
					</table>
					<table border='0' cellpadding='0' cellspacing='0' width='100%'>
						<tr>
							<td height='1' bgcolor='#E5E5E5'></td>
						</tr>
					</table>
					<table border=0 cellpadding=0 cellspacing=0 align=center width='100%'>
						<tr>
							<td width='62'>
								<a href='/admin/board/list.jsp?category=<%=category%>'>
								<img src='/admin/img/board/list.gif' vspace='7' border='0'></a><!-- 목록보기버튼 -->
							</td>
							<td class='bbsnewf5' height='34' align='center'>
								<input type='image' id="submitbtn" src='/admin/img/board/confirm.gif' vspace='7' border='0'><!-- 확인버튼 -->
				      			<a href="javascript:document.com_board.reset();"><img src='/admin/img/board/cancel.gif' vspace='7' border='0'></a><!-- 취소버튼 -->
						    </td>
						    <td width='62'></td>
						</tr>
					</table>
				</form>
			</td>
		</tr>
	</table>
<!-- 게시판 끝 -->
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
