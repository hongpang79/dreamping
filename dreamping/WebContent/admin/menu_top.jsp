<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String loginId = "";
String checkAdmin = "";
try{
	loginId = session.getAttribute("userId").toString();
	checkAdmin = session.getAttribute("grade").toString();
}catch(NullPointerException e){
	checkAdmin = "";
}finally{
	if( !checkAdmin.equals("admin") ){
%>
	<script language='javascript'>
		alert("관리자권한이 없습니다.");
		location.href='/admin/login.jsp';
	</script>
<%
	}
}
%>
 		<table border=0 cellpadding=0 cellspacing=0 width=993>
            <tr>
                <td height=44  valign='bottom'><a href='/admin/main.jsp'><img src='/admin/img/logo.png' align='absmiddle'></a></td>
                <td align=right valign=bottom style='padding:0 26 6 0'>
                    <img src='/admin/img/bl_top2.gif'>아이디 :
                    <b style='color:FF5400'><%=loginId %></b>
                    &nbsp;&nbsp;<a href='/admin/logoutProcess.jsp'><u><img src='/admin/img/btn_main_logout.gif' border='0' align='absmiddle'></u></a>

                </td>
            </tr>
        </table>

        <div id="top_bar" style="width:100%;background:url(/admin/img/bg_menu.gif);">
            <div style="float:left">
                <table border="0" cellpadding="0" cellspacing="0"  >
                    <tr>
                    <!-- New Top Menus S  -->
                         <td width='56'  style='padding-left:6' ><a href='/admin/main.jsp'><img src='/admin/img/topmenu_home_rs_on.gif'></a></td>
						 <td width='56' ><a href='/admin/common/reservation_information.jsp'><img src='/admin/img/topmenu_camp_off.gif'></a></td>
						 <td width='56' ><a href='/admin/product/product_reservation_list.jsp'><img src='/admin/img/topmenu_site_off.gif'></a></td>
					<!-- 	 <td width='56' ><a href='/admin/member/site_member_list.jsp'><img src='/admin/img/topmenu_customer_off.gif'></a></td> -->
						 <td width='56' ><a href='/admin/reservation/reservation_order_list.jsp?file=reservation_order_list&page=1'><img src='/admin/img/topmenu_yoyak_off.gif'></a></td>
						 <td width='56' ><a href='/admin/board/list.jsp?category=notice'><img src='/admin/img/topmenu_board_off.gif'></a></td>
                    <!-- New Top Menus E  -->

                                        <!--내 사이트 바로가기-->
                        <td align='right' style='padding-right:10px;'></td>
                    </tr>
                </table>
            </div>
            <div style="text-align:right;padding-right:10px;padding-top:8px;">
                <a href='/index.jsp' target='_blank'><img src='/admin/img/btn_mysitebarogagi.gif' align='absmiddle'></a>
            </div>
            <div style="clear:both"></div>
        </div>