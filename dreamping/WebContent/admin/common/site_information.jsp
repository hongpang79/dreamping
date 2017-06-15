<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="reservation.SiteVO" %>
<%@ page import="admin.CommonDAO" %>
<%@ page import="admin.ProductDAO" %>
<%
request.setCharacterEncoding("UTF-8");
NumberFormat nf = NumberFormat.getInstance();

String cmd = request.getParameter("cmd")==null?"list":request.getParameter("cmd");
String msg = "";

Vector<SiteVO> zoneList = ProductDAO.getInstance().selectZoneList();

if(!cmd.equals("list")){
	msg = CommonDAO.getInstance().processSite(request);	
}
%>
<html>
<head>
<title></title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
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
	

function deleteCheck(siteNo)
{
	frm = document.bankinfo;

	if(confirm('해당 SITE를 삭제하시겠습니까?') == true) {
		frm.cmd.value = 'delete';
		frm.siteNo.value = siteNo;
		frm.submit();
	}
}
function formCheck()
{
		var sform = document.addform;
		
		if(sform.zoneNo.value.length == 0)
		{
			alert('Zone을 선택하세요.');
			sform.zoneNo.focus();
			return false;
		}

		
		if(sform.siteName.value.length == 0)
		{
			alert('SITE NAME을 입력하세요.');
			sform.siteName.focus();
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

</script>
<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>SITE 설정</li>
	<li class="location">캠핑장관리>캠핑장정보>SITE설정</li>
</ul>

			<!--본문 내용 시작--------------------------------------------------------->
			<table border=0 cellpadding=0 cellspacing=0 width=800>
				<tr height='20'><td></td></tr>
					</tr>
			</table>

			<table border='0' cellspacing='0' cellpadding='0'>
			<tr>
				<td>
					<form name='bankinfo' method='post' action='/admin/common/site_information.jsp'>
						<input type='hidden' name='cmd' value=''>
						<input type='hidden' name='siteNo' value=''>
						<input type="hidden" id="msg" name="msg" value="<%=msg%>">
					<table id="listing_table" class="product_table">
						<thead>
						<tr height='28'>
							<th width='200' align="center">ZONE</th>
							<th width='250' align="center">SITE</th>
							<th width='150' align="center">선택</th>
						</tr>
						</thead>
<%
	Vector<SiteVO> vSite = CommonDAO.getInstance().selectSiteList();
	if (vSite == null){
%>						
						<tr height='28'>
							<td colspan="3" align="center">등록된 정보가 없습니다.</td>
						</tr>
<%
	}else{
		int zoneNo = 0;
		String zoneName = "";
		int siteNo = 0;
		String siteName = "";
		
		SiteVO site = null;
		for(int i=0; i<vSite.size(); i++){
			site = vSite.get(i);
			zoneNo = site.getZoneNo();
			zoneName = site.getZoneName();
			siteNo = site.getSiteNo();
			siteName = site.getSiteName();
		
%>						
					<tr height='28'>
						<td width='200' align="center"><%=zoneName %></td>
						<td width='250' align="center"><%=siteName %></td>
						<td width='150' align="center">
							<a href="javascript:;" onclick="javascript:deleteCheck(<%=siteNo %>)">삭제</a>
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
					<form name='addform' method='post' action='/admin/common/site_information.jsp' onSubmit='return formCheck()'>
					<input type='hidden' name='cmd' value='insert'>
						<tr height='28'>
							<td class='tbsbj' width='140'>ZONE</td>
							<td class='tbcont'>
                                <div style="float:left">
								<select class='txt' name='zoneNo'>
								<option value=''>----------------------</option>
<%
								int vZoneNo = 0;
								String vZoneName = "";
								for(int x=0; x<zoneList.size(); x++){
									vZoneNo = zoneList.get(x).getZoneNo();
									vZoneName = zoneList.get(x).getZoneName();
%>
									<option value='<%=vZoneNo %>'><%=vZoneName %></option>
<%
								}
%>																	
								</select>
                                </div>
							</td>
							<td class='tbsbj'>SITE NAME</td>
							<td height='28' class='tbcont'>
								<input type='text' id='siteName' size='30' name='siteName' value="" >
							</td>
						</tr>
					</table>
					<br>
					<div style='width:800' align='center'>
						<input type="submit" name="add_submit" value="추가하기" style="cursor:hand">
					</div>

					</form>
				</td>
			</tr>
			</table>
			</div>

			<table border='3' cellpadding='7' cellspacing='0' width='800' bordercolor='ECD08A' style='margin-top:20'>
				<tr><Td style='color:585858;line-height:180%;padding-left:20'>
						<b>[사용안내]</b><br>
						<b class=ol>ㆍ</b> 등록하고자 하는 ZONE을 선택 하신 후 SITE명을 입력 해 주십시오.
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
