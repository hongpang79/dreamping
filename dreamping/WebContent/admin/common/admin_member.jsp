<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="admin.MemberVO" %>
<%@ page import="admin.MemberDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
		
	String step = request.getParameter("step")==null?"list":request.getParameter("step");
	String msg = "";
	
	if(!step.equals("list")){
		//msg = MemberDAO.getInstance().processBanner(request);	
	}
%>
<!--common Top Start//-->
<html>
<head>
<title></title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<link rel="stylesheet" type="text/css" href="/admin/css/text_button.css">
</head>

<body bgcolor='#FFFFFF' topmargin='0' leftmargin='0'>
<!-- common Top End //-->
<script language=javascript type="text/JavaScript" src='/admin/js/admin.js'></script>
<script language=javascript src='/admin/js/common.js'></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script language=javascript>
$(document).ready(
	function() {
		if($("#msg").val().length > 0){
			alert($("#msg").val());
	}
});	
</script>

	 <!-- 상단 TOP Menu S -->
     <jsp:include page="/admin/common/menu_top.jsp" />
     <!-- 상단 TOP Menu E -->	 
         
<script type="text/javascript">

function _create_remote_frame(target_id)
{
	if (!document.getElementById("remoteFrame_" + target_id))
	{
		if (window.document.all)
		{
			var new_frame_obj = document.createElement('<IFRAME id="remoteFrame_'+ target_id +'" name="remoteTarget_'+ target_id +'" style="display:block" width=0 height=0 border=0 frameborder=0 scrolling=no marginheight=0 marginwidth=0"></IFRAME>');
		}
		else
		{
			var new_frame_obj = document.createElement("IFRAME");
			new_frame_obj.id = "remoteFrame_"+ target_id;
			new_frame_obj.name = "remoteTarget_"+ target_id;
			new_frame_obj.width = 0;
			new_frame_obj.height = 0;
			new_frame_obj.border = 0;
			new_frame_obj.frameborder = 0;
			new_frame_obj.scrolling = 0;
			new_frame_obj.marginheight = 0;
			new_frame_obj.marginwidth = 0;
			new_frame_obj.style.display = "block";
		}

		document.getElementsByTagName("body")[0].appendChild(new_frame_obj);
	}

	var frame_obj = document.getElementById("remoteFrame_" + target_id);

	return frame_obj;
}

function get_remote_page(target_id, source_url)
{
	var frame_obj = _create_remote_frame(target_id);

	frame_obj.src = source_url;
}

function displayMemberInfo(seq)
{
	get_remote_page("rpstn", "site_admin.php?do=detail_rpstn&seq=" + seq);
}

function valid_data(x)
{
	if (x.match(/^\s*$/) || x.match(/`|~|!|@|#|\$|%|\^|&|\*|\(|\)|\-|\_|\+|\=|\|\||<|>|\,|\.|\?|\/|:|;|\'|"|\[|\]|\{|\}/gi)) {
		return false;
	} else {
		return true;
	}
}


function chkRpstn()
{
	var f = document.rpstn_f;

	if (valid_data(f.master_name.value) == false) {
		alert("[담당자]를 입력하세요.");
		f.master_name.focus();
		return;
	}

	if (f.master_phone.value.match(/^\s*$/)) {
		alert("[연락처]를 입력하세요.");
		f.master_phone.focus();
		return;
	}

	if (f.master_email.value.match(/^\s*$/)) {
		alert("[이메일]를 입력하세요.");
		f.master_email.focus();
		return;
	}

	f.action = "site_admin.php?do=modify_admin_rpstn&page_load=1";
	f.submit();
}

function view(value,target)
{
	if (value == 1)
	{
		document.getElementById(target).style.display = "block";
	}
	else
	{
		document.getElementById(target).style.display = "none";
	}
}

</script>
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
		
			<!-- 본문 타이틀------------------------------------------------------------>
			<ul class="content_title">
				<li>운영자설정</li>
				<li class="location">캠핑장관리>기본정보>운영자설정</li>
			</ul>
	
			<!--본문 내용 시작--------------------------------------------------------->
			<table border=0 cellpadding=0 cellspacing=0 width=800>
				<tr style='padding:17 0 2 0' valign=bottom>
					<td><img src=../img/bl_blue.gif><b>대표운영자</b></td>
					<td align='right'>
						<img src="/admin/img/tbtn_bg_021.gif" align="absmiddle" class="imp"><input type="button" value="대표운영자 정보수정하기" class="bt_a31 tmb12" onClick="displayMemberInfo('1'); return false;">
					</td>
				</tr>
			</table>
			<!--대표운영자설정-->
<%  
	MemberVO member = MemberDAO.getInstance().getMemberForGrade("A");
%>
			<table border=1 cellpadding=0 cellspacing=0 width=800 style='border-collapse:collapse;' bordercolor=D3D3D3>
				<tr height='28' align=center>
					<td width='10%' bgcolor=f7f7f7>ID</td>
					<td width='13%'><%=member.getId() %></td><!--id-->
					<td width='10%' bgcolor=f7f7f7>이름</td>
					<td width='12%'><%=member.getName() %></td>
					<td width='10%' bgcolor=f7f7f7>Mobile</td>
					<td width=15%><%=member.getCell1()+"-"+member.getCell2()+"-"+member.getCell3()%></td>
				</tr>
			</table>
	
			<br><br>
					
		    <!--부운영자 목록-->         
		    <table border=0 cellpadding=0 cellspacing=0 width=800>
		        <tr style='padding:0 0 2 0' valign=bottom>
		            <td><img src=../img/bl_blue.gif><b>부운영자 목록</b></td>
		        </tr>
		    </table>
		    <table border=1 cellpadding=0 cellspacing=0 width=800 style='border-collapse:collapse;' bordercolor=D3D3D3>
		        <tr height='28' align='center'>
		            <td class='tbctr' width=6%>번호</td>
		            <td class='tbctr' width=11%>아이디</td>
		            <td class='tbctr' width=8%>담당자</td>
		            <td class='tbctr' width=10%>연락처</td>
		            <td class='tbctr' width=14%>이메일</td>
		            <td class='tbctr' width=14%>레벨상태</td>
		            <td class='tbctr' width=8%>접근허용</td>
		            <td class='tbctr' width=19%>수정/삭제</td>
		        </tr>
<%
	Vector<MemberVO> vMember = MemberDAO.getInstance().selectMemberList();
	int count = vMember.size();
	if( count == 0 ){
%>
				<tr><td colspan="8" align="center"> <br/>등록된 부운영자가 없습니다<br/><br/></td></tr>
<% 
	}else{
		int memberNo = 0;
		String name="";
		String grade="";
		String id="";
		String cell="";
		String email="";
		String recvYn="";
		
		member = null;
		for(int i=0; i<count; i++){
			member = vMember.get(i);
			memberNo = member.getMemberNo();
			name = member.getName();
			grade = member.getGrade();
			id = member.getId();
			cell = member.getCell1()+"-"+member.getCell2()+"-"+member.getCell3();
			email = member.getEmail();
			recvYn = member.getRecvYn();
%>
				<tr>
					<td><%= i+1 %></td>
					<td><%=id %></td>
					<td><%=name %></td>
					<td><%=cell %></td>
					<td><%=email %></td>
					<td><%=grade %></td>
					<td><%=recvYn %></td>
					<td>
						<input type="button" value="수정" onClick="javascript:modify(<%= memberNo %>);" />
						<input type="button" value="삭제" onClick="javascript:delete(<%= memberNo %>);" />
					</td>
				</tr>			
<%
		}
	}
%> 
	    	</table>
	    	<br>
	
		    <div align='center' style="width:800px;">
		        <img src="http://img.cafe24.com/images/ec_admin/btn/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="부운영자 추가" class="bt_a32 tmb22" onClick="location.href='/admin/site/site_admin.php?do=add_admin'">
		    </div>
	
			<table border=0 cellpadding=0 cellspacing=0 width=800>
				<tr style='padding:0 0 2 0' valign=bottom>
					<td><img src=../img/bl_blue.gif><b>부 운영자 레벨안내</b></td>
				</tr>
			</table>
			<Div id='view'>
				<table border=1 cellpadding=3 cellspacing=0 width=800 style='border-collapse:collapse;line-height:17px' bordercolor=D3D3D3>
					<tr height='28' align='center'>
						<td class='tbctr' width='150'>레벨/권한</td>
						<td class='tbctr' width='180'>접근가능 메뉴</td>
						<td class='tbctr'>권한 설명</td>
					</tr>
					<tr height='28'>
						<td class='tbcont'>레벨 A<br>(대표운영자)</td>
						<td class='tbcont'>어드민 전체</td>
						<td class='tbcont'>대표 운영자에게만 주어지는 권한입니다.</td>
					</tr>
					<tr height='28'>
						<td class='tbcont'>레벨 B<br>(운영관리)</td>
						<td class='tbcont'>1. 캠핑장관리  메뉴 전체<br>
			                      2. 예약상품관리 메뉴 전체<br>
			                      3. 예약관리 메뉴 전체<br>
			                      4. 공지/게시관리 메뉴 전체
			                  </td>
						<td class='tbcont'>전체 사이트를 관리할 수 있는 운영권한입니다.</td>
					</tr>
					<tr height='28'>
						<td class='tbcont'>레벨 C<br>(예약/게시판 관리)</td>
						<td class='tbcont'>
							1. 예약관리 메뉴 전체<br>
							2. 공기/게시관리 메뉴 전체<br>
						<td class='tbcont'>사이트 운영시 사이트 이용자인 회원들과 관련된 <br>대 고객 서비스 업무를 담당하는 권한을 가진 부 운영자입니다.</td>
					</tr>
					<tr height='28'>
						<td class='tbcont'>레벨 D<br>(게시판/콘텐츠 관리)</td>
						<td class='tbcont'>
							1. 공기/게시관리 메뉴 전체<br>
						<td class='tbcont'>사이트 운영시 사이트 게시판 및 콘텐츠를 담당하는 권한을 가진 부 운영자입니다.</td>
					</tr>
				</table>
			</div>
	
			<table border=3 cellpadding=7 cellspacing=0 width=800 bordercolor=ECD08A style='margin-top:40'>
				<tr><td style='color:585858;line-height:180%;padding-left:20'>
						<b>[사용안내]</b><br>
						<b class=ol>ㆍ</b>운영자 접근권한 레벨에 따라 해당 메뉴의 접근이 통제됩니다.<br>
					</td>
				</tr>
			</table>
	
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
