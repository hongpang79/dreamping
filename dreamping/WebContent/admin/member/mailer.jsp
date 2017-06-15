<!--common Top Start//-->
<html>
<head>
<title></title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<link rel="stylesheet" type="text/css" href="http://img.cafe24.com/css/text_button.css">
<script language=javascript src='/cjs/javascript.lib.js'></script>
</head>

<body bgcolor='#FFFFFF' topmargin='0' leftmargin='0'>
<!-- common Top End //-->

<!-- 2009.09.29 메일보내기 textarea를 에디터로 변경해달라는 요청이 있어서 추가 -->
<script type="text/javascript" src="/cjs/javascript.lib.js"></script>
<script type="text/javascript" src="/cjs/webeditor/builder.webedit.js"></script>
<!-- 2009.09.29 메일보내기 textarea를 에디터로 변경해달라는 요청이 있어서 추가 -->

<script language="JavaScript">
<!--

function setComma(str)
{
	str = ""+str+"";
	var retValue = "";
	for(i=0; i<str.length; i++)
	{
		if(i > 0 && (i%3)==0) {
			retValue = str.charAt(str.length - i -1) + "," + retValue;
		 } else {
			retValue = str.charAt(str.length - i -1) + retValue;
		}
	}
	return retValue;
}

function preview_mail()
{

	var frmName = document.frm;
    builderEditor.Send('content');

	var myWin = window.open("", "mail_preview", "width=700,height=600,scrollbars=1,resizable=1,status=0" );
	myWin.document.open();
	myWin.focus();
	myWin.document.write(frmName.content.value);
	myWin.document.write(frmName.unsubscribe.value);
	myWin.document.write("<br><br><br><br><br><center>");
	myWin.document.write("<input type=button style=\"font: 9pt 굴림; height:23px; width:80px\" value=\" 닫    기 \" onclick=\"javascript:window.close();\">");
	myWin.document.close();
}

function form_check( form )
{
    builderEditor.Send('content');
    if(form.senderName.value.match(/^\s*$/)) {
        alert( '보내는 사람 이름을 입력해주세요!' );
		form.senderName.focus();
		return ;
    }
    if(form.senderEmail.value.match(/^\s*$/)) {
        alert( '보내는 사람 이메일을 입력해주세요!' );
		form.senderEmail.focus();
		return ;
    }

    if(!isValidEmail(form.senderEmail.value)) {
        alert( '이메일 형식이 맞지 않습니다.' );
		form.senderEmail.focus();
		return ;
    }

	if(form.title.value.match(/^\s*$/))
	{
		alert( '제목을 입력해주세요!' );
		form.title.focus();
		return ;
	}

	if(form.content.value.match(/^\s*$/))
	{
		alert( '메일내용을 입력해주세요!' );
		return ;
	}
	form.submit();
}

function isValidEmail(email)
{
    invalidChars = " /:,;";
    if(email == "")
    {
        return false;
    }
    for(i=0;i<invalidChars.length;i++)
    {
        badchar = invalidChars.substring(i,i+1);
        if(email.indexOf(badchar, 0) > -1)
        {
                return false;
        }
    }
    atPos = email.indexOf("@",1);
    if(atPos == -1) {
        return false;
    }
    if(email.indexOf("@",atPos+1) > -1)
    {
        return false;
    }
    periodPos = email.indexOf(".",atPos)
    if(periodPos == -1) {
        return false;
    }
    if(periodPos + 3 > email.length)
    {
        return false;
    }
    return true;
}

function boxview(obj) {

	if(obj.mail_type.selectedIndex == 0)
	{
		document.all.msg.innerHTML = '회원에게 뉴스, 이벤트 정보를 전하고자 할 경우';
		obj.title.value = '(동의)';
		document.all.Type1.style.display = 'inline';
    document.all.Type2.style.display = 'none';
	}
	else if(obj.mail_type.selectedIndex == 1)
	{
		document.all.msg.innerHTML = '회원에게 제품(또는 서비스)이나 특정 사항을 알리는 경우';
		obj.title.value = '(동의)';
		document.all.Type1.style.display = 'inline';
    document.all.Type2.style.display = 'none';
	}
	else if(obj.mail_type.selectedIndex == 2)
	{
		document.all.msg.innerHTML = '운영자가 필요하다고 판단되는 기타 정보';
		obj.title.value = '(동의)';
		document.all.Type1.style.display = 'inline';
    document.all.Type2.style.display = 'none';
	}
	else
	{
		document.all.msg.innerHTML = '전체회원에게 싸이트를 폐쇄하거나 운영약관 변경을 알려야 할 긴급상황인 경우';
		obj.title.value = '(광고)';
		document.all.Type1.style.display = 'none';
    document.all.Type2.style.display = 'inline';
	}

}

function mini_help_window_open( page, name, top, left, width, height )
{
        window.open( page, name,
        'toolbar=no, location=no, directories=no, status=no, ' +
        'menubar=no, scrollbars=yes, resizable=yes, width=' +
        width + ', height=' + height +
        ', top=' + top + ', left=' + left );
}

function setFormReset()
{
    builderEditor.Reset('content');
    document.frm.reset();
}

// -->
</script>

<style type="text/css">
	.table_darkgray
	{
		color: black;
		background: "#B4B4B4";
	}
	.table_gray
	{
		color: black;
		background: "#EEEEEE";
	}
	.gray01
	{
		color: "#8B3C68";
		background: white;
	}
</style>


     <!-- 상단 TOP Menu S -->
     <jsp:include page="/admin/member/menu_top.jsp" />
     <!-- 상단 TOP Menu E -->	 
     
    <table border=0 cellpadding=0 cellspacing=0 width=993 style='table-layout:fixed;'>
		<col width=175></col>
	<col width=18></col>
	<col width=></col>
		<tr valign=top>
				<td bgcolor=F7F7F7>
			<!--왼쪽 타이틀------------------------------------------------->
			<jsp:include page="/admin/member/menu_left.jsp" />
			<!--//왼쪽 타이틀------------------------------------------------->
    
		</td>
		<td></td>
				<td>
			<!-본문 타이틀------------------------------------------------------------>
			<table border=0 cellpadding=0 cellspacing=0 width=800>
				<tr style='padding:22 0 2 0' valign=bottom>
					<td class='stitle'><img src=../img/bl_stitle.gif>&nbsp;전체메일 보내기</td>
					<td align='right' class=history>나의 사이트관리 > 전체메일 보내기</td></tr>
				<tr><td colspan=2 height=1 bgcolor=D9D9D9></td></tr>
			</table>


				<!------>
				<table width="770" border="0" cellspacing="0" cellpadding="10" align="left">
					<tr>
					  <td>
						<table width="770" border="0" cellspacing="0" cellpadding="0">
						  <tr>
							<td height="10"></td>
						  </tr>
						  <tr>
							<td >
							  <table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
								  <td width="11" height="15">
									<table width="11" border="0" cellspacing="0" cellpadding="0" height="11">
									  <tr>
										<td bgcolor="1A8AD5" class="a_w">
										  <div align="center">→</div>
										</td>
									  </tr>
									</table>
								  </td>
								  <td width="5" height="15">&nbsp;</td>
								  <td class="title_b" height="15">전체메일 보내기</td>
								</tr>
							  </table>
							</td>
						  </tr>
						  <tr>
							<td height="5"></td>
						  </tr>
						  <tr>
							<td class="importance_blue">
						<font color="#08457B">
						메일 발송 서비스가 무분별한 스팸 메일 발송 등에 이용되지 않도록 제한하기 위한 방편이며,<br>
						스팸 메일 방지 방안이 마련되면, 모든 운영자님께서 해당 서비스를 이용하실 수 있도록 하겠습니다.<br><br>
						스팸메일을 발송할시 약관에 의거 홈페이지를 폐쇄할 수도 있으니, 주의하시기 바랍니다.
						</font>
						</td>
						  </tr>
						  <tr>
							<td height="10"></td>
						  </tr>
						  <tr>
							<td>


				<!-- 이용안내 문구 시작 -->
				<table width="750" border="0" cellpadding="0" cellspacing="0">
				  <tr>
					<td width="15"><img src="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_up_leftimg.gif" width="15" height="14"></td>
					<td background="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_bg_upback.gif"><img src="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_bg_upback.gif" width="12" height="14"></td>
					<td width="15"><img src="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_up_rightimg.gif" width="15" height="14"></td>
				  </tr>
				  <tr>
					<td background="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_bg_leftback.gif"><img src="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_bg_leftback.gif" width="15" height="12"></td>
					<td><table width="750" border="0" cellpadding="0" cellspacing="0">
						<tr>
						  <td width="14">&nbsp;</td>
						  <td class="table_white" style="padding:10px">

※ 월 <script>document.write(setComma('3000'));</script>건 무료 발송 서비스
(<b>0 / 3000건</b>)
- <font color=red><b><script>document.write(setComma('3000'));</script></b></font>(개)의 메일 발송 가능<br>
※ 전체회원 : 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
메일수신 허가회원 : 0

						   </td>
						</tr>
					  </table></td>
					<td background="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_bg_rightback.gif"><img src="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_bg_rightback.gif" width="15" height="12"></td>
				  </tr>
				  <tr>
					<td><img src="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_down_leftimg.gif" width="15" height="14"></td>
					<td background="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_bg_downback.gif"><img src="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_bg_downback.gif" width="12" height="14"></td>
					<td><img src="http://img0001.echosting.cafe24.com/admin/center/newadmin/i/tbl_down_rightimg.gif" width="15" height="14"></td>
				  </tr>
				</a>
				</table>
				<!-- 이용안내 문구 끝 -->


						</td>
						  </tr>
						  <tr>
							<td height="15"></td>
						  </tr>
						  <tr>
							<td>

				<!-- 메일대상 검색 테이블 시작 -->
				  <form name="frm" method="post" action="/admin/myinform/mailer.php" onsubmit="return form_check( this )">
				  <input type='hidden' name='do' value='listup'>
				  <input type='hidden' name='send_flag' value='T'>
				  <input type='hidden' name='mail_point' value='3000'>




				<!--
				  다음 온라인우표제 폐지.
				  2005-05-30
				  <input type='hidden' name='non_mail_point' value='0'>
				  <input type='hidden' name='daum_mail_point' value=''>
				-->

						<table cellspacing=0 cellpadding=0 width=100% border=0 class="table_darkgray">
						<tr>
							<td>
								<table cellspacing=1 cellpadding=3 width="100%" border=0 class="gray01">
                                <tr>
                                    <td align=center width=150 nowrap class="table_gray">보내는사람</td>
									<td class="table_white">
										<input type="text" name="senderName" value=""/>
									</td>
                                </tr>
                                <tr>
                                    <td align=center width=150 nowrap class="table_gray">보내는 사람 이메일 </td>
									<td class="table_white">
										<input type="text" name="senderEmail" style='width:200;' value=""/>
									</td>
                                </tr>
								<tr>
									<td align=center width=150 nowrap class="table_gray">메일구분</td>
									<td class="table_white">
										<select size=1 name=mail_type onchange="boxview(this.form)">
											<option value='letter'>뉴스레터 [수신허가회원]</option>
											<option value='ad'>홍보 [수신허가회원]</option>
											<option value='etc'>기타 [수신허가회원]</option>
											<option value='notice'>긴급공지사항 [모든회원]</option>
										</select>
										<span id='msg' color=#ff8644>회원에게 뉴스, 이벤트 정보를 전하고자 할 경우</span>
									</td>
								</tr>
								<tr>
									<td align=center class="table_gray">메일제목</td>
									<td class="table_white"><input type=text name='title' size=85 maxlength=85 style='width:600;' value='(동의)'></td>
								</tr>
<!--
								<tr>
									<td align=center width=100 class="table_gray">받는사람</td>
									<td class="table_white">
										<table border=0 width=100% cellpadding=1>

											<tr>
												<td width=90 class="table_white"><li>회원구분</td>
												<td class="table_white">
													<select name="group_list" size="1">
																							<option value='1'>일반회원</option>
																							<option value='4'>미미미</option>
																							<option value='2'>대리점</option>
																							<option value='3'>총판</option>
																							<option value='5'>리케아</option>
																							<option value='6'>산업가스</option>
																							<option value='7'>산업가스(울산1공장)</option>
																							<option value="all">회원 모두</option>
													</select>
												</td>
												<td width=80>&nbsp;</td>
											<tr><td colspan=3></td></tr>
											<tr>
												<td class="table_white"><li>성별</td>
												<td class="table_white">
													<input type=radio name=sex value='all' checked>모두
													<input type=radio name=sex value='man'> 남자
													<input type=radio name=sex value='woman'> 여자
												</td>
												<td>&nbsp;</td>
											</tr>
										</table>
									</td>
								</tr>
 -->
 <!-- 문구 수정 kjm2006-07-19 -->
								<tr>
									<td align=center class="table_gray">메일내용</td>
									<td class="table_white">
										<div id="divContent"></div>
										<textarea name='content' id="content" ></textarea>
									</td>
								</tr>
								<tr>
									<td align=center class="table_gray">수신거부</td>
									<td id='Type1' style="display:" class="table_white">
										<textarea rows=5 cols=85 name='unsubscribe' style='font-size:9pt;font-family:굴림,tahoma;color:#555555;background-color:#EEEEEE;width:600;'><table cellspacing=0 cellpadding=5 border=0 align=center width='100%' style='background-color:#EEEEEE; color=black;'><tr><td style='padding:10px'>회원님의 메일 수신동의 여부를 2015-05-27 기준으로 확인해 본 결과, [builderdemo04.cafe24.com]에서 수신에 동의하셨기에 본 메일이 발송되었습니다.<br><a href="http://builderdemo04.cafe24.com/chtml/unsubscribe.php" target="_blank">더 이상 수신을 원치 않으시면 [여기]를 클릭하세요.<br>(If you don't want to receive this mail anymore, click here[Unsubscribe])</a><br><br>*본메일은 발신전용이므로 회신하실 경우 답변되지 않습니다. <br>-----------------------------------------------------------------------------------------------------------<br>주소 :  <br>전화번호 :  / <br>e-mail : </td></tr></table>
										</textarea>
									</td>

									<td id='Type2' style="display:none" class="table_white">
										<textarea rows=5 cols=85 name='unsubscribe1' style='font-size:9pt;font-family:굴림,tahoma;color:#555555;background-color:#EEEEEE;width:600;'><table cellspacing=0 cellpadding=5 border=0 align=center width='100%' style='background-color:#EEEEEE; color=black;'><tr><td style='padding:10px'>귀하의 메일주소는 [builderdemo04.cafe24.com]에서 취득하였습니다.<br><a href="http://builderdemo04.cafe24.com/chtml/unsubscribe.php" target="_blank">더 이상 수신을 원치 않으시면 [여기]를 클릭하세요.<br>(If you don't want to receive this mail anymore, click here[Unsubscribe])</a><br><br>*본메일은 발신전용이므로 회신하실 경우 답변되지 않습니다. <br>----------------------------------------------------------------------------------------------------------<br>주소 :  <br>전화번호 :  / <br>e-mail : </td></tr></table>
										</textarea>
									</td>
								</tr>
							</table>
				</td></tr></table></td></tr></table>

							<table cellspacing=0 cellpadding=10 width="100%" border=0>
								<tr>
									<td align=center>
									<table border=0 cellpadding=0 cellspacing=0>
											<tr>
												<td height=22 nowrap align=center>
													<img src="http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="다시쓰기" class="bt_a32 tmb22" onClick="setFormReset();">
												</td>
												<td width = '10'></td>
												<td height=22 nowrap align=center>
													<img src="http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="미리보기" class="bt_a32 tmb22" onClick="preview_mail();">
												</td>
												<td width = '10'></td>
												<td height=22 nowrap align=center>
													<img src="http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="보내기" class="bt_a32 tmb22" onClick="form_check(document.frm);">
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
				</form>
				<!-- 메일대상 검색 테이블 끝 -->




				<!-- 스팸메일 안내글 시작  문구 수정 2006-07-19 kjm-->
				<table width="770" border="0" cellspacing="0" cellpadding="0">
				<tr><td height="20"></td></tr>
				<tr><td>
				<!--
				<img src="http://www.spamcop.or.kr/images/asGuidelines/tl_infotran.gif" width="280" height="33">--></td></tr>
				<tr><td height="1" bgcolor="#E6EBED"></td></tr>
				</table>


			 <table width="770" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>

								 <table width="100%" border="0" cellpadding="5" cellspacing="3" bgcolor="#E8E8E8">
									<tr>
										<td  align="justify" bgcolor="#FFFFFF" class="gray">
											<table width="100%" border="0" cellspacing="0" cellpadding="5">
												<tr>
													<td>

														<table width="100%" border="0" cellspacing="0" cellpadding="5">
															<tr>
																<td></td>
																<td class="table_white">● 제목 앞에 "(광고)" 또는 "(성인광고)" 문구 및 <u>제목 끝에 "@"를 표시해야 하며</u>, 본문 란의 주용내용을 제목으로 명시해야 함.</td>
															</tr>
															<tr>
																<td></td>
																<td class="table_white">● 또한 본문 안에는 <u>전송자의 명칭/연락처</u> 및 <u>한글과 영문의 수신거부 방법</u>, <u>이메일 수집출처</u> 등을 명시해야 함.</td>
															</tr>
															<tr>
																<td></td>
																<td class="table_white">※ (광@고) (광  고) (광.고) ('성인광고') 같이 제목을 변칙 표기한 경우와 유니코드를 사용하여 문자를 조합한 경우 모두 과태료 대상</td>
															</tr>
															<tr>

															<tr>
															<td></td>
															<td class="table_white">※ 수신거부방법은 메일 본문 안에 회신할 전송자의 전자우편주소를 입력하거나 간단한 클릭만으로 바로 전송자의 수신거부 DB에 연결될 수 있도록 함.</td>
															</tr>

															<tr>
															<td></td>
															<td class="table_white">● 광고수신에 동의를 받은 이메일 전송자의 경우, 동법 시행령에 의거하여 "(광고)" 및 "@" 표시를 하지 않거나 "(동의)" 문구로 대신할 수 있는데, 전혀 표시를 하지 않는 경우 <u>광고 표기 의무를 준수하지 않는 스팸과 구별되지 않아 불이익을 보는 사례가 많기 때문에 "(동의)" 표기를 하는 것을 권장함.</u></td>
															</tr>
															<tr>
															<td></td>
															<td class="table_white">● 이 때, 본문란에는 동의를 얻은 시기 및 내용을 구체적으로 명시해야 함.</td>
															</tr>

															<tr>
															<td class="table_white" colspan="2"><font color="#4560D8">* 2005.12.30 개정 정보통신망법 스팸규제에 따른 스팸방지 가이드라인</font></td>
															</tr>

														</table>

													</td>
												</tr>

											</table>
										</td>
									</tr>
								</table>

					  <br>
					  <br>
					</td>
				  </tr>
				</table>
				<!-- 스팸메일 안내글 끝 -->



						</td>
						  </tr>
					</table>
					</td>
				  </tr>
				</table>
				<!------>



		</td>
	</tr>
</table>
	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->
</body>
</html>

<script type="text/javascript">
var tpl_name = 'base';



var editorConfig	=	{
	component	:	'mailer',
	template	:	tpl_name,
	target			:	'divContent',
	id				:	'content',
	charset		:	'euc-kr',
	width			:	'100%',
	height		:	'500',
	fontsize		:	'12px',
	fontfamily	:	'Dotum',
	fontcolor	:	'#000000',
	backgroundcolor	 :	'#FFFFF',
	value			:	'',

	//글자색 테이블 스타일 시작
	menu		:	[
		'<img src="/cjs/webeditor/images/fontOff.gif" align="absmiddle" id="fontname" style="cursor:pointer">',
		'&nbsp;',
		'<img src="/cjs/webeditor/images/sizeOff.gif" align="absmiddle" id="fontsize" style="cursor:pointer">',
		'&nbsp;',
		'<img src="/cjs/webeditor/images/t_bold.gif" align="absmiddle" id="bold" style="cursor:pointer">',
		'<img src="/cjs/webeditor/images/t_under.gif" align="absmiddle" id="underline" style="cursor:pointer">',
		'<img src="/cjs/webeditor/images/t_italic.gif" align="absmiddle" id="italics" style="cursor:pointer">',
		'<img src="/cjs/webeditor/images/t_over.gif" align="absmiddle" id="strike" style="cursor:pointer">',
		'<img src="/cjs/webeditor/images/t_color.gif" align="absmiddle" id="fontcolor" style="cursor:pointer" onMouseOver="this.src=\'/cjs/webeditor/images/t_color_on.gif\'" onMouseOut="this.src=\'/cjs/webeditor/images/t_color.gif\'">',
		'<img src="/cjs/webeditor/images/t_bg.gif" align="absmiddle" id="fontbgcolor" style="cursor:pointer" onMouseOver="this.src=\'/cjs/webeditor/images/t_bg_on.gif\'" onMouseOut="this.src=\'/cjs/webeditor/images/t_bg.gif\'">',
		'&nbsp;',
		'<img src="/cjs/webeditor/images/c_left.gif" align="absmiddle" id="justifyleft" style="cursor:pointer" onMouseOver="this.src=\'/cjs/webeditor/images/c_left_on.gif\'" onMouseOut="this.src=\'/cjs/webeditor/images/c_left.gif\'">',
		'<img src="/cjs/webeditor/images/c_center.gif" align="absmiddle" id="justifycenter" style="cursor:pointer" onMouseOver="this.src=\'/cjs/webeditor/images/c_center_on.gif\'" onMouseOut="this.src=\'/cjs/webeditor/images/c_center.gif\'">',
		'<img src="/cjs/webeditor/images/c_right.gif" align="absmiddle" id="justifyright" style="cursor:pointer" onMouseOver="this.src=\'/cjs/webeditor/images/c_right_on.gif\'" onMouseOut="this.src=\'/cjs/webeditor/images/c_right.gif\'">',
		'<img src="/cjs/webeditor/images/c_justis.gif" align="absmiddle" id="justifyfull" style="cursor:pointer" onMouseOver="this.src=\'/cjs/webeditor/images/c_justis_on.gif\'" onMouseOut="this.src=\'/cjs/webeditor/images/c_justis.gif\'">',
		'&nbsp;',
		'<img src="/cjs/webeditor/images/img.gif" align="absmiddle" id="imgupload" style="cursor:pointer" onMouseOver="this.src=\'/cjs/webeditor/images/img_on.gif\'" onMouseOut="this.src=\'/cjs/webeditor/images/img.gif\'">',
		'&nbsp;',
		'<img src="/cjs/webeditor/images/layout.gif" align="absmiddle" id="layout" style="cursor:pointer">',
		'&nbsp;<input type="checkbox" id="editmode">HTML'
	]
};
new builderEditor.Create(editorConfig);
</script>
