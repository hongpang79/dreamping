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
    }else if("notice".equals(request.getParameter("category"))){
    	categoryName = "공지사항";
    }else if("qna".equals(request.getParameter("category"))){
    	categoryName = "Q & A";
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
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<HEAD>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="format-detection" content="telephone=no">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0, user-scalable=no,target-densitydpi=medium-dpi">
	<meta http-equiv="Cache-Control" content="no-cache">  
	<meta http-equiv="Expires" content="0">  
	<meta http-equiv="Pragma" content="no-cache">
	<TITLE>Urban Slow City </TITLE>
	<link rel="stylesheet" type="text/css" media="all" href="/css/board/common.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/css/board/layout.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/css/board/content.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/css/board/owl.carousel.css" />
	<link rel='stylesheet' type='text/css' href='/css/company.css'>
	<link href='http://fonts.googleapis.com/css?family=Play:400,700' rel='stylesheet' type='text/css' />
	<script type="text/javascript" src="/js/jquery-1.10.1.min.js"></script>
<!--[if lt IE 9]>
	<script type="text/javascript" src="/js/respond.min.js"></script>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
	
	<script language='javascript' src='/js/common.js'></script>
	<script type="text/javascript" src="/js/owl.carousel.js"></script>	
	<script type="text/javascript" src="/js/jquery.ui.core.js"></script>
</HEAD>
<body leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0">
	<!--menu-->
	<jsp:include page="/main/menu.jsp" />
	<!--//menu-->
	
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
					
		<!-- customerCover -->
		<div class="communityCover">
			<ul class="menu_list">
				<li><a href="/main/board/gallerylist.jsp?category=photo">포토앨범</a></li>
				<li <%if("notice".equals(category)){ %>class="on"<%} %>><a href="/main/board/list.jsp?category=notice">공지사항</a></li>
				<li <%if("qna".equals(category)){ %>class="on"<%} %>><a href="/main/board/list.jsp?category=qna">Q & A</a></li>
			</ul>
		</div>

		<div  class="board_list">
<%
if(category.equals("notice")){
%>
			<table class="mgb30">
				<caption>공지사항</caption>
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
						<td class="tleft"><a href="/main/board/view.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&category=<%=category%>" class="fc_01"><%=article.getSubject()%></a></td>
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
}else if(category.equals("qna")){
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
							 <img src="http://djscooter.cdn3.cafe24.com/images/content/icon_question.png" alt="Q"/>&nbsp;
<%
			if(article.getDescription()!=null){
%>					 
					 		<img src="http://djscooter.cdn3.cafe24.com/images/content/icon_answer.png" alt="A" class="mgl03" />
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
	<div class="paging mgb10" style="border:solid 1px #e3e2da;">
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
			<span class="prevEnd"><a href="/main/board/list.jsp?pageNum=1&category=<%=category%>"><img src="http://djscooter.cdn3.cafe24.com/images/btn/prevEnd.gif" alt="맨처음" /></a></span>
<%	    
	    if (startPage > 10) {    
%>
			<span class="prev"><a href="/main/board/list.jsp?pageNum=<%= startPage - 10 %>&category=<%=category%>"><img src="http://djscooter.cdn3.cafe24.com/images/btn/prev.gif" alt="이전10개" /></a></span>
<%
	    }else{ 
%>
			<span class="prev"><img src="http://djscooter.cdn3.cafe24.com/images/btn/prev.gif" alt="이전10개" /></span>
<%
	    }
%>
		</p>
<%
		for (int i = startPage ; i <= endPage ; i++) {
%>
			<a href="/main/board/list.jsp?pageNum=<%= i %>&category=<%=category%>">
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
			<span class="next"><a href="/main/board/list.jsp?pageNum=<%= startPage + 10 %>&category=<%=category%>"><img src="http://djscooter.cdn3.cafe24.com/images/btn/next.gif" alt="다음10개" /></a></span>
<%
		}else{
%>
			<span class="next"><img src="http://djscooter.cdn3.cafe24.com/images/btn/next.gif" alt="다음10개" /></span>
<%			
		}
%>
			<span class="nextEnd"><a href="/main/board/list.jsp?pageNum=<%= endPage %>&category=<%=category%>"><img src="http://djscooter.cdn3.cafe24.com/images/btn/nextEnd.gif" alt="맨마지막" /></a></span>
<%
	}
%>
		</p>																	
	</div>
<%
if(category.equals("qna")){
%>	
	<div class="text-r"><span class="btn_pack gray"><a href="/main/board/writeForm.jsp?category=<%=category%>">글쓰기</a></span></div>
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
		<a href="javascript:LayerClose();" class="btn_close"><img src="http://djscooter.cdn3.cafe24.com/images/btn/pop_close.png" alt="닫기" /></a>
		</form>
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
	document.frm_passwd.action='/board.do?action=board&step=passwordChk&category=<%=category%>&pageNum=<%=pageNum%>';
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

	<!-- BOTTOM -->
	<!-- #footer -->
	<jsp:include page="/main/bottom.jsp" />
	<!-- // #footer -->

	<!-- BOTTOM -->
</body>
</html>
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












