<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardVO"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String flag = request.getParameter("flag");
	String category = request.getParameter("category");
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
	String action = request.getParameter("action");
	System.out.println("action = " + action);
	String comBoardSearchCode = request.getParameter("com_board_search_code")==null?"":new String(request.getParameter("com_board_search_code").getBytes("ISO-8859-1"),"UTF-8");
	String comBoardSearchValue = request.getParameter("com_board_search_value")==null?"":new String(request.getParameter("com_board_search_value").getBytes("ISO-8859-1"),"UTF-8");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	try{
		BoardDAO dbPro = BoardDAO.getInstance();
		BoardVO article =  dbPro.getArticle(num);
		String thumbImgUrlOrg = article.getThumbImgUrl();
		//System.out.println(article.getThumbImgUrl());
		if(thumbImgUrlOrg==null){
			thumbImgUrlOrg = "";
		}
 %>
 <jsp:include page="/header.jsp" />
	<link rel="stylesheet" type="text/css" media="all" href="/board/css/common.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/board/css/layout.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/board/css/content.css" />
<link rel="stylesheet" type="text/css" media="all" href="/css/owl.carousel.css" />
<link href='http://fonts.googleapis.com/css?family=Play:400,700' rel='stylesheet' type='text/css' />
<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<!--[if lt IE 9]>
	<script type="text/javascript" src="/js/respond.min.js"></script>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script type="text/javascript" src="/js/owl.carousel.js"></script>	

	<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
	<script type="text/javascript" src="/js/HuskyEZCreator.js" charset="utf-8"></script>
	<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
	
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
		      
		});
		 
		 
		 
	</script>
</head>
<body>	
<!-- container -->
<div id="containerWrap">
	<!-- TOP -->
	<!-- #header -->
	<!-- // #header -->
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
	
	<form name='com_board' method='post' enctype="multipart/form-data" action='/board/modifyProcess.jsp' onSubmit='return com_board_writeformCheck()'>
		<input type="hidden" name="category" value="<%=category%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="flag" value="<%=flag%>">
		<input type="hidden" name="com_board_search_code" value="<%=comBoardSearchCode%>">
		<input type="hidden" name="com_board_search_value" value="<%=comBoardSearchValue%>">
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="readcount" value="<%=article.getReadCount()%>">
       	<input type="hidden" name="ref" value="<%=article.getRef()%>">
       	<input type="hidden" name="reStep" value="<%=article.getReStep()%>">
       	<input type="hidden" name="reLevel" value="<%=article.getReLevel()%>">
       	<input type="hidden" name="thumbImgUrlOrg" value="<%=thumbImgUrlOrg %>">
	 
	 	<!-- board_view -->
		<div class="board_view">
			<table cellpadding="0" cellspacing="0" border="0" summary="">
				<caption>등록/수정</caption>
				<colgroup>
					<col class="w_120" />
					<col width="*" />															
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">이름</th>
						<td><input type="text" name="writer" id="writer" class="intxt02 vt-m w-100" value="<%=article.getWriter()%>" /></td>
					</tr>
					<tr>
						<th scope="row">비밀번호</th>
						<td><input type="password" name="password" id="password" class="intxt02 vt-m w-100" value="" /></td>
					</tr>
					<tr>
						<th scope="row">제목</th>
						<td><input type="text" name="subject" id="subject" class="intxt02 vt-m w-500" value="<%=article.getSubject()%>" /></td>
					</tr>									
					<tr>
						<th scope="row">내용</th>
						<td class="padding"><textarea name="description" id="description" rows="10" cols="90" style='display:none;'><%=article.getDescription()%></textarea></td>
					</tr>
<%
	if(category.equals("notice")||category.equals("qna")||category.equals("group")){
	
	}else{
%>					
					<tr>
						<th scope="row">목록이미지</th>
						<td>
							<input type='file' name='thumbImgUrl' id='thumbImgUrl' class='infile01' />&nbsp;&nbsp;(가로 327px로 올려주세요.) &nbsp;&nbsp; 현재목록사진:<%=thumbImgUrlOrg%>
						</td>
					</tr>
<%
	}
%>							
				</tbody>
			</table>		
			<!-- button -->
			<p class="text-c mgt20">
				<span class="btn_pack white mgr05"><a href="javascript:_onSubmit(document.com_board)">수정</a></span>
				<span class="btn_pack white"><a href="javascript:location.href='/board/view.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>&action=<%=action %>&category=<%=category%>&flag=<%=flag %>&com_board_search_code=<%=comBoardSearchCode %>&com_board_search_value=<%=comBoardSearchValue %>';">취소</a></span>					
			</p>
			<!-- // button -->
		</div>
		<!-- // board_view -->
		
	
	</form>
<script type="text/javascript">
function Form_chkVal(Fid,msg)
{
	var frm=document.getElementById(Fid);
	if(!frm.value) {alert(msg);frm.focus();return false;}
	else {return true;}
}
function _onSubmit(f){	
	if(!Form_chkVal('writer','이름을 입력해주세요.')) return;
	if(!Form_chkVal('password','비밀번호를 입력해주세요.')) return;
	if(!Form_chkVal('subject','제목을 입력해주세요.')) return;
	
	oEditors.getById["description"].exec("UPDATE_CONTENTS_FIELD", []);	
	if(!Form_chkVal('description','내용을 입력해주세요.')) return;	
	
	f.action = "/board/modifyProcess.jsp";			
	f.submit();
	
}
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
</div>
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