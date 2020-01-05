<%@ page import="board.BoardDAO" %><%--
  Created by IntelliJ IDEA.
  User: yopy
  Date: 2020-01-05
  Time: 오후 11:18
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
    String pageNum = request.getParameter("pageNum");
    BoardDAO dbPro = BoardDAO.getInstance();
    int check = dbPro.updateArticle(article);
    if(check==1){
%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">
<% }else {%>
<script language="JavaScript">
    alert("비밀번호가 맞지 않아요..!");
    history.go(-1);
</script>
<%
    }
%>
