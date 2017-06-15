<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Vector" %>
<%@ page import="reservation.SiteVO" %>
<%@ page import="admin.ProductDAO" %>
<%@ page import="admin.ReservationDAO" %>
<%
request.setCharacterEncoding("UTF-8");
NumberFormat nf = NumberFormat.getInstance();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

String step = request.getParameter("step")==null?"select":request.getParameter("step");
//String sProductNo = request.getParameter("productNo")==null?"0":request.getParameter("productNo");
String sProductNos = request.getParameter("productNos")==null?"0":request.getParameter("productNos");

int productNo = 0;

String productNames = "";

SiteVO product = new SiteVO();

int rtn = 0;
String msg = "";
if(step.equals("select")){
	productNames = ProductDAO.getInstance().selectProductList(sProductNos);	 
}else{
	rtn = ReservationDAO.getInstance().insertGroupReservation(request);
	
	if(rtn == 0){
		msg = "저장에 실패했습니다. 관리자에게 문의해주세요!";

	}else{
		msg = "저장되었습니다.";
		
	}
	
}
%>
<html>
<head>
<title>UrbanSlowCity Admin</title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
<script language=javascript>
$(document).ready(
	function() {
		if($("#msg").val().length > 0){
			alert($("#msg").val());
			if($("#rtn").val() == 0){
				history.go(-1);
			}else{
				opener.parent.window.location="/admin/reservation/reservation_order_list.jsp";
				self.close();
			}
		}
		
	}
);
	
$(function() {
	  $( "#datepicker1" ).datepicker({
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
<script type="text/javascript" src="/admin/js/reservation_product.js"></script>
<script type="text/javascript" src="/admin/js/calendar.js"></script>
<script type="text/javascript">
	function checkTextArea( e )
	{
		if( !e ) return;
		var srcE = e.target ? e.target : e.srcElement;
		if( !srcE ) return;
		if( !srcE.value ) return;

		if( srcE.value.length >= 300 )
		{
			alert( '300Byte이상은 입력하실 수 없습니다' );
			srcE.value = srcE.value.substring( 0 , 300 );
		}
	}

	function submitGroupReservation()
	{
		var f = document.groupReservationForm;
		
		if(f.chooseDate.value.length == 0){
			alert("이용일자를 입력하세요!");
			f.chooseDate.focus();
			return false;
		}
		
		if(f.nights.value.length == 0){
			alert("이용기간을 선택하세요!");
			f.nights.focus();
			return false;
		}
		
		if(f.users.value.length == 0){
			alert("예약인원을 입력하세요!");
			f.users.focus();
			return false;
		}
		
		if(f.price.value.length == 0){
			alert("예약금액을 입력하세요!");
			f.price.focus();
			return false;
		}
		
		if(f.reserver.value.length == 0){
			alert("예약자명을 입력하세요!");
			f.reserver.focus();
			return false;
		}
				
		f.submit();
	}


</script>

<style type="text/css">@import url(/admin/css/calendar.css);</style>

<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>단체 예약</li>
</ul>

<!--본문---------------------------------------------------------------------->
<form id="groupReservationForm" name="groupReservationForm" method="post">
	<input type="hidden" id="step" name="step" value="update"/>
	<input type="hidden" id="productNos" name="productNos" value="<%=sProductNos %>"/>
	<input type="hidden" id="rtn" name="rtn" value="<%=rtn%>"/>
	<input type="hidden" id="msg" name="msg" value="<%=msg%>"/>
	<center>
	<table class="product_table">
	<col bgcolor="#F6F6F6" width="18%"></col><col width="32%"></col><col bgcolor="#F6F6F6" width="18%"></col><col width="32%"></col>
		<tr>
			<th>상품명</th>
			<td height="36" colspan="3"><%=productNames%></td>
		</tr>
		<tr>
			<th>이용일자*</th>
			<td><input type="text" id="datepicker1" name="chooseDate" size="12" value="" required/></td>
			<th>이용기간*</th>
			<td>
				<select id="nights" name="nights" required>
					<option value=''>-- SELECT --</option>																			
					<% 
					   for(int i=1; i<10 ; i++){ %>
						<option value="<%= i %>" /><% out.print(i); out.print("박 "); out.print(i+1); out.print("일 ");%>
					<% } %>
				</select>
			</td>
		</tr>
		<tr>
			<th>예약인원*</th>
			<td><input type="text" id="users" name="users" size="6" style="text-align:right;padding-right:1px;" value="" required> 명</td>
			<th>예약금액*</th>
			<td><input type="text" id="price" name="price" size="18" style="text-align:right;padding-right:1px;" value="" required> 원</td>
		</tr>
		<tr>
			<th>예약자명*</th>
			<td><input type="text" id="reserver" name="reserver" size="17" value="" required></td>
			<th>이메일</th>
			<td><input type="text" id="email" name="email" size="36" value=""></td>
		</tr>
		<tr>
			<th>연락처</th>
			<td><input type="text" id="phone1" name="phone1" size="4" maxlength="3" value="">-<input type="text" id="phone2" name="phone2" size="4" maxlength="4" value="">-<input type="text" id="phone3" name="phone3" size="4" maxlength="4" value=""></td>
			<th>비상연락처</th>
			<td><input type="text" id="cell1" name="cell1" size="4" maxlength="3" value="">-<input type="text" id="cell2" name="cell2" size="4" maxlength="4" value="">-<input type="text" id="cell3" name="cell3" size="4" maxlength="4" value=""></td>
		</tr>
		<tr>
			<th>요청사항</th>
			<td colspan="3"><textarea cols="70" rows="12" name="content" id="content" style="padding:10px;"></textarea></td> 
		</tr>
	</table>
	</center>
</form>
<center>
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="저장하기" class="bt_a32 tmb22" onclick="submitGroupReservation()">
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="취소하기" class="bt_a32 tmb22" onclick="javascript:self.close();">
</center>
<!--본문 끝---------------------------------------------------------------------------------------->
</body>
</html>