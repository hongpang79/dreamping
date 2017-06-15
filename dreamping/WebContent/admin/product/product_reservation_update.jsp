<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="reservation.SiteVO" %>
<%@ page import="admin.ProductDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	NumberFormat nf = NumberFormat.getInstance();
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<html>
<head>
<title>UrbanSlowCity Admin</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
<script type="text/javascript" src="/js/popup.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
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
	


<script language=javascript>	
	function modifyProduct()
	{
		var productNo = '';
		var productNos = '0';
		
		$("input:checkbox[name=prodcutNos]:checked").each(function(idx, elem){
			productNos = productNos + "," + $(elem).val();
			productNo = $(elem).val();
		});
		
		//alert(productNos);
		
		//if( !confirm( '수정하시겠습니까?' ) ) return;

		var url = "/admin/product/popup_reservation_update.jsp?productNo="+productNo+"&productNos="+productNos;
		url = encodeURI(url);
		popup.openWindowPopup(url, 'Products Modify', {width : '840px', height : '580px'});
	}

	


</script>


<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>상품 일괄 변경</li>
	<li class="location">예약상품관리>상품관리>Product 일괄변경</li>
</ul>

<!--본문---------------------------------------------------------------------->
<table id="listing_table" class="product_table">
	<thead>
	<tr>
		<th rowspan="2">선택</th>
		<th rowspan="2">Product ID</th>
		<th rowspan="2">상품명</th>
		<th rowspan="2">기준인원<br>/최대인원</th>
		<th colspan="2">추가요금</th>
		<th colspan="3">비수기 요금</th>
        <th colspan="3">준성수기 요금</th>
		<th colspan="3">성수기 요금</th>
		<th rowspan="2">Display<br>기간</th>
		<th rowspan="2">sale<br>기간</th>
	</tr>
	<tr>
		<th>아동</th>
		<th>일반</th>
		<th>주중</th>
		<th>주말</th>
		<th>피크닉</th>
		<th>주중</th>
		<th>주말</th>
		<th>피크닉</th>
        <th>주중</th>
		<th>주말</th>
		<th>피크닉</th>
	</tr>
	</thead>
	<tbody>
<%
	Vector<SiteVO> vProduct = ProductDAO.getInstance().selectProductList();
	if( vProduct == null ){
%>
		<tr><td colspan="17"> <br/>등록된 상품이 없습니다<br/><br/></td></tr>
<%
	}else{
		int count = vProduct.size();
		int productNo = 0;
		String productName = "";
		String zoneName = "";
		String siteName = "";
		String productMemo = "";
		String displayStartDay = "";
		String displayEndDay = "";
		String saleStartDay = "";
		String saleEndDay = "";
		int users = 0;
		int maxUsers = 0;
		int addChildPrice = 0;
		int addUserPrice = 0;
		int lowSeasonWeekday = 0;
		int lowSeasonWeekend= 0;
		int lowSeasonPicnic = 0;
		int middleSeasonWeekday = 0;
		int middleSeasonWeekend = 0;
		int middleSeasonPicnic = 0;
		int highSeasonWeekday = 0;
		int highSeasonWeekend = 0;
		int highSeasonPicnic = 0;
		SiteVO product = null;
		for(int i=0; i<count; i++){
			product = vProduct.get(i);
			productNo = product.getProductNo();
			productName = product.getProductName();
			zoneName = product.getZoneName();
			siteName = product.getSiteName();
			users = product.getUsers();
			maxUsers = product.getMaxUsers();
			addChildPrice = product.getAddChildPrice();
			addUserPrice = product.getAddUserPrice();
			lowSeasonWeekday = product.getLowSeasonWeekday();
			lowSeasonWeekend= product.getLowSeasonWeekend();
			lowSeasonPicnic = product.getLowSeasonPicnic();
			middleSeasonWeekday = product.getMiddleSeasonWeekday();
			middleSeasonWeekend = product.getMiddleSeasonWeekend();
			middleSeasonPicnic = product.getMiddleSeasonPicnic();
			highSeasonWeekday = product.getHighSeasonWeekday();
			highSeasonWeekend = product.getHighSeasonWeekend();
			highSeasonPicnic = product.getHighSeasonPicnic();
			productMemo = product.getProductMemo();
			displayStartDay = product.getDisplayStartDay()==null?"":transFormat.format(product.getDisplayStartDay()); 
			displayEndDay = product.getDisplayEndDay()==null?"":transFormat.format(product.getDisplayEndDay()); 
			saleStartDay = product.getSaleStartDay()==null?"":transFormat.format(product.getSaleStartDay()); 
			saleEndDay = product.getSaleEndDay()==null?"":transFormat.format(product.getSaleEndDay()); 
%>
		<tr>
			<td>
				<input type="checkbox" name="prodcutNos" value="<%= productNo %>" />
			</td>
			<td><%= productNo %></td>
			<td><%=productName %></td>
			<td><%=users +"/" +maxUsers %></td>
			<td><% out.print(nf.format(addChildPrice)); %></td>
			<td><% out.print(nf.format(addUserPrice)); %></td>
			<td><% out.print(nf.format(lowSeasonWeekday)); %></td>
			<td><% out.print(nf.format(lowSeasonWeekend)); %></td>
			<td><% out.print(nf.format(lowSeasonPicnic)); %></td>
			<td><% out.print(nf.format(middleSeasonWeekday)); %></td>
			<td><% out.print(nf.format(middleSeasonWeekend)); %></td>
			<td><% out.print(nf.format(middleSeasonPicnic)); %></td>
			<td><% out.print(nf.format(highSeasonWeekday)); %></td>
			<td><% out.print(nf.format(highSeasonWeekend)); %></td>
			<td><% out.print(nf.format(highSeasonPicnic)); %></td>
			<td><%=displayStartDay %> ~ <%=displayEndDay %></td>
			<td><%=saleStartDay %> ~ <%=saleEndDay %></td>
		</tr>
<%					
		}
	}
%>
	</tbody>
</table>

<br>

<center>
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="선택상품변경하기" class="bt_a32 tmb22" onclick="javascript:modifyProduct();">
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
