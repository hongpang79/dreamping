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
    	<tr><td><img src='/admin/img/reservation/title_customer.gif'></td></tr>
    	<tr><td height=1></td></tr>
    	<tr><td class=left1><a href="javascript:;"  >회원관리</a></td></tr>
    	<tr><td height=1></td></tr>
    	<tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/site/site_member_list.php"  >회원정보조회</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/site/site_member_auth.php"  >회원인증</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/site/site_member_level.php"  >회원등급설정</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/site/site_member_group.php"  >회원그룹관리</a>
                </td>
            </tr>
        </tbody>
        <tr><td height=1></td></tr>
        <tr><td class=left1><a href="javascript:;"  >메일관리</a></td></tr>
        <tr><td height=1></td></tr>
        <tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/myinform/mailer.php"  >전체메일보내기</a>
                </td>
            </tr>
        </tbody>
        <tr><td height=1></td></tr>
        <tr><td class=left1><a href="javascript:;"  >SMS 관리</a></td></tr>
        <tr><td height=1></td></tr>
        <tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/site/sms.php?do=sms_send"  >문자보내기</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/site/sms.php?do=sms_send_list_new"  >전송 내역 조회</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/site/sms.php?do=auto_sms_setting"  >자동발송메시지설정</a>
                </td>
             </tr>
         </tbody>
    </table>