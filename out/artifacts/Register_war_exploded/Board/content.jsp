<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %><%--
  Created by IntelliJ IDEA.
  User: yopy
  Date: 2020-01-03
  Time: 오전 2:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판</title>
</head>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");
    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm");
    try {
        BoardDAO dbPro = BoardDAO.getInstance();
        BoardVO article = dbPro.getArticle(num);
        int ref = article.getRef();
        int step = article.getStep();
        int depth = article.getDepth();
%>
<body>
<div style="text-align: center;">
    <b>글 내용 보기</b>
    <br><br>
    <form>
        <table width="500" border="1" cellpadding="0" cellspacing="0" align="center">
            <tr height="30">
                <td align="center" width="125">글번호</td>
                <td align="center" width="125" align="center">
                    <%=article.getNum()%>
                </td>
                <td align="center" width="125">조회수</td>
                <td align="center"w width="125" align="center">
                    <%=article.getReadcount()%>
                </td>
            </tr>
            <tr height="30">
                <td align="center" width="125">작성자</td>
                <td align="center" width="125"><%=article.getWriter()%></td>
                <td align="center" width="125">작성일</td>
                <td align="center" width="125" align="center">
                    <%=simpleDateFormat.format(article.getRegdate())%>
                </td>
            </tr>
            <tr height="30">
                <td align="center" width="125">글제목</td>
                <td align="center" width="375" align="center" colspan="3">
                    <%=article.getSubject()%>
                </td>
            </tr>
            <tr>
                <td align="center" width="125">글내용</td>
                <td align="left" width="375" colspan="3">
                    <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=article.getContent()%></pre>
                </td>
            </tr>
            <tr height="30">
                <td colspan="4" align="right">
                    <input type="button" value="수정"
                    onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" value="삭제"
                           onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" value="목록"
                    onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>">
                </td>
            </tr>
        </table>
        <%
            }catch (Exception e){}
        %>
    </form>
</div>
</body>
</html>
