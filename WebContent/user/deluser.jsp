<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/table_form.css">
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">

<%
//로그인이 안됐을 경우 
if (user == null){
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter writer = response.getWriter();
	writer.println("<script>alert('올바르지 않는 접근입니다.'); location.href='"+"/teamc2/00board/main.jsp"+"';</script>");
	writer.close();
}
%>


<table class="innertable" width="1000px" align="center" border="0">
	<tr class="tablecol">
		<td align="center" colspan="3"> <a href="../00board/main.jsp" class="logo">잇집</a></td>	
	</tr>
	<tr class="tablecol">
		<td class="labeltd" align="center" colspan="3">
			<font size="4">회원탈퇴</font>
		</td>
	</tr>
	<tr class="tablecol">
		<td align="center">
			<font size="3" style="padding:0 0 10px 0;"> 저희 홈페이지를 그만 이용하신다니... 아쉽습니다..</font>
			<br>
			<font size="3" style="padding:0 0 10px 0;">아이디와 비밀번호를 입력하시면 완전히 탈퇴처리 됩니다.</font>
		</td>
	</tr>
	<tr>
		<td>
			<form id="delFrm" name="delFrm" method="post">
				<!-- 유저 정보 입력 -->
				<table style="margin-left: auto; margin-right: auto; padding:100px 0 100px 0;" border="0" align="center">
					<tr class="tablecol">
						<td>
							<input class="inputbox" type="text" id="email" name="email" placeholder="이메일" value="">
						</td>
					</tr>
					
					<tr class="tablecol">
						<td>
							<input class="inputbox" type="text" id="pw" name="pw" placeholder="비밀번호" value="">
						</td>
					</tr>
					<tr><td><br><br><br><br><tr>
					<tr>
						<td rowspan="2" align="center">
							<input class="buttonA" type="submit" value="취소" onclick="goProfile();">
							<input class="buttonA" type="submit" value="탈퇴하겠습니다." onclick="delUser(); return false;">
						</td>
					</tr>
				</table>
			</form>
		</td>
	</tr>
</table>

<script>
function goProfile(){
	document.location="/teamc2/mypage/profileModi.jsp";
}

function delUser(){
	

	if( confirm("정말로 탈퇴하시겠습니까?") != 1){
		return false;		
	}
	
	//email, pw가 빈 칸이 아니면, UserController login.do와 연결
	$.ajax({
		url: "/teamc2/user/deluser.do",
		type: "post",
		data: "email=" + email + "&pw=" + pw,
		success: function(data){
			if(data == "true"){
				alert("탈퇴되었습니다. 안녕히 가세요.");
				document.location="/teamc2/00board/main.jsp";
			}else{
				alert("입력한 정보가 올바르지 않습니다..");			
				return false;
			}
		}
	});
}
</script>

<%@include file="../include/footer.jsp" %>