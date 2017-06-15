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
    	<tr><td><img src='/admin/img/title_room.gif'></td></tr>
        <tr><td height=1></td></tr>
        <tr><td class=left1><a href="javascript:;"  >상품관리</a></td></tr>
        <tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/product/product_reservation_list.jsp"  >상품 리스트</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/product/product_reservation_modify.jsp"  >상품 등록</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/product/product_reservation_update.jsp"  >상품일괄변경</a>
                </td>
            </tr>
        </tbody>
        <tr><td height=1></td></tr>
        <!-- 
        <tr><td class=left1><a href="javascript:;"  >부가서비스 관리</a></td></tr>
        <tr><td height=1></td></tr>
        <tbody>
        	<tr>
        		<td height=21 style='padding:3 0 8 0'>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/product/product_addition_list.jsp"  >부가서비스 리스트</a><br>
                    <img src=/admin/img/bl_left2.gif><a href="/admin/product/product_addition_modify.jsp"  >부가서비스 등록</a>
                </td>
            </tr>
        </tbody>
        <tr><td height=1></td></tr>
         -->
    </table>