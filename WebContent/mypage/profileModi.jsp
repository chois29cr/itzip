<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/table_form.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/mypage.css">

<%
//로그인이 안됐을 경우 
if (user == null){
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter writer = response.getWriter();
	writer.println("<script>alert('올바르지 않는 접근입니다.'); location.href='"+"/teamc2/00board/main.jsp"+"';</script>");
	writer.close();
}
%>


<style>
#profile_thumbnail img{
    width: 300px;
    height: 300px;
    border-radius: 50%;
}

.mailbox {
    border: 1px solid #E6E6E6;
    height:40px;
    width: 300px;
    background-color: #FBFBFB;
}

.cat_title {
	text-decoration:none; 
	color:black;
	font-size:20px;
	font-weight:bold;
}
</style>


<table style="margin-left: auto; margin-right: auto;" border="0" cellpadding="0" cellspacing="0" width="1000px" align="center">
	<tr>
		<td>
			<table border="0" width="100%">
				<tr>
					<td colspan="2" style="padding:5px;"><h3><a href="../mypage/mypageHome.do">마이페이지</a></h3></td>
				</tr>
				<tr>
					<td colspan="2" style="padding:5px;">
						<a class="cur_active" href="../mypage/profileModi.jsp">내 정보</a> &nbsp;&nbsp;&nbsp;
						<a href="../mypage/mypost.do">내 게시물</a> &nbsp;&nbsp;&nbsp;
						<a href="../mypage/myreply.do">내 댓글</a> &nbsp;&nbsp;&nbsp;
						<a href="../mypage/mylike.do">좋아요</a> &nbsp;&nbsp;&nbsp;
						<a href="../mypage/myclass.do">찜한 클래스</a> &nbsp;&nbsp;&nbsp;
						<a href="../mypage/myclass.do">수강 내역</a> 
					</td>
				</tr>
			</table>
			<br><br>
		</td>
	</tr>
</table>

<form id="profileFrm" name="profileFrm" method="post" action="/teamc2/user/modify.do" enctype="multipart/form-data">
<input type="hidden" name="oldFile" value="<%=user.getFile() %>">
<input type="hidden" name="basicFile" value="">
<input type="hidden" name="selectProType"> <!--  프사등록 버튼 (M), 기본프사 버튼(D) -->
<input type="hidden" name="selectTexture"> <!-- name=texture 옵션 선택.. -->
<table class="innertable" width="1000px" >
	<tr class="tablecol">
		<td class="mytd" colspan="2">프로필</td>
	</tr>
	<tr>
		<td colspan="3"> <hr width="100%"> </td>   <!-- 구분선 -->
	</tr>

	<!-- 프사 영역 -->
	<tr>
		<td colspan="2">
			<table style="margin-left: auto; margin-right: auto;" border="0" align="center">
				<tr align="center">
					<td>
						<div id="profile_thumbnail">
							<img src="<%=user.getFile() %>" id="image">
						</div>
					</td>
				</tr>
				<tr align="center">
					<td>
						<input type="file" id="file" name="file" accept="img/*" style="display:none" onchange="thumbNail(event,this);">
						<input class="buttonA" type ="button" value="프사등록" onclick="document.all.file.click();">							
						<input class="buttonA" type="button" value="기본프사!" onclick="basicImg(this);">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<!-- 회원 정보 영역 -->
	<tr align="center">
		<td>
			<table border="0">
				<tr>
					<td width="150px">이메일</td>		
					<td class="mailbox"> <%= user.getEmail() %>	</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<font size="2" color="#63A6DB">이메일은 변경할 수 없습니다.</font></td>
				</tr>
				
				<tr>
					<td>비밀번호 입력</td>
					<td> <input class="inputbox" type="password" id="pw" name="pw">	</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<font class="pwfont" size="2"><span id="pwspan"></span></font>
					</td>
				</tr>
				
				<tr>
					<td>비밀번호 확인</td>
					<td> <input class="inputbox" type="password" id="pwok" name="pwok"> </td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<font class="pwfont" size="2"><span id="pwokspan"></span></font>
					</td>
				</tr>
								
				<tr>
					<td>닉네임</td>
					<td>
					<input class="inputbox" type="text" id="name" name="name" value="<%=user.getName()%>"> </td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<font class="namefont" size="2"><span id="namespan"></span></font>
					</td>
				</tr>
								
				<tr>
					<td>핸드폰 번호</td>
					<td> <input class="inputbox" type="text" id="phone" name="phone" value="<%=user.getPhone()%>"> </td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<font class="phfont" size="2"><span id="phspan"></span></font>
					</td>
				</tr>
				
				<tr>
					<td>인테리어 기호</td>
					<td class="inputbox">
						<select id="texture" name="texture">
						    <option value="classic" <% if (user.getTexture().equals("classic")) out.print("selected");%>>classic</option> 
						    <option value="industrial" <% if (user.getTexture().equals("industrial")) out.print("selected");%>>industrial</option>
						    <option value="minimal" <% if (user.getTexture().equals("minimal")) out.print("selected");%>>minimal</option>
						    <option value="modern" <% if (user.getTexture().equals("modern")) out.print("selected");%>>modern</option>
						    <option value="natural" <% if (user.getTexture().equals("natural")) out.print("selected");%>>natural</option>
						    <option value="romantic" <% if (user.getTexture().equals("romantic")) out.print("selected");%>>romantic</option>
						</select>
					</td>
				</tr>
			</table>
		</td>	
	</tr>
	

	<!-- 나머지 버튼들... -->	
	<tr align="center">
		<td align="right">
			<a class="buttonB" href="../user/deluser.jsp">
				<font size="2"> 탈퇴하시겠습니까? </font>
			</a>
		</td>
	</tr>
	
	<tr align="center">
		<td>
			<input class="buttonA" type="button" value="취소" onclick="location.href='../mypage/mypageHome.do'">
			<input class="buttonA" type="submit" value="확인" onclick="callSubmit(); return false;">
		</td>
	</tr>	

</table>
</form>


<script>

//프로필 사진 업로드 시, 썸네일 생성하는 함수
function thumbNail(event, obj){
	var jObj = $(obj);
	var reader = new FileReader();
	reader.onload = function(event){
	
		var dataUrl = event.target.result;
		jObj.parent().parent().prev().children().find("#profile_thumbnail").find("img").attr("src", dataUrl);		

	};
	
	reader.readAsDataURL(event.target.files[0]);		
	document.profileFrm.selectProType.value='M';
}


//기본프사! 버튼을 누르면 랜덤프로필 하나가 선택된다.
function basicImg(obj){
	var jObj = $(obj);
	var img = new Array();
	img[0] = "/teamc2/images/profile_image/profile1.png";
	img[1] = "/teamc2/images/profile_image/profile2.png";
	img[2] = "/teamc2/images/profile_image/profile3.png";
	img[3] = "/teamc2/images/profile_image/profile4.png";
	img[4] = "/teamc2/images/profile_image/profile5.png";
	var i = Math.floor(Math.random()*(img.length));
	jObj.parent().parent().prev().children().find("#profile_thumbnail").find("img").attr("src", img[i]);
	$("input[name=basicFile]").val(img[i]);
	$("input[name=file]").val("");
	
	document.profileFrm.selectProType.value='D'; 
}


//프사 이외의 정보 수정 시...
var pwFlag = false;
var pwokFlag = false;
var nameFlag = true;
var phoneReg = /^\d{3}-\d{3,4}-\d{4}$/; //핸드폰 정규식
var phoneFlag = true;

//폰트의 색상을 변경하기 위함
var pwfont = $(".pwfont");
var namefont = $(".namefont");
var phfont = $(".phfont");

var tColor = "#63A6DB";
var fColor = "red";

//span영역의 글자 기본색은 참 값으로 세팅
pwfont.attr("color", tColor);
namefont.attr("color", tColor);
phfont.attr("color", tColor);

//id=pw인 곳에 값이 없으면, span 영역에 문구 띄움
$("#pw").blur(function(){	
	var pw = $("#pw").val();
	pwfont.attr("color", tColor);
	
	if(pw == ""){
		pwfont.attr("color", fColor);
		$("#pwspan").html("비밀번호를 입력하세요.");
		$("#pwokspan").html("");
		pwFlag = false;
		
	} else if (pw.length < 8) {
		pwfont.attr("color", fColor);
		$("#pwspan").html("비밀번호는 8글자 이상 입력하세요.");
		$("#pwokspan").html("");
		pwFlag = false;
		
	} else {
		$("#pwspan").html("사용가능한 비밀번호 입니다.");
		$("#pwokspan").html("");
		pwFlag = true;
	}	
});


//id=pwok인 곳에 값이 없으면, span 영역에 문구 띄움
$("#pwok").blur(function(){	
	var pw = $("#pw").val();
	var pwok = $("#pwok").val();
	pwfont.attr("color", tColor);
	
	if( pw == ""){
		pwfont.attr("color", fColor);
		$("#pwspan").html("");
		$("#pwokspan").html("비밀번호 먼저 입력하세요.");
		pwokFlag =false;
		
	//pw가 작성되어 있다면..
	}else{
		
		if (pw.length < 8){
			pwfont.attr("color", fColor);
			$("#pwspan").html("비밀번호는 8글자 이상 입력하세요.");
			$("#pwokspan").html("비밀번호는 8글자 이상 입력하세요.");
			pwokFlag =false;
			return;
		}
		
		//비밀번호가 8글자 이상일 때 아래 실행
		if (pw != pwok){
			pwfont.attr("color", fColor);
			$("#pwspan").html("");
			$("#pwokspan").html("입력한 두 비밀번호가 다릅니다. 비밀번호를 확인하세요.");		
			pwokFlag =false;
		}else {
			$("#pwspan").html("");
			$("#pwokspan").html("비밀번호가 일치합니다.");
			pwokFlag =true;
		}
	}
});


//id=name인 곳에 값이 없으면, span 영역에 문구 띄움
$("#name").blur(function(){	
	var name = $(this).val();
	namefont.attr("color", tColor);
	
	//닉네임 공백o
	if(name == ""){
		namefont.attr("color", fColor);
		$("#namespan").html("닉네임을 입력하세요.");
		nameFlag = false;		
		
	//닉네임 공백x, 닉네임 길이x
	} else if(name.length > 8){
		namefont.attr("color", fColor);
		$("#namespan").html("닉네임은 8글자 이하로 지으세요.");			
		nameFlag = false;		
		return;
	}
	
	
	//닉네임 공백x, 닉네임 길이ok
	if (name!="" && name.length <= 8){
		
		//UserController name.do와 연결
		$.ajax({
			url: "/teamc2/user/nameCK.do",
			type: "post",
			data: "name=" + name,
			success: function(data){
				
				//alert(data); //닉네임 중복이 없을 때, true 찍힘
				if (data == "true"){
					$("#namespan").html("사용가능한 닉네임입니다.");
					nameFlag = true;
				}else{
					namefont.attr("color", fColor);
					$("#namespan").html("중복된 닉네임이 있습니다. 다른 닉네임을 입력하세요.");
					nameFlag = false;
				}
			}
		});
	}
});

//id=phone인 곳에 값이 없으면, span 영역에 문구 띄움
$("#phone").blur(function(){
	//console.log(phoneFlag);
	var phone = $("#phone").val();
	phfont.attr("color", tColor);
	console.log("핸드폰 입력 값 : " + phone);
	
	//핸드폰 공백o
	if(phone == ""){
		phfont.attr("color", fColor);
		$("#phspan").html("핸드폰 번호를 입력하세요.");
		phoneFlag = false;		
		return;
	}	
	
	//핸드폰 공백x, 정규식x
	if(phone.match(phoneReg) == null){
		phfont.attr("color", fColor);
		$("#phspan").html("제대로 작성되지 않았습니다. 다시 한번 확인하세요. (ex>010-2345-6789)");
		phoneFlag = false;
		return;
	}
	
	//공백x, 정규식ㅇ 일 때 중복검사..
	if (phone!="" && phone.match(phoneReg) != null){
		
		//UserController phoneCK.do와 연결
		$.ajax({
			url: "/teamc2/user/phoneCK.do",
			type: "post",
			data: "phone=" + phone,
			success: function(data){
				//alert(data); //핸드폰 중복이 없을 때, true 찍힘
				if (data == "true"){
					$("#phspan").html("사용가능한 핸드폰 번호입니다.");
					phoneFlag = true;
				}else{
					phfont.attr("color", fColor);
					$("#phspan").html("중복된 핸드폰 번호가 있습니다. 다른 핸드폰 번호을 입력하세요.");
					phoneFlag = false;
				}
			}
		});
	}
});



function callSubmit(){

	//틀린 곳에만 span 띄워주기 위해 다 지움
	$("#pwspan").html("");
	$("#pwokspan").html("");
	$("#namespan").html("");
	$("#phspan").html("");
	
	if (pwFlag == false || pwokFlag == false) {
		pwfont.attr("color", fColor);
		alert("비밀번호가 유효하지 않습니다. 확인하세요.");
		$("#pwspan").html("비밀번호를 확인하세요.");
		$("#pwokspan").html("비밀번호를 확인하세요.");
		return;		
	}
	
	if (nameFlag == false) {
		namefont.attr("color", fColor);
		alert("닉네임이 유효하지 않거나 입력되지 않았습니다. 확인하세요.");
		$("#namespan").html("닉네임을 확인하세요.");
		return;
	}

	if (phoneFlag == false) {
		phfont.attr("color", fColor);
		alert("핸드폰 번호가 유효하지 않거나 입력되지 않았습니다. 확인하세요.");
		$("#phspan").html("핸드폰 번호를 확인하세요.");
		return;
	}
	
	//위에서 입력한 정보가 다 맞으면	
	document.profileFrm.submit();
}

</script>

<%@include file="../include/footer.jsp" %>