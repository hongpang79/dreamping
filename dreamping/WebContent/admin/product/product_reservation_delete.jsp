<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="admin.ProductDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	int productNo = Integer.parseInt(request.getParameter("productNo"));

	ProductDAO dbPro = ProductDAO.getInstance();
	int check = dbPro.deleteProduct(productNo);

	if(check==1){
%>
	<script language="JavaScript">   
	<!-- 
		alert("예약상품이 삭제되었습니다.");
		location.href="/admin/product/product_reservation_list.jsp";
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