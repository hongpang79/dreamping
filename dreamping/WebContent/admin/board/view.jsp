<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String flag = request.getParameter("flag");
	String category = request.getParameter("category");
	String comBoardSearchCode = request.getParameter("com_board_search_code")==null?"":new String(request.getParameter("com_board_search_code").getBytes("ISO-8859-1"),"UTF-8");
	String comBoardSearchValue = request.getParameter("com_board_search_value")==null?"":new String(request.getParameter("com_board_search_value").getBytes("ISO-8859-1"),"UTF-8");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String categoryName = "";
	if (category == null){
		category = "notice";
	  	categoryName = "공지사항";
	}else if("notice".equals(request.getParameter("category"))){
		categoryName = "공지사항";
	}else if("qna".equals(request.getParameter("category"))){
		categoryName = "문의하기";
	}else if("photo".equals(request.getParameter("photo"))){
		categoryName = "포토앨범";
	}
	  
	try{
		BoardDAO dbPro = BoardDAO.getInstance();
		BoardVO article = dbPro.getArticle(num);
 
		int ref=article.getRef();
		int reStep=article.getReStep();
		int reLevel=article.getReLevel();
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
	<link rel='stylesheet' type='text/css' href='/css/company.css'>
	<script language='javascript' src='/js/common.js'></script>
	<!-- 게시판 시작 -->
	<link rel="StyleSheet" href="/css/board_6.css" type="text/css">
	<script language="javascript" src="/js/board.js?com_board_id=6&template=bizdemo18406"></script>
	<script language="javascript" type="text/javascript" src="/js/board_util.js"></script>
	
	<table border="0" cellspacing="0" cellpadding="0" width="800" bgcolor="#ffffff" background="">
		<tr>
			<td>
				<table border="0" cellspacing="0" cellpadding="0" width='100%'>
				</table>
				<table border='1' cellpadding='0' cellspacing='0' width='100%' style='border-collapse:collapse' bordercolor='#e5e5e5' class="board">
					<!-- 내용 -->
					<style type="text/css">
					p{margin:0}
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
					    			<a href="/admin/board/list.jsp?category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>&com_board_search_code=<%=comBoardSearchCode%>&com_board_search_value=<%=comBoardSearchValue%>">
					    			<img src="/images/board/list.gif" border='0' align='absmiddle' alt=''></a>
								</td>
							</tr>
						</table>
						<!-- 이전 다움  -->
	     				<!-- //목록 - 버튼 -->
	     			</td>
	     			<td align='right' width='50%'>
				       <!-- 스팸신고 -->
				       <a href='javascript:alert("권한이 없습니다.")' style='display:none'><img alt='' src='/images/board/spam.gif' border='0' /></a>
				       <!-- 추천하기 -->
				       <a href='javascript:alert("권한이 없습니다.")' style='display:none'><img alt='' src='/images/board/recommend.gif' border='0' /></a>
				       <!-- 수정하기 -->
				       <a href="javascript:location.href='/admin/board/modifyForm.jsp?category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>&com_board_search_code=<%=comBoardSearchCode%>&com_board_search_value=<%=comBoardSearchValue%>&num=<%=num%>'";><img alt='' src='/images/board/modify.gif' border='0' /></a>
				       <!-- 삭제하기 -->
				       <a href="javascript: if(!confirm('글을 삭제 하시겠습니까?')){retrun;} location.href='/admin/board/deleteProcess.jsp?category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>&com_board_search_code=<%=comBoardSearchCode%>&com_board_search_value=<%=comBoardSearchValue%>&num=<%=num%>&password=slowcity'";><img alt='' src='/images/board/delete.gif' border='0' /></a>
				       <!-- 답글쓰기 -->
				       <a href="javascript:location.href='/admin/board/writeForm.jsp?category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>&com_board_search_code=<%=comBoardSearchCode%>&com_board_search_value=<%=comBoardSearchValue%>&num=<%=num%>'"; <% if(!category.equals("qna")) out.print("style='display:none'"); %>><img alt='' src='/images/board/reply.gif' border='0' /></a>
	     			</td>
	    		</tr>
	   		</table>
	  	</td>
	</tr>
</table>
<!-- 목록 - 리스트 -->
<!-- //목록 - 리스트  -->

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
<%
 }catch(Exception e){}
 %>
