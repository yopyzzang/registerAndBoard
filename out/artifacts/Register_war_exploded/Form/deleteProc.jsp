<%@ page import="member.StudentDAO" %><%--
  Created by IntelliJ IDEA.
  User: yopy
  Date: 2020-01-01
  Time: 오후 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    StudentDAO dao = StudentDAO.getInstance();
%>
<html>
<head>
    <title>회원 탈퇴</title>
</head>
<%
    String id = (String) session.getAttribute("loginID");
    String pass = request.getParameter("pass");
    int check = dao.deleteMember(id, pass);
    if (check == 1) {
        session.invalidate();
%>
<meta http-equiv="Refresh" content="3;url=login.jsp">
<body>
<div style="text-align: center;">
    회원 정보가 삭제되었습니다..!<br><br>
    안녕히 가세요 ! <br><br>
    3초 후에 로그인 페이지로 이동합니다..
</div>
<%
} else {
%>
<script>
    alert("비밀번호가 맞지 않습니다.")
    history.go(-1);
</script>
<%
    }
%>
</body>
</html>
