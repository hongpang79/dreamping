<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    	category = "photo";
    	categoryName = "포토앨범";
    }else if("photo".equals(request.getParameter("category"))){
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
    
%>   
<HTML>
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
	<script type="text/javascript" src="/js/lib.js"></script>
</HEAD>
<body leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0">
	<!--menu-->
	<jsp:include page="/main/menu.jsp" />
	<!--//menu-->
	<div id="container">	
		<h2><img src="/images/board/photo.png" alt="" /></h2>

		<!-- customerCover -->
		<div class="communityCover">
			<ul class="menu_list">
				<li class="on"><a href="/main/board/gallerylist.jsp?category=photo">포토앨범</a></li>
				<li><a href="/main/board/list.jsp?category=notice">공지사항</a></li>
				<li><a href="/main/board/list.jsp?category=qna">Q & A</a></li>
			</ul>

			<div class="s_titleCover">
				<script type="text/javascript" src="/js/jquery.isotope.min.js"></script>  
				<div class="searchWrap">		
					<form name="frm_search" method="get" action="/Board.do">	
						<input type="hidden" name="start" value="1" />
						<input type="hidden" name="end" value="10" />
						<input type="hidden" name="currentPage" id="currentPage" />
						<input type="hidden" name="category" value="photo" />
<!-- 						
						<div style="float:right;">
							<div class="text-r"><span class="btn_pack gray"><a href="/data/review/write">글쓰기</a></span></div>	
						</div>
						<div class="cover">
							<input type="text" name="query" id="query" value="" class="search_txt logtxt" />
							<a href="#"onclick="searchForm(); return false;"><img src="/images/search.gif" alt="검색" class="img" /></a>
						</div>
 -->							
					</form>
				</div>
				<div class="element-cover">
					<div class="expo_list" id="expoContainer">				
					</div>
				</div>
 			
			<p id="moreBtn"><a href="#more" class="more_btn">다음페이지</a></p>

<script language="javascript">
function searchForm(){
	var frm = document.frm_search;
	if ( !frm.query.value ) {
		alert('검색어를 입력하세요');
		frm.query.focus();
		return;
	}	
	
	frm.action = "";
	frm.submit();
}
</script>
<script type="text/javascript">
var page = 1;
$(function(){	
	var $container = $('#expoContainer');	
	
	loadData();	
	function loadData(){
		$("#currentPage").val(page);
		var string = $("form[name='frm_search']").serialize();			
		//var string;
		$container.isotope({ //리스트생성			
			itemSelector : '.element',
			resizable: false		
		});
		$.ajax(
			{
				type:"post",
				dataType:"html",
				url: "/Board.do",
				data:string,
				success: function(data) {						
					var $newItems = $(data);
					$container.append($newItems).isotope( 'addItems', $newItems );
					$container.isotope( 'appended', $newItems, function(){									
						dataResize();	
					});
					page++;
					if ( $("#expoContainer div").length >= 27 ) {
						$("#moreBtn").hide();
					}
				},
				error: function(data) {
					alert("통신이 원할하지 않습니다. 다시 시도해 주십시오.");
				}
			}
		);			
	}	
	$('#moreBtn a').click(function(){
		loadData();
	});	

	$(window).resize(function(){				
		dataResize();
	});

	/**
	 @ 데이타 리사이즈
	**/
	function dataResize(){			
		var winW = $(window).width();		
		var coverW = $(".communityCover").width()-5
		if(winW < 480){			
			var e_w = Math.floor(coverW);
			$('.element').width(e_w)
			$('.element-cover').width(winW);			
		}else if(winW < 768){			
			var e_w = Math.floor(coverW/2);
			$('.element').width(e_w)
			$('.element-cover').width(winW);			
		}else if(winW < 768 || winW < 1000){			
			var e_w = Math.floor(coverW/3);
			$('.element').width(e_w)
			$('.element-cover').width(winW);			
		}else if(winW > 1000){				
			winW = 1000;
			var e_w = 330;						
			$('.element').width( 330 );			
			$('.element-cover').width(winW);						
		}
		/*
		if ( mobileFlag ) {
			if (winW > 600) var e_w = Math.floor( winW / 3 ) ;	
			else var e_w = Math.floor( winW / 2 ) ;				
			$('.element').width( e_w -1 );
			$('.element-cover').width(winW);						
		}
		if ( tabletFlag ) {			
			var e_w = Math.floor( winW / 3 ) ;	
			$('.element').width( e_w - 1);			
			$('.element-cover').width(winW);							
		}
		if ( webFlag ) {
			winW = 1010;
			var e_w = 327;						
			$('.element').width( 327 );			
			$('.element-cover').width(winW);						
		} 
		*/
		winW = 1000;
			//var e_w = 330;						
			//$('.element').width( 330 );			
			//$('.element-cover').width(winW);						
		$container.isotope({ //리스트생성						
		});	
	}
	
});
</script>
			</div>
			<!-- // customerCover -->
		</div>
	</div>
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

	<!--bottom-->
	<jsp:include page="/main/bottom.jsp" />
	<!--//bottom-->
	
</BODY>
</HTML>
<script language="javascript" type="text/javascript" src="/js/urban.lib.js?date=1364782903"></script>
<script language="javascript" src="/js/urban.board.js"></script>