<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="reservation.RefundVO" %>
<%@ page import="admin.CommonDAO" %>
<%
request.setCharacterEncoding("UTF-8");
NumberFormat nf = NumberFormat.getInstance();

String cmd = request.getParameter("cmd")==null?"list":request.getParameter("cmd");
String msg = "";

if(!cmd.equals("list")){
	msg = CommonDAO.getInstance().processRefund(request);	
}
%>
<html>
<head>
<title>환불금액 설정</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
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
	


<script type="text/javascript">

	$(document).ready(
		function() {
			if($("#msg").val().length > 0){
				alert($("#msg").val());
		}
	});	
	
	function showRegist()
	{
		var rst = document.getElementById( 'refund_setting' );
		var ipts = rst.getElementsByTagName( 'input' );
		for( var i = 0 ; i < ipts.length ; i++ ) if( ipts[ i ].value ) ipts[ i ].value = '';
		rst.getElementsByTagName( 'select' )[0].options[0].selected = true;

		document.getElementsByName( 'cmd' )[0].value = 'add';

		return rst.style.display = '';
	}

	function hideRegist()
	{
		return document.getElementById( 'refund_setting' ).style.display = 'none';
	}

	function submitRegist()
	{
		var spans = document.getElementsByTagName( 'span' );

		var rDbs = document.getElementsByName( 'refundDayBefore' )[ 0 ];
		var rAmount = document.getElementsByName( 'refundAmount' )[ 0 ];

		if( !rDbs.value ) return alert( '예약기준일을 입력해 주세요' );
		if( !rAmount.value ) return alert( '환불금액를 입력해 주세요' );

		if( !/[\d]+/.test( rDbs.value ) ) return alert( '숫자만 입력해 주세요' );
		if( !/[\d]+/.test( rAmount.value ) ) return alert( '숫자만 입력해 주세요' );

		if(document.getElementsByName( 'cmd' )[0].value == "add"){
			for( var i = 0 ; i < spans.length ; i++ )
			{
				if( spans[ i ].getAttribute( 'name' ) != 'dayBefore' ) continue;
				if( spans[ i ].firstChild.nodeValue == rDbs.value ) return alert( '이미 기준이 있습니다' );
			}	
		}
		
		if( !confirm( '저장하시겠습니까?' ) ) return;

		var f = document.refund_setting_form;

		f.submit();
	}

	function deleteRefund( idx )
	{
		if( !confirm( '삭제하시겠습니까?' ) ) return;

		var f = document.refund_setting_form;

		document.getElementsByName( 'cmd' )[0].value = 'del';
		document.getElementsByName( 'refundDayBefore' )[0].value = idx;

		f.submit();
	}

	function editRefund( srcE , idx )
	{
		showRegist();

		var f = document.refund_setting_form;

		document.getElementsByName( 'cmd' )[0].value = 'edit';
		document.getElementsByName( 'key' )[0].value = idx;

		var tr = srcE.parentNode.parentNode;
		var spans = tr.getElementsByTagName( 'span' );
		for( var i = 0 ; i < spans.length ; i++ )
		{
			var sId = spans[ i ].getAttribute( 'name' );
			if( !sId ) continue;
			if( sId == 'dayBefore' ) document.getElementsByName( 'refundDayBefore' )[0].value = spans[ i ].firstChild.nodeValue;
			if( sId == 'amount' ) document.getElementsByName( 'refundAmount' )[0].value = spans[ i ].firstChild.nodeValue;
			if( sId == 'type' )
			{
				if( spans[ i ].firstChild.nodeValue == '%' ) document.getElementsByName( 'refundType' )[0].value = 'P';
				if( spans[ i ].firstChild.nodeValue == '원' ) document.getElementsByName( 'refundType' )[0].value = 'W';
			}
		}
	}
</script>


<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>환불금액 설정</li>
	<li class="location">캠핑장관리>기본정보>환불금액설정</li>
</ul>

<ul class="desc">
	<li>예약 취소시 고객에게 환불할 금액을 설정할 수 있습니다.
	<li>각 기준에 맞게 환불금액를 입력하시면 됩니다.
</ul>

<!--본문---------------------------------------------------------------------->
<table class="product_table" align="center">
	<col width="40%"></col>
	<col width="30%"></col>
	<col width="15%"></col>
	<col width="15%"></col>
	<thead>
	<tr>
		<th>도착일 기준</th>
		<th>환불금액</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
	</thead>
	<tbody>
<%
	Vector<RefundVO> vRefund = CommonDAO.getInstance().selectRefundList();
	if (vRefund == null){
%>
	<tr>
		<td colspan="4" align="center"> <br/>등록된 환불 정보가 없습니다<br/><br/> </td>
	</tr>
<%
	}else{
		int refundDayBefore = 0;
		String refundType = "";
		int refundAmount = 0;
		
		RefundVO refund = null;
		for(int i=0; i<vRefund.size(); i++){
			refund = vRefund.get(i);
			refundDayBefore = refund.getRefundDayBefore();
			refundAmount = refund.getRefundAmount();
			refundType = refund.getRefundType();
			if(refundType.equals("W")){
				refundType = "원";
			}else{
				refundType = "%";
			}
%>
	<tr>
		<td>도착일 <span name="dayBefore"><%=refundDayBefore %></span>일전 취소시</td>
		<td><span name="amount"><%=refundAmount %></span><span name="type"><%=refundType %></span></td>
		<td><a href="javascript:;" onclick="editRefund(this,<%=refundDayBefore %>)">수정</a></td>
		<td><a href="javascript:;" onclick="deleteRefund(<%=refundDayBefore %>); return false;">삭제</a></td>
	</tr>
<%
		}
	}
%>
		</tbody>
</table>

<div class="bottom_cmd">
	<img src='/admin/img/btn_add3.gif' onclick="showRegist()">
</div>

<div id="refund_setting" style="display:none;">
	<form method="post" name="refund_setting_form">
	<input type="hidden" name="cmd">
	<input type="hidden" name="key">
	<input type="hidden" id="msg" name="msg" value="<%=msg%>">
	<table id="refund_setting_table" class="product_table" align="center">
		<col width="45%"></col><col width="25%"></col><col width="15%"></col><col width="15%"></col>
		<thead>
		<tr>
			<th>도착일 기준</th>
			<th>환불금액</th>
		</tr>
		</thead>

		<tbody>
		<tr>
			<td>도착일 <input type="text" name="refundDayBefore" size="3">일전 취소시</td>
			<td>
				<input type="text" name="refundAmount" size="3">
				<select name="refundType">
					<option value="P">%</option>
					<option value="W">원</option>
				</select>
			</td>
		</tr>
		</tbody>
	</table>
	</form>
	<div class="bottom_cmd">
		<img src='/admin/img/btn_save.gif' onclick="submitRegist()">
		<img src='/admin/img/btn_cancel.gif' onclick="hideRegist()">
	</div>
</div>

<div class="usage_instruction">
[사용안내]
<ul class="desc">
	<li><b class=ol>ㆍ</b>환불금액은 %와 금액으로 설정하실 수 있습니다
	<li><b class=ol>ㆍ</b>환불금액의 기준은 예약신청 고객이 예약취소를 할 경우에, 신청한 도착일 기준으로 환불금액를 설정합니다
</ul>
</div>

<!--본문 끝---------------------------------------------------------------------------------------->

		</td>
	</tr>
</table>
	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->

</body>
</html>
