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
String periodGubun = request.getParameter("periodGubun") == null ? "order" : request.getParameter("periodGubun");
String searchSite = request.getParameter("searchSite") == null ? "" : request.getParameter("searchSite");
String searchUserName = request.getParameter("searchUserName")  == null ? "" : request.getParameter("searchUserName");
String mode = request.getParameter("mode") == null ? "" : request.getParameter("mode");
String modeN = request.getParameter("modeN") == null ? "" : request.getParameter("modeN");
String modeY = request.getParameter("modeY") == null ? "" : request.getParameter("modeY");
String modeR = request.getParameter("modeR") == null ? "" : request.getParameter("modeR");
String jobDvsn = request.getParameter("jobDvsn") == null ? "search" : request.getParameter("jobDvsn");
String sort = request.getParameter("sort") == null ? "reg_date" : request.getParameter("sort");

String msg = "";
if(jobDvsn.equals("update")){	
	String status = request.getParameter("status");
	String sReservationNo = request.getParameter("reservationNo");

	msg = ReservationDAO.getInstance().updateReservation(status,sReservationNo);
}else if(jobDvsn.equals("cancleAll")){
	msg = ReservationDAO.getInstance().updateReservationCancleAll();
}

int count = 0;	// 검색된 리스트 총 수 반환
int reservationNo = 0;
String chooseDate = "";
String zoneName = "";
String productName = "";
String reserver = "";
int toddler = 0;
int child = 0;
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
String adminMemo = "";
int totalUser = 0;

String ip = request . getHeader ( "X-Forwarded-For" );   
if  ( ip ==  null  || ip . length ()  ==  0  ||  "unknown" . equalsIgnoreCase ( ip ))  {   
    ip = request . getHeader ( "Proxy-Client-IP" );   
}   
if  ( ip ==  null  || ip . length ()  ==  0  ||  "unknown" . equalsIgnoreCase ( ip ))  {   
    ip = request . getHeader ( "WL-Proxy-Client-IP" );   
}   
if  ( ip ==  null  || ip . length ()  ==  0  ||  "unknown" . equalsIgnoreCase ( ip ))  {   
    ip = request . getHeader ( "HTTP_CLIENT_IP" );   
}   
if  ( ip ==  null  || ip . length ()  ==  0  ||  "unknown" . equalsIgnoreCase ( ip ))  {   
    ip = request . getHeader ( "HTTP_X_FORWARDED_FOR" );   
}   
if  ( ip ==  null  || ip . length ()  ==  0  ||  "unknown" . equalsIgnoreCase ( ip ))  {   
    ip = request . getRemoteAddr ();   
} 
System.out.println("/admin/reservaton_order_list get IP Address : " + ip);
%>
<head>
<title>예약관리</title>
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
			$('input:checkbox[name="modeN"]').prop("checked",true);
			$('input:checkbox[name="modeY"]').prop("checked",true);
			$('input:checkbox[name="modeR"]').prop("checked",true);
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
	
	function adminMemo(reservationNo, price, adminMemo){
		var url = "/admin/reservation/popupAdminMemo.jsp?step=popup&reservationNo="+reservationNo+"&price="+price+"&adminMemo="+adminMemo;
		url = encodeURI(url);
		popup.openWindowPopup(url, 'adminMemo', {width : '510px', height : '380px'});
	}
	
	function admitReservation(status, reservationNo){
		var msg = '선택한 예약을 취소하시겠습니까?';
		if(status == 'Y'){
			msg = '선택한 예약을 승인하시겠습니까?';
		}
		if( !confirm(msg) ) return;

		$('#status').val(status);
		$('#reservationNo').val(reservationNo);
		
		$('#jobDvsn').val("update");
		document.getElementById('reservationSearch').submit();
	}

	function searchForm(){
    	$('#mode').val("");
    	if($("#modeN").prop("checked") == true){
    		if($('#mode').val().length > 0){
    			$('#mode').val($('#mode').val()+",'N'");	
    		}else{
    			$('#mode').val("'N'");
    		}
		}
    	if($("#modeY").prop("checked") == true){
    		if($('#mode').val().length > 0){
    			$('#mode').val($('#mode').val()+",'Y'");	
    		}else{
    			$('#mode').val("'Y'");
    		}
		}
    	if($("#modeR").prop("checked") == true){
    		if($('#mode').val().length > 0){
    			$('#mode').val($('#mode').val()+",'R'");	
    		}else{
    			$('#mode').val("'R'");
    		}
		}
    	$('#jobDvsn').val("search");
        document.getElementById('reservationSearch').submit();
    }
	
	function cancleAll(){
		$('#jobDvsn').val("cancleAll");
		document.getElementById('reservationSearch').submit();
    }

</script>


<style type="text/css">@import url(/admin/css/calendar.css);</style>
<style type="text/css">@import url(/admin/css/text_button.css);</style>

<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>예약접수관리	<li class="location">예약관리>예약접수관리>예약접수관리</ul>

<br>

<!--본문 내용 시작--------------------------------------------------------->
<form id='reservationSearch' name="reservationSearch" method='post'>
	<input type="hidden" id="mode" name="mode" value="<%=mode%>">
	<input type="hidden" id="reservationNo" name="reservationNo" value="">
	<input type="hidden" id="status" name="status" value="">
	<input type="hidden" id="jobDvsn" name="jobDvsn" value="">
	<input type="hidden" id="msg" name="msg" value="<%=msg%>">
<table border=1 cellpadding=7 cellspacing=0 width=800 style='border-collapse:collapse' bordercolor='D3D3D3'>
	<col width='100'></col>
	<col></col>
	<tr>
		<td class='tbctr' align=center>Site명</td>
		<td class='tbcont'>
			<input type=text name="searchSite" value="<%=searchSite %>"/>
		</td>
	</tr>
    <tr>
		<td class='tbctr' align=center>기간</td>
		<td class='tbcont'>
			<select name="periodGubun">
				<option value="order" <% if(periodGubun.equals("order")){%> selected <% }%>>예약접수일자</option>
				<option value="period" <% if(periodGubun.equals("period")){%> selected <% }%>>예약일자</option>
			</select>

            <input type="text" id="datepicker1" name="startDate" size="12" value="<%=startDate%>" />
            <input type="text" id="datepicker2" name="endDate" size="12" value="<%=endDate%>" />
	</tr>
  	<tr>
		<td class='tbctr' align=center>예약자 성명</td>
		<td class='tbcont'>
			<input type=text name="searchUserName" value="<%=searchUserName%>" />
		</td>
	</tr>

    <!--결제여부 T 일 경우
	<tr>
		<td class='tbctr' align=center>결제수단</td>
		<td class='tbcont'>
            <input type="checkbox" name="chargedMethodBank" value="BANK" > 무통장입금
            <input type="checkbox" name="chargedMethodCard" value="CARD" > 카드
        </td>
	</tr>
	-->
  	<tr>
		<td class='tbctr' align=center>예약상태</td>
		<td class='tbcont'>
			<input type="checkbox" id="modeN" name="modeN" value="N" <% if(modeN.equals("N")){%>checked<%}%>><label for="modeW" hidefocus="true">예약대기</label>
			<input type="checkbox" id="modeY" name="modeY" value="Y" <% if(modeY.equals("Y")){%>checked<%}%>><label for="modeA" hidefocus="true">예약완료</label>
			<input type="checkbox" id="modeR" name="modeR" value="R" <% if(modeR.equals("R")){%>checked<%}%>><label for="modeC" hidefocus="true">예약취소</label>
		</td>
	</tr>
	<tr>
		<td class='tbctr' align=center>정렬</td>
		<td class='tbcont'>
			<input type="radio" id="sort" name="sort" value="reg_date" <% if(sort.equals("reg_date")){%>checked<%}%>>접수일자
			<input type="radio" id="sort" name="sort" value="zone_name,site_name" <% if(sort.equals("zone_name,site_name")){%>checked<%}%>>SITE명
			<input type="radio" id="sort" name="sort" value="reserver,zone_name,site_name" <% if(sort.equals("reserver,zone_name,site_name")){%>checked<%}%>>예약자명
		</td>
	</tr>
</table>
</form>

<div style='padding:10 0 16 0;' align=center>
	<img src='/admin/img/reservation/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='button' value='  검 색  ' class='bt_a32 tmb22' onclick="searchForm();">
</div>

<!--검색결과-->
<div id="loadingBar" style="LEFT:'450px'; TOP:expression((document.body.clientHeight/2)); POSITION:absolute; z-index:1">
	<img src="/admin/img/common/InternetSlowdown_Day.gif" />
</div>
<div id="divBody" style="display:none">
<!-- 
<div align="right"><img src='/admin/img/reservation/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='button' value='  일괄예약취소  ' class='bt_a32 tmb22' onclick="cancleAll();">&nbsp;&nbsp;&nbsp;&nbsp;</div>
 -->
<form name="listForm" method="get">
<ul class="bullet_title"><li>검색 결과</ul>
	<table id="listing_table" class="product_table">
		<col width='10'></col>
		<col width='80'></col>
		<col width='160'></col>
		<col width='130'></col>
		<col width='80'></col>
		<col></col>
		<col width='80'></col>
		<col width='60'></col>		
		<thead>
	        <tr>
	            <th>No.</th>
	            <th>예약상품명</th>
	            <th>예약자 정보</th>
				<th>예약내용</th>
	            <th>결제금액</th>
	            <th>예약요청사항</th>
	            <th>접수일자<br>(예약상태)</th>
	            <th>상태변경</th>
	        </tr>
		</thead>
<%
	// 
	// 총 수
	if(request.getParameter("mode") == null || mode.equals("")){
		mode = "'N','Y','R'";
	}else{
		request.getParameter("mode");
	}
	//System.out.println("mode : " +mode);
	Vector<ReservationVO> vReservation = ReservationDAO.getInstance().selectOrderList(startDate,endDate,periodGubun,searchSite,searchUserName,mode,sort);
	
	if( vReservation == null ){
%>
		<tr>
			<td colspan="8" align="center">
				<br>검색 결과가 없습니다<br><br>
			</td>
		</tr>
<%
	}else{
		count = vReservation.size();	// 검색된 리스트 총 수 반환
		for( int i=0; i<count; i++ ){
			ReservationVO reservation = vReservation.get(i);
			reservationNo = reservation.getReservationNo();
			chooseDate = transFormat.format(reservation.getReservationDate());
			zoneName = reservation.getZoneName();
			productName = reservation.getProductName();
			reserver = reservation.getReserver();
			toddler = reservation.getToddler();
			child = reservation.getChild();
			users = reservation.getUsers();
			totalUser = toddler+child+users;
			nights = reservation.getNights();
			price = reservation.getPrice();
			regDate = transFormat.format(reservation.getRegDate());
			phone = reservation.getPhone1().length()==0?"":reservation.getPhone1()+"-"+reservation.getPhone2()+"-"+reservation.getPhone3();
			cell = reservation.getCell1().length()==0?"":reservation.getCell1()+"-"+reservation.getCell2()+"-"+reservation.getCell3();
			email = reservation.getEmail();
			content = reservation.getMemo();
			adminMemo = reservation.getAdminMemo()==null?"":reservation.getAdminMemo();
			payStatus = reservation.getPayStatus();
			if(payStatus.equals("N")){
				status="예약대기";
			}else if(payStatus.equals("Y")){
				status="예약완료";
			}else if(payStatus.equals("C")){
				status="취소/환불신청";
			}else if(payStatus.equals("R")){
				status="예약취소";
			}
%>
		<tr style="height:'56px';">
			<td><%= i+1 %></td>
			<td><%= productName %></td>
			<td style="text-align: left;">
				&nbsp;<%= reserver %><br>
				&nbsp;<%= phone %><br>
				&nbsp;<%= cell %><br>
				&nbsp;<%= email %>
			</td>
			<td style="text-align: left;">
				&nbsp;<%= chooseDate %>&nbsp;(<% if(nights==0){ out.print("picnic"); }else{out.print(nights+"박"+(nights+1)+"일");} %>)<br>
				&nbsp;<%=totalUser%>명 &nbsp;(&nbsp;<%= toddler %>&nbsp;/&nbsp;<%= child %>&nbsp;/&nbsp;<%= users %>&nbsp;)</td>
			<td style="text-align: right;"><% out.print(nf.format(price)); %>원&nbsp;<br><%=adminMemo %>&nbsp;</td>
			<td style="text-align: left;">&nbsp;<%= content %></td>
			<td><%= regDate %><br><a href="javascript:adminMemo('<%=reservationNo%>','<%=price%>','<%=adminMemo %>')">[<%= status %>]</a></td>
			<td>
				<% 
					if(payStatus.equals("N")){ 
				%>
					<input type="button" value="예약승인" onClick="javascript:admitReservation('Y',<%= reservationNo %>);" /><br>
					<input type="button" value="예약취소" onClick="javascript:admitReservation('R',<%= reservationNo %>);" />
				<% 
					}else if(payStatus.equals("Y")){
				%>
					<input type="button" value="취소/환불신청" onClick="javascript:admitReservation('C',<%= reservationNo %>);" />	
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
<%
	if(periodGubun.equals("period")){
		Vector<ReservationVO> vStayReservation = ReservationDAO.getInstance().selectStayOrderList(startDate,endDate,searchSite,searchUserName,mode,sort);
%>
	<br>
	<ul class="bullet_title"><li>연박이용자(조회기간이전 입실자) - 예약일자기준 조회일때만 보여집니다.</ul>
	<table id="listing_table" class="product_table">
		<col width='10'></col>
		<col width='80'></col>
		<col width='160'></col>
		<col width='130'></col>
		<col width='80'></col>
		<col></col>
		<col width='80'></col>	
		<thead>
	        <tr>
	            <th>No.</th>
	            <th>예약상품명</th>
	            <th>예약자 정보</th>
				<th>예약내용</th>
	            <th>결제금액</th>
	            <th>예약요청사항</th>
	            <th>접수일자<br>(예약상태)</th>
	        </tr>
		</thead>
<%		
		if( vStayReservation == null ){
%>
			<tr>
				<td colspan="7" align="center">
					<br>연박 이용자가 없습니다<br><br>
				</td>
			</tr>
<%	
		}else{
			count = vStayReservation.size();	// 검색된 리스트 총 수 반환
			for( int i=0; i<count; i++ ){
				ReservationVO reservation = vStayReservation.get(i);
				reservationNo = reservation.getReservationNo();
				chooseDate = transFormat.format(reservation.getReservationDate());
				zoneName = reservation.getZoneName();
				productName = reservation.getProductName();
				reserver = reservation.getReserver();
				toddler = reservation.getToddler();
				child = reservation.getChild();
				users = reservation.getUsers();
				totalUser = toddler+child+users;
				nights = reservation.getNights();
				price = reservation.getPrice();
				regDate = transFormat.format(reservation.getRegDate());
				phone = reservation.getPhone1().length()==0?"":reservation.getPhone1()+"-"+reservation.getPhone2()+"-"+reservation.getPhone3();
				cell = reservation.getCell1().length()==0?"":reservation.getCell1()+"-"+reservation.getCell2()+"-"+reservation.getCell3();
				email = reservation.getEmail();
				content = reservation.getMemo();
				adminMemo = reservation.getAdminMemo()==null?"":reservation.getAdminMemo();
				payStatus = reservation.getPayStatus();
				if(payStatus.equals("N")){
					status="예약대기";
				}else if(payStatus.equals("Y")){
					status="예약완료";
				}else if(payStatus.equals("C")){
					status="취소/환불신청";
				}else if(payStatus.equals("R")){
					status="예약취소";
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
				<td style="text-align: left;">
					&nbsp;<%= chooseDate %>&nbsp;(<% if(nights==0){ out.print("picnic"); }else{out.print(nights+"박"+(nights+1)+"일");} %>)<br>
					&nbsp;<%=totalUser%>명&nbsp; (&nbsp;<%= toddler %>&nbsp;/&nbsp;<%= child %>&nbsp;/&nbsp;<%= users %>&nbsp;)</td>
				<td style="text-align: right;"><% out.print(nf.format(price)); %>원&nbsp;<br><%=adminMemo %>&nbsp;</td>
				<td style="text-align: left;">&nbsp;<%= content %></td>
				<td><%= regDate %><br>[<%= status %>]</td>
			</tr>
	<% 		}
		} 
	%>			
		</table>
<%
	}
%>
	<br>
<script type="text/javascript" language="JavaScript">
<!--
document.getElementById('loadingBar').style.display="none";
document.getElementById('divBody').style.display="";
//-->
</script>
	<table width=100% border=0 cellspacing=0 cellpadding=10 align=center>
		<tr>
			<td align=right>
				
			</td>
		</tr>
	</table>
	<br>
<!-- 
	<div style='padding:10 0 16 0;' align=center>
		<img src='/admin/img/reservation/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='button' value='예약승인' class='bt_a32 tmb22' onclick="admitReservation()">
		<img src='/admin/img/reservation/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='button' value='예약취소' class='bt_a32 tmb22' onclick="cancelReservation()">
	</div>
 -->
	<div class="usage_instruction">
		<ul class="desc">
			<li><b class=ol>ㆍ</b>현재 접수된 예약 현황 리스트 입니다</li>
			<li><b class=ol>ㆍ</b>예약상태는 예약대기, 예약완료, 예약취소, 취소/환불신청, 환불완료로 구분됩니다</li>
			<li><b class=ol>ㆍ</b>각 예약건의 예약상태 클릭 시 운영자메모를 남길 수 있습니다.</li>
			<li><b class=ol>ㆍ</b>인원은 유아/아동/일반 순 입니다.</li>
			<li><b class=ol>ㆍ</b>일괄예약취소는 24시간 지난 예약대기 건에 대하여 일괄 취소 처리 됩니다.</li>
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
</div>
</html>