<%@ page import="member.StudentDAO" %><%--
  Created by IntelliJ IDEA.
  User: yopy
  Date: 2020-01-01
  Time: 오후 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    StudentDAO dao = StudentDAO.getInstance();

%>
<jsp:useBean id="vo" class="member.StudentVO">
    <jsp:setProperty name="vo" property="*"/>
</jsp:useBean>
<%
    String loginID = (String)session.getAttribute("loginID");
    vo.setId(loginID);
    dao.updateMember(vo);
    System.out.println("123123");
%>
<html>
<head>
    <title>Update Process</title>
    <meta http-equiv="Refresh" content="3;url=login.jsp">
</head>
<body>
<div style="text-align: center;">
    입력하신 내용대로 <b>회원정보가 수정되었습니다..!!</b><br><br>
    3초 후에 로그인 페이지로 이동합니다...
</div>
</body>
</html>
