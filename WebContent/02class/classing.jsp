<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/classing.css">
<%
String name = user.getName();
String phone = user.getPhone();
String cno = request.getParameter("cno");
ClassboardDTO cdto = new ClassboardDTO();
ClassboardVO c = cdto.view(cno);

DCattachDTO da = new DCattachDTO();
DCattachVO dv = da.dImage(Integer.parseInt(cno));
%>
<form id="sWriteFrm" name="sWriteFrm" method="get" action="/teamc2/02class/classing.do">
	<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
		<tr>
			<td class="head">
				<font size="5"><Strong>신청하기</Strong></font>
			</td>
		</tr>
		<tr>
			<td class="line">
				<table>
					<tr>
						<td height="50px">
							<font size="4"><Strong><%= c.getTitle() %></Strong></font>
						</td>
					</tr>
					<tr>
						<td>
							
						</td>
					</tr>
					<tr>
						<td>
							<img class="imglow" src="<%= dv.getDcattach() %>" width="100px" alt="글번호:<%= dv.getCno() %>" title="<%= c.getTitle() %>"><br>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table>
					<tr>
						<td  height="50px">
							<font size="4"><Strong>본인정보</Strong></font>
							<input type="hidden" name="noHidden" value="<%= cno %>">
							<input type="hidden" name="image" value="<%= dv.getDcattach() %>">
							<input type="hidden" name="title" value="<%= c.getTitle() %>">
						</td>
					</tr>
					<tr>
						<td>
							수강생 성함
						</td>
					</tr>
					<tr>
						<td>
							<input class="inputbox" type="text" name="name" value="<%= name %>">
						</td>
					</tr>
					<tr>
						<td>
							수강생 연락처
						</td>
					</tr>
					<tr>
						<td>
							<input class="inputbox" type="text" name="phone" value="<%= phone %>">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center">
				<input class="classbutton" type="submit" value="신청">
			</td>
		</tr>
	</table>
</form>

<%@include file="../include/footer.jsp" %>