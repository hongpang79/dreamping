<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Vector" %>
<%@ page import="reservation.SiteVO" %>
<%@ page import="reservation.AdditionVO" %>
<%@ page import="admin.ProductDAO" %>
<%@ page import="reservation.Reservation" %>
<%
request.setCharacterEncoding("UTF-8");
NumberFormat nf = NumberFormat.getInstance();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

String step = request.getParameter("step")==null?"new":request.getParameter("step");
String sAdditionNo = request.getParameter("additionNo")==null?"0":request.getParameter("additionNo");
int additionNo = 0;

Vector<SiteVO> zoneList = ProductDAO.getInstance().selectZoneList();

AdditionVO addition = new AdditionVO();
String additionName = "";
int zoneNo = 0;
String unit = "";
int additionPrice = 0;
int quantity = 9999;
String displayStartDay = "";
String displayEndDay = "";
String useYn = "Y";
String delYn = "N";
String additionMemo = "";
String msg = "";
int rtn = 0;
if(step.equals("new")){
	
}else if(step.equals("modify")){
	additionNo = Integer.parseInt(sAdditionNo);
	addition = ProductDAO.getInstance().getAddition(additionNo);
	additionName = addition.getAdditionName();
	zoneNo = addition.getZoneNo();
	unit = addition.getUnit();
	additionPrice = addition.getAdditionPrice();
	quantity =  addition.getQuantity();
	additionMemo =  addition.getAdditionMemo();
	displayStartDay = addition.getDisplayStartDay()==null?"":transFormat.format(addition.getDisplayStartDay());
	displayEndDay = addition.getDisplayEndDay()==null?"":transFormat.format(addition.getDisplayEndDay());
	useYn = addition.getUseYn()==null?"Y":addition.getUseYn();
	delYn = addition.getDelYn()==null?"N":addition.getDelYn();
	
}else{
	rtn = ProductDAO.getInstance().modifyAddition(request);

	if(rtn == 0){
		msg = "저장에 실패했습니다. 관리자에게 문의해주세요!";

	}else{
		msg = "저장되었습니다.";
		
	}
	
}
%>
<html>
<head>
<title>THE DREAMPING ADMIN</title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<link rel="stylesheet" type="text/css" href="/admin/css/text_button.css">
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
				location.href="/admin/product/product_addition_list.jsp";
			}
		}
		
	}
);
	
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
<script type="text/javascript" src="/admin/js/calendar.js"></script>
<script language=javascript>
	
	function saveBasicInfo()
	{
		var f = document.basicInfoForm;

		for( var i = 0 , iptsLabel = { 'name' : '부가서비스명' , 'unit' : '단위' , 'price' : '가격' , 'quantity' : '수량' } , ipts = f.getElementsByTagName( 'input' ) , iptName = null ; i < ipts.length ; i++ )
		{
			iptName = ipts[ i ].getAttribute( 'name' );
			if( !iptName ) continue;
			if( !iptsLabel[ iptName ] ) continue;

			if( !ipts[ i ].value )
			{
				ipts[ i ].focus();
				return alert( iptsLabel[ iptName ] + '을 입력해 주세요' );
			}

			if( ( ( iptName == 'price' ) || ( iptName == 'quantity' ) ) && ( !/[\d]+/.test( ipts[ i ].value ) ) )
			{
				ipts[ i ].focus();
				return alert( iptsLabel[ iptName ] + '에는 숫자만 입력해 주세요' );
			}
		}

		f.submit();
	}


</script>

<style type="text/css">@import url(/admin/css/calendar.css);</style>
<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>부가서비스 등록</li>
	<li class="location">예약상품관리>부가서비스 관리>부가서비스 등록</li>
</ul>

<!--본문---------------------------------------------------------------------->
<form name="basicInfoForm" method="post">
	<input type="hidden" id="msg" name="msg" value="<%=msg%>">
	<input type="hidden" id="orgStep" name="orgStep" value="<%=step %>"/>
	<input type="hidden" id="step" name="step" value="<%=step %>"/>
	<input type="hidden" id="rtn" name="rtn" value="<%=rtn%>">
<ul class="bullet_title"><li>부가서비스 정보입력</ul>

<table class="product_table" id="product_addition_table">
<col bgcolor="#F6F6F6" width="18%"></col><col width="32%"></col><col bgcolor="#F6F6F6" width="18%"></col><col width="32%"></col>
	<tr>
		<th>상품그룹</th>
		<td colspan="3">
			<select id="zoneNo" name="zoneNo">
				<option value=''>-- SELECT --</option>																			
				<% for(int i=0; i<zoneList.size(); i++){ %>
					<option value="<%= zoneList.get(i).getZoneNo() %>" <% if(zoneList.get(i).getZoneNo()== zoneNo){ %> selected <%} %>><%=zoneList.get(i).getZoneName()%></option>
				<% } %>
			</select>
		</td>
	</tr>
	<tr>
		<th>부가서비스명</td>
		<td><input type="text" name="additionName" size="35" value="<%=additionName%>"></td>
		<th>가격</td>
		<td><input type="text" name="additionPrice" size="16" style="text-align:right;padding-right:1px;" value="<%=additionPrice%>"> 원</td>
	</tr>
	<tr>
		<th>예약상품 1개당<br>판매가능한 수량</td>
		<td><input type='text' name="quantity" style="text-align:right;padding-right:1px;" size='10' value="<%=quantity%>"></td>
		<th>단위</td>
		<td><input type="text" name="unit" size="12" value="<%=unit%>"></td>
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
		<th>부가서비스 설명</th>
		<td colspan="3">
			<textarea cols="70" rows="12" name="additionMemo" id="additionMemo" style="padding:10px;"><%=additionMemo.replace("\r\n","<br/>") %></textarea>
		</td>
	</tr>
	
</table>
<br>
<center>
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="저장하기" class="bt_a32 tmb22" onclick="saveBasicInfo();">
</center>
<br>

</form>
<!--본문 끝---------------------------------------------------------------------------------------->
<!-- by gckim 2008-03-19 -->


							</td>
					</tr>
				</table>
	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->
	

</body>
</html>
