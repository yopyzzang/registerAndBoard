<%--
  Created by IntelliJ IDEA.
  User: itbank
  Date: 2019-12-30
  Time: 오후 2:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="dao" class="member.StudentDAO"/>
<%
    String id = request.getParameter("id");
    boolean check = dao.idCheck(id);
%>
<html>
<head>
    <title>ID 중복체크</title>
    <script language="JavaScript" src="/JavaScript/script.js"></script>
</head>
<body>
<br>
<center>
    <b><%=id%></b>
    <%
        if(check){
            out.println("는 이미 존재하는 ID입니다.<br><br>");
        }else {
            out.println("는 사용 가능 합니다. <br><br>");
        }
    %>
    <a href="#" onclick="javascript:self.close()">닫기</a>
</center>
</body>
</html>
