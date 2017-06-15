<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Vector" %>
<%@ page import="reservation.SiteVO" %>
<%@ page import="admin.ProductDAO" %>
<%@ page import="reservation.Reservation" %>
<%
request.setCharacterEncoding("UTF-8");
NumberFormat nf = NumberFormat.getInstance();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

String step = request.getParameter("step")==null?"select":request.getParameter("step");
String sProductNo = request.getParameter("productNo")==null?"0":request.getParameter("productNo");
String sProductNos = request.getParameter("productNos")==null?"0":request.getParameter("productNos");

int productNo = 0;

String productNames = "";

SiteVO product = new SiteVO();
int users = 0;
int maxUsers = 0;
int addChildPrice = 0;
int addUserPrice = 0;
int lowSeasonWeekday = 0;
int lowSeasonWeekend = 0;
int lowSeasonPicnic = 0;
int middleSeasonWeekday = 0;
int middleSeasonWeekend = 0;
int middleSeasonPicnic = 0;
int highSeasonWeekday = 0;
int highSeasonWeekend = 0;
int highSeasonPicnic = 0;
String displayStartDay = "";
String displayEndDay = "";
String useYn = "Y";
int sale = 0;
String saleStartDay = "";
String saleEndDay = "";
String saleMemo = "";
int flatPrice = 0;
String flatPriceStartDay = "";
String flatPriceEndDay = "";
String productMemo = "";
String msg = "";
int rtn = 0;
if(step.equals("select")){
	productNames = ProductDAO.getInstance().selectProductList(sProductNos);
	
	productNo = Integer.parseInt(sProductNo);
	product = ProductDAO.getInstance().getProduct(productNo);
	
	users = product.getUsers();
	maxUsers = product.getMaxUsers();
	addChildPrice = product.getAddChildPrice();
	addUserPrice = product.getAddUserPrice();
	lowSeasonWeekday = product.getLowSeasonWeekday();
	lowSeasonWeekend = product.getLowSeasonWeekend();
	lowSeasonPicnic = product.getLowSeasonPicnic();
	middleSeasonWeekday = product.getMiddleSeasonWeekday();
	middleSeasonWeekend = product.getMiddleSeasonWeekend();
	middleSeasonPicnic = product.getMiddleSeasonPicnic();
	highSeasonWeekday = product.getHighSeasonWeekday();
	highSeasonWeekend = product.getHighSeasonWeekend();
	highSeasonPicnic = product.getHighSeasonPicnic();
	displayStartDay = product.getDisplayStartDay()==null?"":transFormat.format(product.getDisplayStartDay());
	displayEndDay = product.getDisplayEndDay()==null?"":transFormat.format(product.getDisplayEndDay());
	useYn = product.getUseYn()==null?"Y":product.getUseYn();
	sale = product.getSale();
	saleStartDay =product.getSaleStartDay()==null?"":transFormat.format(product.getSaleStartDay());
	saleEndDay = product.getSaleEndDay()==null?"":transFormat.format(product.getSaleEndDay());
	saleMemo = product.getSaleMemo();
	flatPrice = product.getFlatPrice();
	flatPriceStartDay = product.getFlatPriceStartDay()==null?"":transFormat.format(product.getFlatPriceStartDay());;
	flatPriceEndDay = product.getFlatPriceEndDay()==null?"":transFormat.format(product.getFlatPriceEndDay());;
	productMemo = product.getProductMemo();
	 
}else{
	System.out.println(request.getParameter("productNos"));
	rtn = ProductDAO.getInstance().modifyProducts(request);
	
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
				opener.parent.window.location.reload();
				self.close();
			}
		}
		
	}
);
	
$(function() {
	  $( "#datepicker1, #datepicker2, #datepicker3, #datepicker4, #datepicker5, #datepicker6" ).datepicker({
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

	function submitProductModify()
	{
		var f = document.productModifyForm;
		
		f.submit();
	}


</script>

<style type="text/css">@import url(/admin/css/calendar.css);</style>

<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>상품 일괄 수정</li>
</ul>

<!--본문---------------------------------------------------------------------->
<form id="productModifyForm" name="productModifyForm" method="post">
	<input type="hidden" id="step" name="step" value="update"/>
	<input type="hidden" id="productNos" name="productNos" value="<%=sProductNo %>"/>
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
			<th>기준 인원</th>
			<td><input type="text" id="users" name="users" size="6" style="text-align:right;padding-right:1px;" value="<%=users%>"> 명</td>
			<th>최대 인원</th>
			<td><input type="text" id="maxUsers" name="maxUsers" size="6" style="text-align:right;padding-right:1px;" value="<%=maxUsers%>"> 명</td>
		</tr>
	
		<tr>
			<th>초과 1인당<br> 추가요금(아동)</th>
			<td><input type="text" id="addChildPrice" name="addChildPrice" size="18" style="text-align:right;padding-right:1px;" value="<%=addChildPrice%>"> 원</td>
			<th>초과 1인당<br> 추가요금(일반)</th>
			<td><input type="text" id="addUserPrice" name="addUserPrice" size="18" style="text-align:right;padding-right:1px;" value="<%=addUserPrice%>"> 원</td>
		</tr>
	
		<tr>
			<th>비수기 요금</th>
			<td colspan="3">
	            주중 <input type="text" id="lowSeasonWeekday" name="lowSeasonWeekday" size="18" style="text-align:right;padding-right:1px;" value="<%=lowSeasonWeekday%>"> 원 &nbsp;&nbsp;&nbsp;
	            주말 <input type="text" id="lowSeasonWeekend" name="lowSeasonWeekend" size="18" style="text-align:right;padding-right:1px;" value="<%=lowSeasonWeekend%>"> 원 &nbsp;&nbsp;&nbsp;
	            피크닉 <input type="text" id="lowSeasonPicnic" name="lowSeasonPicnic" size="18" style="text-align:right;padding-right:1px;" value="<%=lowSeasonPicnic%>"> 원
	        </td>
	    </tr>
	    <tr>
	        <th>준성수기 요금</th>
	        <td colspan="3">
	            주중 <input type="text" id="middleSeasonWeekday" name="middleSeasonWeekday" size="18" style="text-align:right;padding-right:1px;" value="<%=middleSeasonWeekday%>"> 원 &nbsp;&nbsp;&nbsp;
	            주말 <input type="text" id="middleSeasonWeekend" name="middleSeasonWeekend" size="18" style="text-align:right;padding-right:1px;" value="<%=middleSeasonWeekend%>"> 원 &nbsp;&nbsp;&nbsp;
	            피크닉 <input type="text" id="middleSeasonPicnic" name="middleSeasonPicnic" size="18" style="text-align:right;padding-right:1px;" value="<%=middleSeasonPicnic%>"> 원
	        </td>
		</tr>
	    <tr>
	        <th>성수기 요금</th>
	        <td colspan="3">
	            주중 <input type="text" id="highSeasonWeekday" name="highSeasonWeekday" size="18" style="text-align:right;padding-right:1px;" value="<%=highSeasonWeekday%>"> 원 &nbsp;&nbsp;&nbsp;
	            주말 <input type="text" id="highSeasonWeekend" name="highSeasonWeekend" size="18" style="text-align:right;padding-right:1px;" value="<%=highSeasonWeekend%>"> 원 &nbsp;&nbsp;&nbsp;
	            피크닉 <input type="text" id="highSeasonPicnic" name="highSeasonPicnic" size="18" style="text-align:right;padding-right:1px;" value="<%=highSeasonPicnic%>"> 원
	        </td>
		</tr>
		<tr>
			<th>상품진열기간</th>
			<td><input type="text" id="datepicker1" name="displayStartDay" size="12" value="<%=displayStartDay%>" /> ~ 
	            <input type="text" id="datepicker2" name="displayEndDay" size="12" value="<%=displayEndDay%>" /></td>
			<th>상품진열여부</th>
			<td><input type="radio" name="useYn" value="Y" <% if(useYn.equals("Y")){ %> checked <%} %>/>진열
				<input type="radio" name="useYn" value="N" <% if(useYn.equals("N")){ %> checked <%} %>/>진열안함</td>
		</tr>
		<tr>
			<th>균일가</th>
			<td><input type="text" name="flatPrice" size="18" style="text-align:right;padding-right:1px;" value="<%=flatPrice %>"> 원</td>
			<th>균일가기간</th>
			<td><input type="text" id="datepicker5" name="flatPriceStartDay" size="12" value="<%=flatPriceStartDay %>" /> ~
				<input type="text" id="datepicker6" name="flatPriceEndDay" size="12" value="<%=flatPriceEndDay %>" /></td>
		</tr>
		<tr>
			<th>sale</th>
			<td><input type="text" name="sale" size="6" style="text-align:right;padding-right:1px;" value="<%=sale%>"> %</td>
			<th>sale기간</th>
			<td><input type="text" id="datepicker3" name="saleStartDay" size="12" value="<%=saleStartDay%>" /> ~ 
	            <input type="text" id="datepicker4" name="saleEndDay" size="12" value="<%=saleEndDay%>" /></td>
		</tr>
		<tr>
			<th>sale/균일가 설명</th>
			<td colspan="3"><textarea cols="70" rows="12" name="saleMemo" id="saleMemo" style="padding:10px;"><%=saleMemo.replace("\r\n","<br/>") %></textarea></td>
		</tr>
		<tr>
			<th>상품설명</th>
			<td colspan="3"><textarea cols="70" rows="12" name="productMemo" id="productMemo" style="padding:10px;"><%=productMemo.replace("\r\n","<br/>") %></textarea></td>
		</tr>
	</table>
	</center>
</form>
<center>
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="저장하기" class="bt_a32 tmb22" onclick="submitProductModify()">
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="취소하기" class="bt_a32 tmb22" onclick="javascript:self.close();">
</center>
<!--본문 끝---------------------------------------------------------------------------------------->
</body>
</html>