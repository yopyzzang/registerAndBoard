<%@ page import="member.StudentDAO" %><%--
  Created by IntelliJ IDEA.
  User: yopy
  Date: 2020-01-01
  Time: 오후 5:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    StudentDAO dao = StudentDAO.getInstance();
%>
<%
    String id = request.getParameter("id");
    String pass = request.getParameter("pass");
    int check = dao.loginCheck(id,pass);
%>
<%
    if(check == 1){ // login success..
        session.setAttribute("loginID",id);
        response.sendRedirect("login.jsp");
    }else if(check==0){
%>
<script>
    alert("비밀번호가 틀렸어요..!")
    history.go(-1);
</script>
<%
    }else {
%>
<script>
    alert("아이디가 없어요..!")
    history.go(-1);
</script>
<%
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
