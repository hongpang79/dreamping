<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="admin.StatisticsVO" %>
<%@ page import="admin.StatisticsDAO" %>
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
<title>매출통계</title>
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
     <jsp:include page="/admin/reservation/menu_top.jsp" />
     <!-- 상단 TOP Menu E -->		                	
	
	<table border=0 cellpadding=0 cellspacing=0 width=800>
		<tr valign=top>
			<td width=175 bgcolor=F7F7F7>
				<!--왼쪽 타이틀------------------------------------------------->
				<jsp:include page="/admin/reservation/menu_left.jsp" />
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
	<li>매출통계	<li class="location">예약관리>예약접수관리>매출통계</ul>

<br>
<!--본문 내용 시작--------------------------------------------------------->

<TABLE cellSpacing=0 cellPadding=0 width=800 border=0>
    <TR style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 2px; PADDING-TOP: 22px" vAlign=bottom>
      <TD><IMG src="/admin/img/bl_blue.gif"><B>매출 검색
    </TR>
</TABLE>

<table border='1' cellpadding='0' cellspacing='0' width='800' style='border-collapse:collapse' bordercolor='#D3D3D3'>
<form name='searchs' id='searchs' method='post' action="/admin/reservation/selling_statistics.jsp">
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
      <TD><IMG src="/admin/img/bl_blue.gif"><B>매출 내역 : <%=startDate%> ~ <%=endDate%></B></TD>
    </TR>
</TABLE>



<table border='1' cellpadding='0' cellspacing='0' width='800' style='border-collapse:collapse' bordercolor='#D3D3D3'>
    <tr height='30'>
        <td class='tbctr' align='center' >일자</td>
        <td class='tbctr' align='center' >예약주문금액</td>
        <td class='tbctr' align='center' >입금후 취소</td>
        <td class='tbctr' align='center' >결제금액</td>
        <td class='tbctr' align='center' >환불금액</td>
        <td class='tbctr' align='center' >순 매출</td>
    </tr>
<%
	Vector<StatisticsVO> statistics = StatisticsDAO.getInstance().selectStatisticsForPeriod(startDate,endDate);

	if( statistics == null ){
%>
		<tr>
			<td colspan="6" align="center">
				<br>검색 결과가 없습니다<br><br>
			</td>
		</tr>
<%
	}else{
		int count = statistics.size();	// 검색된 리스트 총 수 반환
		
		String reservationDay = "";
		int sumAmount = 0;
		int cancelAmount = 0; 
		int billingAmount = 0;
		int refundAmount = 0;
		int netAmount = 0;
		StatisticsVO statistic = new StatisticsVO();
		for( int i=0; i<count; i++ ){
			statistic = statistics.get(i);
			reservationDay = transFormat.format(statistic.getReservationDay());
			sumAmount = statistic.getSumAmount();
			cancelAmount = statistic.getCancelAmount();
			billingAmount = statistic.getBillingAmount();
			refundAmount = statistic.getRefundAmount();
			netAmount = statistic.getNetAmount();
%>
	        <tr height='30' align='center'>
	        	<td><%=reservationDay %></td>
	            <td align=right style='padding-right:5'>\<% out.print(nf.format(sumAmount)); %></td>
	            <td align=right style='padding-right:5'>\<% out.print(nf.format(cancelAmount)); %></td>
	            <td align=right style='padding-right:5'>\<% out.print(nf.format(billingAmount)); %></td>
	            <td align=right style='padding-right:5'>\<% out.print(nf.format(refundAmount)); %></td>
	            <td align=right style='padding-right:5'>\<% out.print(nf.format(netAmount)); %></td>
	        </tr>			
<%			
		}
		
		statistic = StatisticsDAO.getInstance().selectStatisticsForPeriodSum(startDate,endDate);
		sumAmount = statistic.getSumAmount();
		cancelAmount = statistic.getCancelAmount();
		billingAmount = statistic.getBillingAmount();
		refundAmount = statistic.getRefundAmount();
		netAmount = statistic.getNetAmount();
%>
		<tr height='30' align='center'>
            <td class='tbctr'>총계</td>
            <td class='tbctr' align=right style='padding-right:5'>\<% out.print(nf.format(sumAmount)); %></td>
            <td class='tbctr' align=right style='padding-right:5'>\<% out.print(nf.format(cancelAmount)); %></td>
            <td class='tbctr' align=right style='padding-right:5'>\<% out.print(nf.format(billingAmount)); %></td>
            <td class='tbctr' align=right style='padding-right:5'>\<% out.print(nf.format(refundAmount)); %></td>
            <td class='tbctr' align=right style='padding-right:5'>\<% out.print(nf.format(netAmount)); %></td>
        </tr>
<%		
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
			<b class=ol>ㆍ</b>입금후 취소는 예약자의 주문취소시(예약완료(입금확인후))에 취소/환불관리에서 환불승인이 완료 되었을때  <br>  나타나는 주문금액에 대한 취소금액입니다. 실제환불 금액은 환불 입력금액이 적용 됩니다.<br>
			<b class=ol>ㆍ</b>환불금액은 환불관리에서 입력된 환불금액이 나타 납니다.<br>
			<b class=ol>ㆍ</b>입금후 취소의 경우 환불이 안되었을때는 순매출로 표시됩니다.<br>
            <b class=ol>ㆍ</b>취소/환불금액은 취소/환불 완료일 기준으로 표시됩니다.

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
