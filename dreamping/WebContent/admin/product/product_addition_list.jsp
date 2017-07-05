<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>THE DREAMPING ADMIN</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
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
	

<style type="text/css">@import url(/admin/css/text_button.css);</style>


<script language=javascript>
	function deleteAddition( idx )
	{
		if( !confirm( '삭제하시겠습니까?' ) ) return;

		var cmd = document.createElement( 'input' );
		cmd.type = 'hidden';
		cmd.name = 'cmd';
		cmd.value = 'delete';

		var key = document.createElement( 'input' );
		key.type = 'hidden';
		key.name = 'additionkey';
		key.value = idx;

		var f = document.createElement( 'form' );
		f.style.display = 'none';
		f.setAttribute( 'method' , 'post' );
		document.body.appendChild( f );
		f.appendChild( cmd );
		f.appendChild( key );

		f.submit();
	}
</script>


<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>부가서비스 등록</li>
	<li class="location">예약상품관리>부가서비스 관리>부가서비스 목록</li>
</ul>

<!--본문---------------------------------------------------------------------->
<ul class="bullet_title"><li>등록된 부가 서비스</ul>

<table id="listing_table" class="product_table">
	<col width="60px"></col><col width="120px"></col><col></col><col width="100px"></col><col width="100px"></col>
	<thead>
	<tr>
		<td>번호</td><td>부가서비스명</td><td>설명</td><td>수정</td><td>삭제</td>
	</tr>
	</thead>

	<tbody>
	
	<tr><td colspan="5"> <br/>등록된 상품이 없습니다<br/><br/> </td></tr>

		</tbody>

</table>

<br>

<center>
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="새 부가서비스 등록하기" class="bt_a32 tmb22" onclick="location.href='/admin/product/product_addition_modify.jsp';">
</center>
<br>

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
