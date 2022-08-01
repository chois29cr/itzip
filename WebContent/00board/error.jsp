<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<% response.setStatus(200); %>
<% String referer = (String)request.getHeader("REFERER"); //이전페이지 url정보를 가져온다 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>잇집</title>
<link rel="stylesheet" type="text/css" href="../css/table_form.css">

<style>
.logo {
	text-decoration:none;
	color:black;	
	font-family: Sandoll 삼립호빵체 TTF Outline;
	font-size: 36px;
	width:250px;
}
* {
	font-family: 리디바탕;
	padding:0;
	margin:0;
	box-sizing: border-box;
	vertical-align:middle;
}
.buttonA{
	outline: 1px solid #ffffff;
	background-color:#6AAFE6;
	color:white;
	border:none;
	text-align:center;
	width:100px;
	height:35px;	
	display:inline-block;
	cursor:pointer;
	margin:3px;
}
.buttonA:hover{
	outline: 1px solid #ffffff;
 	background-color:#b9dcf0;
 	color:black;
	transition: background-color .3s; 	
}
</style>

</head>
<body>

<br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br>
<table style="margin-left: auto; margin-right: auto;" border="0" align="center">
	<tr class="tablecol">
		<td align="center"> <a href="/teamc2/00board/main.jsp" class="logo">잇집</a></td>
	</tr>
	<tr >
		<td style="padding:10px;">페이지를 찾을 수 없습니다.</td>
	</tr>
	<tr>
		<td align="center">
			<input type="button" class="buttonA" value="메인으로" onclick="location.href='/teamc2/00board/main.jsp';">			
		</td>
	</tr>
</table>



<script>
//약간 빈틈이 있어서 메인으로 이동하는 버튼으로 수정함
/*
function goBack(){ 
	history.back()
}

$(document).ready(function(){	
	var preUrl = document.referrer;
	
	//이전 방문한 url 찍기
	console.log("이전url: "+preUrl);	
}); 
 */
</script>


</body>
</html>