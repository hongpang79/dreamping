<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	int pageSize = 10;  // 한 페이지에 나타낼 글 수
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    Timestamp today = new Timestamp(System.currentTimeMillis());
    String searchDay = sdf.format(today);

    request.setCharacterEncoding("UTF-8");
    String category=request.getParameter("category");
    
    String categoryName = "";
    if (category == null){
    	category = "notice";
    	categoryName = "공지사항";
    }else if("notice".equals(category)){
    	categoryName = "공지사항";
    }else if("qna".equals(category)){
    	categoryName = "문의하기";
    }else if("photo".equals(category)){
    	categoryName = "포토앨범";
    }
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {//페이지 번호가 인수로 넘어오지 않으면 1을 기억
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;  //그 페이지의 시작행 지정
    // 2페이지의 경우
    // (2-1)*10 + 1 = 11
    int endRow = currentPage * pageSize; // 그 페이지의 끝행 지정
    // 2페이지의 경우
    //  2+10 = 20
    int count = 0;    // 전체 글 수
    int number=0;   // 그 페이지에서 시작행 번호
    
    List articleList = null;
    BoardDAO dbPro = BoardDAO.getInstance();
    
    String comBoardSearchCode = request.getParameter("com_board_search_code")==null?"":request.getParameter("com_board_search_code");
    String comBoardSearchCodeUtf8 = request.getParameter("com_board_search_code")==null?"":new String(request.getParameter("com_board_search_code").getBytes("ISO-8859-1"),"UTF-8");
    String comBoardSearchValue = request.getParameter("com_board_search_value")==null?"":request.getParameter("com_board_search_value");
    String comBoardSearchValueUtf8 = request.getParameter("com_board_search_value")==null?"":new String(request.getParameter("com_board_search_value").getBytes("ISO-8859-1"),"UTF-8");
  //System.out.println("list.jsp [comBoardSearchValue][request] " + request.getParameter("com_board_search_value"));
  //System.out.println("list.jsp [comBoardSearchValue][utf-8] " + comBoardSearchValueUtf8);

    String flag = request.getParameter("flag");
    if(flag == null){
    	flag="form";
    	comBoardSearchCode="subject";
    	comBoardSearchValue="";
    }
    //System.out.println("flag = " + flag + " ; gubun = "+gubun+" ; sstring = " +sstring);
    if(flag.equals("search")) {
    	count = dbPro.getArticleCount(category, comBoardSearchCode, comBoardSearchValue);	
    	if(count == 0){
    		comBoardSearchValue = comBoardSearchValueUtf8;
    		count = dbPro.getArticleCount(category, comBoardSearchCode, comBoardSearchValue);
    	}
	    if (count > 0) {
            articleList = dbPro.getArticles(startRow, endRow, category, comBoardSearchCode, comBoardSearchValue);
        }
    }else{
    	count = dbPro.getArticleCount(category);
    	if (count > 0) {
   	        articleList = dbPro.getArticles(startRow, endRow, category);
   	    }
    }

    number=count-(currentPage-1)*pageSize;//그 페이지에서 시작 행 번호
    // 전체 52개의 글인 경우 2페이지 시작 행 번호
    // 52 - (2-1)*10 = 42
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
	<table border="0" cellspacing="0" cellpadding="0" width="800" bgcolor="#ffffff" background="">
		<tr>
			<td>	
				<table border="0" cellspacing="0" cellpadding="0" width="100%">
				</table>
				<table border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse" width="100%" bordercolor="#E5E5E5" class="board">
					<colgroup>
						<col width="60" />
						<col />
						<col width="100" />
						<col width="80" />
						<col width="60" />
					</colgroup>
					<tr align="center" height="30" bgcolor="#F7F7F7">
						<td class="att_title"><font style='color:#000000;font-size:12px;'>번호</font></td>
						<td class="att_title"><font style='color:#000000;font-size:12px;'>제목</font></td>
						<td class="att_title"><font style='color:#000000;font-size:12px;'>작성자</font></td>
						<td class="att_title"><font style='color:#000000;font-size:12px;'>작성일자</font></td>
						<td class="att_title"><font style='color:#000000;font-size:12px;'>조회수</font></td>
					</tr>
<%
	if (count == 0) {  // 등록된 글이 없는 경우
%>
					<tr align='center' height='28'>
						<td class="bbsno" colspan="5">등록된 내용이 없습니다.</td>
					</tr>	 														
<%
	}else{     // 등록된 글이 있는 경우
		for(int i=0; i<articleList.size(); i++) {
    		BoardVO article = (BoardVO)articleList.get(i);
    		if(flag.equals("search")){
%>
					<tr align='center' height='28' onclick="location.href='/admin/board/view.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&category=<%=category%>&flag=search&com_board_search_code=<%=comBoardSearchCode %>&com_board_search_value=<%=comBoardSearchValue %>'; return false;" style='cursor:pointer;' style="cursor:pointer" >
<%   			
    		}else{
%>
					<tr align='center' height='28' onclick="location.href='/admin/board/view.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&category=<%=category%>'; return false;" style='cursor:pointer;' style="cursor:pointer" >
<%    			
    		}
%> 														
						<td class="bbsno"><%=number--%></td>
						<td class='bbsnewf5' align='left'>
<%
			int wid=0;  // 들여쓰기 설정(레벨에 따라)
%>
							<img src="/images/board/level.gif" width="<%=wid%>">
<%			
			if(article.getReLevel()>0){
				wid=5*(article.getReLevel());
%>				
							<img src="/images/board/reply_ic.gif"">
<%			
			}													
			
	    	if(flag.equals("search")) { 
%>  															
							<a href='/admin/board/view.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&category=<%=category%>&flag=search&com_board_search_code=<%=comBoardSearchCode %>&com_board_search_value=<%=comBoardSearchValue %>'>
<%          
			}else{ 
%>  															
							<a href="/admin/board/view.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&category=<%=category%>">
<%			
			}
%>												
							<%=article.getSubject()%></a></td>
						<td class="bbswriter"><%=article.getWriter()%></td>
						<td class="bbsetc_dateof_write"><%= sdf.format(article.getRegDate())%></td>
						<td class="bbsetc_view_count"><%=article.getReadCount()%></td>
					</tr>
<%		
		}
	}
%>																								
				</table>
				<table border='0' cellpadding='0' cellspacing='0' width='100%'>
				</table>
				<table border='0' cellpadding='0' cellspacing='0' width='100%'>
				    <tr><td height='1' bgcolor='#E5E5E5'></td></tr>
				</table>
				<!-- 페이징 -->
				<table border="0" cellpadding="0" cellspacing="0" align="center" width="100%">
					<tr>
						<td width='62'></td>
						<td height="34" align="center" class="paging">
<%
    if (count > 0) {  // 등록된 글이 있는 경우
	    int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
	    // 총페이지 수 계산
	    //  5 + 1 = 6(등록된 글이 52개인 경우)
	    // 5 + 0 = 5 (등록된 글이 50개인 경우)     
	    int startPage = (int)(currentPage/10)*10+1;
	    int pageBlock=10;
	    // 시작 페이지 번호
	    // (int)15/10 * 10 + 1= 11(15페이지의 경우)
	    int endPage = startPage + pageBlock-1;
	    //
	    if (endPage > pageCount) endPage = pageCount;
	
	    if(flag.equals("search")) {
	    	if (startPage > 10) {    %>
	        	<a href="/admin/board/list.jsp?pageNum=<%= startPage - 10 %>&category=<%=category%>&flag=search&com_board_search_code=<%=comBoardSearchCode %>&com_board_search_value=<%=comBoardSearchValue %>"><img src="/images/board/btn_prev.gif" alt="이전" /></a>
<%      	}
		    for (int i = startPage ; i <= endPage ; i++) {  %>
		        <a href="/admin/board/list.jsp?pageNum=<%= i %>&category=<%=category%>&flag=search&com_board_search_code=<%=comBoardSearchCode %>&com_board_search_value=<%=comBoardSearchValue %>">&nbsp;<%= i %></a>
<%
		    }
		    if (endPage < pageCount) {  %>
		    	<a href="/admin/board/list.jsp?pageNum=<%= startPage + 10 %>&category=<%=category%>&flag=search&com_board_search_code=<%=comBoardSearchCode %>&com_board_search_value=<%=comBoardSearchValue %>">&nbsp;<img src="/images/board/btn_next.gif" alt="다음" /></a>
<%
		    }
	    }else{
	        if (startPage > 10) {    %>
	            <a href="/admin/board/list.jsp?pageNum=<%= startPage - 10 %>&category=<%=category%>"><img src="/images/board/btn_prev.gif" alt="이전" /></a>
<%      	}
	        for (int i = startPage ; i <= endPage ; i++) {  %>
	            <a href="/admin/board/list.jsp?pageNum=<%= i %>&category=<%=category%>">&nbsp;<%= i %></a>
<%
	        }
	        if (endPage < pageCount) {  %>
	            <a href="/admin/board/list.jsp?pageNum=<%= startPage + 10 %>&category=<%=category%>">&nbsp;<img src="/images/board/btn_next.gif" alt="다음" /></a>
<%
	        }
	    }
    }
%>																
						</td>
						<td width='62' align='right' <% if(category.equals("qna")) out.print("style='display:none'"); %>>
						<!-- 글쓰기 -->		
							<a href='/admin/board/writeForm.jsp?category=<%=category%>' style=''><img alt='' src='/images/board/write.gif' border='0' /></a>
						<!-- //글쓰기 -->
						</td>
					</tr>
					<tr><td colspan='3' height='1' bgcolor="#E5E5E5"></td></tr>
				</table>
				<!-- //페이징 -->
				
				<!-- 검색 -->
				<div id="ext_search" style="text-align:left">
					<table id="search_table" border="0" cellspacing="0" cellpadding="2">
					<form name='com_board_search' method='post' action='/admin/board/list.jsp?category=<%=category%>&flag=search' onsubmit="return FormCheck.init('com_board_search')">
						<tr>
							<td class="est_cate_cell">
								<select title="select" name='com_board_search_code' class="cateform" align='absmiddle' onchange='sel_search();'>
									<option value='subject' <%if(comBoardSearchCode.equals("subject")){%> selected <%}%>>제목</option>
									<option value='description' <%if(comBoardSearchCode.equals("description")){%> selected <%}%>>내용</option>
									<option value='writer' <%if(comBoardSearchCode.equals("writer")){%> selected <%}%>>작성자</option>
								</select>
							</td>
							<td class="est_keyword_cell">
								<div id='search_display1' style='display:block;'>
									<input title="input" alt="" type='text' class="keywordform" align='absmiddle' name='com_board_search_value' chk="y" msg="검색어" kind="" value="<%=comBoardSearchValue%>"/>
								</div>
								<div id='search_display2' style='display:none;'>
									<input title="input" alt="" type='text' class="dateform" align='absmiddle' name='com_board_search_value1' value='<%=searchDay %>' />&nbsp;~&nbsp;
									<input title="input" alt="" type='text' class="dateform" align='absmiddle' name='com_board_search_value2' value='<%=searchDay %>' />
								</div>
							</td>
							<td class="est_btn_cell">
								<input title="input" alt="" type='image' src='/images/board/search.gif' border='0' align='absmiddle'>
							</td>
						</tr>
					</form>
					</table>
				</div>
				<!-- //검색 -->
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
