<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  request.setCharacterEncoding("UTF-8");
  int num=0,readcount=0,ref=1,reStep=0,reLevel=0;
  String reSubject="";
  String category=request.getParameter("category");
%> 
<HTML>
<HEAD>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<TITLE>Urban Slow City </TITLE>
	<link rel="stylesheet" type="text/css" media="all" href="/css/board/content.css" />
	<link rel='stylesheet' type='text/css' href='/css/company.css'>
	<script language='javascript' src='/js/common.js'></script>
	
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
</HEAD>
<body leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0">
	<!--menu-->
	<jsp:include page="/main/menu.jsp" />
	<!--//menu-->
	
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="Table_01" >
		<tr>
			<td align="center">
			
				<table width="1200" height="700" border="0" cellspacing="0" cellpadding="0">
					<tr height="200px">
						<td>
							<table width="1200px">
								<tr>
									<td width="5px"></td>
									<td width="1150px">
										<div id="container">
											<%
												if("notice".equals(category)){
											%>
												<h2><img src="/images/board/notice.png" alt="" /></h2>
											<%
												}
											%>	
											<%
												if("qna".equals(category)){
											%>
												<h2><img src="/images/board/qna.png" alt="" /></h2>
											<%
												}
											%>	
											<%
												if("photo".equals(category)){
											%>
												<h2><img src="/images/board/photo.png" alt="" /></h2>
											<%
												}
											%>	
											<!-- customerCover -->
											<div class="communityCover">
											<ul class="menu_list">
												<li><a href="/main/board/gallerylist.jsp?category=photo">포토앨범</a></li>
												<li <%if("notice".equals(category)){ %>class="on"<%} %>><a href="/main/board/list.jsp?category=notice">공지사항</a></li>
												<li <%if("qna".equals(category)){ %>class="on"<%} %>><a href="/main/board/list.jsp?category=qna">Q & A</a></li>
											</ul>
											</div>
										</div>
									</td>
									<td></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
    					<td align="center" valign="top">
    									
    									<!-- 게시판 시작 -->
    									<link rel="StyleSheet" href="/css/board_6.css" type="text/css">
    									<script language="javascript" src="/js/board.js?com_board_id=6&template=bizdemo18406"></script>
    									<script language="javascript" type="text/javascript" src="/js/board_util.js"></script>
    									<table border="0" cellspacing="0" cellpadding="0" width="1100" bgcolor="#ffffff" background="">
    									</table>
    									<table border="0" cellspacing="0" cellpadding="0" width="1100" bgcolor="#ffffff" background="">
    									
    									<form name='com_board' method='post' action='/main/board/writeProcess.jsp' onSubmit='return com_board_writeformCheck()'>
    										<input type="hidden" name="category" value="<%=category%>">
    										<input type="hidden" name="num" value="<%=num%>">
									        <input type="hidden" name="readcount" value="<%=readcount%>">
									        <input type="hidden" name="ref" value="<%=ref%>">
									        <input type="hidden" name="re_step" value="<%=reStep%>">
									        <input type="hidden" name="re_level" value="<%=reLevel%>">
											
											<tr>
												<td>
													<table border="1" cellpadding="3" cellspacing="0" width="100%" style="border-collapse:collapse" bordercolor="#E5E5E5">
													<!-- 본문 -->
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
															text-align:left;
														}
														input border {
															border:1px solid #EAEAEA;
															height:20px;
														}
													</style>
														<tr height='30' class='board'>
															<td class="board_bgcolor"><span style="color:#000000;font-size:12px;">작성자</span></td>
															<td class="board_desc"><input title="input" type="text" id='writer' name="writer" style="border:1px solid #EAEAEA;height:20px;" maxlength="50" size="50" value=""></td>
														</tr>
														<tr height='30' class='board'>
															<td class="board_bgcolor"><span style="color:#000000;font-size:12px;">비밀번호</span></td>
															<td class="board_desc"><input title="input" type='password' id='password' name='password' style="border:1px solid #EAEAEA;height:20px;" maxlength='20' size='20' /></td>
														</tr>
														<tr height='30' class='board'>
															<td class="board_bgcolor"><span style="color:#000000;font-size:12px;">제목</span></td>
															<td class="board_desc"><input title="input" type='text' class='public_input input_form' id='subject' name="subject" style="border:1px solid #EAEAEA;height:20px;" maxlength="100" size="100" value=""/></td>
														</tr>
														<tr height='30'>
															<td colspan='2' align='center' width='100%'>
																<textarea title="input" name='description' id='description' style='display:none;'></textarea>
															</td>
														</tr>
														<tr style='display:none' id="bn">
															<td></td>
															<td class="board_desc"><!-- 첨부 파일 --></td>
														</tr>
														<tr height='30' class='board'>
															<td class="board_bgcolor"><span style="color:#000000;font-size:12px;">비밀글</span></td>
															<td class="board_desc"><input title="input" type='checkbox' name='secret' value='비밀글'  >비밀글</td>
														</tr>
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
   																<a href='/main/board/list.jsp?category=<%=category%>'>
   																<img src='/images/board/list.gif' vspace='7' border='0'></a><!-- 목록보기버튼 -->
   															</td>
   															<td class='bbsnewf5' height='34' align='center'>
   																<input type='image' id="submitbtn" src='/images/board/confirm.gif' vspace='7' border='0'><!-- 확인버튼 -->
														      	<a href="javascript:document.com_board.reset();"><img src='/images/board/cancel.gif' vspace='7' border='0'></a><!-- 취소버튼 -->
														    </td>
														    <td width='62'></td>
														</tr>
													</table>
												</td>
											</tr>
										</form>
    									</table>
										<!-- 게시판 끝 -->
										
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr height="150"><td></td></tr>
				</table>

			 </td>
		</tr>
	</table>

	<!--bottom-->
	<jsp:include page="/main/bottom.jsp" />
	<!--//bottom-->
	
</BODY>
</HTML>
<script language="javascript" type="text/javascript" src="/js/urban.lib.js?date=1364782903"></script>
