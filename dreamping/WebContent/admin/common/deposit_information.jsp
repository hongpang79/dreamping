<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="reservation.DepositVO" %>
<%@ page import="admin.CommonDAO" %>
<%
request.setCharacterEncoding("UTF-8");
NumberFormat nf = NumberFormat.getInstance();

String cmd = request.getParameter("cmd")==null?"list":request.getParameter("cmd");
String msg = "";

if(!cmd.equals("list")){
	msg = CommonDAO.getInstance().processDeposit(request);	
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
	
function addForm(check,mode)
{
	if(mode == 'm'){
		frm = document.bankinfo;
		var bank_check=0;


        if(document.bankinfo["bank_idx[]"].length)
        {
            for(i=0;i<document.bankinfo["bank_idx[]"].length;i++)
            {
                if(document.bankinfo["bank_idx[]"][i].checked){
                    bank_check++;
                }
            }
        }
        else{
            if(document.bankinfo["bank_idx[]"].checked){
                bank_check=1;
            }
        }


		if(bank_check < 1){
			alert('수정할 무통장입금 계좌를 선택하세요.');
			return false;
		}
		else if(bank_check > 1){
			alert('수정할 무통장입금 계좌는 하나만 선택이 가능합니다.');
			return false;
		}
		else{
			frm.mode.value='modify_view';
			frm.submit();
		}
	}
	else{
		if(check == "T"){
			document.all.add.style.display='';
            document.addform.bank_acc_no.value='';
            document.addform.bank_depositor.value='';
            document.addform.is_active.value='';
            document.addform.bank_name.value='';
            document.addform.add_submit.value='등록하기';

            document.addform.cmd.value = "insert";
		}
		else{
			document.all.add.style.display='none';
		}
	}

    // [skyoon : 2009-11-10]
    checkBank(null);
}

function deleteCheck(account)
{
	frm = document.bankinfo;

	if(confirm('해당 계좌를 삭제하시겠습니까?') == true) {
		frm.cmd.value = 'delete';
		frm.account.value = account;
		frm.submit();
	}
}
function formCheck()
{
		var sform = document.addform;
		var bankusecheck=0;

		if(sform.bank_name.value.length == 0)
		{
			alert('은행을 선택하세요.');
			sform.bank_name.focus();
			return false;
		}

		for (i=0; i<sform.is_active.length; i++)
		{
			if(sform.is_active[i].checked){
			    bankusecheck++;
			}
		}

		if(bankusecheck < 1){
			alert('은행사용여부를 선택하세요.');
			return false;
		}

		if(sform.bank_acc_no.value.length == 0)
		{
			alert('계좌번호를 입력하세요.');
			sform.bank_acc_no.focus();
			return false;
		}

		if(sform.bank_depositor.value.length == 0)
		{
			alert('예금주를 입력하세요.');
			sform.bank_depositor.focus();
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

function checkBank(value) {
    document.getElementsByName('etc_bank_name')[0].value = '';
    if(value == 'etc') {
        document.getElementById('id_etc_bank_name').style.display = '';
    } else {
        document.getElementById('id_etc_bank_name').style.display = 'none';
    }
}
</script>
<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>무통장입금 계좌 설정</li>
	<li class="location">캠핑장관리>기본정보>무통장입금계좌설정</li>
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
						<form name='bankinfo' method='post' action='/admin/common/deposit_information.jsp'>
						<input type='hidden' name='cmd' value=''>
						<input type='hidden' name='account' value=''>
						<input type="hidden" id="msg" name="msg" value="<%=msg%>">
				      <thead>
						<tr height='28'>
							<th width='200' align="center">은행명</th>
							<th width='250' align="center">계좌번호</th>
							<th width='150' align="center">예금주</th>
							<th width='150' align="center">선택</th>
						</tr>
					  </thead>
<%
	Vector<DepositVO> vDeposit = CommonDAO.getInstance().selectDepositList();
	if (vDeposit == null){
%>						
						<tr height='28'>
							<td colspan="4" align="center">등록된 정보가 없습니다.</td>
						</tr>
<%
	}else{
		String bankName = "";
		String account = "";
		String depositor = "";
		
		DepositVO deposit = null;
		for(int i=0; i<vDeposit.size(); i++){
			deposit = vDeposit.get(i);
			bankName = deposit.getBankName();
			account = deposit.getAccount();
			depositor = deposit.getDepositor();
		
%>						
					<tr height='28'>
						<td width='200' align="center"><%=bankName %></td>
						<td width='250' align="center"><%=account %></td>
						<td width='150' align="center"><%=depositor %></td>
						<td width='150' align="center">
							<a href="javascript:;" onclick="javascript:deleteCheck('<%=account %>')">삭제</a>
						</td>
					</tr>
<%
		}
	}
%>					
					</table>
					<br>
<!--
					<div style='width:800' align='center'>
						<input type="button" name="bank_delete" value="선택계좌 삭제" onClick="javascript:deleteCheck()" style="cursor:hand">&nbsp;<input type="button" name="bank_mody" value="선택계좌 수정" onClick="javascript:addForm('T', 'm')" style="cursor:hand">&nbsp;<input type="button" name="bank_add" value="신규계좌 등록" onClick="javascript:addForm('T', 'i')" style="cursor:hand">
					</div>

					<div style='width:800' align='center'>
						<a href="#" onClick="javascript:deleteCheck(); return false;"><img src='/admin/img/common/btn_bank_del.gif'></a>
						<a href="#" onClick="javascript:addForm('T', 'm'); return false;"><img src='/admin/img/common/btn_modify.gif'></a>
						<a href="#" onClick="javascript:addForm('T', 'i'); return false;"><img src='/admin/img/common/btn_bank_add.gif'></a>
					</div>
 -->					
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
					<form name='addform' method='post' action='/admin/common/deposit_information.jsp' onSubmit='return formCheck()'>
					<input type='hidden' name='cmd' value='insert'>
						<tr height='28'>
							<td class='tbsbj' width='140'>은행명</td>
							<td class='tbcont'>
                                <div style="float:left">
								<select class='txt' name='bank_name' onchange="checkBank(this.value)">
								<option value=''>----------------------</option>
																	<option value='신한(조흥)은행' >신한(조흥)은행</option>
																	<option value='신용협동조합' >신용협동조합</option>
																	<option value='수출입은행' >수출입은행</option>
																	<option value='수협중앙회' >수협중앙회</option>
																	<option value='국민은행' >국민은행</option>
																	<option value='농협중앙회' >농협중앙회</option>
																	<option value='기업은행' >기업은행</option>
																	<option value='제주은행' >제주은행</option>
																	<option value='ABN-AMRO' >ABN-AMRO</option>
																	<option value='경남은행' >경남은행</option>
																	<option value='도이치은행' >도이치은행</option>
																	<option value='광주은행' >광주은행</option>
																	<option value='전북은행' >전북은행</option>
																	<option value='하나은행' >하나은행</option>
																	<option value='한국시티(한미)은행' >한국시티(한미)은행</option>
																	<option value='산업은행' >산업은행</option>
																	<option value='대구은행' >대구은행</option>
																	<option value='HSBC은행' >HSBC은행</option>
																	<option value='우체국' >우체국</option>
																	<option value='우리은행' >우리은행</option>
																	<option value='새마을금고' >새마을금고</option>
																	<option value='상호저축은행' >상호저축은행</option>
																	<option value='부산은행' >부산은행</option>
																	<option value='SC제일은행' >SC제일은행</option>
																	<option value='외환은행' >외환은행</option>
								                                <option value='etc' >기타직접입력</option>
								</select>
                                </div>
                                <div id="id_etc_bank_name" style="display:none"><input type="text" name="etc_bank_name" size="30" value=""></div>
							</td>
						</tr>
						<tr>
							<td class='tbsbj'>계좌번호</td>
							<td height='28' class='tbcont'>
								<input type='text' id='bank_acc_no' size='30' name='bank_acc_no' value="" onkeyDown="javascript:numnberCheck()">※ 숫자와 '-'만 입력 가능합니다.
							</td>
						</tr>
						<tr>
							<td class='tbsbj'>예금주</td>
							<td height='28' class='tbcont'>
								<input type='text' id='bank_depositor' size='15' maxlength='10' name='bank_depositor' value="">
							</td>
						</tr>
						<!-- 
						<tr>
							<td class='tbsbj'>은행사용여부</td>
							<td height='28' class='tbcont'>
																														<input type='radio' id='is_active' value="T" name='is_active'  >사용<input type='radio' id='is_active' value="F" name='is_active' checked>미사용
							</td>
						</tr>
						 -->

					</table>
					<br>
<!--
					<div style='width:800' align='center'>
						<input type="image" src='/admin/img/btn_modify.gif' name="add_submit" style="cursor:hand">&nbsp;<img src='/admin/img/btn_cancel.gif' name="add_cancel" onClick="javascript:addForm('F')">
					</div>
 -->

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
						<b class=ol>ㆍ</b> 무통장입금을 사용하고자 하는 은행을 선택 하신 후 계좌번호와 받을실 입금자명을 입력 해 주십시오.
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
