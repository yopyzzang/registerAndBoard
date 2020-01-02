<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="board.BoardVO" %>
<%@ page import="board.BoardDAO" %><%--
  Created by IntelliJ IDEA.
  User: itbank
  Date: 2020-01-02
  Time: 오후 2:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
    int count = 0;
    int number = 0;
    List<BoardVO> articleList = null;
    BoardDAO dbPro = BoardDAO.getInstance();
    count = dbPro.getArticleCount(); // 전체 글 수
    if (count > 0) {
        articleList = dbPro.getArticles();
    }
    number = count;
%>
<html>
<head>
    <title>게시판</title>
    <link href="/CSS/boardStyle.css" rel="stylesheet" type="text/css">
</head>
<body>
<div style="text-align: center;">
    <b>글 목록(전체 글:<%=count%>)</b>
    <table width="700">
        <tr>
            <a href="writeForm.jsp">[글쓰기]</a>
        </tr>
    </table>
    <%
        if (count == 0) {
    %>
    <table width="700" border="1" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center">게시판에 저장된 글이 없습니다.</td>
        </tr>
    </table>
    <% } else {%>
    <table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
        <tr height="30">
            <td align="center" width="50">번호</td>
            <td align="center" width="250">제 목</td>
            <td align="center" width="100">작성자</td>
            <td align="center" width="150">작성일</td>
            <td align="center" width="50">조 회</td>
            <td align="center" width="100">IP</td>
        </tr>
    </table>
    <%
        for (int i = 0; i < articleList.size(); i++) {
            BoardVO article = (BoardVO) articleList.get(i);
    %>
    <table border="1" width="700" cellspacing="0" cellpadding="0" align="center">
    <tr height="30">
        <td align="center" width="50"><%=number--%>
        </td>
        <td width="250"><a href="content.jsp?num=<%=article.getNum()%>&pageNum=1"><%=article.getSubject()%>
        </a>
            <%
                if (article.getReadcount() >= 20) {
            %><b>[인기글]</b><%}%>
        </td>
        <td align="center" width="100">
            <a href="mailto:<%=article.getEmail()%>">
                <%=article.getWriter()%>
            </a>
        </td>
        <td align="center" width="150">
            <%=simpleDateFormat.format(article.getRegdate())%>
        </td>
        <td align="center" width="50"><%=article.getReadcount()%>
        </td>
        <td align="center" width="100"><%=article.getIp()%>
        </td>
    </tr>
    </table>
    <%}%>
</div>
<%}%>
</body>
</html>
