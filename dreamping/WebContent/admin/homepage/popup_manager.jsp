<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="admin.PopupVO" %>
<%@ page import="admin.CommonDAO" %>
<%
request.setCharacterEncoding("UTF-8");
NumberFormat nf = NumberFormat.getInstance();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

String cmd = request.getParameter("cmd")==null?"list":request.getParameter("cmd");
String msg = "";

if(!cmd.equals("list")){
	msg = CommonDAO.getInstance().processPopup(request);	
}
%>
<html>
<head>
<title></title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
<script type="text/javascript" src="/js/popup.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
<script language=javascript>
$(document).ready(
		function() {
			if($("#msg").val().length > 0){
				alert($("#msg").val());
		}
	});	
	
function deleteCheck(layerId)
{
	frm = document.bankinfo;

	if(confirm('팝업을 삭제하시겠습니까?') == true) {
		frm.cmd.value = 'delete';
		frm.layerId.value = layerId;
		frm.submit();
	}
}

function callPopup(layerId){
	var action = "update";
	if(layerId == "NEW"){
		action = "insert";
	}
	var url = "/admin/homepage/popup_form.jsp?action="+action+"&layerId="+layerId;
	url = encodeURI(url);
	popup.openWindowPopup(url, 'popup', {width : '800px', height : '380px'});
}
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
	

<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>팝업관리</li>
	<li class="location">공지/게시관리>홈페이지 관리>팝업관리</li>
</ul>

			<!--본문 내용 시작--------------------------------------------------------->
			<table border=0 cellpadding=0 cellspacing=0 width=800>
				<tr height='20'><td></td></tr>
					</tr>
			</table>

			<table border='0' cellspacing='0' cellpadding='0'>
			<tr>
				<td>
					<table class="product_table" align="center">
					  <form name='bankinfo' method='post' action='/admin/homepage/popup_manager.jsp'>
						<input type='hidden' name='cmd' value=''>
						<input type='hidden' name='layerId' value=''>
						<input type='hidden' name='displayStartDay' value=''>
						<input type='hidden' name='displayEndDay' value=''>
						<input type='hidden' name='useYn' value=''>
						<input type="hidden" id="msg" name="msg" value="<%=msg%>">
						<thead>
						<tr height='28'>
							<th rowspan="2" width='120' align="center">Popup ID<br>[이름]</th>
							<th rowspan="2" width='470' align="center">Source</th>
							<th width='120' align="center">공지기간</th>
							<th rowspan="2" width='60' align="center">선택</th>
						</tr>
						<tr height='28'>
							<th width='60' align="center">사용여부</th>
						</tr>
						</thead>
<%
	String dvsn = "admin";
	Vector<PopupVO> vPopup = CommonDAO.getInstance().selectPopupList(dvsn);
	if (vPopup == null){
%>						
						<tr height='28'>
							<td colspan="4" align="center">등록된 정보가 없습니다.</td>
						</tr>
<%
	}else{
		
		String layerId = "";
		String style = "";
		String imgSrc = "";
		String usemapId = "";
		String area = "";
		String alt = "";
		String useYn = "";
		String displayStartDay = "";
		String displayEndDay = "";
		
		PopupVO popup = null;
		for(int i=0; i<vPopup.size(); i++){
			popup = vPopup.get(i);
			layerId = popup.getLayerId();
			style = popup.getStyle();
			imgSrc = popup.getImgSrc();
			usemapId = popup.getUsemapId();
			area = popup.getArea();
			area = area.replaceAll("<", "");
			area = area.replaceAll("/>", "");
			alt = popup.getAlt();
			useYn = popup.getUseYn();
			displayStartDay = popup.getDisplayStartDay()==null?"":transFormat.format(popup.getDisplayStartDay()); ;
			displayEndDay = popup.getDisplayEndDay()==null?"":transFormat.format(popup.getDisplayEndDay()); 
		
%>						
					<tr>
						<td rowspan="2" width='120' align="center"><%=layerId %><br>[<%=alt %>]</td>
						<td rowspan="2" width="470" align="left">
							div class="<%=layerId%>" id="<%=layerId%>" <br> style="<%=style %>"<br><br>
								img src="<%=imgSrc %>" border="0" usemap="#<%=usemapId%>" <br>alt="<%=alt %>" <br><br>
								map name="<%=usemapId%>" id="<%=usemapId%>"<br>
									<%=area %>
						</td>
						<td width='120' align="center">
							시작: <%=displayStartDay %><br> 
            				종료: <%=displayEndDay %>
						</td>
						<td  rowspan="2" width='60' align="center">
							<input type="button" value="수정" onClick="javascript:callPopup('<%= layerId %>');" /><br><br>
							<input type="button" value="삭제" onClick="javascript:deleteCheck('<%= layerId %>');" />
						</td>
					</tr>
					<tr>
						<td width='60' align="center"><%=useYn %></td>
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
			<div style='width:800' align='center'>
				<input type="button" name="add_submit" onClick="javascript:callPopup('NEW');" value="추가하기" style="cursor:hand">
			</div>
			<table border='3' cellpadding='7' cellspacing='0' width='800' bordercolor='ECD08A' style='margin-top:20'>
				<tr><Td style='color:585858;line-height:180%;padding-left:20'>
						<b>[사용안내]</b><br>
						<b class=ol>ㆍ</b> 메인화면 팝업을 관리하는 페이지 입니다.<br>
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