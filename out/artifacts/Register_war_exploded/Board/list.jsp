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
    int pageSize = 5;
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;

    int count = 0;
    int number = 0;
    List<BoardVO> articleList = null;
    BoardDAO dbPro = BoardDAO.getInstance();
    count = dbPro.getArticleCount(); // 전체 글 수
    if (count > 0) {
        articleList = dbPro.getArticles(startRow, endRow);
    }
    number = count - (currentPage - 1) * pageSize;
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
            <td width="250"><a
                    href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject()%>
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

    <%
        if (count > 0) {
            int pageBlock = 5;
            int imsi = count % pageSize == 0 ? 0 : 1;
            int pageCount = count / pageSize + imsi;
            int startPage = (int) ((currentPage - 1) / pageBlock) * pageBlock + 1;
            int endPage = startPage + pageBlock - 1;
            if(endPage>pageCount) endPage = pageCount;
            if(startPage>pageBlock){ %>
    <a href="list.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
    <%
        }
        for (int i = startPage; i <=endPage ; i++) {
    %>
    <a href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a>
    <%
        }
        if(endPage<pageCount){
    %>
    <a href="list.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
    <%
        }
        }
    %>
</div>
<%}%>
</body>
</html>
