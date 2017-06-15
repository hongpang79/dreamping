<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="admin.SmsDAO" %>
<%
request.setCharacterEncoding("UTF-8");
NumberFormat nf = NumberFormat.getInstance();

String cmd = request.getParameter("cmd")==null?"list":request.getParameter("cmd");
String msg = "";

if(!cmd.equals("list")){
	msg = SmsDAO.getInstance().processSmsUser(request);	
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
	

function deleteCheck(phoneNumber)
{
	frm = document.smsUserInfo;

	if(confirm('해당 휴대전화번호를 삭제하시겠습니까?') == true) {
		frm.cmd.value = 'delete';
		frm.phoneNumber.value = phoneNumber;
		frm.submit();
	}
}
function formCheck()
{
		var sform = document.addform;
		
		
		if(sform.name.value.length == 0)
		{
			alert('이름을 입력하세요.');
			sform.name.focus();
			return false;
		}
		
		if(sform.phoneNumber.value.length == 0)
		{
			alert('휴대전화번호를 입력하세요.');
			sform.phoneNumber.focus();
			return false;
		}
		
		if(sform.dvsn.value.length == 0)
		{
			alert('등급을 입력하세요.');
			sform.dvsn.focus();
			return false;
		}
		
		if(sform.desc.value.length == 0)
		{
			alert('설명을 입력하세요.');
			sform.desc.focus();
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
	<li>SMS수신자설정</li>
	<li class="location">캠핑장관리>SMS관리>SMS수신자설정</li>
</ul>

			<!--본문 내용 시작--------------------------------------------------------->
			<table border=0 cellpadding=0 cellspacing=0 width=800>
				<tr height='20'><td></td></tr>
					</tr>
			</table>

			<table border='0' cellspacing='0' cellpadding='0'>
			<tr>
				<td>
					<form name='smsUserInfo' method='post' action='/admin/common/sms_user_setting.jsp'>
						<input type='hidden' name='cmd' value=''>
						<input type='hidden' name='phoneNumber' value=''>
						<input type="hidden" id="msg" name="msg" value="<%=msg%>">
					<table id="listing_table" class="product_table">
						<thead>
						<tr height='28'>
							<th width='150' align="center">이름</th>
							<th width='180' align="center">휴대전화번호</th>
							<th width='120' align="center">등급</th>
							<th width='250' align="center">설명</th>
							<th width='100' align="center">선택</th>
						</tr>
						</thead>
<%
	List<Map<String,String>> smsUser = SmsDAO.getInstance().getSMSUser();
	if (smsUser == null){
%>						
						<tr height='28'>
							<td colspan="5" align="center">등록된 정보가 없습니다.</td>
						</tr>
<%
	}else{
		String name = "";
		String phoneNumber = "";
		String dvsn = "";
		String desc = "";
		
		Map<String,String> user = null;
		for(int i=0; i<smsUser.size(); i++){
			user = smsUser.get(i);
			name = user.get("name");
			phoneNumber = user.get("phoneNumber");
			dvsn = user.get("dvsn");
			desc = user.get("desc");
			
%>						
					<tr height='28'>
						<td width='150' align="center"><%=name %></td>
						<td width='180' align="center"><%=phoneNumber %></td>
						<td width='120' align="center"><%=dvsn %></td>
						<td width='250' align="left"><%=desc %></td>
						<td width='100' align="center">
							<a href="javascript:;" onclick="javascript:deleteCheck('<%=phoneNumber %>')">삭제</a>
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
					<form name='addform' method='post' action='/admin/common/sms_user_setting.jsp' onSubmit='return formCheck()'>
					<input type='hidden' name='cmd' value='insert'>
						<tr height='28'>
							<td class='tbsbj'>이름</td>
							<td class='tbcont'>
                                <input type='text' id='name' size='10' name='name' value="" >
							</td>
							<td class='tbsbj'>휴대전화번호</td>
							<td height='28' class='tbcont'>
								<input type='text' id='phoneNumber' size='18' name='phoneNumber' value="" onkeyDown="javascript:numnberCheck()">
							</td>
							<td class='tbsbj'>등급</td>
							<td height='28' class='tbcont'>
								<input type='text' id='dvsn' size='10' name='dvsn' value="">
							</td>
							<td class='tbsbj'>설명</td>
							<td height='28' class='tbcont'>
								<input type='text' id='desc' size='40' name='desc' value="">
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
						<b class=ol>ㆍ</b> 등록하고자 하는 이름,전화번호,설명을 입력 해 주십시오.<br>
						<b class=ol>ㆍ</b> 등급은 관리자가 임의로 입력하면 됩니다.
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
