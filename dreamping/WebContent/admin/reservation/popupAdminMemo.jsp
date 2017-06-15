<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.ReservationDAO" %>
<%
request.setCharacterEncoding("UTF-8");

String step = request.getParameter("step");
String reservationNo = request.getParameter("reservationNo");
String price = request.getParameter("price");
//System.out.println(request.getParameter("adminMemo"));
String adminMemo = "";
adminMemo = request.getParameter("adminMemo")==null?"":new String(request.getParameter("adminMemo").getBytes("ISO-8859-1"),"UTF-8");

String msg = "";
if(step.equals("save")){
	adminMemo = request.getParameter("adminMemo")==null?"":request.getParameter("adminMemo");
	msg = ReservationDAO.getInstance().updateReservationAdminComment(reservationNo, price, adminMemo);
}
%>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<title>관리자 comment</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<link rel='stylesheet' type='text/css' href='/css/template.css'>
<script>
$(document).ready(
	function() {
		if($("#msg").val().length > 0){
			alert($("#msg").val());
			opener.parent.window.location.reload();
			self.close();
		}
	}
);
</script>
</head>
<body>
<form name="adminMemoForm" action="/admin/reservation/popupAdminMemo.jsp" method="post">
	<input type="hidden" name="step" value="save"/>
	<input type="hidden" name="reservationNo" value="<%=reservationNo %>"/>
	<input type="hidden" id="msg" name="msg" value="<%=msg%>">
	<table class="table1">
		<colgroup>
			<col width="105" />
			<col width="*" />
		</colgroup>
		<tr>
			<td colspan="2"><strong>관리자 comment</strong></td>
		</tr>
		<tr>
			<th><font size="2">결제금액</font></th>
			<td><input type="text" name="price" size="8" value="<%=price%>" /><font size="2"> 원</font></td>
		</tr>
		<tr>
			<th><font size="2">운영자<br/>comment</font></th>
			<td>
				<textarea cols="40" rows="7" name="adminMemo" id="adminMemo" style="padding:10px;"><%=adminMemo %></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<img src="/admin/img/btn_save.gif" onClick="submit();"/>&nbsp;<img src="/admin/img/btn_cancel.gif" onClick="javascript:self.close();"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>