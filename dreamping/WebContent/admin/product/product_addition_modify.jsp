<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>THE DREAMPING ADMIN</title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
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


<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>부가서비스 등록</li>
	<li class="location">예약상품관리>부가서비스 관리>부가서비스 등록</li>
</ul>

<!--본문---------------------------------------------------------------------->
<form name="basicInfoForm" method="post">

<ul class="bullet_title"><li>부가서비스 정보입력</ul>

<table class="product_table" id="product_addition_table">
<col width="200px"></col><col width="300px"></col><col width="150px"></col><col width="150px"></col>
	<tr>
		<th>부가서비스명</td>
		<td><input type="text" name="additionName" size="40" value=""></td>
		<th>단위</td>
		<td><input type="text" name="unit" size="16" value=""></td>
	</tr>
	<tr>
		<th>가격</td>
		<td><input type="text" name="additionPrice" size="30" value=""> 원</td>
		<th>예약상품 1개당<br>판매가능한 수량</td>
		<td><input type='text' name="quantity" size='10' value=""></td>
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
		<td colspan="3"><input type='text' name="desc" size='100' value=""></td>
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
