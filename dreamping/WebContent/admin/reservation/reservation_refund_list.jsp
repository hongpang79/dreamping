<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="reservation.ReservationVO" %>
<%@ page import="admin.ReservationDAO" %>
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
//periodGubun,searchSite,searchUserName,mode
String periodGubun = request.getParameter("periodGubun") == null ? "cancle" : request.getParameter("periodGubun");
String searchSite = request.getParameter("searchSite") == null ? "" : request.getParameter("searchSite");
String searchUserName = request.getParameter("searchUserName")  == null ? "" : request.getParameter("searchUserName");
String mode = request.getParameter("mode") == null ? "" : request.getParameter("mode");
String modeF = request.getParameter("modeF") == null ? "" : request.getParameter("modeF");
String modeC = request.getParameter("modeC") == null ? "" : request.getParameter("modeC");
String jobDvsn = request.getParameter("jobDvsn") == null ? "search" : request.getParameter("jobDvsn");

String msg = "";
if(jobDvsn.equals("update")){
	String status = request.getParameter("status");
	String sReservationNo = request.getParameter("reservationNo");
	String sRefundPrice = request.getParameter("refundPrice");
	String sRefundMemo = request.getParameter("refundMemo");
	msg = ReservationDAO.getInstance().updateReservationRefund(status,sReservationNo,sRefundPrice,sRefundMemo);
}
%>
<html>
<head>
<title>환불관리</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
<script type="text/javascript" src="/js/popup.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
<script>
$(document).ready(
	function() {
		if($("#mode").val() == ""){
			$('input:checkbox[name="modeF"]').prop("checked",true);
			$('input:checkbox[name="modeC"]').prop("checked",true);
		}
		
		if($("#msg").val().length > 0){
			alert($("#msg").val());
		}
	}
);

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

<script type="text/javascript" src="/admin/js/calendar.js"></script>
<script language=javascript>
	var cal = null;

	function toggleCheck( e ){
		if( !e ) return;
		var srcE = null;
		srcE = ( e.target ? e.target : e.srcElement );
		if( !srcE ) return;

		var tb = srcE.offsetParent.offsetParent;
		var ipts = tb.getElementsByTagName( 'input' );
		for( var i = 0 , chk = srcE.checked ; i < ipts.length ; i++ ){
			if( ipts[ i ].getAttribute( 'type' ) != 'checkbox' ) continue;
			if( ipts[ i ].disabled ) continue;
			ipts[ i ].checked = chk;
		}
	}
	
	function refundMemo(reservationNo, refundPrice, refundMemo){
		var url = "/admin/reservation/popupRefundMemo.jsp?step=popup&reservationNo="+reservationNo+"&refundPrice="+refundPrice+"&refundMemo="+refundMemo;
		url = encodeURI(url);
		popup.openWindowPopup(url, 'adminMemo', {width : '510px', height : '380px'});
	}
	
	function admitReservation(status, reservationNo, refundPrice, refundMemo){
		var msg = '취소/환불 내역을 승인하시겠습니까?';
		if(status == 'Y'){
			msg = '취소/환불 내역을 취소하시겠습니까?';
		}
		if( !confirm(msg) ) return;
		
		$('#status').val(status);
		$('#reservationNo').val(reservationNo);
		$('#refundPrice').val(refundPrice);
		$('#refundMemo').val(refundMemo);
		
		$('#jobDvsn').val("update");
		document.getElementById('reservationSearch').submit();
	}

	function searchForm(){
    	$('#mode').val("");
    	if($("#modeC").prop("checked") == true){
    		if($('#mode').val().length > 0){
    			$('#mode').val($('#mode').val()+",'C'");	
    		}else{
    			$('#mode').val("'C'");
    		}
		}
    	if($("#modeF").prop("checked") == true){
    		if($('#mode').val().length > 0){
    			$('#mode').val($('#mode').val()+",'F'");	
    		}else{
    			$('#mode').val("'F'");
    		}
		}
    	
    	$('#jobDvsn').val("search");
        document.getElementById('reservationSearch').submit();
    }
	
    function refundPriceText( e ){
		var srcE = ( e.target ? e.target : e.srcElement );
		var price = srcE.options[ srcE.selectedIndex ].value;
		var priceIpt = srcE.offsetParent.nextSibling.getElementsByTagName( 'input' )[ 0 ];

		priceIpt.value = price;
    }
</script>


<style type="text/css">@import url(/admin/css/text_button.css);</style>

<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>취소/환불관리	<li class="location">예약관리>예약접수관리>취소/환불관리</ul>
<br>

<!--본문 내용 시작--------------------------------------------------------->
<form id='reservationSearch' name="reservationSearch" method='post'>
	<input type="hidden" id="mode" name="mode" value="<%=mode%>">
	<input type="hidden" id="reservationNo" name="reservationNo" value="">
	<input type="hidden" id="status" name="status" value="">
	<input type="hidden" id="jobDvsn" name="jobDvsn" value="">
	<input type="hidden" id="msg" name="msg" value="<%=msg%>">
	<input type="hidden" id="refundMemo" name="refundMemo" value="">
	<input type="hidden" id="refundPrice" name="refundPrice" value="">

<table border=1 cellpadding=7 cellspacing=0 width=800 style='border-collapse:collapse' bordercolor='D3D3D3'>
	<col width='100'></col><col></col>
	<tr>
		<td class='tbctr' align=center>Site No</td>
		<td class='tbcont'>
			<input type=text name="searchSite" value="<%=searchSite %>" size=30 >
		</td>
	</tr>
    <tr>
		<td class='tbctr' align=center>기간</td>
		<td class='tbcont'>
			<select name="periodGubun">
				<option value="order" <% if(periodGubun.equals("order")){%>selected<%}%>>예약접수일자</option>
				<option value="period" <% if(periodGubun.equals("period")){%>selected<%}%>>예약일자</option>
				<option value="cancle" <% if(periodGubun.equals("cancle")){%>selected<%}%>>환불요청일자</option>
				<option value="refund" <% if(periodGubun.equals("refund")){%>selected<%}%>>환불일자</option>
			</select>

            <input type="text" id="datepicker1" name="startDate" size="12" value="<%=startDate%>">
			~
            <input type="text" id="datepicker2" name="endDate" size="12" value="<%=endDate%>">
		</td>
	</tr>
  	<tr>
		<td class='tbctr' align=center>예약자 성명</td>
		<td class='tbcont'>
			<input type=text name="searchUserName" value="<%=searchUserName %>" size=30>
		</td>
	</tr>

    <!--결제여부 T 일 경우
	<tr>
		<td class='tbctr' align=center>결제수단</td>
		<td class='tbcont'>
            <input type="checkbox" name="chargedMethodBank" value="BANK"  onpropertychange="document.getElementsByName( 'nTDPage' )[0].value='';"> 무통장입금
            <input type="checkbox" name="chargedMethodCard" value="CARD"  onpropertychange="document.getElementsByName( 'nTDPage' )[0].value='';"> 카드
        </td>
	</tr>
	-->
  	<tr>
		<td class='tbctr' align=center>예약상태</td>
		<td class='tbcont'>	
			<input type="checkbox" id="modeC" name="modeC" value="C" <% if(modeC.equals("C")){%>checked<%}%>><label for="modeC" hidefocus="true">취소/환불신청</label>
			<input type="checkbox" id="modeF" name="modeF" value="F" <% if(modeF.equals("F")){%>checked<%}%>><label for="modeF" hidefocus="true">환불완료</label>
		</td>
	</tr>
</table>
</form>

<div style='padding:10 0 16 0;' align=center>
	<img src='/admin/img/reservation/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='button' value='  검 색  ' class='bt_a32 tmb22' onclick="searchForm();">
</div>

<!--검색결과-->

<form name="listForm" method="get">
<ul class="bullet_title"><li>검색 결과</ul>
	<table id="listing_table" class="product_table">
		<col width='10'></col>
		<col width='80'></col>
		<col width='160'></col>
		<col width='70'></col>
		<col width='90'></col>
		<col width='100'></col>
		<col></col>
		<col width='70'></col>
		<col width='60'></col>
		<thead>
	        <tr>
	            <th>No.</th>
	            <th>예약상품명</th>
	            <th>예약자 정보</th>
				<th>예약내용</th>
				<th>환불금액</th>
				<th>환불요청정보</th>
				<th>취소사유</th>
	            <th>환불일자<br>예약상태</th>
	            <th>상태변경</th>
	         </tr>
		</thead>
<%
	// 총 수
	mode = request.getParameter("mode") == null || request.getParameter("mode") == "" ? "'C','F'" : request.getParameter("mode");
	Vector<ReservationVO> vReservation = ReservationDAO.getInstance().selectRefundList(startDate,endDate,periodGubun,searchSite,searchUserName,mode);
	if( vReservation == null ){
%>	
		<tr>
			<td colspan="9" align="center">
				<br>검색 결과가 없습니다<br><br>
			</td>
		</tr>
<%
	}else{
		int count = vReservation.size();	// 검색된 리스트 총 수 반환
		int reservationNo = 0;
		String chooseDate = "";
		String zoneName = "";
		String productName = "";
		String reserver = "";
		int users = 0;
		int nights = 0;
		int price = 0;
		String regDate = "";
		String content = "";
		String payStatus = "";
		String status = "";
		String phone = "";
		String cell = "";
		String email = "";
		String refundBank = "";
		String refundDepositor = "";
		String refundAccount = "";
		String refundRegDate = "";
		String refundDate = "";
		String refundMemo = "";
		String remark = "";
		String refundBase = "";
		String refundType = "";
		int refundPrice = -1;
		int calcPrice = 0;
		for( int i=0; i<count; i++){
			ReservationVO reservation = vReservation.get(i);
			reservationNo = reservation.getReservationNo();
			chooseDate = transFormat.format(reservation.getReservationDate());
			zoneName = reservation.getZoneName();
			productName = reservation.getProductName();
			reserver = reservation.getReserver();
			users = reservation.getUsers();
			nights = reservation.getNights();
			price = reservation.getPrice();
			regDate = transFormat.format(reservation.getRegDate());
			phone = reservation.getPhone1().length()==0 ? "" : reservation.getPhone1()+"-"+reservation.getPhone2()+"-"+reservation.getPhone3();
			cell = reservation.getCell1().length()==0 ? "" : reservation.getCell1()+"-"+reservation.getCell2()+"-"+reservation.getCell3();
			email = reservation.getEmail();
			remark = reservation.getRemark();
			refundBank = reservation.getRefundBank() == null ? "" : reservation.getRefundBank();
			refundDepositor = reservation.getRefundDepositor() == null ? "" : reservation.getRefundDepositor();
			refundAccount = reservation.getRefundAccount() == null ? "" : reservation.getRefundAccount();
			remark = reservation.getRemark();
			refundRegDate = reservation.getRefundRegDate() == null ? "" : transFormat.format(reservation.getRefundRegDate());
			refundDate = reservation.getRefundDate() == null ? "" : transFormat.format(reservation.getRefundDate());
			refundPrice = reservation.getRefundPrice();
			calcPrice = reservation.getCalcPrice();
			refundMemo = reservation.getRefundMemo();
			refundType = reservation.getRefundType() == "W" ? "원":"%";
			refundBase = reservation.getRefundDay()+"일이전 "+reservation.getRefundAmount()+refundType;
			payStatus = reservation.getPayStatus();
			if(payStatus.equals("F")){
				status="환불완료";
			}else if(payStatus.equals("C")){
				status="예약취소<br>환불요청";
			}
%>	
		<tr>
			<td><%= i+1 %></td>
			<td><%= productName %></td>
			<td style="text-align: left;">
				&nbsp;<%= reserver %><br>
				&nbsp;<%= phone %><br>
				&nbsp;<%= cell %><br>
				&nbsp;<%= email %>
			</td>
			<td>
				<%= chooseDate %><br>
				(<% if(nights==0){ out.print("picnic"); }else{out.print(nights+"박"+(nights+1)+"일");} %>)<br>
				<% out.print(nf.format(price)); %>원
			</td>
			<td style="text-align: right;">
				<%= refundRegDate %>&nbsp;<br>
				<% if(refundMemo==null){ out.print(refundBase); }else{ out.print(refundMemo); } %>&nbsp;<br>
				<b><% if(refundMemo==null){ out.print(nf.format(calcPrice)); }else{out.print(nf.format(refundPrice));} %></b>원&nbsp;
			</td>
			<td style="text-align: left;">
				&nbsp;<%= refundBank %><br>
				&nbsp;<%= refundAccount %><br>
				&nbsp;<%= refundDepositor %>
			</td>
			<td style="text-align: left;">&nbsp;<%= remark %></td>
			<td>
				<%= refundDate %><br>
				<a href="javascript:refundMemo('<%=reservationNo%>','<% if(refundPrice == -1){ out.print(nf.format(calcPrice)); }else{out.print(nf.format(refundPrice));} %>','<% if(refundMemo==null){ out.print(refundBase); }else{ out.print(refundMemo); } %>')">[<%= status %>]</a>
			</td>
			<td>
				<% 
					if(payStatus.equals("C")){ 
				%>
					<input type="button" value="환불완료" onClick="javascript:admitReservation('F','<%= reservationNo %>','<%=calcPrice %>','<%=refundBase %>');" />
					<input type="button" value="환불취소" onClick="javascript:admitReservation('Y','<%= reservationNo %>','0','');" />
				<% 
					}
				%>
			</td>
		</tr>
<% 		}
	} 
%>				
	
	</table>

</form>

	<br>
	<table width=100% border=0 cellspacing=0 cellpadding=10 align=center>
		<tr>
			<td align=right>
				
			</td>
		</tr>
	</table>
	<br>
<!-- 
	<div style='padding:10 0 16 0;' align=center>

			<img src='/admin/aimg/reservation/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='button' value='예약취소' class='bt_a32 tmb22'onclick="admitRefund()">
		<img src='/admin/aimg/reservation/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='button' value='환불취소' class='bt_a32 tmb22' onclick="cancelRefund()">
	
	</div>
 -->
	<div class="usage_instruction">
		<ul class="desc">
			<li><b class=ol>ㆍ</b>취소/환불 신청 접수 후, 운영자가 금액을 확인한 후 고객의 환불계좌로 입금합니다.
			<li><b class=ol>ㆍ</b>환불 수수료 조건은 캠핑장관리>환불설정관리에서 수정 관리하실 수 있습니다.
			<li><b class=ol>ㆍ</b>각 예약건의 예약상태 클릭 시 운영자메모를 남길 수 있습니다.</li>
			<li><b class=ol>ㆍ</b>환불금액을 확인하고 입금처리 한 후 환불상태를 환불완료로 변경합니다.
		</ul>
	</div>


<!--본문 끝---------------------------------------------------------------------------------------->

			</td>
		</tr>
	</table>
	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->			
</body>
</html>
