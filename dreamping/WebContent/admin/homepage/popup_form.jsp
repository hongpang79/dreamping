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
String action = request.getParameter("action")==null?"insert":request.getParameter("action");
String layerId = request.getParameter("layerId")==null?"layer_pop":request.getParameter("layerId");
String msg = "";

PopupVO popup = null;
String style = "";
String imgSrc = "";
String usemapId = "";
String area = "";
String alt = "";
String useYn = "";
String displayStartDay = "";
String displayEndDay = "";	

if(cmd.equals("list")&&action.equals("update")){
	popup = CommonDAO.getInstance().getPopup(layerId);
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
}else{
	if(!cmd.equals("list")){
		msg = CommonDAO.getInstance().processPopup(request);
	}
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
<script language=javascript>
$(document).ready(
		function() {
			if($("#msg").val().length > 0){
				alert($("#msg").val());
				opener.parent.window.location.reload();
				self.close();
		}
	});	

$(function() {
	  $( "#datepicker3, #datepicker4").datepicker({
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
	

function formCheck()
{
	var sform = document.addform;
	
	if(sform.layerId.value.length == 0)
	{
		alert('Popup ID를 입력하세요.');
		sform.layerId.focus();
		return false;
	}

	if(sform.alt.value.length == 0)
	{
		alert('설명을 입력하세요.');
		sform.alt.focus();
		return false;
	}

	if(sform.style.value.length == 0)
	{
		alert('style을 입력하세요.');
		sform.style.focus();
		return false;
	}
	
	if(sform.usemapId.value.length == 0)
	{
		alert('Usemap ID를 입력하세요.');
		sform.usemapId.focus();
		return false;
	}
	
	if(sform.area.value.length == 0)
	{
		alert('area를 입력하세요.');
		sform.area.focus();
		return false;
	}
	
	if(sform.displayStartDay.value.length == 0)
	{
		alert('시작일자 입력하세요.');
		sform.displayStartDay.focus();
		return false;
	}
	
	if(sform.displayEndDay.value.length == 0)
	{
		alert('종료일자 입력하세요.');
		sform.displayEndDay.focus();
		return false;
	}
	
	if(confirm('저장하시겠습니까?') == true) {
		frm.submit();
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
<body bgcolor='#FFFFFF' topmargin='0' leftmargin='0'>
	<!--본문 내용 시작--------------------------------------------------------->
	<table border='0' cellspacing='0' cellpadding='0' >
	<tr height='56'>
		<td style="padding:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>■ 팝업 추가/수정</strong></td>
	</tr>
	<tr>
		<td align="center">
			<table border='1' cellpadding='0' cellspacing='0' width='740' style='border-collapse:collapse' bordercolor='cccccc'>
				<form name='addform' method='post' action='/admin/homepage/popup_form.jsp' onSubmit='return formCheck()'>
					<input type='hidden' name='cmd' value='<%=action%>'/>
					<input type='hidden' name='action' value='<%=action%>'/>
					<input type='hidden' name='msg' id='msg' value="<%=msg %>"/>
				<tr height='28'>
					<td class='tbsbj' width='100'>Popup ID</td>
					<td class='tbcont'><input type='text' id='layerId' size='20' maxlength='20' name='layerId' value="<%=layerId %>"></td>
					<td class='tbsbj'>Popup명</td>
					<td class='tbcont'><input type='text' id='alt' size='30' name='alt' value="<%=alt %>"></td>
				</tr>
				<tr height='28'>
					<td class='tbsbj'>이미지</td>
					<td colspan="3" height='28' class='tbcont'>
						<input title="input" type='text' id='imgSrc' name="imgSrc" style="border:1px solid #EAEAEA;height:20px;" maxlength="50" size="50" value="<%=imgSrc%>"/>
							<a href="javascript:WinOpen('/admin/homepage/popupFileUploader.jsp?target=imgSrc','file_upload','384','270','false')"><img src="/admin/img/common/file_upload.gif"/></a>
					</td>
				</tr>
				<tr height='28'>
					<td class='tbsbj'>스타일</td>
					<td colspan="3" height='28' class='tbcont'>
						<input type='text' id='style' size='87' name='style' value="<%=style %>">
					</td>
				</tr>
				<tr height='28'>
					<td class='tbsbj' width='100'>Usemap ID</td>
					<td colspan="3" height='28' class='tbcont'>
						<input type='text' id='usemapId' size='20' maxlength='20' name='usemapId' value="<%=usemapId%>">
					</td>
				</tr>
				<tr height='28'>
					<td class='tbsbj'>area</td>
					<td colspan="3" height='28' class='tbcont'>
						<textarea cols="70" rows="5" id='area' name='area' style="padding:10px;"><%=area %></textarea>
					</td>
				</tr>
				<tr height='28'>
					<td class='tbsbj' width='100'>사용여부</td>
					<td class='tbcont'>
						<input type="radio" name="useYn" value="Y" <% if(useYn.equals("Y")){ %> checked <%} %>/>Yes
						<input type="radio" name="useYn" value="N" <% if(useYn.equals("N")){ %> checked <%} %>/>No
					</td>
					<td class='tbsbj'>공지기간</td>
					<td class='tbcont'>
						<input type="text" id="datepicker3" name="displayStartDay" size="12" value="<%=displayStartDay %>" /> ~ 
          				<input type="text" id="datepicker4" name="displayEndDay" size="12" value="<%=displayEndDay %>" />
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
</body>
</html>