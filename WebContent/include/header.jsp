<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dto.*" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="../css/header.css">
<script src="../js/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>

<body>
<% 
UserinfoVO user = (UserinfoVO)session.getAttribute("user"); 
String k = request.getParameter("k");
if(k == null) k = "";
if(user != null) {
	String isadmin = user.getIsadmin();
}
%>



<table class="headertable" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr align="center">
		<td><a class="logo" href="../00board/main.jsp">잇집</a></td>
		<td align="center" width="100px">
			<a class="cat_href" href="../01myroom/myroom.jsp">
			<span id ="category">내방</span>
			<img class="hvr-grow" alt="로고입니다." src="/teamc2/images/header_hover/blue.png" height="10px" width="10px">
			</a>
		</td>
		<td align="center" width="100px">
			<a class="cat_href" href="../02class/classBoard.jsp">
				<span id ="category">클래스</span>
				<img class="hvr-grow" alt="로고입니다." src="/teamc2/images/header_hover/yellow.png" height="10px" width="10px">
			</a>
		</td>
		<td align="center" width="100px">
			<a class="cat_href" href="../03qna/qna.jsp">
				<span id ="category"> Q&A </span>
				<img class="hvr-grow" alt="로고입니다." src="/teamc2/images/header_hover/red.png" height="10px" width="10px">
			</a>
		</td>
		<td align="center" width="100px">
			<a class="cat_href" href="../04brand/story.jsp">
				<span id ="category">브랜드스토리</span>
				<img class="hvr-grow" alt="로고입니다." src="/teamc2/images/header_hover/green.png" height="10px" width="10px">
			</a>
		</td>
		<td align="right">
			<form id="searchFrm" name="searchFrm" method="get" action="../00board/search.jsp">			
				<input class="searchbox" id="k" name="k" type="text" placeholder="검색">
			</form>
		</td>	
		<%
		if (user == null){
		%>
			<td width="400px">
				<a class="logjn" href="../user/login.jsp"> 로그인 </a> &nbsp; &nbsp; &nbsp;
				<a class="logjn" href="../user/join.jsp"> 회원가입 </a>
			</td>
		<%
		}else {
		%>	
		
		<td width="220px" align="right">
			<div id="profile" align="center">
				<input type="hidden" id="isadmin" name="isadmin" value="<%=user.getIsadmin() %>">
				<img alt="프로필사진" src="<%=user.getFile() %>" style="width:45px; height:45px; border-radius:50%;">
				<%= user.getName() %>
				<%
				if(user.getIsadmin().equals("Y")){
				%>
				<div class="profilehiddenY"><br>
					<a class="main_cate" href="../manager/oArticle.do?page=1" style="text-decoration:none; color:#000000">관리자페이지</a>
					<br><br>
					<a class="main_cate" href="../mypage/mypageHome.do" style="text-decoration:none; color:#000000">마이페이지</a>
					<br><br>
					<a class="main_cate" href="../02class/cWrite.jsp" style="text-decoration:none; color:#000000">클래스 등록</a>
					<br><br>
					<a class="main_cate" href="../01myroom/mWrite.jsp" style="text-decoration:none; color:#000000">내방 자랑하기</a>
					<br><br>
					<a class="main_cate" href="../03qna/qWrite.jsp" style="text-decoration:none; color:#000000">질문하기</a>
					<br><br>
				</div>
				<%
				}else{
				%>
				<div class="profilehiddenN"><br>
					<a class="main_cate" href="../mypage/mypageHome.do" style="text-decoration:none; color:#000000">마이페이지</a>
					<br><br>
					<a class="main_cate" href="../01myroom/mWrite.jsp" style="text-decoration:none; color:#000000">내방 자랑하기</a>
					<br><br>
					<a class="main_cate" href="../03qna/qWrite.jsp" style="text-decoration:none; color:#000000">질문하기</a>
					<br><br>
				</div>
				<%
				}
				%>
			</div>
		</td>
		<td width="180px">
			<a class="logjn" href="../mypage/mypageHome.do" style="padding:3px;">마이페이지</a>
			<br><br>
			<a class="logjn" href="/teamc2/user/logout.do" style="padding:3px;">로그아웃</a>
		<%
		}
		%>		
		</td>
	</tr>
</table>
<br><br><br><br><br><br>

<a class="sangdam" id="channel-chat-button" href="#" onclick="void chatChannel();">
  <img src="../images/icon/sangdam.png"  />
</a>
<a class="chat" href="#" onclick="chat()"><img src="../images/icon/chat.png"  /></a>



<!-- 헤더 유저/관리자 기능 토글 -->
<script>
$(document).ready(function() {
	var isadmin = $('#profile').find('#isadmin').val();
	console.log(isadmin);
	
	$('#profile').click(function() {
   		if(isadmin == "Y"){    		
       	$(this).find(".profilehiddenY").toggleClass('open');
   		}
   		if(isadmin == "N"){
	   	     $(this).find(".profilehiddenN").toggleClass('open');    		
   		}
  	});
});
</script>


<!-- 카카오톡 상담 기능 -->
<script type="text/javascript">
function chatChannel() {
  Kakao.Channel.chat({
    channelPublicId: '_EVfTs',
  })
}
function loginWithKakao() {
  Kakao.Auth.authorize({
    redirectUri: 'https://developers.kakao.com/tool/demo/oauth'
  })
}
// 아래는 데모를 위한 UI 코드입니다.
displayToken()
function displayToken() {
  const token = getCookie('authorize-access-token')
  if(token) {
    Kakao.Auth.setAccessToken(token)
    Kakao.Auth.getStatusInfo(({ status }) => {
      if(status === 'connected') {
        document.getElementById('token-result').innerText = 'login success. token: ' + Kakao.Auth.getAccessToken()
      } else {
        Kakao.Auth.setAccessToken(null)
      }
    })
  }
}
function getCookie(name) {
  const value = "; " + document.cookie;
  const parts = value.split("; " + name + "=");
  if (parts.length === 2) return parts.pop().split(";").shift();
}

// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('e7b35836bbfd7b332af72bcd6186fde1');

// SDK 초기화 여부를 판단합니다.
console.log(Kakao.isInitialized());
    
function chat(){
 	var url="../00board/broadcast.html";
     window.open(url,"","width=450,height=700,left=1400,top=300,status=no,titlebar=no,location=no");
}
</script>
<br><br><br>