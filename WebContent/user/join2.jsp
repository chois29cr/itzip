<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@include file="../include/header.jsp" %>    
<link rel="stylesheet" type="text/css" href="../css/table_form.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/join2.css">
<script src="../js/jquery-3.6.0.min.js"></script>
<%
String file = request.getParameter("file");
String email = request.getParameter("email");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String phone = request.getParameter("phone");


System.out.println("join2.jsp    ->  작성한 email..? : " + email);
System.out.println("join2.jsp    ->  file..? : " + file);
System.out.println("join2.jsp    ->  name..? : " + name);

if(file == null || email == null || pw == null || name == null || phone == null){
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter writer = response.getWriter();
	writer.println("<script>alert('올바르지 않는 접근입니다.'); location.href='"+"/teamc2/00board/main.jsp"+"';</script>");
	writer.close();	
}
%>

<body>
<br><br><br><br><br><br><br>

<form id="joinFrm2" name="joinFrm2" method="post" action="/teamc2/user/join.do" >
	<input type="hidden" name="texture">
	<input type="hidden" name="file" value="<%=file%>">
	<input type="hidden" name="email" value="<%=email%>">
	<input type="hidden" name="pw" value="<%=pw%>">
	<input type="hidden" name="name" value="<%=name%>">
	<input type="hidden" name="phone" value="<%=phone%>">
	<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
		<tr class="tablecol">
			<td align="center" colspan="3"> <a href="../00board/main.jsp" class="logo">잇집</a></td>	
		</tr>
		<tr class="tablecol">
			<td class="labeltd" align="center" colspan="3">
				<font size="4">회원가입</font>
			</td>
		</tr>
		<tr class="tablecol">
			<td class="labeltd" colspan="3">
				<font size="3"> 마지막 단계입니다! &nbsp; 선호하는 인테리어 스타일을 골라주세요. </font>
			</td>
		</tr>
	
		<!-- 텍스쳐 옵션 -->
		<tr align="center">
			<td>
				<figure class="textureImg" onclick="textSelect(this,'classic');">
					<img src="/teamc2/images/texture_image/classic.png" alt="classic">
					<figcaption>
						<h3>classic</h3>
				    	<p>유럽풍의 클래식한 가구들과 어두운 톤과 벨벳 등을 활용한 고풍스러움이 느껴지는 인테리어 입니다.</p>
				  	</figcaption>
				</figure>
				<p>classic</p>
			</td>
			<td>
				<figure class="textureImg" onclick="textSelect(this, 'industrial');">
					<img src="/teamc2/images/texture_image/industrial.png" alt="industrial">
					<figcaption>
						<h3>industrial</h3>
				    	<p>파이프, 기계부품, 목재 등을 활용하여 공간의 즐거움을 극대화한 인테리어 입니다. </p>
				  	</figcaption>
				</figure>
				<p>industrial</p>
			</td>
			<td>
				<figure class="textureImg" onclick="textSelect(this, 'minimal');">
					<img src="/teamc2/images/texture_image/minimal.png" alt="minimal">
					<figcaption>
						<h3>minimal</h3>
						<p>단순한 색상 배치와 공간의 단순화로 절제미와 감각이 느껴지는 인테리어 입니다. </p>
					</figcaption>
				</figure>
				<p>minimal</p>
			</td>		
		</tr>
	
		<tr align="center">
			<td>
				<figure class="textureImg" onclick="textSelect(this, 'modern');">
					<img src="/teamc2/images/texture_image/modern.png" alt="modern">
					<figcaption>
						<h3>modern</h3>
						<p>현대적인 심플함이 느껴지며 기능적, 합리적으로 단순함을 지향하는 인테리어 입니다.</p>
					</figcaption>
				</figure>
				<p>modern</p>
			</td>
			<td>
				<figure class="textureImg" onclick="textSelect(this, 'natural');">
					<img src="/teamc2/images/texture_image/natural.png" alt="natural">
					<figcaption>
						<h3>natural</h3>
						<p>나무, 흙, 식물 등 자연적인 소재와 우드톤을 활용하여 원목의 느낌이 돋보이는 자연주의 인테리어 입니다.</p>
					</figcaption>
				</figure>
				<p>natural</p>
			</td>	
			<td>
				<figure class="textureImg" onclick="textSelect(this, 'romantic');">
					<img src="/teamc2/images/texture_image/romantic.png" alt="romantic">
					<figcaption>
						<h3>romantic</h3>
						<p>화사한 컬러와 레이스, 실크의 소재를 사용하여 감성을 담은 낭만적인 스타일의 인테리어 입니다. </p>
					</figcaption>
				</figure>
				<p>romantic</p>
			</td>
		</tr>
		
		<tr>
			<td colspan="3" align="center">
				<!--
				<input class="buttonA" type="button" value="이전으로" onclick="goJoin();">
				-->
				<input class="buttonA" type="button" value="취소" onclick="goMain();">
				<input class="buttonA" type="submit" value="가입하기" onclick="callSubmit(); return false;">
				
			</td>
		</tr>
	</table>
</form>


<br><br><br><br><br>


<script>
//[TODO] 이전으로 버튼 누르면 join.jsp로 이동
function goJoin(){
	
}

//취소 버튼 누르면 돌아가기
function goMain(){
	if(confirm("지금까지 작성한 내용이 모두 지워집니다. 메인 페이지로 이동하시겠습니까?") != 1){
		return;
	}
	document.location.href="/teamc2/00board/main.jsp";
}


//사진 선택 시 값 texture 값 저장
var selectTexture = "";
var selectFlag = false;

function textSelect(obj, type){
	
	//이미 사진을 셀렉트 해놓은 게 있다면,
	//모든 figure 검사하여 ,, clickTextureImg 클래스를 지워주고.
	$("figure").removeClass("clickTexturImg");
	
	//클릭한 사진에 대하여... 클래스를 덧붙여준다.
	$(obj).addClass("clickTexturImg");
	
	//클릭한 사진의 type을 적용시켜준다. (DB에 저장하기 위함)
	$("input[name=texture]").val(type);
}


function callSubmit(){
	
	//figure 하위에 clickTexturImg 클래스를 갖는 애를 찾는다. (=텍스쳐가 선택됐다는 의미)
	var selected = $("figure").hasClass("clickTexturImg");
	
	if(selected == true){
		alert("회원이 되신걸 축하합니다!");
		document.joinFrm.submit();
	}else{
		alert("선호하는 인테리어 스타일을 반드시 선택해주세요.");
	}
}

</script>

<%@include file="../include/footer.jsp" %>