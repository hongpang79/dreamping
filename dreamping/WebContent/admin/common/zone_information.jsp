<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="reservation.SiteVO" %>
<%@ page import="admin.CommonDAO" %>
<%@ page import="admin.ProductDAO" %>
<%
request.setCharacterEncoding("UTF-8");
NumberFormat nf = NumberFormat.getInstance();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

String cmd = request.getParameter("cmd")==null?"list":request.getParameter("cmd");
String msg = "";

if(!cmd.equals("list")){
	msg = CommonDAO.getInstance().processZone(request);	
}
%>
<html>
<head>
<title></title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
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
$(document).ready(
		function() {
			if($("#msg").val().length > 0){
				alert($("#msg").val());
		}
	});	
	

function deleteCheck(zoneNo, orderNo)
{
	frm = document.bankinfo;

	if(confirm('해당 Zone을 삭제하시겠습니까?') == true) {
		frm.cmd.value = 'delete';
		frm.zoneNo.value = zoneNo;
		frm.orderNo.value = orderNo;
		frm.submit();
	}
}
function formCheck()
{
		var sform = document.addform;
		
		
		if(sform.zoneName.value.length == 0)
		{
			alert('ZONE NAME을 입력하세요.');
			sform.siteName.focus();
			return false;
		}
		
		if(sform.orderNo.value.length == 0)
		{
			alert('정렬순서를 입력하세요.');
			sform.orderNo.focus();
			return false;
		}

		
}

function numnberCheck()
{


	if(event.keyCode == 109 || event.keyCode == 189)
	{
		return true;
	}
	else{
		var inp=String.fromCharCode(event.keyCode);
		if (isNaN(inp)) {
			if((event.keyCode < 96 || event.keyCode > 105) ) {
				//event.keyCode 8 => Back Space , 37 = (<-방향키) ,  39 = (->방향키)
				// [CS , TFT , YongHun Jeong , 2009-12-08]
				if( (event.keyCode !=8) && (event.keyCode !=37) && (event.keyCode !=39) ) {
					alert("숫자 또는 '-'만  입력해주세요!");
						event.returnValue=false;
				}
			}
		}
		else{
			return true;
		}
	}
}

function editZone(zoneNo,zoneName,orderNo,useStartDay,useEndDay)
{
	var f = document.addform;

	document.addform.cmd.value = 'edit';
	document.getElementsByName( 'zoneNoOrg' )[0].value = zoneNo;
	document.getElementsByName( 'zoneName' )[0].value = zoneName;
	document.getElementsByName( 'orderNoOrg' )[0].value = orderNo;
	document.getElementsByName( 'useStartDay' )[0].value = useStartDay;
	document.getElementsByName( 'useEndDay' )[0].value = useEndDay;
	document.getElementsByName( 'orgZoneName' )[0].value = zoneName;
}

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
<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>ZONE 설정</li>
	<li class="location">캠핑장관리>캠핑장정보>ZONE설정</li>
</ul>

			<!--본문 내용 시작--------------------------------------------------------->
			<table border=0 cellpadding=0 cellspacing=0 width=800>
				<tr height='20'><td></td></tr>
					</tr>
			</table>

			<table border='0' cellspacing='0' cellpadding='0'>
			<tr>
				<td>
					<form name='bankinfo' method='post' action='/admin/common/zone_information.jsp'>
						<input type='hidden' name='cmd' value=''>
						<input type='hidden' name='zoneNo' value=''>
						<input type='hidden' name='orderNo' value=''>
						<input type="hidden" id="msg" name="msg" value="<%=msg%>">
					<table id="listing_table" class="product_table">
						<thead>
						<tr height='28'>
							<th width='250' align="center">ZONE</th>
							<th width='80' align="center">정렬순서</th>
							<th align="center">사용시작일자</th>
							<th align="center">사용종료일자</th>
							<th width='150' align="center">선택</th>
						</tr>
						</thead>
<%
	Vector<SiteVO> vZone = ProductDAO.getInstance().selectZoneList();
	if (vZone == null){
%>						
						<tr height='28'>
							<td colspan="3" align="center">등록된 정보가 없습니다.</td>
						</tr>
<%
	}else{
		int zoneNo = 0;
		String zoneName = "";
		int orderNo = 0;
		String useStartDay = "";
		String useEndDay = "";
		
		SiteVO zone = null;
		for(int i=0; i<vZone.size(); i++){
			zone = vZone.get(i);
			zoneNo = zone.getZoneNo();
			zoneName = zone.getZoneName();
			orderNo = zone.getOrderNo();
			useStartDay = transFormat.format(zone.getUseStartDay());
			useEndDay = transFormat.format(zone.getUseEndDay());
			
%>						
					<tr height='28'>
						<td width='250' align="center"><%=zoneName %></td>
						<td width='80' align="center"><%=orderNo %></td>
						<td align="center"><%=useStartDay %></td>
						<td align="center"><%=useEndDay %></td>
						<td width='150' align="center">
							<a href="javascript:;" onclick="editZone('<%=zoneNo %>','<%=zoneName %>',<%=orderNo %>,'<%=useStartDay %>','<%=useEndDay %>')">수정</a>
							<a href="javascript:;" onclick="javascript:deleteCheck('<%=zoneNo %>','<%=orderNo%>')">삭제</a>
						</td>
					</tr>
<%
		}
	}
%>					
					</table>
					<br>
					</form>
				</td>
			</tr>
			</table>
			<!--무통장입금 계좌 입력-->
			<div id='add' style='display:block'>
			<table border='0' cellspacing='0' cellpadding='0'>
			<tr>
				<td>
					<table border='1' cellpadding='0' cellspacing='0' width='800' style='border-collapse:collapse' bordercolor='cccccc'>
					<form name='addform' method='post' action='/admin/common/zone_information.jsp' onSubmit='return formCheck()'>
					<input type='hidden' name='cmd' value='insert'>
					<input type='hidden' id='zoneNoOrg' name='zoneNoOrg'>
					<input type='hidden' id='orgZoneName' name='orgZoneName'>
						<tr height='28'>
							<td class='tbsbj' width='140'>ZONE NAME</td>
							<td class='tbcont'>
                                <input type='text' id='zoneName' size='30' name='zoneName' value="" >
							</td>
							<td class='tbsbj'>정렬 순서</td>
							<td height='28' class='tbcont'>
								<input type='text' id='orderNoOrg' size='10' name='orderNoOrg' value="" onkeyDown="javascript:numnberCheck()">
							</td>
						</tr>
						<tr height='28'>
							<td class='tbsbj' width='140'>사용기간</td>
							<td class='tbcont' colspan="3">
								<input type="text" id="datepicker1" name="useStartDay" size="12" value="" /> ~
								<input type="text" id="datepicker2" name="useEndDay" size="12" value="" /> 
							</td>
						</tr>
					</table>
					<br>
					<div style='width:800' align='center'>
						<input type="submit" name="add_submit" value="저장하기" style="cursor:hand">
					</div>

					</form>
				</td>
			</tr>
			</table>
			</div>

			<table border='3' cellpadding='7' cellspacing='0' width='800' bordercolor='ECD08A' style='margin-top:20'>
				<tr><Td style='color:585858;line-height:180%;padding-left:20'>
						<b>[사용안내]</b><br>
						<b class=ol>ㆍ</b> 등록하고자 하는 ZONE NAME을 입력 후 정렬순서를 입력 해 주십시오.<br>
						<b class=ol>ㆍ</b> 정렬순서에 따라 예약화면에 순서대로 표시됩니다.<br>
						<b class=ol>ㆍ</b> 사용기간은 년도와 월까지만 적용되며 일자는 무시됩니다.(월단위로 기간이 등록된다고 생각하시면 됩니다.)
				    </td>
				</tr>
			</table>

			<table border=0 cellpadding=0 cellspacing=0>
				<tr><td height=50></td></tr>
			</table>


			<!--본문 끝---------------------------------------------------------------------------------------->

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
