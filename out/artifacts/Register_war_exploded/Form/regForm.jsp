<%--
  Created by IntelliJ IDEA.
  User: itbank
  Date: 2019-12-30
  Time: 오후 1:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script language="JavaScript" src="/JavaScript/script.js"></script>
<html>
<head>
    <title>Register Form</title>
</head>
<body>
<form method="post" action="regProc.jsp" name="regForm">
    <table border="1">
        <tr>
            <td colspan="2" align="center">회원가입 정보 입력</td>
        </tr>
        <tr>
            <td align="right">아이디&nbsp;&nbsp;</td>
            <td><input type="text" name="id"/>&nbsp;
                <input type="button" value="중복확인" onclick="idCheck(this.form.id.value)"/></td>
        </tr>
        <tr>
            <td align="right">패스워드&nbsp;&nbsp;  </td>
            <td><input type="password" name="pass"/></td>
        </tr>
        <tr>
            <td align="right">패스워드 확인&nbsp;&nbsp; </td>
            <td><input type="password" name="repass"/></td>
        </tr>
        <tr>
            <td align="right">이름&nbsp;&nbsp;  </td>
            <td><input type="text" name="name"/></td>
        </tr>
        <tr>
            <td align="right">전화번호&nbsp;&nbsp;  </td>
            <td>
                <select name="phone1">
                    <option value="02">02</option>
                    <option value="010">010</option>
                    <option value="011">011</option>
                    <option value="016">016</option>
                    <option value="017">017</option>
                    <option value="018">018</option>
                    <option value="019">019</option>
                </select>
                <input type="text" name="phone2" size="5"/>
                <input type="text" name="phone3" size="5"/>
            </td>
        </tr>
        <tr>
            <td align="right">이메일&nbsp;&nbsp;</td>
            <td><input type="text" name="email"/></td>
        </tr>
        <tr>
            <td align="right">우편번호&nbsp;&nbsp;  </td>
            <td><input type="text" name="zipcode"/>
                <input type="button" value="찾기" onclick="this"/></td>
        </tr>
        <tr>
            <td align="right">주소1&nbsp;&nbsp;  </td>
            <td><input type="text" name="address1" size="50"/></td>
        </tr>
        <tr>
            <td align="right">주소2&nbsp;&nbsp;  </td>
            <td><input type="text" name="address2" size="30"/></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="button" value="회원가입" onclick="this"/>&nbsp;&nbsp;
                <input type="reset" value="다시입력"/>
            </td>
        </tr>
    </table>
</form>

</body>
</html>
