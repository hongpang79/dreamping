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
    	<tr><td><img src='/admin/img/title_pension.gif'></td></tr>
        <tr><td height=1></td></tr>
        <tr><td class=left1><a href="javascript:;"  >기본정보</a></td></tr>
        <tr><td height=1></td></tr>
        <tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/common/reservation_information.jsp"  >예약환경설정</a><br>
                    <!-- 
                    <img src=/admin/img/bl_left2.gif><a href=""  >예약항목설정</a><br>
                    -->
                    <img src=/admin/img/bl_left2.gif><a href="/admin/common/refund_amount.jsp"  >환불금액설정</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/common/admin_member.jsp"  >운영자설정</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/common/deposit_information.jsp"  >무통장입금계좌설정</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/common/holyday_information.jsp"  >휴일관리</a><br>
                </td>
            </tr>
        </tbody>
        <tr><td height=1></td></tr>
        <tr><td class=left1><a href="javascript:;"  >캠핑장정보</a></td></tr>
        <tr><td height=1></td></tr>
        <tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/common/zone_information.jsp"  >ZONE설정</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/common/site_information.jsp"  >SITE설정</a><br>
                </td>
            </tr>
        </tbody>
        <tr><td height=1></td></tr>
        <tr><td class=left1><a href="javascript:;"  >SMS관리</a></td></tr>
        <tr><td height=1></td></tr>
        <tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/common/auto_sms_setting.jsp"  >SMS발송메시지관리</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/common/sms_user_setting.jsp"  >SMS수신자설정</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/common/sms_log.jsp"  >SMS발송내역조회</a><br>
                </td>
            </tr>
        </tbody>
    </table>