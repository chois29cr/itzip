<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/table_form.css">

<br><br><br><br><br><br>

<table style="margin-left: auto; margin-right: auto;" width="900px" border="0" align="center">
	<tr align="center">
		<td>
		
			<!-- 이메일 찾기 -->
			<form id="find1Frm" name="find1Frm" method="post" action="findok.jsp">
				<table border="0" width="350px">
					<tr class="tablecol">
						<td><font size="4"><strong>이메일 찾기</strong></font>
						</td>
					</tr>
					<tr class="tablecol">
						<td height="50px">
							<font size="2"> 회원가입 시 입력한 핸드폰 번호로 이메일을 확인하실 수 있습니다. </font>
						</td>
					</tr>
					<tr class="tablecol" align="center"> 
						<td><input class="inputbox" id="phone1" name="phone1" type="text" placeholder="핸드폰 번호 (ex>010-1234-5678)"></td>
					</tr>
					<tr>
						<td>
							<font class="phfont" size="2"><span id="phspan1"></span></font>
						</td>
					</tr>
					<tr class="tablecol"><td></td></tr> <!-- 빈칸.. -->
					<tr class="tablecol" align="center">
						<td>
							<input class="buttonA" type="button" value="확인" onclick="callSubmit1(); return false;">
						</td>
					</tr>	
				</table>
			</form>
		</td>
		<td>
		
			<!-- 임시 비밀번호 발급 -->
			<form id="find2Frm" name="find2Frm">
				<table border="0" width="350px">
					<tr class="tablecol">
						<td><font size="4"><strong>임시 비밀번호 발급</strong></font>
						</td>
					</tr>			
					<tr class="tablecol">
						<td height="50px">
							<font size="2"> 회원가입 시 입력한 이메일과 핸드폰 번호로 임시 비밀번호를 발급받으실 수 있습니다.
						</td>
					</tr>
					<tr class="tablecol" align="center"> 
						<td>
							<input class="inputbox" id="email" name="email" type="text" placeholder="이메일">
						</td>
					</tr>
					<tr>
						<td>
							<font class="emailfont" size="2"><span id="emailspan"></span></font>
						</td>
					</tr>
	
					<tr class="tablecol" align="center"> 
						<td>
							<input class="inputbox" id="phone2" name="phone2" type="text" placeholder="핸드폰 번호 (ex>010-1234-5678)">
						</td>
					</tr>				
					<tr>
						<td>
							<font class="phfont" size="2"><span id="phspan2"></span></font>
						</td>
					</tr>
					<tr class="tablecol" align="center">
						<td>
							<input class="buttonA" type="button" value="확인" onclick="callSubmit2(); return false;">
						</td>
					</tr>
				</table>
			</form>
		</td>
	</tr>
</table>

<script>
var phoneReg = /^\d{3}-\d{3,4}-\d{4}$/; //핸드폰 정규식
var emailReg = /^[0-9a-zA-Z]([-_.]?[-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;  //이메일 정규식
var tColor = "#63A6DB";
var fColor = "red";

//span영역의 글자 기본색은 참 값으로 세팅
var phfont = $(".phfont");
var emailfont = $(".emailfont");
phfont.attr("color", tColor);
emailfont.attr("color", tColor);


function callSubmit1(){
	//아이디 찾기 값
	var phone1 = $("#phone1").val();
	
	
	//핸드폰 번호 입력x
	if(phone1 == ""){	
		phfont.attr("color", fColor);
		alert("핸드폰 번호를 입력하세요.");
		$("#phspan1").html("핸드폰 번호를 입력하세요.");
		$("#emailspan").html("");
		$("#phspan2").html("");
		return;
	}

	//핸드폰 번호 입력ㅇ, 정규식x
	if(phone1.match(phoneReg) == null){
		phfont.attr("color", fColor);
		alert("핸드폰 입력 양식을 확인하세요. (ex>010-2345-6789)");
		$("#phspan1").html("핸드폰 입력 양식을 확인하세요. (ex>010-2345-6789)");
		$("#emailspan").html("");
		$("#phspan2").html("");
		return;
	}
	
	document.find1Frm.action = "/teamc2/user/findEmail.do";
	document.find1Frm.submit();
}

function callSubmit2(){
	
	//임시비밀번호 발급 값
	var email = $("#email").val();
	var phone2 = $("#phone2").val();	
	
	//이메일 입력x
	if(email == ""){	
		emailfont.attr("color", fColor);
		alert("이메일을 입력하세요.");
		$("#emailspan").html("이메일을 입력하세요.");
		$("#phspan1").html("");
		$("#phspan2").html("");
		return;
	}
	
	//email 입력ㅇ, 정규식x
	if(email.match(emailReg) == null){
		emailfont.attr("color", fColor);
		alert("유효하지 않는 이메일 입니다. 이메일을 확인하세요.");		
		$("#emailspan").html("유효하지 않는 이메일 입니다. 이메일을 확인하세요.");
		$("#phspan1").html("");
		$("#phspan2").html("");
		return;
	}

	//핸드폰 번호 입력x
	if(phone2 == ""){	
		phfont.attr("color", fColor);
		alert("핸드폰 번호를 입력하세요.");
		$("#phspan2").html("핸드폰 번호를 입력하세요.");
		$("#phspan1").html("");
		$("#emailspan").html("");
		return;
	}

	//핸드폰 번호 입력ㅇ, 정규식x
	if(phone2.match(phoneReg) == null){
		phfont.attr("color", fColor);
		alert("핸드폰 입력 양식을 확인하세요. (ex>010-2345-6789)");
		$("#phspan2").html("핸드폰 입력 양식을 확인하세요. (ex>010-2345-6789)");
		$("#phspan1").html("");
		$("#emailspan").html("");
		return;
	}	
	
	//이메일 입력ㅇ, 정규식ㅇ / 핸드폰 번호 입력ㅇ, 정규식ㅇ
	$.ajax({
		url: "/teamc2/user/findPW.do",
		type: "post",
		data: "email=" + email + "&phone2=" + phone2,
		success: function(data){
			if (data == "true"){
				//alert("true");
				alert("임시 비밀번호가 발송되었습니다. 새로 로그인 해주세요.");
				document.location="login.jsp";
			}else{
				alert("가입한 내역을 찾을 수 없습니다.");
				$("#phspan1").html("");
				$("#emailspan").html("");
				$("#phspan2").html("");
			}			
		}
	});
}
</script>


<%@include file="../include/footer.jsp" %>