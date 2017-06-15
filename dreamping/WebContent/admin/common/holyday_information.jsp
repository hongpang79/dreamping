<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="admin.HolydayVO" %>
<%@ page import="admin.CommonDAO" %>
<%
request.setCharacterEncoding("UTF-8");
NumberFormat nf = NumberFormat.getInstance();

String cmd = request.getParameter("cmd")==null?"list":request.getParameter("cmd");
String msg = "";

if(!cmd.equals("list")){
	msg = CommonDAO.getInstance().processHolyday(request);	
}
%>
<html>
<head>
<title></title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
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
	
<script language=javascript>
$(document).ready(
		function() {
			if($("#msg").val().length > 0){
				alert($("#msg").val());
		}
	});	
	
function deleteCheck(dvsnCd, mmdd)
{
	frm = document.bankinfo;

	if(confirm('해당 일자를 삭제하시겠습니까?') == true) {
		frm.cmd.value = 'delete';
		frm.dvsnCd.value = dvsnCd;
		frm.mmdd.value = mmdd.replace("-","");
		frm.submit();
	}
}
function formCheck()
{
		var sform = document.addform;
		
		if(sform.dvsnCd.value.length == 0)
		{
			alert('양력/음력을 선택하세요.');
			sform.dvsnCd.focus();
			return false;
		}

		if(sform.mmdd.value.length == 0)
		{
			alert('일자를 입력하세요.');
			sform.mmdd.focus();
			return false;
		}else{
			sform.mmdd.value = sform.mmdd.value.replace("-","");
		}

		if(sform.description.value.length == 0)
		{
			alert('설명을 입력하세요.');
			sform.description.focus();
			return false;
		}
}

function numnberCheck()
{


	if(event.keyCode == 109 || event.keyCode == 189)
	{
		return true;
	}
	else{
		var inp=String.fromCharCode(event.keyCode);
		if (isNaN(inp)) {
			if((event.keyCode < 96 || event.keyCode > 105) ) {
				//event.keyCode 8 => Back Space , 37 = (<-방향키) ,  39 = (->방향키)
				// [CS , TFT , YongHun Jeong , 2009-12-08]
				if( (event.keyCode !=8) && (event.keyCode !=37) && (event.keyCode !=39) ) {
					alert("숫자 또는 '-'만  입력해주세요!");
						event.returnValue=false;
				}
			}
		}
		else{
			return true;
		}
	}
}

</script>
<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>휴일관리</li>
	<li class="location">캠핑장관리>기본정보>휴일관리</li>
</ul>

			<!--본문 내용 시작--------------------------------------------------------->
			<table border=0 cellpadding=0 cellspacing=0 width=800>
				<tr height='20'><td></td></tr>
					</tr>
			</table>

			<table border='0' cellspacing='0' cellpadding='0'>
			<tr>
				<td>
					<table class="product_table" align="center">
					  <form name='bankinfo' method='post' action='/admin/common/holyday_information.jsp'>
						<input type='hidden' name='cmd' value=''>
						<input type='hidden' name='dvsnCd' value=''>
						<input type='hidden' name='mmdd' value=''>
						<input type="hidden" id="msg" name="msg" value="<%=msg%>">
					  <thead>
						<tr height='28'>
							<th width='150' align="center">양력/음력</th>
							<th width='150' align="center">휴일</th>
							<th width='250' align="center">설명</th>
							<th width='100' align="center">사용여부</th>
							<th width='100' align="center">선택</th>
						</tr>
					  </thead>
<%
	Vector<HolydayVO> vHolyday = CommonDAO.getInstance().selectHolydayList();
	if (vHolyday == null){
%>						
						<tr height='28'>
							<td colspan="5" align="center">등록된 정보가 없습니다.</td>
						</tr>
<%
	}else{
		String orgDvsnCd = "";
		String dvsnCd = "";
		String mmdd = "";
		String description = "";
		String useYn = "";
		
		HolydayVO holyday = null;
		for(int i=0; i<vHolyday.size(); i++){
			holyday = vHolyday.get(i);
			orgDvsnCd = holyday.getDvsnCd();
			if(orgDvsnCd.equals("SOLAR")){
				dvsnCd = "양력";
			}else{
				dvsnCd = "음력";
			}
			mmdd = holyday.getMmdd();
			description = holyday.getDescription();
			useYn = holyday.getUseYn();
		
%>						
					<tr height='28'>
						<td width='150' align="center"><%=dvsnCd %></td>
						<td width='150' align="center"><%=mmdd %></td>
						<td width='250' align="left"><%=description %></td>
						<td width='100' align="center"><%=useYn %></td>
						<td width='100' align="center">
							<a href="javascript:;" onclick="javascript:deleteCheck('<%=orgDvsnCd %>','<%=mmdd %>')">삭제</a>
						</td>
					</tr>
<%
		}
	}
%>					
					</table>
					<br>
			       </form>
				</td>
			</tr>
			</table>
			<!--무통장입금 계좌 입력-->
			<div id='add' style='display:block'>
			<table border='0' cellspacing='0' cellpadding='0'>
			<tr>
				<td>
					<table border='1' cellpadding='0' cellspacing='0' width='800' style='border-collapse:collapse' bordercolor='cccccc'>
					<form name='addform' method='post' action='/admin/common/holyday_information.jsp' onSubmit='return formCheck()'>
					<input type='hidden' name='cmd' value='insert'>
						<tr height='28'>
							<td class='tbsbj' width='100'>구분</td>
							<td class='tbcont'>
                                <div style="float:left">
								<select class='txt' name='dvsnCd'>
									<option value=''>--------</option>
									<option value='SOLAR' >양력</option>
									<option value='LUNAR' >음력</option>
								</select>
                                </div>
							</td>
							<td class='tbsbj'>날짜</td>
							<td height='28' class='tbcont'>
								<input type='text' id='mmdd' size='12' name='mmdd' value="" onkeyDown="javascript:numnberCheck()"> ※ 숫자와 '-'만 입력 가능합니다.
							</td>
						</tr>
						<tr height='28'>
							<td class='tbsbj'>설명</td>
							<td colspan="3" height='28' class='tbcont'>
								<input type='text' id='description' size='80' maxlength='80' name='description' value="">
							</td>
						</tr>
						

					</table>
					<br>
					<div style='width:800' align='center'>
						<input type="submit" name="add_submit" value="추가하기" style="cursor:hand">
					</div>

					</form>
				</td>
			</tr>
			</table>
			</div>
			<!--//무통장입금 계좌 입력-->
			<table border='3' cellpadding='7' cellspacing='0' width='800' bordercolor='ECD08A' style='margin-top:20'>
				<tr><Td style='color:585858;line-height:180%;padding-left:20'>
						<b>[사용안내]</b><br>
						<b class=ol>ㆍ</b> 날짜는 1월1일은 01-01로 12월31일은 12-31로 1자리숫자의 경우 앞에 0을 붙여서 입력하시기 바랍니다.
				    </td>
				</tr>
			</table>

			<table border=0 cellpadding=0 cellspacing=0>
				<tr><td height=50></td></tr>
			</table>


			<!--본문 끝---------------------------------------------------------------------------------------->

<table border=0 cellpadding=0 cellspacing=0>
    <tr><td height=50></td></tr>
</table>

<!--본문 끝---------------------------------------------------------------------------------------->


							</td>
					</tr>
				</table>
	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->
</body>
</html>
