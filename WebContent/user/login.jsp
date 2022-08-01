<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>   
<link rel="stylesheet" type="text/css" href="../css/table_form.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">


<!-- 아웃라인 테이블 -->
<br><br><br><br><br><br><br><br>
<table style="margin-left: auto; margin-right: auto;" border="0" align="center">
	<tr class="tablecol">
		<td align="center"> <a href="../00board/main.jsp" class="logo">잇집 </a></td>
	</tr>
	<tr class="tablecol">
		<td>
			<form id="loginFrm" name="loginFrm" method="post">
				
				<!-- 로그인 테이블 -->
				<table style="margin-left: auto; margin-right: auto;" border="0" width="450px" align="center">
					<tr class="tablecol">
						<td>
							<input class="inputbox" type="text" id="email" name="email" placeholder="이메일">
							<span id="emailspan" name="emailspan"></span>
						</td>
						<td rowspan="2" align="center">
							<input class="loginbutton" type="submit" value="로그인" onclick="loginCheck(); return false;">
						</td>
					</tr>
					
					<tr class="tablecol">
						<td>
							<input class="inputbox" type="password" id="pw" name="pw" placeholder="비밀번호">
							<span id="pwspan" name="pwspan"></span>
						</td>
					</tr>
					
					<tr>
						<td colspan="2"><br> <hr width="450px"> </td>   <!-- 구분선 -->
					</tr>
					
					<tr>
						<td align="right">
							<input class="buttonB" type="button" value="아이디/비밀번호찾기"
									onclick="document.location='finduser.jsp'">
						</td>
						<td align="right">
							<input class="buttonB" type="button" value="회원가입"
									onclick="document.location='join.jsp'">
						</td>
					</tr>
				</table>
			</form>
		</td>
	</tr>	
</table>

<br><br><br><br><br><br>
<br><br><br><br><br><br>
<br><br>

<script>
function loginCheck(){
	var email = $("#email").val();
	var pw = $("#pw").val();
	
	if(email == ""){
		alert("이메일을 입력하세요");
		loginFrm.email.focus();
		return false;
	}
	
	if(pw == ""){
		alert("비밀번호를 입력하세요");
		loginFrm.pw.focus();
		return false;
	}

	//email, pw가 빈 칸이 아니면, UserController login.do와 연결
	$.ajax({
		url: "/teamc2/user/login.do",
		type: "post",
		data: "email=" + email + "&pw=" + pw,
		success: function(data){
			if(data == "true"){		
				document.location="/teamc2/00board/main.jsp";
			}else{
				alert("없는 회원이거나, 로그인 정보가 불일치합니다.");			
				return false;
			}
		}
	});
}
</script>

<%@include file="../include/footer.jsp" %>