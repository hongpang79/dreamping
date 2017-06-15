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
    	<tr><td><img src='/admin/img/title_board.gif'></td></tr>
    	<tr><td height=1></td></tr>
    	<tr><td class=left1><a href="javascript:;"  >게시물 관리</a></td></tr>
        <tr><td height=1></td></tr>
        <tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/board/list.jsp?category=notice"  >공지사항</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/board/list.jsp?category=qna"  >문의하기</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/board/list.jsp?category=photo"  >포토앨범</a>
                </td>
            </tr>
        </tbody>
        <tr><td height=1></td></tr>
        <tr><td class=left1><a href="javascript:;"  >홈페이지 관리</a></td></tr>
        <tr><td height=1></td></tr>
        <tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
        			<img src=/admin/img/bl_left2.gif><a href="/admin/homepage/popup_manager.jsp"  >팝업관리</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/homepage/main_banner.jsp"  >메인 Banner 관리</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/homepage/main_content.jsp"  >메인 page관리</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/homepage/about_content.jsp"  >About page관리</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/homepage/site_content.jsp"  >Site page관리</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/homepage/content_manager.jsp"  >Content page관리</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/homepage/contact_content.jsp"  >Contact page관리</a><br>
                </td>
            </tr>
        </tbody>
    </table>