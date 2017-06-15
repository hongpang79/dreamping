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
<!-- common Top End //--><link rel="stylesheet" href="/cjs/jquery/css/flora.all.css">
<script type="text/javascript" src="/cjs/jquery/jquery-1.2.6.js"></script>
<script type="text/javascript" src="/cjs/jquery/jquery.ui.all.js"></script>
<script type="text/javascript" src="/cjs/jquery/jquery.sx.popup.js"></script>
<script language='javascript'>


	function date_setting(mode){
		if(mode=="day"){
			document.all.sdate.value="2015-05-27";
			document.all.edate.value="2015-05-27";
		}else if(mode=="week"){
			document.all.sdate.value="2015-05-20";
			document.all.edate.value="2015-05-27";
		}else if(mode=="1month"){
			document.all.sdate.value="2015-04-27";
			document.all.edate.value="2015-05-27";
		}else if(mode=="3month"){
			document.all.sdate.value="2015-02-27";
			document.all.edate.value="2015-05-27";
		}
	}

	function dateSetting(els) {
		$(document).ready(function(){$(els).datepicker({dateFormat: "yy-mm-dd", showOn: "both", buttonImage: "/admin/aimg/franchise/btn_calendar.gif", buttonImageOnly: true,
			clearText: "초기화",
			closeText: "닫기",
			currentText: "오늘",
			prevText: "이전달",
			nextText: "다음달",
			monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
			dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"]
	})});
	}
	// 등급변경
	function member_change_level()
	{
		var sel_seq = '';

		if(document.form.total_cnt.value > 1)
		{
			for(i=0; i<document.form.sel_mem.length; i++)
			{
				if(document.form.sel_mem[i].checked == true)
				{
					if (sel_seq != '') sel_seq = sel_seq + ',';

					sel_seq = sel_seq + document.form.sel_mem[i].value;
				}
			}
		}
		else if(document.form.sel_mem.checked == true) sel_seq = document.form.sel_mem.value

		var level = document.form.change_level.options[document.form.change_level.selectedIndex].value;
		var group = document.form.change_group.options[document.form.change_group.selectedIndex].value;

		if(sel_seq == false)
		{
			alert('등급변경하기 위한 회원을 선택하세요.');
			return;
		}
		else if(level == '' && group == '')
		{
			alert('변경할 등급 또는 레벨을 선택하세요.');
			return;
		}
		else
		{
			document.form.action = 'site_member_list.php?mode=change_level';
			document.form.method = 'post';
			document.form.sel_seq.value = sel_seq;
			document.form.submit();
		}
	}

	function secedePop(uri , w , h, m_seq) {
		var features = "width=" + w + ",height=" + h;
		window.open(uri + "?m_seq=" + m_seq, 'popup' , features);
	}

	function popWin2(uri , w , h) {
		var search_about = document.form_s.search_about.options[document.form_s.search_about.selectedIndex].value;
		var search_about_txt = document.form_s.search_about.options[document.form_s.search_about.selectedIndex].text;
		var features = "width=" + w + ",height=" + h;
		window.open(uri + "?search_about=" + search_about + "&search_about_txt=" + search_about_txt, 'popup' , features);
	}

	function foreigner_search(is_foreigner) {
		var form = document.getElementById('form_s');

		var ipt = document.createElement( 'input' );
		ipt.setAttribute( 'type' , 'hidden' );
		ipt.setAttribute( 'name' , 'is_foreigner' );
		ipt.setAttribute( 'value' , is_foreigner);
		form.appendChild( ipt );
		form.submit();

	}


	function checkAll( e ) {
		if( !e ) return;
		var srcE = ( e.target ? e.target : e.srcElement );
		var tb = srcE.offsetParent.offsetParent.offsetParent;
		var ipts = tb.getElementsByTagName( 'input' );

		for( var i = 0 ; i < ipts.length ; i++ ) {

			if( ipts[ i ].type != 'checkbox' || ipts[i].disabled) continue;
			ipts[ i ].checked = srcE.checked;
		}
	}

	initial_command();
	function initial_command()
	{
		if(!window['jQuery'])
		{
			setTimeout("initial_command()",100);
			return;
		}
		dateSetting('#sdate');
		dateSetting('#edate');
		$(document).ready(function(){
			var opt = {  width: '700px' , height : '800px' , scrollbars : 1  }
			$('A[rel="external"]').popup(opt);
		});
	}
	// 회원DB백업
	function member_backup()
	{
		document.form.action = 'site_member_excelAct.php?mode=memberBackup';
		document.form.method = 'get';
		document.form.submit();
	}

</script>

     <!-- 상단 TOP Menu S -->
     <jsp:include page="/admin/member/menu_top.jsp" />
     <!-- 상단 TOP Menu E -->	       
    
<table border=0 cellpadding=0 cellspacing=0 width=993>
	<tr valign=top>
		<td width=175 bgcolor=F7F7F7>
			<!--왼쪽 타이틀------------------------------------------------->
			<jsp:include page="/admin/member/menu_left.jsp" />
			<!--//왼쪽 타이틀------------------------------------------------->
			
    
    
    
		</td>
		<td width=18><img src=/admin/img/e.gif width=18></td>
		<td>
			<!--본문 타이틀------------------------------------------------------------>
			<table border=0 cellpadding=0 cellspacing=0 width=800>
				<tr style='padding:22 0 2 0' valign=bottom>
					<td class='stitle'><img src=/admin/img/bl_stitle.gif>&nbsp;회원정보 조회</td>
					<td align='right' class=history>사이트관리>회원가입관리>회원정보조회</td>
				</tr>
				<tr><td colspan=2 height=1 bgcolor=D9D9D9></td></tr>
			</table>

			<!--본문 내용 시작--------------------------------------------------------->

			<script language=javascript src='/admin/js/site_member.js'></script>
			<script language=javascript src='/admin/js/common.js'></script>

			<table border=0 cellpadding=0 cellspacing=0 width=800>
				<tr><td height='10'></td></tr>
				<tr><td>
						<a href='./site_member_list.php?detailmenu=mgt'><img src='../img/tab_search_member_on.gif' align='absmiddle'></a>
						<a href='./site_outmember_list.php?detailmenu=mgt'><img src='../img/tab_mal_02.gif' align='absmiddle'></a>
						<a href='/admin/template_set/site_member_config_list.php'><img src='../img/tab_mal_01.gif' align='absmiddle'></a>
					</td>
				</tr>
			</table>

			<div style='margin-top:10'></div>

			<table border=1 cellpadding=7 cellspacing=0 width=800 style='border-collapse:collapse' bordercolor='D3D3D3'>
			<form method="get" action="" name="form_s">
			<input type='hidden' name='work_req' value='search'>
			<input type="hidden" name="search" value="y">
			<input type="hidden" name="seq" value="">
			<input type="hidden" name="mid" value="">
			<input type="hidden" name="tid" value="">
				<col width='150'></col>
				<col style='padding:10 0 0 0;'></col>
				<tr>
					<td class='tbctr' align=center rowspan=2>검색기간</td>
					<td class='tbcont' style='padding:5 0 3 8;'>
						<img src='/admin/aimg/franchise/tbtn_bg_021.gif' align='absmiddle' class='imp'><input type='button' onclick='date_setting("day")'    value=' 당일 ' class='bt_a31 tmb12'>
						<img src='/admin/aimg/franchise/tbtn_bg_021.gif' align='absmiddle' class='imp'><input type='button' onclick='date_setting("week")'   value=' 1주일 ' class='bt_a31 tmb12'>
						<img src='/admin/aimg/franchise/tbtn_bg_021.gif' align='absmiddle' class='imp'><input type='button' onclick='date_setting("1month")' value=' 1개월 ' class='bt_a31 tmb12'>
						<img src='/admin/aimg/franchise/tbtn_bg_021.gif' align='absmiddle' class='imp'><input type='button' onclick='date_setting("3month")' value=' 3개월 ' class='bt_a31 tmb12'>
					</td>
				</tr>
				<tr>
					<td class='tbcont'>
						<input type='text' id='sdate' name='sdate' class='border' size='15' value="">
						&nbsp;~&nbsp;&nbsp;<input type='text' id='edate' name='edate' class='border' size='15' value="">
					</td>
				</tr>
				<tr>
					<td class='tbctr' align=center>회원그룹</td>
					<td class='tbcont' style='padding:5 0 3 8;'>
						<select name='search_group' class='txt' align='absmiddle'>
							<option value='' selected>-회원그룹-</option>
							<option value=''>---------------------------------------</option>
													<option value='1' >그룹 1 : 운영자 (운영자 그룹)</option>
													<option value='2' >그룹 2 : 일반회원 (일반회원 그룹)</option>
												</select>
					</td>
				</tr>
				<tr>
					<td class='tbctr' align=center>회원등급</td>
					<td class='tbcont' style='padding:5 0 3 8;'>
						<select name='search_level' class='txt' align='absmiddle'>
							<option value='' selected>-회원등급-</option>
							<option value=''>---------------------------------------</option>
													<option value='1' >레벨 1 : 홈페이지 운영자 (운영자권한)</option>
													<option value='2' >레벨 2 : 운영팀1 </option>
													<option value='3' >레벨 3 : 운영팀2 </option>
													<option value='4' >레벨 4 : 운영팀3 </option>
													<option value='5' >레벨 5 : 특별회원 </option>
													<option value='6' >레벨 6 : 최우수회원 </option>
													<option value='7' >레벨 7 : 우수회원 </option>
													<option value='8' >레벨 8 : 정회원 </option>
													<option value='9' >레벨 9 : 일반회원 (기본회원)</option>
													<option value='10' >레벨 10 : 불량회원 (불량회원)</option>
												</select>
					</td>
				</tr>
				<tr>
					<td class='tbctr' align=center>검색입력</td>
					<td class='tbcont' style='padding:5 0 3 8;'>
						<select name='search_about' class='txt' align='absmiddle'>
							<option value='m_id'      >아이디</option>
							<option value='name'      >이름</option>
							<option value='email'     >이메일</option>
                            <option value='nickname'     >별명(닉네임)</option>
						</select>
						<input type='text' name='search_txt' id='border' size='15' align='absmiddle' value=''>
						<img src='/admin/aimg/franchise/tbtn_bg_021.gif' align='absmiddle' class='imp' style='margin:0'><input type='button' value=' 찾기 ' class='bt_a31 tmb12' onclick="popWin2('site_member_popup.php',320,300)">
					</td>
				</tr>
				<tr>
					<td colspan='2'><div id='search_help'></div></td>
				<tr>
			</table>
			<div style='margin-top:10;text-align:center'>
				<img src='/admin/aimg/franchise/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='submit' value=' 검 색  ' class='bt_a32 tmb22' >
			</div>
			</form>


			<!--회원 그룹별 목록보기-->
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr height=30>
					<td><img src='/admin/img/bl_blue.gif'>회원(총 0명)</td>
					<td align=right>
						<select name='is_foreigner' onChange='foreigner_search(this.options[this.selectedIndex].value)'>
							<option value='' selected>-내/외국인-</option>
							<option value='Y' >외국인</option>
							<option value='N' >내국인</option>
						</select>
						<img src='/admin/aimg/franchise/tbtn_bg_021.gif' align='absmiddle' class='imp' style='margin:0'><input type="button" value=" 회원DB백업 " class="bt_a31 tmb21" onClick="member_backup()">
					</td>
				</tr>
			</table>

			<table border=1 cellpadding=0 cellspacing=0 width=800 style=border-collapse:collapse bordercolor=D3D3D3>
			<form name='form' method='post' action='./site_member_del.php?detailmenu=mgt' target='f_hidden'>
				<input type='hidden' name='total_cnt' value='0'>
				<input type='hidden' name='sel_seq' value=''>
				<input type='hidden' name='mode' value='memberBackup'>
				<tr class=tbctr align=center>
					<td height='35'><input type='checkbox' onclick="checkAll(event)"></td>
					<td>번호</td>
					<td>내/외국인</td>
					<td>가입일</td>
					<td>회원등급</td>
					<td>회원그룹</td>
					<td>이름</td>
					<td>아이디</td>
					<td>이메일</td>
					<td>휴대전화</td>
					<td>SMS<br> 수신여부</td>
					<td>이메일<br> 수신여부</td>
					<td width=68>탈퇴처리</td>
				</tr>
								<tr height=30 align='center'>
					<td colspan='14'>조회된 결과가 없습니다.</td>
				</tr>
							</table>

			<!--table border='1' cellpadding=0 cellspacing=0 width=500 style='border-collapse:collapse;margin-top:10' bordercolor=D3D3D3>
				<tr><td class='tbsbj'>선택회원</td>
					<td class='tbcont'>
						<select class='txt' align='absmiddle'>
							<option>AAAA</option>
						</select>
						그룹으로
						<input type='checkbox' class='radio' style='margin-left:20'>이동
						<input type='checkbox' class='radio' style='margin-left:20'>추가
					</td>
				</tr>
			</table-->

			<table border='1' cellpadding='0' cellspacing='0' width='800' height='35' style='margin-top:10;' bordercolor='#D3D3D3'>
				<tr>
					<td class='tbsbj' style='padding-right:20;text-align:left;'>
						선택한 회원을
						<select name='change_level' class='txt'>
							<option value=''>- 회원등급 -</option>
							<option value=''>---------------------------</option>
						                            						                            							<option value='2'>등급 2 : 운영팀1 </option>
                            						                            							<option value='3'>등급 3 : 운영팀2 </option>
                            						                            							<option value='4'>등급 4 : 운영팀3 </option>
                            						                            							<option value='5'>등급 5 : 특별회원 </option>
                            						                            							<option value='6'>등급 6 : 최우수회원 </option>
                            						                            							<option value='7'>등급 7 : 우수회원 </option>
                            						                            							<option value='8'>등급 8 : 정회원 </option>
                            						                            							<option value='9'>등급 9 : 일반회원 (기본회원)</option>
                            						                            							<option value='10'>등급 10 : 불량회원 (불량회원)</option>
                            												</select>
						<select name='change_group' class='txt' align='absmiddle'>
							<option value='' selected>- 회원그룹 -</option>
							<option value=''>---------------------------</option>
													<option value='1' >그룹 1 : 운영자 (운영자 그룹)</option>
													<option value='2' >그룹 2 : 일반회원 (일반회원 그룹)</option>
												</select>
						(으)로
						<img src="http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_021.gif" align="absmiddle" class="imp" style="margin-top:3px"><input type="button" value=" 변경 " class="bt_a31 tmb21" onClick="member_change_level()">
					</td>
				</tr>
			</table>

			<!--page number---->
			<table border=0 cellpadding=0 cellspacing=0 align=center width='100%' style='margin-top:10'>
			   <tr>
			    	<td class=pagenum height=34 align='center'>

			    		
<table border=0 cellspacing=0 cellpadding=0 width=92%>
<tr height=30>
	<td align=center></td></tr>
</table>

			    	</td>
			    </tr>

			    
			</form>
			</table>

			<table border=0 cellpadding=0 cellspacing=0>
				<tr><td height=50></td></tr>
			</table>

			<iframe name='f_hidden' width=0 height=0 frameboarder=0 scrolling='yes'></iframe>

			<!--본문 끝---------------------------------------------------------------------------------------->

		</td>
	</tr>
</table>

	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->

</body>
</html>