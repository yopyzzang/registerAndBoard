<%--
  Created by IntelliJ IDEA.
  User: yopy
  Date: 2020-01-01
  Time: 오후 10:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원 탈퇴</title>
    <script language="JavaScript" src="/JavaScript/script.js"></script>
</head>
<body onload="begin()">
<form name="myForm" method="post" action="deleteProc.jsp" onsubmit="return checkIt()">
    <table width="260" border="1" align="center">
        <tr>
            <td colspan="2" align="center"><b style="color: red">회원탈퇴</b></td>
        </tr>
        <tr>
            <td width="150"><b>비밀번호 입력</b></td>
            <td width="110">
                <input type="password" name="pass" size="15">
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="회원탈퇴">
                <input type="button" value="취  소" onclick="javascript:window.location='login.jsp'">
            </td>
        </tr>
    </table>
</form>

</body>
</html>
