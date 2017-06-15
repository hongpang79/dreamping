<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Vector" %>
<%@ page import="admin.MainBoardVO" %>
<%@ page import="admin.MainDAO" %>
<%
request.setCharacterEncoding("UTF-8");
NumberFormat nf = NumberFormat.getInstance();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

String step = request.getParameter("step")==null?"new":request.getParameter("step");
String sBannerNo = request.getParameter("bannerNo")==null?"0":request.getParameter("bannerNo");
int bannerNo = 0;

MainBoardVO board = new MainBoardVO();

String bannerName = "";
String imgUrl = "";
int boardNo = 0;
String boardSubject = "";
//String displayStartDay = "";
//String displayEndDay = "";
String useYn = "Y";

if(step.equals("modify")){
	bannerNo = Integer.parseInt(sBannerNo);
	board = MainDAO.getInstance().getBanner(bannerNo);
	bannerName = board.getSubject();
	imgUrl = board.getImgUrl();
	boardNo = board.getBoardNo();
	boardSubject = board.getBoardSubject();
	//displayStartDay = board.getDisplayStartDay()==null?"":transFormat.format(board.getDisplayStartDay());
	//displayEndDay = board.getDisplayEndDay()==null?"":transFormat.format(board.getDisplayEndDay());
	useYn = board.getUseYn()==null?"Y":board.getUseYn();
}
%>
<html>
<head>
<title>홈페이지 관리 > 메인 Banner 관리</title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/popup.js"></script>
<script language=javascript>
$(document).ready(
	function() {
		if($("#msg").val().length > 0){
			alert($("#msg").val());
			if($("#rtn").val() == 0){
				history.go(-1);
			}else{
				location.href="/admin/homepage/main_banner.jsp";
			}
		}
	}
);
	
$(function() {
	  $( "#datepicker1, #datepicker2, #datepicker3, #datepicker4, #datepicker5, #datepicker6" ).datepicker({
	    dateFormat: 'yy-mm-dd',
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNames: ['일','월','화','수','목','금','토'],
	    dayNamesShort: ['일','월','화','수','목','금','토'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
	    showMonthAfterYear: true,
	    yearSuffix: '년'
	  });
	});


</script>
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
	

<script type="text/javascript" src="/admin/js/calendar.js"></script>
<script type="text/javascript">

	function submitMainModify()
	{
		var f = document.mainModifyForm;
		
		if(f.subject.value == ""){
			alert("배너명을 입력해 주세요!");
			f.subject.focus();
			return;
		}
		
		if(f.boardNo.value == 0){
			alert("링크공지제목을 선택해 주세요!");
			f.boardSubject.focus();
			return;
		}
		
		if(f.step.value == "modify"){
			f.step.value = "update";
		}else{
			f.step.value = "insert";
		}

		f.submit();
	}

	function noticeList(){
		var url = "/admin/homepage/popupNoticeList.jsp";
		url = encodeURI(url);
		popup.openWindowPopup(url, 'notice', {width : '520px', height : '480px'});
	}
</script>

<style type="text/css">@import url(/admin/css/calendar.css);</style>

<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>메인 Banner 등록</li>
	<li class="location">공지/게시관리>홈페이지 관리>Banner 등록</li>
</ul>

<!--본문---------------------------------------------------------------------->
<table border=0 cellpadding=0 cellspacing=0 width=800>
	<tr height='20'><td></td></tr>
</table>

<form id="mainModifyForm" name="mainModifyForm" method='post' enctype="multipart/form-data" action='/admin/homepage/writeProcessBanner.jsp'>
	<input type="hidden" id="step" name="step" value="<%=step %>"/>
	<input type="hidden" id="category" name="category" value="banner"/>
<table class="product_table">
	<col bgcolor="#F6F6F6" width="18%"></col>
	<col width="32%"></col>
	<col bgcolor="#F6F6F6" width="18%">	</col>
	<col width="32%"></col>
	<tr>
		<th>배너명</th>
		<td colspan="3">
			<input type="text" id="num" name="num" size="10" value="<%=bannerNo %>" style="background:gray;text-align:right;" readonly >
			<input type="text" id="subject" name="subject" size="70" value="<%=bannerName%>"></td>
	</tr>
	<tr>
		<th>배너이미지</th>
		<td colspan="3"><input title="input" type='file' class='public_input input_form' id='imgUrl' name="imgUrl" style="border:1px solid #EAEAEA;height:20px;" maxlength="50" size="50" value="<%=imgUrl%>"/></td>
	</tr>
	<tr>
		<th>링크공지제목</th>
		<td colspan="3">
			<input type="text" id="boardNo" name="boardNo" size="10" value="<%=boardNo %>" style="background:gray;text-align:right;" readonly >
			<input type="text" id="boardSubject" name="boardSubject" size="70" value="<%=boardSubject%>" readonly onclick="javascript:noticeList()">
		</td>
	</tr>
	<tr>
	<!-- 
		<th>배너진열기간(구현중)</th>
		<td><input type="text" id="datepicker1" name="displayStartDay" size="12" value="" /> ~ 
            <input type="text" id="datepicker2" name="displayEndDay" size="12" value="" /></td>
     -->
		<th>배너사용여부</th>
		<td colspan="3"><input type="radio" name="useYn" value="Y" <% if(useYn.equals("Y")){ %> checked <%} %>/>사용
			<input type="radio" name="useYn" value="N" <% if(useYn.equals("N")){ %> checked <%} %>/>사용안함</td>
	</tr>
</table>
</form>


<div style='width:800' align='center'>
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="저장하기" class="bt_a32 tmb22" onclick="submitMainModify()">
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="취소하기" class="bt_a32 tmb22" onclick="location.reload();">
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="배너리스트" class="bt_a32 tmb22" onclick="location.href='/admin/homepage/main_banner.jsp'">
</div>


<table border='3' cellpadding='7' cellspacing='0' width='800' bordercolor='ECD08A' style='margin-top:20'>
	<tr><Td style='color:585858;line-height:180%;padding-left:20'>
			<b>[사용안내]</b><br>
			<b class=ol>ㆍ</b> .
	    </td>
	</tr>
</table>

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