<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="reservation.AdditionVO" %>
<%@ page import="admin.ProductDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	NumberFormat nf = NumberFormat.getInstance();
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy/MM/dd");
%>
<html>
<head>
<title>THE DREAMPING ADMIN</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<link rel="stylesheet" type="text/css" href="/admin/css/text_button.css">
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
		cmd.name = 'step';
		cmd.value = 'delete';

		var key = document.createElement( 'input' );
		key.type = 'hidden';
		key.name = 'additionNo';
		key.value = idx;

		var f = document.createElement( 'form' );
		f.style.display = 'none';
		f.setAttribute( 'method' , 'post' );
		f.setAttribute( 'action' , '/admin/product/product_addition_delete.jsp');
		document.body.appendChild( f );
		f.appendChild( cmd );
		f.appendChild( key );

		f.submit();
	}
	
	function modifyAddition( idx )
	{
		//if( !confirm( '수정하시겠습니까?' ) ) return;

		var cmd = document.createElement( 'input' );
		cmd.type = 'hidden';
		cmd.name = 'step';
		cmd.value = 'modify';

		var key = document.createElement( 'input' );
		key.type = 'hidden';
		key.name = 'additionNo';
		key.value = idx;

		var f = document.createElement( 'form' );
		f.style.display = 'none';
		f.setAttribute( 'method' , 'post' );
		f.setAttribute( 'action' , '/admin/product/product_addition_modify.jsp');
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
<ul class="bullet_title"><li>등록된 부가 서비스</li></ul>

<table id="listing_table" class="product_table">
	<col width="60px"></col>
	<col width="120px"></col>
	<col width="120px"></col>
	<col width="80px"></col>
	<col></col>
	<col width="80px"></col>
	<col width="100px"></col>
	<thead>
		<tr>
			<td>번호</td>
			<td>상품그룹명</td>
			<td>부가서비스명</td>
			<td>가격</td>
			<td>Display 기간</td>
			<td>사용여부</td>
			<td>선택</td>
		</tr>
	</thead>

	<tbody>
<%
	Vector<AdditionVO> vAddition = ProductDAO.getInstance().selectAdditionList();
	if( vAddition == null ){
%>		
	
	<tr><td colspan="7"> <br/>등록된 상품이 없습니다<br/><br/> </td></tr>
<%
	}else{
		int count = vAddition.size();
		int additionNo = 0;
		String additionName = "";
		String zoneName = "";
		String displayStartDay = "";
		String displayEndDay = "";
		int additionPrice = 0;
		String useYn = "";
		
		AdditionVO addition = null;
		for(int i=0; i<count; i++){
			addition = vAddition.get(i);
			additionNo = addition.getAdditionNo();
			additionName = addition.getAdditionName();
			zoneName = addition.getZoneName();
			additionPrice = addition.getAdditionPrice();
			displayStartDay = addition.getDisplayStartDay()==null?"":transFormat.format(addition.getDisplayStartDay()); 
			displayEndDay = addition.getDisplayEndDay()==null?"":transFormat.format(addition.getDisplayEndDay()); 
			useYn = addition.getUseYn();
%>
		<tr>
			<td><%= i+1 %></td>
			<td><%=zoneName %></td>
			<td><%=additionName %></td>
			<td><% out.print(nf.format(additionPrice)); %></td>
			<td><%=displayStartDay %> ~ <%=displayEndDay %></td>
			<td><%=useYn %></td>
			<td>
				<input type="button" value="수정" onClick="javascript:modifyAddition(<%= additionNo %>);" />
				<input type="button" value="삭제" onClick="javascript:deleteAddition(<%= additionNo %>);" />
			</td>
		</tr>
<%					
		} //end for
	} //end if
%>
	</tbody>

</table>

<br>

<center>
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="새 부가서비스 등록하기" class="bt_a32 tmb22" onclick="location.href='/admin/product/product_addition_modify.jsp';">
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
