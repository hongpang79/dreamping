<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="admin.StatisticsVO" %>
<%@ page import="admin.StatisticsDAO" %>
<%
request.setCharacterEncoding("UTF-8");

NumberFormat nf = NumberFormat.getInstance();

Calendar cal = Calendar.getInstance();
String year = cal.get(Calendar.YEAR)+"";
String month = cal.get(Calendar.MONTH)+1+"";
if(month.length() < 2){
	month = "0"+month;
}
String day = cal.get(Calendar.DATE)+"";
if(day.length() < 2){
	day = "0"+day;
}
String today = year+"-"+month+"-"+day;
StatisticsVO statistics = StatisticsDAO.getInstance().selectMainStatisticsCnt(today);
int rsvtCompCnt = statistics.getRsvtCompCnt();
int rsvtWaitCnt = statistics.getRsvtWaitCnt();
int rsvtRefdReqCnt = statistics.getRsvtRefdReqCnt();
int rsvtRefdCompCnt = statistics.getRsvtRefdCompCnt();
%>
<html>
<head>
<title>UrbanSlowCity Admin</title>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<link rel="icon" href="/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="/images/favicon.png" type="image/x-icon" />
<link rel="apple-touch-icon" href="/images/apple-touch-icon.png" />
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
</head>

<body bgcolor='#FFFFFF' topmargin='0' leftmargin='0'>        

        <!-- 상단 TOP Menu S -->
        <jsp:include page="/admin/menu_top.jsp" />
        <!-- 상단 TOP Menu E -->
    
<table border=0 cellpadding=0 cellspacing=0 width=993>
	<tr valign=top>
		<td width=195 bgcolor=F7F7F7>
			<!--왼쪽 타이틀------------------------------------------------->
			<jsp:include page="/admin/menu_left.jsp" />
			<!--//왼쪽 타이틀------------------------------------------------->
<script>


function setCookie(name,value,expiredays)
{
    var todayDate = new Date();
    todayDate.setDate(todayDate.getDate() + expiredays);
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}

function closeWin()
{
    //if(document.checkClose.ncook.checked == true)
    //{
        setCookie("layer_popup", "done" ,1);
        document.getElementById("layer_popup").style.display="none";
    //}
}

function getCookie(name)
{

    var nameOfCookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length )
    {
        var y = (x+nameOfCookie.length);
        if ( document.cookie.substring( x, y ) == nameOfCookie ) {

            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ){
                endOfCookie = document.cookie.length;
            }

            return document.cookie.substring( y, endOfCookie );
        }

        x = document.cookie.indexOf( " ", x ) + 1;

        if ( x == 0 ){
            break;
        }
    }

    return "";
}

function closepop(){
    document.getElementById("layer_popup").style.display="none";
}

function openpop(isPopup){
    try {
        var lpop = document.getElementById("layer_popup");

        if (getCookie("layer_popup") == "done" )
        {
            lpop.style.display = "none";
        }else{
            lpop.style.display = "block";
        }

        if(isPopup == 1) lpop.style.display = "none";
    } catch(e) {

    }
}

window.onload = function(){

    ///openpop();

}

</script>
		</td>
		<td width=18><img src=/admin/img/e.gif width=18></td>
		<td>
			<!--본문 내용 시작--------------------------------------------------------->

			<!--table border=0 cellpadding=0 cellspacing=0 width=608 style='padding-top:9'>
				<tr><td><img src='../img/main_visual_bnr.gif'></td></tr>
			</table-->

			<div class="component_main_page_display">
				<ul><li><img src='/admin/img/bl_blue.gif'>예약현황<li class="more"><a href="/admin/reservation/reservation_order_list.jsp?file=reservation_order_list&moduleIdx=1&pageMode=L&list=1">more</a></ul>
				<table>
				<col width="20%"></col><col width="30%"></col><col width="20%"></col><col width="30%"></col>
					<tr>
						<th>예약 완료</th><td><% out.print(nf.format(rsvtCompCnt)); %> 건</td>
						<th>예약 대기</th><td><% out.print(nf.format(rsvtWaitCnt)); %> 건</td>
					</tr>
					<tr>
						<th>취소/환불 신청</th><td><% out.print(nf.format(rsvtRefdReqCnt)); %> 건</td>
						<th>취소/환불 완료</th><td><% out.print(nf.format(rsvtRefdCompCnt)); %> 건</td>
					</tr>
				</table>
			</div>
			
<!-- 					
				<div style='margin:18 0 3 0'><img src='../img/bl_blue.gif'><b>오늘의 사이트 변동 내역</b></div>
				<table border=1 cellpadding=0 cellspacing=0 width='608' style='border-collapse:collapse;padding-top:3' bordercolor='E5E5E5'>
					<tr><td class='tbsbj' width='140' height='28'>신규회원</td>
						<td class='tbcont' style='border-right:0'>0명</td>
						<td align='right' style='border-left:0'>
							<a href='/admin/site/site_admin.php'><img src='../img/btn_mem_manage.gif' hspace='9'></a>
						</td>
					</tr>
				</table>
 -->

			<table border='0' cellpadding='0' cellspacing='0'>
				<tr><td height=50></td></tr>
			</table>
            			<!--본문 끝---------------------------------------------------------------------------------------->

		</td>
		<td valign='top'>
			<!--우측 베너--->

			<table border='0' cellpadding='0' cellspacing='0'>
				<tr>
					<td>
						<br>
					</td>
				 </tr>
			</table>

		</td>
	</tr>
</table>

	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->

</body>
</html>
