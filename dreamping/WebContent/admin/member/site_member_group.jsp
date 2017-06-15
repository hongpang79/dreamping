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
	

<script language="JavaScript" src="/cjs/javascript.lib.js"></script>
<script language="JavaScript">
var mid = '';
var tid = '';


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

	function addForm() {
		document.getElementById('layer_add_group').style.display='block';
		document.getElementById('mode').value = 'write';
		document.getElementById('group_name').value = '';
		document.getElementsByName('auth_secede[0]').checked;
		document.getElementById('content').value = '';
	}

	// add & modify
	function GroupSubmit() {
		var form = document.getElementById('groupForm');

		if (!FormCheck.init(form.name)) {
			return;
		}

		form.method	= 'post';

		var mode = document.getElementById('mode').value;
		if (mode != 'modifyForm') {
			document.getElementById('mode').value = 'write';
		}else {
			document.getElementById('mode').value = 'modify';
		}

		form.submit();

	}

	// delete
	function deleteGroupSubmit() {
		var form = document.getElementById('groupForm');
		form.method	= 'post';

		document.getElementById('mode').value = 'delete';

		form.submit();
	}

	function modifyGroupSubmit(groupIdx) {
		var form = document.getElementById('groupForm');
		form.method	= 'post';
		document.getElementById('mode').value = 'modifyForm';

		var ipt = document.createElement( 'input' );
		ipt.setAttribute( 'type' , 'hidden' );
		ipt.setAttribute( 'name' , 'group_idx' );
		ipt.setAttribute( 'value' , groupIdx);
		form.appendChild( ipt );
		form.submit();

	}

	function setDefaultGroupSubmit() {
		var form = document.getElementById('groupForm');
		form.method	= 'post';

		document.getElementById('mode').value = 'setDefaultGroup';
		var groupIdx = document.getElementById('default_group').value;

		var ipt = document.createElement( 'input' );
		ipt.setAttribute( 'type' , 'hidden' );
		ipt.setAttribute( 'name' , 'group_idx' );
		ipt.setAttribute( 'value' , groupIdx);
		form.appendChild( ipt );
		form.submit();
	}

	function search_member(groupIdx) {
		window.location.href='/admin/site/site_member_list.php?work_req=search&search_group='+groupIdx+'&mid='+mid+'&tid='+tid
	}

	function popWin(uri , w , h,is_scroll,is_resize) {
		var features = "width=" + w + ",height=" + h;
		if (is_scroll) features += ",scrollbars=yes";
		if (is_resize) features += ",resizable=no";
		else features += ",resizable=no";
		window.open(uri, 'popup' , features);
	}


</script>

<table border=0 cellpadding=0 cellspacing=0 width=800>
	<tr style="padding:22 0 2 0" valign=bottom>
		<td class="stitle"><img src="/admin/img/bl_stitle.gif" border="0">&nbsp;회원그룹관리</td>
		<td align="right" class="history">회원관리 > 회원 그룹관리</td>
	</tr>
	<tr><td colspan="2" height="1" bgcolor="D9D9D9"></td></tr>
</table>
<!-- header End -->


<form id="groupForm" name="groupForm" method="get" action="/admin/site/site_member_group.php?mid=&tid=">
<input type="hidden" name="mode" value="">
<input type="hidden" name="group_idx" value="">
<div >
	<dl>
		<dt>* <span style='color:red;'>기본 그룹</span>은 수정하거나 삭제 하실 수 없습니다.</dt>
		<dt>* 신규로 생성한 회원그룹은 추가,수정,삭제등  회원그룹을 관리하실 수 있습니다.</dt>
	</dl>
</div>



<div style='padding:0 0 4 0;'>
<img src='/admin/img/bl_blue.gif'>회원그룹목록
</div>

<table id='listing_table' class='product_table'>
	<thead>
	<tr>
		<th><input type='checkbox' onclick="checkAll(event)"></th>
		<th>번호</th>
		<th>회원그룹</th>
		<th>기본등급</th>
		<th>회원수</th>
		<th width=80>회원</th>
		<th width=48 align="center">수정</th>
	</tr>
	</thead>
			<tr>

		<td><input type="checkbox" name="group_idxs[]" value="1" disabled></td>
		<td>1</td>
		<td>운영자</td>
		<td>9</td>
		<td>0</td>
		<td><img src='http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_021.gif' align='absmiddle' class='imp'><input type='button' value=' 회원조회 ' class='bt_a31 tmb12' onclick='search_member(1)'></td>
		<td>				<span style='color:red;'>[기본 그룹]</span>
			
		</td>
	</tr>
				<tr>

		<td><input type="checkbox" name="group_idxs[]" value="2" disabled></td>
		<td>2</td>
		<td>일반회원</td>
		<td>9</td>
		<td>0</td>
		<td><img src='http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_021.gif' align='absmiddle' class='imp'><input type='button' value=' 회원조회 ' class='bt_a31 tmb12' onclick='search_member(2)'></td>
		<td>				<img src='http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_021.gif' align='absmiddle' class='imp'><input type='button' value=' 수정 ' class='bt_a31 tmb12' onclick='modifyGroupSubmit(2)'>
			
		</td>
	</tr>
		
</table>


<table border='1' cellpadding='0' cellspacing='0' width='800' height='35' style='margin-top:10;' bordercolor='#D3D3D3'>
	<tr>
		<td class='tbsbj' style='padding-right:20;text-align:left;'>
			회원 기본 그룹을
		<select id='default_group'>
													<option value=2 selected>일반회원</option>
							</select>
		(으)로
		<img src='http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_021.gif' align='absmiddle' class='imp'><input type='button' value=' 설정 ' class='bt_a31 tmb12' onclick='setDefaultGroupSubmit()'>
		합니다.
		</td>
	</tr>
</table>

<div style='margin-top:10;text-align:center'>
<img src='http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='button' value='등록하기 ' class='bt_a32 tmb22' onclick="addForm();">
<img src='http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='button' value='삭제하기 ' class='bt_a32 tmb22' onclick="deleteGroupSubmit()">
</div>


<div id='layer_add_group' style='display:none'>
<div style='padding:10 0 4 0;'>
<img src='/admin/img/bl_blue.gif'>회원그룹 등록
</div>
<table border=1 cellpadding=7 cellspacing=0 width=800 style='border-collapse:collapse' bordercolor='D3D3D3'>
	<col width='150'></col>
	<col style='padding:10 0 0 0;'></col>
	<tr>
		<td class='tbctr' align=center>회원그룹</td>
		<td class='tbcont' style='padding:5 0 3 8;'>
			<input type='text' size=30 id='group_name' name='group_name' value='' chk="y" kind="" msg="회원그룹" len="1-10">
		</td>
	</tr>
	<tr>
		<td class='tbctr' align=center>회원가입 시 기본등급</td>
		<td class='tbcont' style='padding:5 0 3 8;'>
			<select name='default_level'>
														<option value=2 >운영팀1</option>
																					<option value=3 >운영팀2</option>
																					<option value=4 >운영팀3</option>
																					<option value=5 >특별회원</option>
																					<option value=6 >최우수회원</option>
																					<option value=7 >우수회원</option>
																					<option value=8 >정회원</option>
																														<option value=9 selected>일반회원</option>
																					<option value=10 >불량회원</option>
													</select>
		</td>
	</tr>
	<tr>
		<td class='tbctr' align=center>회원탈퇴 권한</td>
		<td class='tbcont' style='padding:5 0 3 8;'>
			<input type='radio' name='auth_secede' value=1 checked>회원 직접 탈퇴처리
			<input type='radio' name='auth_secede' value=2 >운영자 탈퇴처리
			<input type='radio' name='auth_secede' value=3 >모두 탈퇴처리
		</td>
	</tr>
	<tr>
		<td class='tbctr' align=center>회원그룹설명</td>
		<td class='tbcont' style='padding:5 0 3 8;'>
			<textarea rows=5 cols=65 id='border' name='content' chk="y" kind="" msg="회원그룹설명" len="1-50"></textarea><br>
			<div style='padding:8 0 0 0;'>
			※ 회원그룹 생성 후 쉽게 구분할 수 있도록 간단하게 설명을 입력하세요
   		(내부적으로 운영자만 보는 설명입니다.)
   		</div>
		</td>
	</tr>
	<!-- <tr>
		<td class='tbctr' align=center>관리자메뉴접근권한</td>
		<td class='tbcont' style='padding:5 0 3 8;'>
							<div> ※ 회원그룹 등록완료 후 설정하실 수 있습니다. </div>
					</td>
	</tr> -->
</table>

<div style='padding:10 0 10 0;text-align:center'>
<img src='http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='button' value='저장하기 ' class='bt_a32 tmb22' onclick="GroupSubmit()">
<img src='http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif' align='absmiddle' class='imp'><input type='reset'  value='취소하기 ' class='bt_a32 tmb22'>
</div>
</div>
<table border='3' cellpadding='7' cellspacing='0' width='800' bordercolor='ECD08A' align=center>
	<tr>
		<Td style='color:585858;line-height:180%;padding-left:20'>
			<b>[사용안내]</b><br>
			<b class=ol>ㆍ </b>운영자 그룹은 회원등급이 자동으로 1등급(운영자 권한)으로 설정됩니다.<br>
			<b class=ol>ㆍ </b>회원그룹별로 메뉴접근권한 및 기본등급을 설정하실 수 있습니다.<br>
			<b class=ol>ㆍ </b>메뉴접근권한이 표시되지 않은 회원그룹은 어드민 접근 권한이 없는 회원입니다. <br>
		</td>
	</tr>
</table>

<div style='padding:30 0 0 0;'>

</div>
</form>

	<!-- footer Start -->
	</td>
	</tr>
</table>
	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->
</body>
</html>
<!-- footer End -->
