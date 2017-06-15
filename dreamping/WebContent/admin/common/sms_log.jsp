<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="admin.SmsDAO" %>
<%
request.setCharacterEncoding("UTF-8");

NumberFormat nf = NumberFormat.getInstance();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

Calendar cal = Calendar.getInstance();
String year = cal.get(Calendar.YEAR)+"";
String month = cal.get(Calendar.MONTH)+1+"";
if(month.length() < 2){
	month = "0"+month;
}
String day = cal.get(Calendar.DATE)+"";
if(day.length() < 2){
	day = "0"+day;
}
String startDate = request.getParameter("startDate") == null ? year+"-"+month+"-"+day :request.getParameter("startDate");
String endDate = request.getParameter("endDate") == null ? year+"-"+month+"-"+day :request.getParameter("endDate");
%>
<html>
<head>
<title>SMS발송내역조회</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
</head>

<body bgcolor='#FFFFFF' topmargin='0' leftmargin='0'>

	 <!-- 상단 TOP Menu S -->
     <jsp:include page="/admin/common/menu_top.jsp" />
     <!-- 상단 TOP Menu E -->		                	
	
	<table border=0 cellpadding=0 cellspacing=0 width=800>
		<tr valign=top>
			<td width=175 bgcolor=F7F7F7>
				<!--왼쪽 타이틀------------------------------------------------->
				<jsp:include page="/admin/common/menu_left.jsp" />
				<!--//왼쪽 타이틀------------------------------------------------->
			</td>
			<td width=18><img src=/admin/img/e.gif width=18></td>
			<td width="100%">
			<td align="left" width="50%">

<script language=javascript>
$(function() {
	  $( "#datepicker1, #datepicker2" ).datepicker({
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

<style type="text/css">@import url(/admin/css/text_button.css);</style>

<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>SMS발송내역조회</li>
	<li class="location">캠핑장관리>SMS관리>SMS발송내역조회</li>
</ul>

<br>
<!--본문 내용 시작--------------------------------------------------------->

<TABLE cellSpacing=0 cellPadding=0 width=800 border=0>
    <TR style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 2px; PADDING-TOP: 22px" vAlign=bottom>
      <TD><IMG src="/admin/img/bl_blue.gif"><B>SMS 발송내역 검색
    </TR>
</TABLE>

<table border='1' cellpadding='0' cellspacing='0' width='800' style='border-collapse:collapse' bordercolor='#D3D3D3'>
<form name='searchs' id='searchs' method='post' action="/admin/common/sms_log.jsp">
    <tr height='30'>
        <td class='tbctr' align='center'>기간</td>
        <td style='padding-left:5'>
            <input type="text" id="datepicker1" name="startDate" size="12" value="<%=startDate%>" /> ~ 
            <input type="text" id="datepicker2" name="endDate" size="12" value="<%=endDate%>" />
        </td>
    </tr>
</table>

<table border='0' cellpadding='0' cellspacing='0'>
    <tr><td height='10'></td></tr>
</table>


<div style='width:800' align='center'>
    <input type='submit' value=' 검  색 ' onClick="searchForm();" style='#cursor:hand;font-family:verdana; font-size:11px; color:white; background-color:#5A598C; border-width:0; height:20;"' onmouseover="this.style.backgroundColor='#8C8EC6' " onmouseout="this.style.backgroundColor='#5A598C'">
</div>
</form>
<br><br>

<div id="searchResult" style="display:block;;">
<TABLE cellSpacing=0 cellPadding=0 width=800 border=0>
    <TR style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 2px; PADDING-TOP: 22px" vAlign=bottom>
      <TD><IMG src="/admin/img/bl_blue.gif"><B>SMS발송 내역 : <%=startDate%> ~ <%=endDate%></B></TD>
    </TR>
</TABLE>



<table border='1' cellpadding='0' cellspacing='0' width='800' style='border-collapse:collapse' bordercolor='#D3D3D3'>
    <col width='80'></col>
	<col width='100'></col>
	<col></col>
	<col width='80'></col>
    <tr height='30'>
        <td class='tbctr' align='center' >발송일자</td>
        <td class='tbctr' align='center' >휴대폰번호</td>
        <td class='tbctr' align='center' >메시지내용</td>
        <td class='tbctr' align='center' >발송성공여부</td>
    </tr>
<%
List<Map<String,Object>> smsLogs = SmsDAO.getInstance().selectSmsLog(startDate,endDate);

	if( smsLogs == null ){
%>
		<tr>
			<td colspan="6" align="center">
				<br>검색 결과가 없습니다<br><br>
			</td>
		</tr>
<%
	}else{
		int count = smsLogs.size();	// 검색된 리스트 총 수 반환
		String msgDay = "";
		String msg = ""; 
		String phoneNumber = "";
		String rtnMessage = "";
		Map<String,Object> smsLog = null;
		for( int i=0; i<count; i++ ){
			smsLog = smsLogs.get(i);
			msgDay = transFormat.format(smsLog.get("smsDay")); 
			msg = (String) smsLog.get("msg");
			phoneNumber = (String) smsLog.get("phoneNumber");
			rtnMessage = (String) smsLog.get("rtnMessage");
			
%>
	        <tr height='30' align='center'>
	        	<td><%=msgDay %></td>
	        	<td><%=phoneNumber %></td>
	        	<td align='left' style="padding-right:5; word-break:break-all;"><%=msg %></td>
	        	<td><%=rtnMessage %></td>
	        </tr>			
<%			
		}
	}
%>
    </table>
<table border='0' cellpadding='0' cellspacing='0'>
    <tr><td height='10'></td></tr>
</table>
</div>


<table border='3' cellpadding='7' cellspacing='0' width='100%' bordercolor='#ECD08A' style='margin-top:40'>
    <tr><Td style='color:585858;line-height:180%;padding-left:20'>
            <b>[사용안내]</b><br>
			<b class=ol>ㆍ</b>SMS발송내역을 조회할 수 있습니다.<br>
			<b class=ol>ㆍ</b>발송실패의 경우 충전금액이 차감되지 않습니다.<br>
			<b class=ol>ㆍ</b>충전금액 부족으로 발송이 안되는 경우 http://www.sendgo.co.kr/ 접속하여 충전하여 주십시오<br>
        </td>
    </tr>
</table>



<table border=0 cellpadding=0 cellspacing=0>
<tr>
    <td height=50></td>
</tr>
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
