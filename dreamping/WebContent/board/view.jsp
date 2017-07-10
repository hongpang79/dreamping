<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	request.setCharacterEncoding("UTF-8");
	String action=request.getParameter("action");
	String category=request.getParameter("category");
	String categoryName = "";
	  String imgpath = "";
	  if (category == null){
	  	category = "notice";
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
	  }else if("photo".equals(request.getParameter("category"))){
	  	categoryName = "갤러리";
	  	imgpath = "/board/images/gallery.png";
	  }else if("event".equals(request.getParameter("category"))){
	  	categoryName = "이벤트";
	  	imgpath = "/board/images/event.png";
	  }
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String flag = request.getParameter("flag");
	
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
<jsp:include page="/header.jsp" />
<meta name="Title" content="<%=article.getSubject()%>" />
<link rel="stylesheet" type="text/css" media="all" href="/board/css/common.css" />
<link rel="stylesheet" type="text/css" media="all" href="/board/css/layout.css" />
<link rel="stylesheet" type="text/css" media="all" href="/board/css/content.css" />
<link rel="stylesheet" type="text/css" media="all" href="/css/owl.carousel.css" />
<link href='http://fonts.googleapis.com/css?family=Play:400,700' rel='stylesheet' type='text/css' />
<!--[if lt IE 9]>
	<script type="text/javascript" src="/js/respond.min.js"></script>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<!-- <script type="text/javascript" src="/js/common.js"></script> -->	
<!--<script type="text/javascript" src="/js/select.js"></script>-->
<script type="text/javascript" src="/js/owl.carousel.js"></script>	
</head>
<body>
<!-- container -->
<div id="containerWrap">
	<!-- TOP -->
	<!-- TOP -->

	<!-- contCover -->
	<div id="contCover">

	<!-- BODY -->
	<!-- #container -->
<div id="container">	
<br><br><h2></h2>	
	<h2><img src="<%=imgpath %>" alt="" /></h2>
	<div class="communityCover">
		<ul class="menu_list">
			<li <%if(category.equals("notice")){out.print("class='on'");} %>><a href="/board/list.jsp?action=board&category=notice">공지사항</a></li>
			<li <%if(category.equals("qna")){out.print("class='on'");} %>><a href="/board/list.jsp?action=board&category=qna">Q & A</a></li>
			<li <%if(category.equals("event")){out.print("class='on'");} %>><a href="/board/gallerylist.jsp?action=board&category=event">이벤트</a></li>
			<li <%if(category.equals("photo")){out.print("class='on'");} %>><a href="/board/gallerylist.jsp?action=board&category=photo">갤러리</a></li>
			<li <%if(category.equals("group")){out.print("class='on'");} %>><a href="/board/list.jsp?action=board&category=group">제휴/단체문의</a></li>	
		</ul>
	</div>

		<div id="printWrap">
<!-- noticeView -->
<div class="noticeView mgb20">
	<div class="title">
		<p>
<%
	if(category.equals("qna")||category.equals("group")){
%>		
		<img src="/board/images/icon_question.png" alt="Q" class="mgr10" />
<%
	}
%>
		<%=article.getSubject()%></p>						
		<ul>
			<li>
				<!-- <span class="print"><a href="#print" onclick="printAction()">인쇄</a></span> 
				<span class="twitter"><a href="#twitter" onclick="send_sns(1, 'http://thedreamping.com/board/view.jsp?action=<%=action %>&num=<%=article.getNum()%>&pageNum=<%=pageNum%>&category=<%=category%>' , '<%=article.getSubject()%>');">twitter</a></span>
				<span class="face_b"><a href="#face_b" onclick="send_sns(2, 'http://thedreamping.com/board/view.jsp?action=<%=action %>&num=<%=article.getNum()%>&pageNum=<%=pageNum%>&category=<%=category%>' , '<%=article.getSubject()%>');">facebook</a></span>
				-->
			</li>
			<li class="fc_01"><%=article.getWriter()%></li>
			<li class="letter_zero fc_01"><%= sdf.format(article.getRegDate())%></li>
			<li class="letter_zero fc_01"><%=article.getReadCount()%></li>
		</ul>
	</div>
	<!-- viewCont -->
	<div class="contCover">
		<div class="cont text-l">							
			<%=article.getDescription()%>				
	</div>
	<!-- // viewCont -->
<%
	if(!category.equals("notice") && article.getReDescription() != null){
%>
	<!-- viewCont -->
	<div class="contCover">
		<div class="guide_list">
			<div class="cont text-l"><img src="/board/images/icon_answer.png" alt="A" class="mgl03" /><br><br>							
				<%=article.getReDescription()%>
			</div>
		</div>					
	</div>	
<%		
	}
%>										
</div>
<!-- // noticeView -->	
</div>

<form name="deleteFrm" method="post" onsubmit="deleteData(document.deleteFrm); return false;">
<input type="hidden" name="num" value="<%=num %>" />	
<!-- button -->
<p class="text-c mgt20 mgb60">
<%
	if(category.equals("qna")&&(article.getReDescription() == null)){
%>	
	<span class="btn_pack white mgr05"><a href="#hide" onclick="$('#qna_pwd').show();$('#b_passwd').focus();">삭제</a></span>	<span class="btn_pack white mgr05"><a href="javascript:location.href='/board/modifyForm.jsp?action=<%=action %>&category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>&com_board_search_code=<%=comBoardSearchCode%>&com_board_search_value=<%=comBoardSearchValue%>&num=<%=num%>'">수정</a></span>	<span class="btn_pack white"><a href="/board/list.jsp?action=<%=action %>&category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>">목록</a></span>
<%
	}else if(category.equals("group")&&(article.getReDescription() == null)){
%>	
	<span class="btn_pack white mgr05"><a href="#hide" onclick="$('#qna_pwd').show();$('#b_passwd').focus();">삭제</a></span>	<span class="btn_pack white mgr05"><a href="javascript:location.href='/board/modifyForm.jsp?action=<%=action %>&category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>&com_board_search_code=<%=comBoardSearchCode%>&com_board_search_value=<%=comBoardSearchValue%>&num=<%=num%>'">수정</a></span>	<span class="btn_pack white"><a href="/board/list.jsp?action=<%=action %>&category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>">목록</a></span>
<%
	}else if(category.equals("notice")||category.equals("qna")||category.equals("group")){
%>
	<span class="btn_pack white"><a href="/board/list.jsp?action=<%=action %>&category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>">목록</a></span>
<%
	}else{
%>
	<span class="btn_pack white"><a href="/board/gallerylist.jsp?action=<%=action %>&category=<%=category%>&pageNum=<%=pageNum%>&flag=<%=flag%>">목록</a></span>
<%		
	}
%>

</p>
<!-- // button -->				
</form>
<!-- pw_pop -->
			<div class="pw_pop" id="qna_pwd" style="display:none;">
				<form name="frm_passwd" method="post">
					<input type="hidden" name="action" value="<%=action%>">
					<input type="hidden" name="category" value="<%=category%>">
					<input type="hidden" name="pageNum" value="<%=pageNum%>">
					<input type="hidden" name="flag" value="<%=flag%>">
					<input type="hidden" name="com_board_search_code" value="<%=comBoardSearchCode%>">
					<input type="hidden" name="com_board_search_value" value="<%=comBoardSearchValue%>">
					<input type="hidden" name="num" value="<%=num%>">
					<p class="title">비밀번호 확인</p>
					<p class="info">이 게시글의 비밀번호를 입력해주세요</p>
					<p class="input_pw">
					<input type="password" name=password id="b_passwd" class="intxt01" />
					<a href="#pass" onclick="passwdOk();" title="확인" class="btn_com">확인</a>
					</p>
					<a href="javascript:LayerClose();" class="btn_close"><img src="/board/images/btn/pop_close.png" alt="닫기" /></a>
				</form>
			</div>
		</div>		
<!-- commentWrap -->


<iframe id="hiddenFrame" name="hiddenFrame" width="0" height="0" frameborder="0"></iframe>
<script type="text/javascript">
/******* 원문 삭제 *******/
function passwdOk(){
	if ( !$('#b_passwd').val() )
	{
		alert('비밀번호를 입력하세요.');
		$('#b_passwd').focus();
		return false;
	}
	document.frm_passwd.action='/board/deleteProcess.jsp';
	document.frm_passwd.submit();
}
//Layer 숨김
function LayerClose(){
	$('#qna_pwd').hide();
}
</script>
	</div>
	<!-- // customerCover -->

	</div>	<!-- BODY -->

</div>
	<!-- #footer -->
	<jsp:include page="/footer.jsp" />
	<!-- // #footer -->
</body>
</html>
<%
 }catch(Exception e){}
 %>
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