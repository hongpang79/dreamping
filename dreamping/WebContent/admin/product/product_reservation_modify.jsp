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

String step = request.getParameter("step")==null?"new":request.getParameter("step");
String sProductNo = request.getParameter("productNo")==null?"0":request.getParameter("productNo");
int productNo = 0;

Vector<SiteVO> zoneList = ProductDAO.getInstance().selectZoneList();
//Vector<SiteVO> siteList = null;

SiteVO product = new SiteVO();
String productName = "";
//String zoneName = "";
String siteName = "";
int zoneNo = 0;
int siteNo = 0;
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
if(step.equals("new")){
	//siteList = ProductDAO.getInstance().selectSiteList();
}else if(step.equals("modify")){
	productNo = Integer.parseInt(sProductNo);
	product = ProductDAO.getInstance().getProduct(productNo);
	productName = product.getProductName();
	//zoneName = product.getZoneName();
	siteName = product.getSiteName();
	zoneNo = product.getZoneNo();
	siteNo = product.getSiteNo();
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
	
	//siteList = ProductDAO.getInstance().selectSiteList(zoneNo); 
}else{
	rtn = ProductDAO.getInstance().modifyProduct(request);
	//alert(rtn);
	if(rtn == 0){
		msg = "저장에 실패했습니다. 관리자에게 문의해주세요!";

	}else{
		msg = "저장되었습니다.";
		
	}
	
}
%>
<html>
<head>
<title>SITE관리 > SITE</title>
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
				location.href="/admin/product/product_reservation_list.jsp";
			}
		}
		
		$("#step").val("siteSearch"); //alert($("#step").val());
		$("#searchZoneNo").val($("#searchZoneNo").val());
		var params = $('#productModifyForm').serialize(); //alert(params);
		$.ajax({
				type: 'POST',
				url: '/Reservation.do',
				data: params,
				dataType: 'json',
				success: function(obj){
					if(obj == null){
						obj = 0;
					}
					//alert(obj.data.length);
					var selected = "";
					for(var i=0; i<obj.data.length; i++){
						//alert(obj.data[i].siteNo);
						if(obj.data[i].siteNo == $("#searchSiteNo").val()){
							selected = "selected";
						}else{
							selected = "";
						}
						$("#siteNo").append("<option value='"+obj.data[i].siteNo+"' "+ selected +" >"+obj.data[i].siteName+"</option>");
					}
				}
			});
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


	 <!-- 상단 TOP Menu S -->
     <jsp:include page="/admin/product/menu_top.jsp" />
     <!-- 상단 TOP Menu E -->		            
    	
	
	<table border=0 cellpadding=0 cellspacing=0 width=800>
			<tr valign=top>
							<td width=175 bgcolor=F7F7F7>
					<!--왼쪽 타이틀------------------------------------------------->
					<jsp:include page="/admin/product/menu_left.jsp" />
					<!--//왼쪽 타이틀------------------------------------------------->
    
					</td>
					<td width=18><img src=/admin/img/e.gif width=18></td>
					<td width="100%">
						<td align="left" width="50%">
	

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
		
		if(f.productName.value == ""){
			alert("상품명을 입력해 주세요!");
			f.productName.focus();
		}
		
		if(f.orgStep.value == "modify"){
			f.step.value = "update";
		}else{
			f.step.value = "insert";
		}

		f.submit();
	}


</script>

<style type="text/css">@import url(/admin/css/calendar.css);</style>

<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>상품 등록
	<li class="location">예약상품관리>상품관리>Product 등록
</ul>

<!--본문---------------------------------------------------------------------->
<form id="productModifyForm" name="productModifyForm" method="post">
	<input type="hidden" id="orgStep" name="orgStep" value="<%=step %>"/>
	<input type="hidden" id="step" name="step" value="<%=step %>"/>
	<input type="hidden" id="productNo" name="productNo" value="<%=productNo %>"/>
	<input type="hidden" id="siteName" name="siteName" value="<%=siteName %>"/>
	<input type="hidden" id="searchZoneNo" name="searchZoneNo" value="<%=zoneNo%>"/>
	<input type="hidden" id="searchSiteNo" name="searchSiteNo" value="<%=siteNo %>"/>
	<input type="hidden" id="rtn" name="rtn" value="<%=rtn%>">
	<input type="hidden" id="msg" name="msg" value="<%=msg%>">
<table class="product_table">
<col bgcolor="#F6F6F6" width="18%"></col><col width="32%"></col><col bgcolor="#F6F6F6" width="18%"></col><col width="32%"></col>
	<tr>
		<th>상품명</th>
		<td colspan="3"><input type="text" id="productName" name="productName" size="30" value="<%=productName%>"></td>
	</tr>
	<tr>
		<th>Zone</th>
		<td>
			<select id="zoneNo" name="zoneNo">
				<option value=''>-- SELECT --</option>																			
				<% for(int i=0; i<zoneList.size(); i++){ %>
					<option value="<%= zoneList.get(i).getZoneNo() %>" <% if(zoneList.get(i).getZoneNo()== zoneNo){ %> selected <%} %>><%=zoneList.get(i).getZoneName()%></option>
				<% } %>
			</select>
		</td>
		<th>Site Name</th>
		<td>
			<select id="siteNo" name="siteNo">
				<option value=''>-- SELECT --</option>																			
			</select>
		</td>
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
</form>

<br>
<center>
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="저장하기" class="bt_a32 tmb22" onclick="submitProductModify()">
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="취소하기" class="bt_a32 tmb22" onclick="location.reload();">
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="상품리스트" class="bt_a32 tmb22" onclick="location.href='/admin/product/product_reservation_list.jsp'">
</center>
<br>

<!--본문 끝---------------------------------------------------------------------------------------->

							</td>
					</tr>
				</table>
				
	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->
	

</body>
</html>
<script type="text/javascript">
//select box 동적변경
//function change_useday(){
$("#zoneNo").change(function(){
	$("#siteNo").find('option').each(function(){
		$(this).remove();
	});
	var selectVal = $(this).val(); //alert(selectVal);
	if(selectVal != ''){
		$("#step").val("siteSearch"); //alert($("#step").val());
		$("#searchZoneNo").val(selectVal);
		var params = $('#productModifyForm').serialize(); //alert(params);
		$.ajax({
				type: 'POST',
				url: '/Reservation.do',
				data: params,
				dataType: 'json',
				success: function(obj){
					if(obj == null){
						obj = 0;
					}
					//alert(obj.data.length);
					for(var i=0; i<obj.data.length; i++){
						//alert(obj.data[i].siteNo);
						$("#siteNo").append("<option value='"+obj.data[i].siteNo+"'>"+obj.data[i].siteName+"</option>");
					}
				}
			});
	}
});	

$("#siteNo").change(function(){
	var selectVal = $("#siteNo option:selected").text();
	//alert(selectVal);
	$("#siteName").val(selectVal);
});
</script>