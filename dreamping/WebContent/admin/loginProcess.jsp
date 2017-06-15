<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "admin.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8");%>

<%
    String id = request.getParameter("userId");
	String passwd  = request.getParameter("passwd");
	
	MemberDAO member = MemberDAO.getInstance();
    int check = member.userCheck(id,passwd);

	if(check==0){
		session.setAttribute("userId",id);
		session.setAttribute("grade","admin");
		response.sendRedirect("/admin/main.jsp");
	}else if(check==1){%>
	<script> 
	  alert("권한이 없습니다.");
      history.go(-1);
	</script>
<%	}else{ %>
	<script>
	  alert("아이디 or 비밀번호가 맞지 않습니다.");
	  history.go(-1);
	</script>
<%}	%>