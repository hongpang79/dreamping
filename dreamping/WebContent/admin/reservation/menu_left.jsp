<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<script type="text/javascript">
    <!--
        function bodyShow(idx)
        {
            var num= parseInt(idx) +1;
            var nodeObj= document.getElementById('menus_' +num );

            if(nodeObj) {
                var dis = nodeObj.style.display;
                if(dis == 'none') dis = 'block';
                else dis = 'none';
            }
        }

        function popWin(uri , w , h,is_scroll,is_resize) {
            var features = "width=" + w + ",height=" + h;
            features += ",scrollbars=1";
            if (is_resize) features += ",resizable=yes";
            else features += ",resizable=no";
            window.open(uri, 'popup' , features);
        }
    //-->
    </script>
    <style type="text/css">
    .pointer { cursor:pointer}
    .span_sel {
        font-weight:bold;
        color:#cc0000;
    }
    </style>
    
    <table border=0 cellpadding=0 cellspacing=0 width=100% bgcolor=F7F7F7>
    	<tr><td><img src='/admin/img/reservation/title_reserv.gif'></td></tr>
        <tr><td height=1></td></tr>
        <tr><td class=left1><a href="javascript:;"  >예약접수관리</a></td></tr>
        <tr><td height=1></td></tr>
        <tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/reservation/reservation_order_list.jsp"  >예약접수관리</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/reservation/reservation_refund_list.jsp"  >취소/환불관리</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/reservation/selling_statistics.jsp"  >매출통계</a>
                </td>
            </tr>
        </tbody>
        <tr><td height=1></td></tr>
        <tr><td class=left1><a href="javascript:;"  >예약현황관리</a></td></tr>
        <tr><td height=1></td></tr>
        <tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/reservation/reservation_group_order.jsp"  >단체예약하기</a><br>
                </td>
            </tr>
        </tbody>
    </table>