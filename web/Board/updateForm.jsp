<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %><%--
  Created by IntelliJ IDEA.
  User: yopy
  Date: 2020-01-04
  Time: 오전 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판</title>
    <script language="JavaScript" src="script.js"></script>
</head>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");
    try {
        BoardDAO dbPro = BoardDAO.getInstance();
        BoardVO article = dbPro.updateGetArticle(num);
%>
<body>
<div style="text-align: center;">
    <b>글수정</b>
    <br>
    <form method="post" name="writeform"
    action="updateProc.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
        <table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
            <tr>
                <td width="70" align="center">이름</td>
                <td align="left" width="330">
                    <input type="text" size="10" maxlength="10" name="writer" value="<%=article.getWriter()%>">
                    <input type="hidden" name="num" value="<%=article.getNum()%>">
                </td>
            </tr>
            <tr>
                <td width="70" align="center">제목</td>
                <td align="left" width="330">
                    <input type="text" size="40" maxlength="50" name="subject" value="<%=article.getSubject()%>">
                </td>
            </tr>
            <tr>
                <td width="70" align="cneter">이메일</td>
                <td align="left" width="330">
                    <input type="text" size="40" maxlength="30" name="email" value="<%=article.getEmail()%>">
                </td>
            </tr>
            <tr>
                <td width="70" align="center">내 용</td>
                <td align="left" width="330">
                    <textarea name="content" rows="13" cols="40">
                        <%=article.getContent()%>
                    </textarea>
                </td>
            </tr>
            <tr>
                <td width="70" align="center">비밀번호</td>
                <td align="left" width="330">
                    <input type="password" size="8" maxlength="12" name="pass">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="글수정">
                    <input type="reset" value="다시작성">
                    <input type="button" value="목록보기"
                    onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
                </td>
            </tr>
        </table>
    </form>
</div>
<%
    }catch (Exception e){}
%>
</body>
</html>
