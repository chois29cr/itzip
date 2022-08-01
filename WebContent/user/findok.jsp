<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/table_form.css">

<%
String email = (String)request.getAttribute("email");
%>


<br><br><br><br><br><br>
<table style="margin-left: auto; margin-right: auto;" width="900px" border="0" align="center">
	<tr class="tablecol">
		<td><font size="4"><strong>이메일 찾기 결과</strong></font>
		</td>
	</tr>
	
	<tr>
		<td><br><br><br><br></td>
	</tr>
	<tr class="tablecol" align="center">
		<td>가입한 이메일 주소는 <%= email %> 입니다. </td>
	</tr>
	<tr>
		<td><br><br><br><br></td>
	</tr>
	
	<tr class="tablecol" align="center">
		<td>
			<input class="buttonA" type="button" value="로그인 하기" onclick="document.location='login.jsp';">
			<input class="buttonA" type="button" value="임시 비밀번호 발급" onclick="document.location='finduser.jsp';">
		</td>
	</tr>
</table>


<%@include file="../include/footer.jsp" %>