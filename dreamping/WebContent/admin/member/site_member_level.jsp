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
	 <!-- 상단 TOP Menu S -->
     <jsp:include page="/admin/member/menu_top.jsp" />
     <!-- 상단 TOP Menu E -->	 
    
<table border='0' cellpadding='0' cellspacing='0' width='993'>
	<tr valign='top'>
		<td width='175' bgcolor='#F7F7F7'>
			
    		<!--왼쪽 타이틀------------------------------------------------->
			<jsp:include page="/admin/member/menu_left.jsp" />
			<!--//왼쪽 타이틀------------------------------------------------->
    
		</td>
		<td width='18'><img src='/admin/img/e.gif' width='18'></td>
		<td>
			<!--본문 타이틀------------------------------------------------------------>
			<table border='0' cellpadding='0' cellspacing='0' width='800'>
				<tr style='padding:22 0 2 0' valign=bottom>
					<td class='stitle'><img src='/admin/img/bl_stitle.gif' border='0'>&nbsp;회원등급 관리</td>
					<td align='right' class='history'>회원관리>회원가입관리>회원등급관리</td></tr>
				<tr><td colspan='2' height='1' bgcolor='#D9D9D9'></td></tr>
			</table>

			<table border='0' cellpadding='0' cellspacing='0'>
				<tr><td height='10'></td></tr>
			</table>

			<!--본문 내용 시작--------------------------------------------------------->
			<table border='1' cellpadding='0' cellspacing='0' width='500' style='border-collapse:collapse' bordercolor='#D3D3D3'>
			<form name='member_level' method='post' action='site_member_level.php'>
			<input type='hidden' name='mode' value='update'>
				<tr class='tbctr' align='center'>
					<td width='200'>회원등급</td>
					<td>등급 표시 이름(한글 10자, 영문 20자)</td>
				</tr>
							<tr height='30'>
					<td style='padding-left:20'>레벨 1 (운영자권한)</td>
					<td align='center'>
                                                <input type='text' id='border' value='홈페이지 운영자' size='40' maxlength='20' disabled style="background-color:#EFEFEF">
                        <input type='hidden' name='level[1]' value='홈페이지 운영자'>
                                            </td>
				</tr>
							<tr height='30'>
					<td style='padding-left:20'>레벨 2 </td>
					<td align='center'>
                                                <input type='text' id='border' name='level[2]' value='운영팀1' size='40' maxlength='20'>
                                            </td>
				</tr>
							<tr height='30'>
					<td style='padding-left:20'>레벨 3 </td>
					<td align='center'>
                                                <input type='text' id='border' name='level[3]' value='운영팀2' size='40' maxlength='20'>
                                            </td>
				</tr>
							<tr height='30'>
					<td style='padding-left:20'>레벨 4 </td>
					<td align='center'>
                                                <input type='text' id='border' name='level[4]' value='운영팀3' size='40' maxlength='20'>
                                            </td>
				</tr>
							<tr height='30'>
					<td style='padding-left:20'>레벨 5 </td>
					<td align='center'>
                                                <input type='text' id='border' name='level[5]' value='특별회원' size='40' maxlength='20'>
                                            </td>
				</tr>
							<tr height='30'>
					<td style='padding-left:20'>레벨 6 </td>
					<td align='center'>
                                                <input type='text' id='border' name='level[6]' value='최우수회원' size='40' maxlength='20'>
                                            </td>
				</tr>
							<tr height='30'>
					<td style='padding-left:20'>레벨 7 </td>
					<td align='center'>
                                                <input type='text' id='border' name='level[7]' value='우수회원' size='40' maxlength='20'>
                                            </td>
				</tr>
							<tr height='30'>
					<td style='padding-left:20'>레벨 8 </td>
					<td align='center'>
                                                <input type='text' id='border' name='level[8]' value='정회원' size='40' maxlength='20'>
                                            </td>
				</tr>
							<tr height='30'>
					<td style='padding-left:20'>레벨 9 (기본회원)</td>
					<td align='center'>
                                                <input type='text' id='border' name='level[9]' value='일반회원' size='40' maxlength='20'>
                                            </td>
				</tr>
							<tr height='30'>
					<td style='padding-left:20'>레벨 10 (불량회원)</td>
					<td align='center'>
                                                <input type='text' id='border' name='level[10]' value='불량회원' size='40' maxlength='20'>
                                            </td>
				</tr>
						</table>

			<table border='0' cellpadding='0' cellspacing='0'>
				<tr><td height='10'></td></tr>
			</table>

			

			<br>

			<div style='width:500' align='center'>
				<img src="http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="저장하기" class="bt_a32 tmb22" onClick="this.form.submit()">
				<img src="http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="취소하기" class="bt_a32 tmb22" onClick="this.form.reset();">
			</div>
			</form>

			<table border='3' cellpadding='7' cellspacing='0' width='800' bordercolor='#ECD08A' style='margin-top:40'>
				<tr><Td style='color:585858;line-height:180%;padding-left:20'>
						<b>[사용안내]</b><br>
						<b class=ol>ㆍ</b>홈페이지 운영자는 자동으로 레벨1(운영자 권한)으로 설정됩니다.<br>
						<b class=ol>ㆍ</b>회원가입을 하면 기본 레벨이 자동으로 레벨9로 설정되어 있으나 변경하실 수 있습니다.
					</td>
				</tr>
			</table>
			<!--본문 끝---------------------------------------------------------------------------------------->

			<table border='0' cellpadding='0' cellspacing='0'>
				<tr><td height='50'></td></tr>
			</table>
		</td>
	</tr>
</table>

	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->

</body>
</html>