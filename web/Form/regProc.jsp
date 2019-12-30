<%--
  Created by IntelliJ IDEA.
  User: yopy
  Date: 2019-12-31
  Time: 오전 1:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("euc-kr");%>
<jsp:useBean id="dao" class="member.StudentDAO"/>
<jsp:useBean id="vo" class="member.StudentVO"/>
<jsp:setProperty name="vo" property="*"/>
<%
    boolean flag = dao.memberInsert(vo);
%>
<html>
<head>
    <title>회원가입 확인</title>
</head>
<body>
<div style="text-align: center;">
    <%
        if(flag){
            out.println("<b>회원가입을 축하 드립니다..!!</b><br>");
            out.println("<a href=regForm.jsp>다시 가입</a>");
        }else {
            out.println("<b>다시 입력해주세요..</b><br>");
            out.println("<a href=regForm.jsp>다시 가입</a>");
        }
    %>
</div>
</body>
</html>
