<%@ page import="java.sql.Timestamp" %>
<%@ page import="board.BoardDAO" %><%--
  Created by IntelliJ IDEA.
  User: itbank
  Date: 2020-01-02
  Time: 오후 1:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="article" scope="page" class="board.BoardVO">
    <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
    article.setRegdate(new Timestamp(System.currentTimeMillis()));
    article.setIp(request.getRemoteAddr());
    BoardDAO dbPro=BoardDAO.getInstance();
    dbPro.insertArticle(article);
    response.sendRedirect("list.jsp");
%>
<html>
<head>
</head>
<body>

</body>
</html>
