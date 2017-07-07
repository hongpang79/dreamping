<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="admin.ProductDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	int additionNo = Integer.parseInt(request.getParameter("additionNo"));

	ProductDAO dbPro = ProductDAO.getInstance();
	int check = dbPro.deleteAddition(additionNo);

	if(check==1){
%>
	<script language="JavaScript">   
	<!-- 
		alert("부가서비스상품이 삭제되었습니다.");
		location.href="/admin/product/product_addition_list.jsp";
		//self.close();
	-->
	</script>      
<% }else{%>
       <script language="JavaScript">     
       <!--     
         alert("삭제에 실패했습니다.");
         history.go(-1);
       -->
      </script>
<%
  }
%>