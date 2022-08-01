<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@page import="dto.ClassboardDTO"%>
<%@ page import="vo.*"%>
<%@include file="../include/header.jsp"%>

<!-- Smart Editor -->
<script type="text/javascript" src="../se/js/HuskyEZCreator.js"
	charset="UTF-8"></script>
<script type="text/javascript"
	src="../se/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js"
	charset="UTF-8"></script>

<link rel="stylesheet" type="text/css" href="../css/q_boardLayer.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/classBoard.css">

<%
String pageno = request.getParameter("page");
if (pageno == null)
	pageno = "1";

//로그인이 안됐거나, 일반 유저가 접근할 경우. 
if (user == null || user.getIsadmin().equals("N")){
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter writer = response.getWriter();
	writer.println("<script>alert('올바르지 않는 접근입니다.'); location.href='"+"/teamc2/00board/main.jsp"+"';</script>");
	writer.close();
}
%>

<!-- 제목, 내용, 카테고리가 null이 아닌지 검사하는 모달창 -->
<div id="modal">
	<div id="modalFrm">
		<div class="modalCont" style="display: table-cell;">
			<font id="checkData"></font> <br><br>
			<button class="buttonB" type="button" id="closebtn">확인</button>
		</div>
		<div class="modalBG"></div>
	</div>
</div>


<body>


<!-- 현재 카테고리 표시 영역 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td colspan="2" style="padding:5px;"><h2><a href="classBoard.jsp">클래스</a></h2></td>
	</tr>
	<tr>
		<td style="padding:5px;">요즘 사람들은 이런 즐거움을 찾고있어요!</td>
	</tr>
	<tr>
		<td style="padding:10px;">※관리자 전용 페이지입니다.<br>
		</td>
	</tr>
</table>
<br><br>

<!-- 글쓰기 테이블 -->
<form id="cWriteFrm" name="cWriteFrm" method="post"
	action="/teamc2/02class/write.do" enctype="multipart/form-data">
	<table id="mWriteCont" name="mWriteCont"
		style="margin-left: auto; margin-right: auto;" border="0"
		width="1000px" align="center">
		<tr>
			<td colspan="2"><input class="inputbox" type="text" id="title"
				name="title" placeholder="제목을 입력하세요." maxlength="33"
				oninput="numberMaxLength(this);"></td>
		</tr>
		<tr>
			<td>
				<table id="attachTable" name="attachTable"
					style="width: 950px; height: 400px;">

					<tr>
						<td width="495px"><textarea class="bodybox" id="ir1"
								name="ir1" style="width: 100%; height: 400px;"></textarea></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table style="margin-left: auto; margin-right: auto;" border="0"
		width="1000px" align="center">
		<tr class="labelcell">
			<td colspan="2" align="center">
				<input class="buttonA" type="button" value="취소" onclick="goBoard();">
				<input class="buttonA" type="submit" value="등록" onclick="submitContents(this); return false;"></td>
		</tr>
	</table>
</form>
	

<script>
function goBoard(){
	if(confirm("지금까지 작성한 내용이 모두 지워집니다. 글 작성을 취소하시겠습니까?") != 1){
		return;
	}
	document.location.href="classBoard.jsp?k=<%=k%>&page=<%=pageno%>";
}

//스마트에디터 생성 코드
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef : oEditors,
	elPlaceHolder : "ir1",
	sSkinURI : "../se/SmartEditor2Skin.html",
	fCreator : "createSEditor2"

});

function numberMaxLength(e) {
	if (e.value.length > e.maxLength) {
		e.value = e.value.slice(0, e.maxLength);
	}
}

//‘저장’ 버튼을 누르면 실행
function submitContents(elClickedObj) {

	// 에디터의 내용이 textarea에 적용된다.
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);

	var title = document.cWriteFrm.title.value;
	console.log(title);

	if (title == "") {
		$("#checkData").text("제목을 입력하세요.");
		$("#modal").show();
		return false;
	}

	var ir1 = document.getElementById("ir1").value;
	console.log(ir1);

	if (ir1 == "<p>&nbsp;</p>") {
		$("#checkData").text("내용을 입력하세요.");
		$("#modal").show();
		return false;
	}

	var imgcnt = document.getElementById("ir1").value.indexOf("<img");
	console.log(imgcnt);

	if (imgcnt == -1) {
		$("#checkData").text("이미지를 최소 1장 추가하세요.");
		$("#modal").show();
		return false;
	}

	// document.getElementById("ir1").value를 이용해서 처리한다.
	try {
		if(confirm("이대로 글을 등록하시겠습니까?") != 1){
			return;
		}
		elClickedObj.form.submit();
	} catch (e) {
	}
}

//textArea에 이미지 첨부
function pasteHTML(filepath) {
	var sHTML = '<img src="C:\\dbrmsgh\\teamc2\\WebContent\\upload'+filepath+'">';
	oEditors.getById["ir1"].exec("PASTE_HTML", [ sHTML ]);
}

//확인 버튼 누르면 모달이 사라짐
document.getElementById("closebtn").onclick = function() {

	document.getElementById("modal").style.display = "none";

}

$("ir1").find('img').each(function() {
	var src = $(this).attr('src');
	console.log(src);
});
</script>
</body>
</html>