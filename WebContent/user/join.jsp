<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="dto.UserinfoDTO"%>
<%@include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/table_form.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<script src="../js/jquery-3.6.0.min.js"></script>
<body>
<br><br><br><br><br><br>
<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
	<tr class="tablecol">
		<td align="center"> <a href="../00board/main.jsp" class="logo">잇집</a></td>	
	</tr>
	<tr class="tablecol">
		<td class="labeltd" align="center" colspan="2"><font size="4">회원가입</font></td>
	</tr>
	<tr class="tablecol">
		<td>
		
		<form id="joinFrm" name="joinFrm" method="post" action="join2.jsp" >
			<input type="hidden" name="file">	
				<!-- 회원가입 테이블 -->
				<table style="margin-left: auto; margin-right: auto;" border="0" width="550px">
					<tr class="tablecol">
						<td width="100px"></td>
						<td align="left" colspan="2">
							<input type="text" id="email" name="email" class="inputbox" placeholder="example@naver.com">
						</td>
						<td>
							<input class="buttonA" type="button" value="인증번호 전송" onclick="emailSend();">
						</td>
					</tr>
					<tr>
						<td width="100px"></td>
						<td>
							<font class="emailfont" size="2"><span id="emailspan"></span></font>
						</td>
					</tr>
										
					<tr class="tablecol">
						<td width="100px"></td>
						<td align="left" colspan="2">
							<input type="text" id="certiNum" name="certiNum" class="inputbox" width="250px" placeholder="인증번호 입력">
						</td>
						<td>
							<input class="buttonA" type="button" value="인증번호 확인" onclick="emailCerti();">
						</td>
					</tr>
					<tr>
						<td width="100px"></td>
						<td>
							<font class="emailfont" size="2"><span id="certispan"></span></font>
						</td>
					<tr>

					<tr class="tablecol">
						<td width="100px"></td>
						<td align="left" colspan="2">
							<input type="password" id="pw" name="pw" class="inputbox" placeholder="비밀번호"><br>
						</td>
					</tr>
					<tr>
						<td width="100px"></td>
						<td>
							<font class="pwfont" size="2"><span id="pwspan"></span></font>
						</td>
					</tr>					
					
					<tr class="tablecol">
						<td width="100px"></td>
						<td align="left" colspan="2">
							<input type="password" id="pwok" name="pwok" class="inputbox" placeholder="비밀번호 확인"><br>
						</td>
					</tr>
					<tr>
						<td width="100px"></td>
						<td>
							<font class="pwfont" size="2"><span id="pwokspan"></span></font>
						</td>
					</tr>
																
					<tr class="tablecol">
						<td width="100px"></td>
						<td align="left" colspan="2">
							<input type="text" id="name" name="name" class="inputbox" placeholder="닉네임"><br>
						</td>
					</tr>
					<tr>
						<td width="100px"></td>
						<td>
							<font class="namefont" size="2"><span id="namespan"></span></font>
						</td>
					</tr>
										
					<tr class="tablecol">
						<td width="100px"></td>
						<td align="left" colspan="2">
							<input type="text" id="phone" name="phone" class="inputbox" placeholder="핸드폰 번호 (ex>010-2345-6789)"><br>
						</td>
					</tr>
					<tr>
						<td width="100px"></td>
						<td>
							<font class="phfont" size="2"><span id="phspan"></span></font>
						</td>
					</tr>
					
					<tr class="tablecol">
						<td align="center" colspan="4">
							<input class="buttonA" type="button" value="취소" onclick="goMain();">
							<input class="buttonA" type="button" value="확인" onclick="callSubmit(); return false;">
						</td>
					</tr>
				</table>
			</form>
		</td>
	</tr>	
</table>


<script>

function goMain(){
	if(confirm("지금까지 작성한 내용이 모두 지워집니다. 메인 페이지로 이동하시겠습니까?") != 1){
		return;
	}
	document.location.href="/teamc2/00board/main.jsp";
}

var emailReg = /^[0-9a-zA-Z]([-_.]?[-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;  //이메일 정규식
var emailSendFlag = false;
var certiNumFlag = false;
var emailSendData = "";  //id=email에 작성한 이메일을 emailSendData에 저장하기 위한 변수.

var pwFlag = false;
var pwokFlag = false;
var nameFlag = false;

var phoneReg = /^\d{3}-\d{3,4}-\d{4}$/; //핸드폰 정규식
var phoneFlag = false;

//폰트의 색상을 변경하기 위함
var emailfont = $(".emailfont");
var pwfont = $(".pwfont");
var namefont = $(".namefont");
var phfont = $(".phfont");

var tColor = "#63A6DB";
var fColor = "red";

//span영역의 글자 기본색은 참 값으로 세팅
emailfont.attr("color", tColor);
pwfont.attr("color", tColor);
namefont.attr("color", tColor);
phfont.attr("color", tColor);	


//id=email값 유/무에 따른 span 영역 문구
$("#email").blur(function(){
	var email = $("#email").val();
	emailfont.attr("color", tColor);	
	
	//이메일 입력x
	if(email == ""){	
		emailfont.attr("color", fColor);
		$("#emailspan").html("이메일을 입력하세요.");
		$("#certispan").html("");
		emailcheckFlag = false;
		return;
	}
	
	//email 입력ㅇ, 정규식x
	if(email.match(emailReg) == null){
		emailfont.attr("color", fColor);
		$("#emailspan").html("유효하지 않는 이메일 입니다. 이메일을 확인하세요.");
		$("#certispan").html("");
		emailcheckFlag = false;
		return;
	}
	
	//이메일 입력ㅇ, 정규식ㅇ
	if (email.match(emailReg) != null){
		
		//UserController emailCK.do와 연결하여.. 중복검사 
		$.ajax({
			url: "/teamc2/user/emailCK.do",
			type: "post",
			data: "email=" + email,
			success: function(data){		
				//alert(data); //이메일 중복이 없을 때, true 찍힘
				if (data == "true"){
					$("#emailspan").html("사용가능한 이메일입니다.");
					$("#certispan").html("");
					emailcheckFlag = true;
					emailSendFlag = true;
				}else{
					emailfont.attr("color", fColor);
					$("#emailspan").html("중복된 이메일이 있습니다. 다른 이메일을 입력하세요.");
					$("#certispan").html("");
					emailSendFlag = false;
					emailcheckFlag = true;
				}
			}
		});
	}
});


//인증번호 전송 버튼 :: 클릭하면 실행
function emailSend() {
	var email = $("#email").val();
	emailfont.attr("color", tColor);
	
	/*email 가 null 일 때 검사. 	     *** emailSendFlag == false를 둔 이유 ***
	 emailSendFlag == true && email = "" 일 때 emailCerti() 버튼에서 검사함
	*/
	 if(emailSendFlag == false && email == ""){
		
		emailfont.attr("color", fColor);
		alert("이메일이 작성되지 않았습니다. 적절한 이메일을 입력하세요.");
		$("#emailspan").html("이메일을 입력하세요.");
		$("#certispan").html("");
		emailSendFlag = false;
		return;	
	}
	
	
	//빈칸 x , 중복 x 일때, 
	//id=email이 채워지면 이메일 정규식 검사..		
	if (email.match(emailReg) != null && emailcheckFlag == true && emailSendFlag == true) {
		emailfont.attr("color", tColor);
		$("#emailspan").html("사용가능한 이메일입니다.");
		$("certispan").html("");
		
		
		//이메일 정규식에 부합할 때, 아래 실행
		//EmailController email.do와 연결
		$.ajax({
			url: "/teamc2/email/email.do",
			type: "post",
			data: "email=" + email,
			success: function(data){
				//alert(data);  //EmailController의 email.do 잘 실행되면 true 찍힘
				alert("이메일이 전송되었습니다. 인증번호를 입력하세요.");
				$("#emailspan").html("인증번호가 전송되었습니다.");
				$("#certispan").html("");
				emailSendFlag = true;
				emailSendData = email; // id=email에 작성한 이메일을 emailSendData에 저장한다.
										//인증번호 전송한 이메일을 최초에 작성한 이메일로 기억한다.
			}
		});	
	}else{ //이메일 정규식에 어긋나면
		if (emailSendFlag == false && emailcheckFlag == true){
			emailfont.attr("color", fColor);
			alert("중복된 이메일이 있습니다. 다른 이메일을 입력하세요.");
			$("#emailspan").html("중복된 이메일이 있습니다. 다른 이메일을 입력하세요.");
			$("certispan").html("");
			emailSendFlag = false;
			return;
		}
		if (emailSendFlag == false && emailcheckFlag == false){
			emailfont.attr("color", fColor);
			alert("유효하지 않는 이메일 입니다. 이메일을 확인하세요.");
			$("#emailspan").html("유효하지 않는 이메일 입니다. 이메일을 확인하세요.");
			$("certispan").html("");
			emailcheckFlag = false;
			return;
		}
	}
}


//id=certiNum값 유/무에 따른 span영역 문구
$("#certiNum").blur(function(){
	var certiNum = $("#certiNum").val();
	var email = $("#email").val();
	$("#emailspan").html("");
	$("#certispan").html("");	
	
	emailfont.attr("color", tColor);
	

	//이메일 전송 안 해놓고 마우스 blur 하거나 아무 값을 입력하면,
	if(emailSendFlag == false) {
		emailfont.attr("color", fColor);
		$("emailspan").html("");
		$("#certispan").html("이메일 인증 후 인증번호를 입력하세요.");
		return;
	}
	
	//이메일 인증 OK 이후...id=certiNum이 빈칸이면
	if (certiNum == "") {
		emailfont.attr("color", fColor);
		$("#certispan").html("전송된 인증번호를 입력하세요.");
		return;
	}
	
	//이메일인증ok, id=certiNum에 아무 값을 입력하면
	//span에 문구 안 뜨고, 버튼 클릭해서 값을 검사해야 함
});


//인증번호 확인 버튼 :: 클릭하면 실행
function emailCerti() {
	var certiNum = $("#certiNum").val();
	var email = $("#email").val();
	emailfont.attr("color", tColor);
		
	//이메일이 작성되지 않았을 경우.
	if(email == ""){
		emailfont.attr("color", fColor);
		alert("이메일이 작성되지 않았습니다. 적절한 이메일을 입력하세요.");
		$("#emailspan").html("이메일을 입력하세요.");
		$("#certispan").html("");
		return;
	}

	//이메일이 입력ok, 이메일 인증x 
	if (emailSendFlag == false) {
		emailfont.attr("color", fColor);
		alert("적절한 이메일 형식이 아니거나, 이메일 인증이 되지 않았습니다..");
		$("#emailspan").html("이메일을 확인하세요.");
		$("#certispan").html("");
		return;
	}
	
	//이메일이 입력ok, 이메일 인증ok, 인증번호 입력x 
	if(certiNum == ""){
		emailfont.attr("color", fColor);
		alert("인증번호를 입력하세요.");		
		$("#emailspan").html("");
		$("#certispan").html("인증번호를 입력하세요.");

	//이메일 입력ok, 이메일 인증ok, 인증번호 입력ok 일 경우
	}else {
		
		//1. (성공) 이메일 정규식 인증ok, 입력 돼있는 이메일과 인증번호를 받은 이메일이 같은경우
		//certiNum span의 문구는 값을 아무거나 입력하는 순간 지워진다.
		if (emailSendFlag == true && emailSendData == email){
			
			//EmailController emailOK.do와 연결
			$.ajax({
				url: "/teamc2/email/emailOK.do",
				type: "post",
				data: "certiNum=" + certiNum,
				success: function(data){
	
					if(data == "true") {  //찐성공
						emailfont.attr("color", tColor);
						alert("인증되었습니다.");
						$("#certispan").html("인증되었습니다.");
						certiNumFlag = true;
					}else{				//실패 (전송된 인증번호 != 작성된 인증번호)
						emailfont.attr("color", fColor);
						alert("인증에 실패하였습니다.");
						$("#certispan").html("인증에 실패하였습니다. 인증번호를 확인해주세요."); 
						certiNumFlag = false;
					}
				}
			});
			return;
		}
		
		//(실패)
		//2. 전송된 인증번호와 작성한 인증번호가 다를 경우  --> 위에서 처리함
				
		//3. 인증번호 전송을 누른 상태인데 입력했던 이메일 일치하지 않는 경우
		if(emailSendFlag == true && emailSendData != email) {
			emailfont.attr("color", fColor);
			$("#emailspan").html("이메일 정보가 바뀌었습니다. 이메일 인증을 다시 받으세요.");
			certiNumFlag = false;
			emailSendFlag = false;
			return;
		}
		
		/* [debug] 안 된다. 다른 방안으로 대처가 되긴 함.
		//4. 인증번호 전송 ok, 입력했던 이메일 데이터가 지워진 경우
		if (emailSendFlag == true && email == "") {
			emailfont.attr("color", fColor);
			$("#emailspan").html("인증받은 이메일을 재입력하거나, 새로운 이메일을 인증받으세요.");
			certiNumFlag = false;
			return;
		}
		*/
	}
}

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
	
	if(phone == ""){
		phfont.attr("color", fColor);
		$("#phspan").html("핸드폰 번호를 입력하세요.");
		phoneFlag = false;		
		return;
	}	
	
	if(phone.match(phoneReg) == null){
		phfont.attr("color", fColor);
		$("#phspan").html("제대로 작성되지 않았습니다. 다시 한번 확인하세요. (ex>010-2345-6789)");
		phoneFlag = false;
	} else {
		$("#phspan").html("사용가능한 핸드폰 번호입니다.");
		phoneFlag = true;
		return;
	}
});


//가입하기 버튼 눌렀을 때, 폼이 작성 안 됐을 때 alert 
function callSubmit(){
	
	//틀린 곳에만 span 띄워주기 위해 다 지움
	$("#emailspan").html("");
	$("#certispan").html("");
	$("#pwspan").html("");
	$("#pwokspan").html("");
	$("#namespan").html("");
	$("#phspan").html("");
	
	if (emailSendFlag == false){
		emailfont.attr("color", fColor);
		alert("이메일이 유효하지 않거나 인증되지 않았습니다. 확인하세요");
		$("#emailspan").html("이메일을 확인하세요.");
		return;
	}
	
	if (certiNumFlag == false){
		emailfont.attr("color", fColor);
		alert("인증번호가 유효하지 않거나 입력되지 않았습니다. 확인하세요.");
		$("#certispan").html("인증번호를 확인하세요.");
		return;
	}

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
	
	
	//위에서 입력한 정보가 다 맞으면, 랜덤한 기본프사가 적용된다..
	var img = new Array();
	img[0] = "/teamc2/images/profile_image/profile1.png";
	img[1] = "/teamc2/images/profile_image/profile2.png";
	img[2] = "/teamc2/images/profile_image/profile3.png";
	img[3] = "/teamc2/images/profile_image/profile4.png";
	img[4] = "/teamc2/images/profile_image/profile5.png";
	var i = Math.floor(Math.random()*(img.length));
	
	
	$("input[name=file]").val(img[i]);
	

	document.joinFrm.submit();
}

</script>

<%@include file="../include/footer.jsp" %>