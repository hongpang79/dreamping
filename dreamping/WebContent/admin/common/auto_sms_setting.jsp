<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.SmsDAO" %>
<%
request.setCharacterEncoding("UTF-8");

String set_mode = request.getParameter("set_mode")==null?"list":request.getParameter("set_mode");
String msg = "";
if("setup".equals(set_mode)){
	msg = SmsDAO.getInstance().updateSMSMassage(request);	
}

String dvsn = "user";
String[] message_customer = SmsDAO.getInstance().getSMSList(dvsn);
dvsn = "admin";
String[] message_admin = SmsDAO.getInstance().getSMSList(dvsn);

%>
<html>
<head>
<title></title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<link rel="stylesheet" type="text/css" href="/admin/css/text_button.css">
</head>

<body bgcolor='#FFFFFF' topmargin='0' leftmargin='0'>
<!-- common Top End //-->
<script language=javascript type="text/JavaScript" src='/admin/js/admin.js'></script>
<script language=javascript src='/admin/js/common.js'></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script language=javascript>
$(document).ready(
	function() {
		if($("#msg").val().length > 0){
			alert($("#msg").val());
	}
});	
</script>

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
<!-- 본문 타이틀------------------------------------------------------------>

<ul class="content_title">
	<li>SMS 발송 메시지 관리</li>
	<li class="location">캠핑장관리>SMS관리>SMS 발송메시지관리</li>
</ul>

<ul class="desc">
	<li style='padding-left:6'>자동 발송할 항목들을 선택하고 그에 해당하는 SMS 문자 메시지를 등록하고 관리하는 곳입니다. <br>
				여기에서 설정한 내용대로 예약자에게 자동으로 메시지가 전송됩니다.<br>
				<font color="red"><b>메세지는 최대 90Bytes까지 전송 가능합니다.</b></font><br>
                <font color="red"><b>변수를 사용하는 경우, 실제 발송 시 메세지 길이를 확인하여 90Bytes 이상인 경우 발송되지 않을 수 있습니다.</b></font><br>
    </li>
</ul>

<table border=1 cellpadding=7 cellspacing=0 width=800 style='border-collapse:collapse' bordercolor='D3D3D3'>
<form name="frmAutoSmsSetup" method="post">
	<input type="hidden" name="set_mode" value="setup"/>
	<input type="hidden" id="msg" name="msg" value="<%=msg%>"/>
	<col width='20%'></col>
	<col width='30%'></col>
	<col width='30%'></col>
	<tr align='center'>
		<td class='tbctr'>자동 발송 선택</td>
		<td class='tbctr'>고객</td>
		<td class='tbctr'>운영자</td>
	</tr>

	<tr>
		<td class='tbctr'>
			예약접수(무통장입금)<br>
		</td>
		<td class='tbcont' align='center'>
			<textarea name="message_customer[]" rows="12" cols="30" style='overflow:hidden;border:1 solid #00BEE7;BACKGROUND:#E7FBFF;font-size:12px;padding:10;line-height:18px' onfocus="this.style.background='#FEE787';" onblur="this.style.background='#E7FBFF'"><%=message_customer[0] %></textarea>
		</td>
		<td class='tbcont' align='center' valign="top">
			<textarea name="message_admin[]" rows="6" cols="30" style='overflow:hidden;border:1 solid #00BEE7;BACKGROUND:#E7FBFF;font-size:12px;padding:10;line-height:18px' onfocus="this.style.background='#FEE787';" onblur="this.style.background='#E7FBFF'"><%=message_admin[0] %></textarea>
		</td>
	</tr>
<!-- 
	<tr>
		<td class='tbctr'>
			입금안내 메시지<br>(무통장입금시)<br>
		</td>
		<td class='tbcont' align='center'>
			<textarea name="message_customer[]" rows="6" cols="30" style='overflow:hidden;border:1 solid #00BEE7;BACKGROUND:#E7FBFF;font-size:12px;padding:10;line-height:18px' onfocus="this.style.background='#FEE787';" onblur="this.style.background='#E7FBFF'"><%=message_customer[1] %></textarea>
		</td>
		<td class='tbcont' align='center'>
		</td>
	</tr>
 -->
 	<input type="hidden" name="message_customer[]" />
 	<input type="hidden" name="message_admin[]" />
	<tr>
		<td class='tbctr'>
			결제완료(무통장입금)<br>
		</td>
		<td class='tbcont' align='center'>
			<textarea name="message_customer[]" rows="6" cols="30" style='overflow:hidden;border:1 solid #00BEE7;BACKGROUND:#E7FBFF;font-size:12px;padding:10;line-height:18px' onfocus="this.style.background='#FEE787';" onblur="this.style.background='#E7FBFF'"><%=message_customer[2] %></textarea>
		</td>
		<td class='tbcont' align='center'>
			<input type="hidden" name="message_admin[]" />
		</td>
	</tr>
	
	<tr>
		<td class='tbctr'>
			예약취소완료<br>
		</td>
		<td class='tbcont' align='center'>
			<textarea name="message_customer[]" rows="6" cols="30" style='overflow:hidden;border:1 solid #00BEE7;BACKGROUND:#E7FBFF;font-size:12px;padding:10;line-height:18px' onfocus="this.style.background='#FEE787';" onblur="this.style.background='#E7FBFF'"><%=message_customer[3] %></textarea>
		</td>
		<<td class='tbcont' align='center'>
			<textarea name="message_admin[]" rows="6" cols="30" style='overflow:hidden;border:1 solid #00BEE7;BACKGROUND:#E7FBFF;font-size:12px;padding:10;line-height:18px' onfocus="this.style.background='#FEE787';" onblur="this.style.background='#E7FBFF'"><%=message_admin[3] %></textarea>
		</td>
	</tr>
	<tr>
		<td class='tbctr'>
			환불완료<br>
		</td>
		<td class='tbcont' align='center'>
			<textarea name="message_customer[]" rows="6" cols="30" style='overflow:hidden;border:1 solid #00BEE7;BACKGROUND:#E7FBFF;font-size:12px;padding:10;line-height:18px' onfocus="this.style.background='#FEE787';" onblur="this.style.background='#E7FBFF'"><%=message_customer[4] %></textarea>
		</td>
		<td class='tbcont' align='center'>
			<textarea name="message_admin[]" rows="6" cols="30" style='overflow:hidden;border:1 solid #00BEE7;BACKGROUND:#E7FBFF;font-size:12px;padding:10;line-height:18px' onfocus="this.style.background='#FEE787';" onblur="this.style.background='#E7FBFF'"><%=message_admin[4] %></textarea>
		</td>
	</tr>
	<tr>
		<td class='tbctr'>
			Q&A등록<br>
		</td>
		<td class='tbcont' align='center'>
		</td>
		<td class='tbcont' align='center'>
			<textarea name="message_admin[]" rows="6" cols="30" style='overflow:hidden;border:1 solid #00BEE7;BACKGROUND:#E7FBFF;font-size:12px;padding:10;line-height:18px' onfocus="this.style.background='#FEE787';" onblur="this.style.background='#E7FBFF'"><%=message_admin[5] %></textarea>
		</td>
	</tr>
</table>

<div style='margin-top:19px;text-align:center'>
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="submit" value="설정하기" class="bt_a32 tmb22">
</div>

<table cellspacing=0 cellpadding=0 border=0>
	<tr style='padding:20 0 2 0' valign=bottom>
		<td><img src='/admin/img/bl_blue.gif'><b>문자메시지에 사용되는 변수명 안내</b></td>
	</tr>
</table>

<ul class='desc'>
	<li style='padding-left:6'>예약 상황 별 메시지의 변수 사용은 해당 메시지 예시에 들어있는 변수 내에서만 사용 가능합니다.
</ul>

<table border=1 cellpadding=7 cellspacing=0 width=800 style='border-collapse:collapse' bordercolor='D3D3D3'>
	<col width='25%'></col>
	<col width='25%'></col>
	<col width='25%'></col>
	<col width='25%'></col>

	<tr align='center'>
		<td class='tbctr'>변수명</td>
		<td class='tbctr'>변수설명</td>
		<td class='tbctr'>출력글자 수 제한</td>
		<td class='tbctr'>예시</td>
	</tr>
	<tr align='center'>
		<td class='tbctr' style="text-align:left;">[DATE]</td>
		<td class='tbcont' style="text-align:left;">예약일자</td>
		<td class='tbcont' style="text-align:left;">(숫자 10자)</td>
		<td class='tbcont' style="text-align:left;">예) 2015-01-01</td>
	</tr>
	<tr align='center'>
		<td class='tbctr' style="text-align:left;">[SITENAME]</td>
		<td class='tbcont' style="text-align:left;">사이트명</td>
		<td class='tbcont' style="text-align:left;">(문자 16자)</td>
		<td class='tbcont' style="text-align:left;">예) 유니온1</td>
	</tr>
	<tr align='center'>
		<td class='tbctr' style="text-align:left;">[RESERVER]</td>
		<td class='tbcont' style="text-align:left;">예약자</td>
		<td class='tbcont' style="text-align:left;">가변</td>
		<td class='tbcont' style="text-align:left;">예) 홍길동</td>
	</tr>
	<tr align='center'>
		<td class='tbctr' style="text-align:left;">[BANK]</td>
		<td class='tbcont' style="text-align:left;">입금은행</td>
		<td class='tbcont' style="text-align:left;">가변</td>
		<td class='tbcont' style="text-align:left;">예) 우리은행</td>
	</tr>
	<tr align='center'>
		<td class='tbctr' style="text-align:left;">[ACCOUNT]</td>
		<td class='tbcont' style="text-align:left;">입금계좌번호</td>
		<td class='tbcont' style="text-align:left;">가변</td>
		<td class='tbcont' style="text-align:left;">예) 1234567890</td>
	</tr>
	<tr align='center'>
		<td class='tbctr' style="text-align:left;">[PRICE]</td>
		<td class='tbcont' style="text-align:left;">예약결제금액</td>
		<td class='tbcont' style="text-align:left;">가변</td>
		<td class='tbcont' style="text-align:left;">예) 256,000원</td>
	</tr>
	<tr align='center'>
		<td class='tbctr' style="text-align:left;">[DEPOSITOR]</td>
		<td class='tbcont' style="text-align:left;">예금주</td>
		<td class='tbcont' style="text-align:left;">가변</td>
		<td class='tbcont' style="text-align:left;">예) 홍길동</td>
	</tr>
	<tr align='center'>
		<td class='tbctr' style="text-align:left;">[DEPOSITDATE]</td>
		<td class='tbcont' style="text-align:left;">입금기한</td>
		<td class='tbcont' style="text-align:left;">(숫자 10자)</td>
		<td class='tbcont' style="text-align:left;">예) 2015-01-01</td>
	</tr>
</table>

<br>

※ 메시지에는 [NAME], [SITENAME] 등의 변수명 등록이 가능하며 변수 값은 길이가 가변적이므로 주의하시기 바랍니다. <Br>
&nbsp;&nbsp;&nbsp;&nbsp;메시지로 보낼 수 있는 최대 글자수는 한글의 경우 1,000자 입니다. 이 길이를 초과한  글자수는 메시지에서 생략될 수 있습니다.<Br>
&nbsp;&nbsp;&nbsp;&nbsp;입력할 메시지의 내용에 따라 각 변수명을 잘 활용하여 메시지를 등록하시기 바랍니다.

<table border='3' cellpadding='7' cellspacing='0' width='800' bordercolor='ECD08A' align=center  style='margin-top:20px'>
	<tr><Td style='color:585858;line-height:180%;padding-left:20'>
			<b>[사용안내]</b><br>
			<b class=ol>ㆍ</b>자동 발송할 항목의 메시지를 변경하실 수 있습니다. 해당 항목의 메시지 창을 클릭하시면 메시지를 변경하실 수 있습니다.<br>
			<b class=ol>ㆍ</b>SMS 문자발송내역 확인은 SMS 발송내역 조회 페이지에서 확인하실 수 있습니다.
		</td>
	</tr>
</form>
</table>

<br/>			
			</td>
		</tr>
	</table>
	
	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->
	
</body>
</html>