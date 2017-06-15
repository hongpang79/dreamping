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
     
    <link rel="stylesheet" href="/cjs/jquery/css/flora.all.css">
<script type="text/javascript" src="/cjs/jquery/jquery-1.2.6.js"></script>
<script type="text/javascript" src="/cjs/jquery/jquery.ui.all.js"></script>
<script language='javascript'>


    window.onload = function() {
        dateSetting('#sdate');
        dateSetting('#edate');
    }

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

	function secedePop(uri , w , h, m_id) {
		var features = "width=" + w + ",height=" + h;
		window.open(uri + "?m_id=" + m_id, 'popup' , features);
	}

	function popWin2(uri , w , h) {
		var search_about = document.form_s.search_about.options[document.form_s.search_about.selectedIndex].value;
		var search_about_txt = document.form_s.search_about.options[document.form_s.search_about.selectedIndex].text;
		var features = "width=" + w + ",height=" + h;
		window.open(uri + "?search_about=" + search_about + "&search_about_txt=" + search_about_txt + "&smode=auth", 'popup' , features);
	}

	function type_search(type) {
		var form = document.getElementById('form_s');

		var ipt = document.createElement( 'input' );
		ipt.setAttribute( 'type' , 'hidden' );
		ipt.setAttribute( 'name' , 'type' );
		ipt.setAttribute( 'value' , type);
		form.appendChild( ipt );
		form.submit();

	}


</script>

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
					<td class='stitle'><img src=../img/bl_stitle.gif>&nbsp;회원인증</td>
					<td align='right' class=history>사이트관리>회원가입관리>회원인증</td></tr>
				<tr><td colspan=2 height=1 bgcolor=D9D9D9></td></tr>
			</table>

			<!--본문 내용 시작--------------------------------------------------------->

										<div style='padding:14 0 10 0;'>
					<img src='/admin/img/bl_blue.gif'>회원검색
				</div>
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
						<td class='tbctr' align=center>검색입력</td>
						<td class='tbcont' style='padding:5 0 3 8;'>
							<select name='search_about' class='txt' align='absmiddle'>
								<option value='m_id'      >아이디</option>
								<option value='name'      >이름</option>
								<option value='email'     >이메일</option>
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

				<table border=0 cellpadding=0 cellspacing=0 width=800>
					<tr style='padding:22 0 2 0' valign=bottom>
						<td height='25'><img src=../img/bl_blue.gif><b>회원가입 요청  대기 리스트</b> (대기 : <font color='2A20FF'>0명</font>/ 보류 : <font color='F9495A'>0명)</font></td>
						<td align='right'>
							<select name='type' onchange="type_search(this.options[this.selectedIndex].value)">
								<option value='a'>전체</option>
								<option value='w'>대기</option>
								<option value='f'>보류</option>
							</select>
						</td>
					</tr>
				</table>

				<script language='JavaScript'>
				
				function set_Mem_Auth(gubun)
				{
					var form = document.form;
					var chk = check(form);
					if(gubun == "") {
						alert("처리 단계 정보가 없습니다.");
						return;
					}

					var gubun_txt;
					if(gubun == "Y")			gubun_txt = "회원인증";
					else if(gubun == "N")	gubun_txt = "인증거부";

					if(!chk) {
						alert(gubun_txt+" 처리 할 회원을 선택하세요.");
						return false;
					}

					if(gubun == "N") {
						if (confirm("선택하신 회원의 회원가입인증을 거부합니다.\r\n해당 회원은 보류 상태로 전환됩니다.") == false) return;
					}

					form.gubun.value = gubun;
					form.submit();
				}

				//체크박스 체크
				function check(form)
				{
					var check = 0;
					for(var i = 0; i < form.elements.length; i++) {
						if(form.elements[i].type == "checkbox") {
							if(form.elements[i].checked) {
								check =1;
								break;
							}
						}
					}

					if(check) {
						return true;
					} else {
						return false;
					}
				}

				//체크박스
				function checkboxAll(form)
				{
					if(form.checkbox.checked == true) {
						for(var i = 0; i < form.elements.length; i++) {
							if(form.elements[i].type == "checkbox") {
								form.elements[i].checked = true;
							}
						}
					} else {
						for(var i = 0; i < form.elements.length; i++) {
							if(form.elements[i].type == "checkbox") {
								form.elements[i].checked = false;
							}
						}
					}
				}

				function chkDel(form)
				{
					var chk	=	check(form);

					if(!chk) {
						alert('삭제할 회원을 선택해주세요.');
						return false;
					}

					var ans = confirm('정말 삭제하시겠습니까?');

					if(ans == true) {
						form.target		=	'_self';
						form.method	=	'POST';
						form.action		=	'/admin/site/site_member_auth_del.php';
						form.submit();
					}
				}

				
				</script>



				<table border=1 cellpadding=0 cellspacing=0 width=800 style='border-collapse:collapse;' bordercolor=D3D3D3>
				<form name='form' method='post' action='./site_member_auth_YN.php?detailmenu=config' target='f_hidden'>
					<input type='hidden' name='chk_id' value=''>
					<input type='hidden' name='chk_id_list' value=''>
					<input type='hidden' name='gubun' value=''>
					<tr align='center'>
						<td class='tbctr'>
							<input type='checkbox' name="checkbox" onClick="checkboxAll(this.form)"></td>
						<td class='tbctr'>번호</td>
						<td class='tbctr'>회원가입일자</td>
						<td class='tbctr'>회원그룹</td>
						<td class='tbctr'>회원이름</td>
						<td class='tbctr'>회원ID</td>
                        <td class='tbctr'>대기상태</td>
					</tr>

					
				</table>

				<!--page number---->
				<table border=0 cellpadding=0 cellspacing=0 align=center width='100%' style='margin-top:20'>
				   <tr>
				    	<td class=pagenum height=34 align='center'>

				    		
<table border=0 cellspacing=0 cellpadding=0 width=92%>
<tr height=30>
	<td align=center></td></tr>
</table>

				    	</td>
				    </tr>
				    <tr>
						<td align='center'>
							<img src="http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="회원인증" class="bt_a32 tmb22" onClick="set_Mem_Auth('Y');">
							<img src="http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="인증거부" class="bt_a32 tmb22" onClick="set_Mem_Auth('N');">
                            							<img src="http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value=" 삭제 " class="bt_a32 tmb22" onClick="chkDel(this.form);">
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