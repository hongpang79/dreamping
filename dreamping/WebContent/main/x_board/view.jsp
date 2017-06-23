<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String flag = request.getParameter("flag");
	String category = request.getParameter("category");
	String comBoardSearchCode = request.getParameter("com_board_search_code")==null?"":new String(request.getParameter("com_board_search_code").getBytes("ISO-8859-1"),"UTF-8");
	String comBoardSearchValue = request.getParameter("com_board_search_value")==null?"":new String(request.getParameter("com_board_search_value").getBytes("ISO-8859-1"),"UTF-8");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	try{
		BoardDAO dbPro = BoardDAO.getInstance();
		BoardVO article = dbPro.getArticle(num);
 
		int ref=article.getRef();
		int reStep=article.getReStep();
		int reLevel=article.getReLevel();
%>
<HTML>
<HEAD>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<TITLE>Urban Slow City </TITLE>
	<link rel="stylesheet" type="text/css" media="all" href="/css/board/content.css" />
	<link rel='stylesheet' type='text/css' href='/css/company.css'>
	<script language='javascript' src='/js/common.js'></script>
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
										<tr>
											<td>
												<table border="0" cellspacing="0" cellpadding="0" width='100%'>
												</table>
												<table border='1' cellpadding='0' cellspacing='0' width='100%' style='border-collapse:collapse' bordercolor='#e5e5e5' class="board">
													<!-- 내용 -->
													<style type="text/css">p{margin:0}</style>
													<style type="text/css">
													/*
													   .board_bgcolor 테이블 제목 컬럼 스타일 지정
													   .board_desc    테이블 제목 옆 내용 컬럼 스타일 지정
													   $com_board.table_size :: 관리자가 지정한 전체 테이블 사이즈
													   .board_description 콘텐츠 내용 스타일을 지정
													*/
													p{
													    margin:0;
													    padding:0;
													}
													.board_bgcolor
													{
													  /*width:107px;*/
													  width:20%;
													  text-align:center;
													}
													.board_desc
													{
														padding:3 0 3 10;
														line-height:150%;
														/*width:1093px;*/
													    width:80%;
														text-align:left;
														padding-left:5px;
													}
													.board_description
													{
														    overflow:hidden;
													        word-break:break-all;
													}
													#post_area{
														width:100%;
														padding:5px;
													    word-spacing:0pt;
													    word-break:break-all;
													}
													</style>
													<tr height="30">
														<td class="board_bgcolor">
															<font style="color:#000000;font-size:12px;">제목</font></td>
														<td class="board_desc"><%=article.getSubject()%></td>
													</tr>
													<tr height="30">
														<td class="board_bgcolor"><font style="color:#000000;font-size:12px;">작성자</font></td>
														<td class="board_desc"><%=article.getWriter()%></td>
													</tr>
													<tr height="30">
														<td class="board_bgcolor"><font style="color:#000000;font-size:12px;">작성일자</font></td>
														<td class="board_desc"><%= sdf.format(article.getRegDate())%></td>
													</tr>
													<tr height="30">
														<td class="board_bgcolor"><font style="color:#000000;font-size:12px;">조회수</font></td>
														<td class="board_desc"><%=article.getReadCount()%></td>
													</tr>
													<!-- 글 내용 -->
													<tr height="30">
														<td colspan="2" class="board_description" width="100%" height="100px">
															<div id="post_area">
																<%=article.getDescription()%>
															</div>
														</td>
													</tr>
													<!-- //내용 -->
									   			</table>
									   			<table border='0' cellpadding='0' cellspacing='0' width='100%'>
									    			<tr>
									    				<td height='1' bgcolor='#E5E5E5'></td>
									    			</tr>
									   			</table>
									   			<table border='0' cellpadding='0' cellspacing='0' width='100%'>
									    		<tr>
									    			<td height='10'></td>
									    		</tr>
									   		</table>
									
										   <!-- 게시물 평가 -->
										   
										   <!--// 게시물 평가 -->
										
										   <!-- 댓글 쓰기 -->
										   
										   <!-- //댓글 쓰기 -->
										
										   <!-- 댓글 목록 -->
										   
										   <!-- //댓글 목록 -->
									
									   		<table border='0' cellpadding='0' cellspacing='0' width='100%'>
									    		<tr>
									    			<td><br></td>
									    		</tr>
									   		</table>
									   		<table border='0' cellpadding='0' cellspacing='0' width='100%'>
									    		<tr>
									    			<td height='1' bgcolor='#E5E5E5'></td>
									    		</tr>
									   		</table>
									
									   		<table border='0' cellpadding='0' cellspacing='0' align='center' width='100%'>
									    		<tr>
									     			<td class='bbsnewf5' height='34' align='center' width='50%'>
									     				<!-- 목록 - 버튼 -->
									      				<!-- 이전 다음  -->
														<table border='0' cellpadding='0' cellspacing='0' align='center' width='100%'>
															<tr>
																<td class='bbsnewf5' height='34' align='left' width='50%' style="border:0px">
																<%if("photo".equals(category)){ %>
																	<a href="/main/board/gallerylist.jsp?category=<%=category%>&pageNum=<%=pageNum%>">
																<%
																}else{
																%>
																	<a href="/main/board/list.jsp?category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>&com_board_search_code=<%=comBoardSearchCode%>&com_board_search_value=<%=comBoardSearchValue%>">
																<%} %>
													    			<img src="/images/board/list.gif" border='0' align='absmiddle' alt=''></a>
																</td>
															</tr>
														</table>
														<!-- 이전 다움  -->
									     				<!-- //목록 - 버튼 -->
									     			</td>
									     			<td align='right' width='50%'>
												       <!-- 스팸신고 -->
												       <a href='javascript:alert("답글쓰기 권한이 없습니다.")' style='display:none'><img alt='' src='/images/board/spam.gif' border='0' /></a>
												       <!-- 추천하기 -->
												       <a href='javascript:alert("답글쓰기 권한이 없습니다.")' style='display:none'><img alt='' src='/images/board/recommend.gif' border='0' /></a>
<%if("qna".equals(category)){ %>
												       <!-- 수정하기 -->
												       <a href="javascript:location.href='/main/board/modifyForm.jsp?category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>&com_board_search_code=<%=comBoardSearchCode%>&com_board_search_value=<%=comBoardSearchValue%>&num=<%=num%>'";><img alt='' src='/images/board/modify.gif' border='0' /></a>
												       <!-- 삭제하기 -->
												       <a href="javascript:openWindow('/main/board/deleteConfirm.jsp?category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>&com_board_search_code=<%=comBoardSearchCode%>&com_board_search_value=<%=comBoardSearchValue%>&num=<%=num%>','350','150')"><img alt='' src='/images/board/delete.gif' border='0' /></a>
<%} %>
												       <!-- 답글쓰기 -->
												       <a href='javascript:alert("답글쓰기 권한이 없습니다.")' style='display:none'><img alt='' src='/images/board/reply.gif' border='0' /></a>
									     			</td>
									    		</tr>
									   		</table>
									  	</td>
									</tr>
								</table>
								<!-- 목록 - 리스트 -->
								<!-- //목록 - 리스트  -->
								
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
<script language="javascript" src="/js/urban.board.js"></script>
<%
 }catch(Exception e){}
 %>