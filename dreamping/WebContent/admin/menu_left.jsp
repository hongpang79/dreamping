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
			<table border='4' cellpadding='0' cellspacing='0' bgcolor='ffffff' width='181' bordercolor='CDCDCD' style='border-collapse:collapse;margin:7;padding:5 7 7 7'>
                <tr>
                	<td valign='top' style='line-height:150%'><b>아이디 : <%=loginId %></b> <br>
                        <img src='/admin/img/main_login_line.gif'><br>
                    	<a href='/admin/logoutProcess.jsp'><img src='/admin/img/btn_main_logout.gif' align='absmiddle'></a>
                    </td>
                </tr>
            </table>