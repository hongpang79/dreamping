<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	request.setCharacterEncoding("UTF-8");
	String action = request.getParameter("action");

	int pageSize = 10;  // 한 페이지에 나타낼 글 수
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    Timestamp today = new Timestamp(System.currentTimeMillis());
    String searchDay = sdf.format(today);

    
    String category=request.getParameter("category");
    
    String categoryName = "";
    String imgpath = "";
    if (category == null){
    	category = "notice";
    	categoryName = "공지사항";
    	imgpath = "/board/images/notice.png";
    }else if("notice".equals(request.getParameter("category"))){
    	categoryName = "공지사항";
    	imgpath = "/board/images/notice.png";
    }else if("qna".equals(request.getParameter("category"))){
    	categoryName = "Q & A";
    	imgpath = "/board/images/qna.png";
    }else if("group".equals(request.getParameter("category"))){
    	categoryName = "제휴/단체문의";
    	imgpath = "/board/images/group.png";
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
<jsp:include page="/header.jsp" />
<link rel="stylesheet" type="text/css" media="all" href="/board/css/common.css" />
<link rel="stylesheet" type="text/css" media="all" href="/board/css/layout.css" />
<link rel="stylesheet" type="text/css" media="all" href="/board/css/content.css?ver=1" />
<!-- <link rel="stylesheet" type="text/css" media="all" href="/css/jquery.ui.datepicker.css" /> -->
<link rel="stylesheet" type="text/css" media="all" href="/css/owl.carousel.css" />
<link href='http://fonts.googleapis.com/css?family=Play:400,700' rel='stylesheet' type='text/css' />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<!--[if lt IE 9]>
	<script type="text/javascript" src="/js/respond.min.js"></script>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<!-- <script type="text/javascript" src="/js/common.js"></script> -->	
<script type="text/javascript" src="/js/owl.carousel.js"></script>	
<!-- <script type="text/javascript" src="/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.ui.datepicker.js"></script>	
<script type="text/javascript" src="/js/lib.js"></script> -->
</head>
<body>
<!-- container -->
<div id="containerWrap">
	<!-- contCover -->
	<div id="contCover">
	<!-- BODY -->
	<!-- #container -->
<div id="container">	
	<br><br><h2></h2>
	<h2><img src="<%=imgpath %>" alt="" /></h2>
	<!-- customerCover -->
	<div class="communityCover">
		<ul class="menu_list">
			<li <%if(category.equals("notice")){out.print("class='on'");} %>><a href="/board/list.jsp?action=board&category=notice">공지사항</a></li>
			<li <%if(category.equals("qna")){out.print("class='on'");} %>><a href="/board/list.jsp?action=board&category=qna">Q & A</a></li>
			<li <%if(category.equals("event")){out.print("class='on'");} %>><a href="/board/gallerylist.jsp?action=board&category=event">이벤트</a></li>
			<li <%if(category.equals("photo")){out.print("class='on'");} %>><a href="/board/gallerylist.jsp?action=board&category=photo">갤러리</a></li>
			<li <%if(category.equals("group")){out.print("class='on'");} %>><a href="/board/list.jsp?action=board&category=group">제휴/단체</a></li>	
		</ul>
</div>
<div  class="board_list">
<%
if(category.equals("notice")){
%>
	<table summary="" class="mgb30">
		<caption>자유 게시판</caption>
		<colgroup>			
			<col width="70px;" class="p_tl" />
			<col width="*" />							
			<col width="100px" />
			<col width="90px" class="p_tl" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="p_tc">번호</th>
				<th scope="col">제목</th>								
				<th scope="col">등록일</th>
				<th scope="col" class="p_tc">조회수</th>
			</tr>
		</thead>
		<tbody>
<%
	if (count == 0) {  // 등록된 글이 없는 경우
%>		
			<tr align='center' height='28'>
				<td class="bbsno" colspan="4">등록된 내용이 없습니다.</td>
			</tr>	
<%
	}else{     // 등록된 글이 있는 경우
		for(int i=0; i<articleList.size(); i++) {
			BoardVO article = (BoardVO)articleList.get(i);
%>
			<tr>
				<td class="letter_zero p_tc"><%=number--%></td>
				<td class="tleft"><a href="/board/view.jsp?action=<%=action %>&num=<%=article.getNum()%>&pageNum=<%=currentPage%>&category=<%=category%>" class="fc_01"><%=article.getSubject()%></a></td>
				<td class="letter_zero"><%= sdf.format(article.getRegDate())%></td>				
				<td class="letter_zero p_tc"><%=article.getReadCount()%></td>
			</tr>
<%
		}
	}
%>		
		</tbody>
	</table>	
<%
}else if(category.equals("qna") || category.equals("group")){
%>
	<table summary="" class="mgb30">
		<caption>자유 게시판</caption>
		<colgroup>			
			<col width="70px;" class="p_tl" />
			<col width="*" />							
			<col width="100px" class="m_layout_tl" />
			<col width="100px" class="m_layout_tl" />
			<col width="85px" class="p_tl" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="p_tc">번호</th>
				<th scope="col">제목</th>								
				<th scope="col" class="m_layout_tc">작성자</th>
				<th scope="col" class="m_layout_tc">등록일</th>
				<th scope="col" class="p_tc">조회수</th>
			</tr>
		</thead>
		<tbody>
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
%>	
			<tr>				 
				<td class="fs_14 fc_01 p_tc"><%=number--%></td>
				<td class="tleft qna_titlefs_14 fc_01">
					 <img src="/board/images/icon_question.png" alt="Q"/>&nbsp;
<%
			if(article.getReDescription()!=null){
%>					 
					 <img src="/board/images/icon_answer.png" alt="A" class="mgl03" />
<%
				}
%>					 
					 <a href="#hide" onclick="$('#qna_pwd').show();$('#b_passwd').focus();$('#num').val('<%=article.getNum()%>')"><%=article.getSubject()%></a>
					 <p class="writer m_b"><%=article.getWriter()%><span class="letter_zero"><%= sdf.format(article.getRegDate())%></span></p>
				</td>
				<td class="fs_14 fc_01 m_layout_tc"><%=article.getWriter()%></td>
				<td class="letter_zero m_layout_tc"><%= sdf.format(article.getRegDate())%></td>				
				<td class="letter_zero p_tc"><%=article.getReadCount()%></td>
			</tr>	
<%
		}
	}
%>
		</tbody>
	</table>
<%
}
%>	
	<div class="paging mgb10">
		<p class="prevCover">
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
%>
			<span class="prevEnd"><a href="/board/list.jsp?action=<%=action %>&pageNum=1&category=<%=category%>"><img src="/board/images/btn/prevEnd.gif" alt="맨처음" /></a></span>
<%	    
	    if (startPage > 10) {    
%>
			<span class="prev"><a href="/board/list.jsp?action=<%=action %>&pageNum=<%= startPage - 10 %>&category=<%=category%>"><img src="/board/images/btn/prev.gif" alt="이전10개" /></a></span>
<%
	    }else{ 
%>
			<span class="prev"><img src="/board/images/btn/prev.gif" alt="이전10개" /></span>
<%
	    }
%>
		</p>
<%
		for (int i = startPage ; i <= endPage ; i++) {
%>
			<a href="/board/list.jsp?action=<%=action %>&pageNum=<%= i %>&category=<%=category%>">
<%
			if( i == currentPage){
%>
				<strong class="border first"><%= i %></strong>
<%
			}else{
%>				
				<%= i %>
<%
			}
%>
		</a>
		
<%
		}
%>
		<p class="nextCover">
<%
		if (endPage < pageCount) {  
%>
			<span class="next"><a href="/board/list.jsp?action=<%=action %>&pageNum=<%= startPage + 10 %>&category=<%=category%>"><img src="/board/images/btn/next.gif" alt="다음10개" /></a></span>
<%
		}else{
%>
			<span class="next"><img src="/board/images/btn/next.gif" alt="다음10개" /></span>
<%			
		}
%>
			<span class="nextEnd"><a href="/board/list.jsp?action=<%=action %>&pageNum=<%= endPage %>&category=<%=category%>"><img src="/board/images/btn/nextEnd.gif" alt="맨마지막" /></a></span>
<%
	}
%>
		</p>																	
	</div>
<%
if(category.equals("qna") || category.equals("group")){
%>	
	<div class="text-r"><span class="btn_pack gray"><a href="/board/writeForm.jsp?action=<%=action %>&category=<%=category%>">글쓰기</a></span></div>
<%
}
%>
	<!-- pw_pop -->
	<div class="pw_pop" id="qna_pwd" style="display:none;">
		<form name="frm_passwd" method="post">
		<input type="hidden" name="num" id="num" />
		<p class="title">비밀번호 확인</p>
		<p class="info">이 게시글의 비밀번호를 입력해주세요</p>
		<p class="input_pw">
		<input type="password" name="b_passwd" id="b_passwd" class="intxt01" />
		<a href="#pass" onclick="passwdOk();" title="확인" class="btn_com">확인</a>
		</p>
		<a href="javascript:LayerClose();" class="btn_close"><img src="/board/images/btn/pop_close.png" alt="닫기" /></a>
		</form>
	</div>
</div>								

<script language="javascript">
//<![CDATA[ 
function searchForm(){
	var frm = document.frm_search;
	if ( !frm.query.value ) {
		alert('검색어를 입력하세요');
		frm.query.focus();
		return false;
	}	
	
	frm.submit();
}
function passwdOk(){
	if ( !$('#b_passwd').val() )
	{
		alert('비밀번호를 입력하세요.');
		$('#b_passwd').focus();
		return false;
	}
	document.frm_passwd.action='/Board.do?action=board&step=passwordChk&category=<%=category%>&pageNum=<%=pageNum%>';
	document.frm_passwd.submit();
}
//Layer 숨김
function LayerClose(){
	$('#qna_pwd').hide();
}
//]]>
</script>
	</div>
	<!-- // customerCover -->

</div>	<!-- BODY -->
	</div>
	<!-- BOTTOM -->
	<!-- #footer -->
	<jsp:include page="/footer.jsp" />
	<!-- // #footer -->

	<!-- BOTTOM -->
<script type="text/javascript">
$(function(){
	setTimeout( resize , 500 );
	function resize(){
		if($(window).width() < 800)
		{
			$(".newwin").width( $(window).width() - 20 ).css({'left' : '10px' , 'top' : '10px'});			
		}	
	}
	$(window).resize(function(){		
		resize();		
	});
});
</script>
