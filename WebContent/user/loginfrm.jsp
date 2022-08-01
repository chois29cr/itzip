<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<style>
* {
	font-family: 리디바탕;
	padding:0;
	margin:0;
}



.inputbox {
	width:300px;
	height:35px;
	border:1px solid #D0D0D0;
}

.inputbox:focus {outline:2px solid #000000;}

.bline {
	border-bottom:1px solid black;
}
.rline {
	border-right:1px solid #D0D0D0;
	border-bottom:1px solid #D0D0D0;
}
.lline {
	border-left:1px solid #D0D0D0;
	border-bottom:1px solid #D0D0D0;
}
.leftline {
	border-left:2px solid #E7E7E7;
}

.buttonA{
	outline: 1px solid #000000;
	background-color:#000000;
	color:white;
	border:none;
	text-align:center;
	width:300px;
	height:35px;	
	display:inline-block;
	cursor:pointer;
	margin:3px;
}
.buttonB{
	outline: 1px solid #000000;
	background-color:#6B6869;
	color:#C5C5C5;
	border:none;
	text-align:center;
	width:300px;
	height:35px;	
	display:inline-block;
	cursor:pointer;
	margin:3px;
}
.buttonC{
	outline: 1px solid #000000;
	background-color:#ffffff;
	color:#000000;
	border:none;
	text-align:center;
	width:300px;
	height:35px;	
	display:inline-block;
	cursor:pointer;
	margin:3px;
}

<!-- 폰트 사이즈 -->

.jb-xx-small { font-size: xx-small; }
.x-small { font-size: x-small; color: #a8a8a8; }
.xs-small { font-size: x-small; }
.jb-small { font-size: small; }
.jb-medium { font-size: medium; }
.jb-large { font-size: large; }
.jb-x-large { font-size: x-large; }
.jb-xx-large { font-size: xx-large; }
</style>
</head>
<body>
<br><br><br><br><br><br><br><br><br><br><br><br><br>


<table border="0" style="margin-left: auto; margin-right: auto;" border="0"  cellpadding="0" cellspacing="0" width="1000px" height="400px" align="center" >
	<tr>
		<td class="bline" align="left" height="40px" colspan="2">
			<strong>로그인</strong>
		</td>
	</tr>
	<tr>
		<td class="lline" width="500px">
			<table  border="0" style="margin-left: auto; margin-right: auto;" border="0"  cellpadding="0" cellspacing="0" width="100%" height="300px" align="center">
				<tr>
					<td>
						<table border="0" style="margin-left: auto; margin-right: auto;" border="0"  cellpadding="0" cellspacing="0" width="300px" height="200px" align="center">
							<tr>
								<td>
								<strong>회원 로그인</strong>
								</td>
							</tr>
							<tr>
								<td class="x-small">
								가입하신 아이디와 비밀번호를 입력해주세요.<br>
								비밀번호는 대소문자를 구분합니다.
								</td>
							</tr>
							<tr>
								<td>
								<input class="inputbox" type="text" placeholder="MEMBER ID">
								</td>
							</tr>
							<tr>
								<td>
								<input class="inputbox" type="text" placeholder="PASSWORD">
								</td>
							</tr>
							<tr>
								<td>
								<input class="buttonA" type="button" value="LOG-IN">
								</td>
							</tr>
							<tr>
								<td class="xs-small">
								 <input type="checkbox">보안접속
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
		<td class="rline" width="500px">
			<table  border="0" style="margin-left: auto; margin-right: auto;" border="0"  cellpadding="0" cellspacing="0" width="100%" height="300px" align="center">
					<tr>
						<td  class="leftline">
							<table border="0" style="margin-left: auto; margin-right: auto;" border="0"  cellpadding="0" cellspacing="0" width="300px" height="200px" align="center">
								<tr>
									<td>
									<strong>회원가입</strong>
									</td>
								</tr>
								<tr>
									<td class="x-small">
									가입하신 아이디와 비밀번호를 입력해주세요.<br>
									비밀번호는 대소문자를 구분합니다.
									</td>
								</tr>
								<tr>
									<td>
									<input class="buttonB" type="button" value="JOIN-US">
									</td>
								</tr>
								<tr>
									<td class="x-small">
									가입하신 아이디와 비밀번호를 입력해주세요.<br>
									비밀번호는 대소문자를 구분합니다.
									</td>
								</tr>
								<tr>
									<td>
									<input class="buttonC" type="button" value="ID/PASSWORD">
									</td>
								</tr>
							</table>
						</td>
					</tr>
			</table>
		</td>
	</tr>
</table>

<%@include file="../include/footer.jsp" %>