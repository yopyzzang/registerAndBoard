<%@ page import="java.util.Vector" %>
<%@ page import="member.ZipCodeVO" %><%--
  Created by IntelliJ IDEA.
  User: yopy
  Date: 2019-12-30
  Time: 오후 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script language="JavaScript" src="/JavaScript/script.js"></script>
<jsp:useBean id="dao" class="member.StudentDAO"/>

<%
    request.setCharacterEncoding("UTF-8");
    String check = request.getParameter("check");
    String dong = request.getParameter("dong");
    Vector<ZipCodeVO> zipCodeList = dao.zipCodeRead(dong);
    int totalList = zipCodeList.size();
%>
<html>
<head>
    <title>우편번호 검색</title>
</head>
<body>
<div style="text-align: center;">
    <b>우편번호 찾기</b>
    <form name="zipForm" method="post" action="zipCheck.jsp">
        <table>
            <tr>
                <td>동 이름 입력 : <input name="dong" type="text">
                    <input type="button" value="검색" onclick="dongCheck()"/>
                </td>
            </tr>
        </table>
        <input type="hidden" name="check" value="n">
    </form>
    <table>
        <%
            if (check.equals("n")) {
        %>
        <%
            if (zipCodeList.isEmpty()) {
        %>
        <tr>
            <td align="center"><br>검색된 결과가 없어요..!</td>
        </tr>
        <%
        } else {
        %>
        <tr>
            <td align="center"><br>
                @검색 후 , 아래 우편번호를 클릭하면 자동으로 입력됩니다.
            </td>
        </tr>
        <%
            for (int i = 0; i < totalList; i++) {
                ZipCodeVO vo = zipCodeList.elementAt(i);
                String tempZipcode = vo.getZipcode();
                String tempSido = vo.getSido();
                String tempGugun = vo.getGugun();
                String tempDong = vo.getDong();
                String tempRi = vo.getRi();
                String tempBunji = vo.getBunji();
                if (tempRi == null) tempRi = " ";
                if (tempBunji == null) tempBunji = " ";
        %>
        <tr>
            <td>
                <a href="javascript:sendAddress('<%=tempZipcode%>','<%=tempSido%>','<%=tempGugun%>'
,'<%=tempDong%>','<%=tempRi%>','<%=tempBunji%>')">
                    <%=tempDong%>&nbsp;<%=tempRi%>&nbsp;<%=tempBunji%>
                </a><br>
                <%
                        }
                    }
                %>
                <%}%>
            </td>
        </tr>
        <tr>
            <td align="center">
                <a href="javascript:this.close();">닫기</a>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
