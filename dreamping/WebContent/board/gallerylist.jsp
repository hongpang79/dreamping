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
    String imgpath = "";
    if (category == null){
    	category = "photo";
    	categoryName = "갤러리";
    	imgpath = "/board/images/gallery.png";
    }else if("photo".equals(request.getParameter("category"))){
    	categoryName = "갤러리";
    	imgpath = "/board/images/gallery.png";
    }else if("event".equals(request.getParameter("category"))){
    	categoryName = "이벤트";
    	imgpath = "/board/images/event.png";
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
    //  2*10 = 20
    int count = 0;    // 전체 글 수
    int number=0;   // 그 페이지에서 시작행 번호
    
%>   
<jsp:include page="/header.jsp" />
	<link rel="stylesheet" type="text/css" media="all" href="/board/css/common.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/board/css/layout.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/board/css/content.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/css/jquery.ui.datepicker.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/css/owl.carousel.css" />
	<link href='http://fonts.googleapis.com/css?family=Play:400,700' rel='stylesheet' type='text/css' />
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<!--[if lt IE 9]>
	<script type="text/javascript" src="/js/respond.min.js"></script>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
	<script type="text/javascript" src="/js/owl.carousel.js"></script>	
	<script type="text/javascript" src="/js/jquery.ui.core.js"></script>
	<script type="text/javascript" src="/js/jquery.ui.datepicker.js"></script>
</HEAD>
<div id="containerWrap">
	<div id="contCover">
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

			<div class="s_titleCover">
				<script type="text/javascript" src="/board/js/jquery.isotope.min.js"></script>  
				<div class="searchWrap">		
					<form name="frm_search" method="get" action="/Board.do">		
						<input type="hidden" name="start" value="1" />
						<input type="hidden" name="end" value="10" />
						<input type="hidden" name="currentPage" id="currentPage" />
						<input type="hidden" name="category" value="<%=category %>" />	
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

<script type="text/javascript">
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

var page = 1;
$(function(){	
	var $container = $('#expoContainer');	
	
	loadData();	
	function loadData(){
		$("#currentPage").val(page);
		var string = $("form[name='frm_search']").serialize();			
		//alert(string);
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
	<!-- #footer -->
	<section class="mbr-section mbr-section-md-padding mbr-footer footer1" id="contacts1-6" style="background-color: rgb(255, 255, 255); padding-top: 90px; padding-bottom: 90px;">
    
    <div class="container">
        <div class="row">
            <div class="mbr-footer-content col-xs-12 col-md-3">
                <img src="/img/footerLogo.png" style="padding:0px 0px 40px;">
				<p>&copy; 2017 <span style="color: #f83600;">DREAMPING</span>, All Right Reserved</p>
            </div>
            <div class="mbr-footer-content col-xs-12 col-md-3">
                <p><font color="#000000" face="Montserrat, sans-serif" size="3"><span style="letter-spacing: -1px; line-height: 20px;"><strong>INFORMATION</strong></span></font>
                <br>
                상호명 : 엠엔엠레저컨설팅<br>
                대표자명 : 맹정환<br>
                 주소 : 경기도 남양주시 화도읍 금남리 105-1<br>
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(북한강로 1630-18)<br>
                대표전화 : 031-559-8763<br>
                현장전화 : 010.8893.9088</p>
            </div>
            <div class="mbr-footer-content col-xs-12 col-md-3">
                <p><font color="#000000" face="Montserrat, sans-serif" size="3"><span style="letter-spacing: -1px; line-height: 20px;"><strong>LICENCE</strong></span></font>
                <br>
                사업자등록번호 : 381-63-00132<br>
                통신판매신고번호 :&nbsp;<br>
       e-mail : <br>
                개인정보보호정책 책임자 : 맹정환</p>
            </div>
            <div class="mbr-footer-content col-xs-12 col-md-3">
                <p><font color="#7c7c7c" face="Montserrat, sans-serif" size="3"><span style="letter-spacing: -1px; line-height: 20px;"><strong>BANK INFO<br></strong></span></font>
                <br>
                은행명 : 국민은행<br>
                계좌번호 : 401301-04-057170<br>
                예금주 : 엠앤엠레저컨설팅</p>
            </div>

        </div>
    </div>
</section>


  <script src="/assets/tether/tether.min.js"></script>
  <script src="/assets/bootstrap/js/bootstrap.min.js"></script>
  <script src="/assets/smooth-scroll/smooth-scroll.js"></script>
  <script src="/assets/dropdown/js/script.min.js"></script>
  <script src="/assets/touch-swipe/jquery.touch-swipe.min.js"></script>
  <script src="/assets/viewport-checker/jquery.viewportchecker.js"></script>
  <script src="/assets/jarallax/jarallax.js"></script>
  <script src="/assets/bootstrap-carousel-swipe/bootstrap-carousel-swipe.js"></script>
  <script src="/assets/jquery-mb-ytplayer/jquery.mb.ytplayer.min.js"></script>
  <script src="/assets/theme/js/script.js"></script>
  <script src="/assets/mobirise-slider-video/script.js"></script>
  
  
  <input name="animation" type="hidden">
  </body>
</html>
	<!-- // #footer -->	
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