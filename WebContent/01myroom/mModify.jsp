<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@page import="dto.*"%>
<%@ page import="vo.*" %> 
<%@include file="../include/header.jsp" %>
<!-- Smart Editor -->
<script type="text/javascript" src="../se/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script type="text/javascript" src="../se/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="UTF-8"></script>


<link rel="stylesheet" type="text/css" href="../css/q_boardLayer.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">

<%
String no = request.getParameter("no");
String pageno = request.getParameter("page");
if(pageno == null) pageno="1";
//out.print("email"+user.getEmail());

MyroomVO m = (MyroomVO)request.getAttribute("modi");
ArrayList<MattachVO> maList = (ArrayList<MattachVO>)request.getAttribute("maList");
%>
<script>
//취소버튼 클릭시 Q&A 원래 목록으로 돌아가게끔 경로 설정할 것  
function goMyroom(){
	document.location="myroom.jsp" 
}
</script>
<style>
/*mWrite.jsp에서 사진 업로드 시, 썸네일 최대 사이즈 */
#div_thumbnail img{
	max-width:300px;
	max-height:400px;
}
.inputbox{
	width:990px;
	height:35px;
	border:none;
}
.textbox{
	width:490px;
	height:400px;
	resize:none;
}
</style>


<!-- 제목, 내용, 카테고리가 null이 아닌지 검사하는 모달창 -->
<div id="modal">
	<div id="modalFrm">
	    <div class="modalCont" style="display: table-cell;" >
				<font id="checkData"></font> 입력하세요. <br><br>
		        <button class="buttonB" type="button" id="closebtn">확인</button>	        	       
	    </div>   
	    <div class="modalBG"></div>
	</div>
</div>


<body>

<!-- 글쓰기 수칙 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td>
			카테고리에 맞는 방 사진을 업로드해주세요. <br>
		</td> 
	</tr>
</table>

<br>


<!-- 글쓰기 테이블 -->
<form id="mModifyFrm" name="mModifyFrm" method="post" action="/teamc2/01myroom/modify.do" enctype="multipart/form-data">
	<table id="mModifyCont" name="mModifyCont" style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
		<tr>
			<td colspan="2">
				<input type="hidden" name="no" value="<%= no %>">
				<input class="inputbox" type="text" id="title" name="title" placeholder="제목을 입력하세요." value="<%= m.getTitle() %>" maxlength="33" oninput="numberMaxLength(this);">
			</td>
		</tr>		
		<tr>
			<td>
				<table id="attachTable" name="attachTable" style="width:950px; height:400px;">
				
					<tr>						
						<td width="495px">
							<textarea class="bodybox" id="ir1" name="ir1" style="width:100%; height:400px;"><%= m.getBody() %></textarea>						
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<div id="addBtn" style="display: none;">
					<input class="buttonC" type="button" value="추가" onclick='javascript:addmWriteFrm();'>
				</div>
				<div id="delBtn" style="display: none;">
					<input class="buttonC" type="button" value="삭제" onclick='javascript:delmWriteFrm(this);'>
				</div>		
			</td>
		</tr>
	</table>


	<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">				
		<tr class="labelcell">
			<td colspan="2" align="center">
				<input class="buttonA" type="button" value="취소" onclick="javascript:goMyroom();">
				<input class="buttonA" type="submit" value="수정" onclick="javascript:submitContents(this); return false;">
			</td>
		</tr>
	</table>
</form>


<script>

//스마트에디터 생성 코드
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
 oAppRef: oEditors,
 elPlaceHolder: "ir1",
 sSkinURI: "../se/SmartEditor2Skin.html",
 fCreator: "createSEditor2"
 
});

//제목 글자수 초과 입력을 막는다
function numberMaxLength(e){
	
	 if(e.value.length > e.maxLength){
        e.value = e.value.slice(0, e.maxLength);
    }
}


//‘저장’ 버튼을 누르면 실행
function submitContents(elClickedObj) {
	
	// 에디터의 내용이 textarea에 적용된다.
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
 
	var title = document.mWriteFrm.title.value;
	console.log(title);
	
	if(title==""){
		$("#checkData").text("제목을 ");
		$("#modal").show();		
		return false;
	}

	var ir1 = document.getElementById("ir1").value;
	console.log(ir1);
	
	if(ir1=="<p>&nbsp;</p>"){
		$("#checkData").text("내용을 ");
		$("#modal").show();
		return false;
	}
	
	var imgcnt = document.getElementById("ir1").value.indexOf("<img");
	console.log(imgcnt);
	
	if(imgcnt == -1){
		alert("이미지를 추가해주세요.");
		return false;
	}
	
	// document.getElementById("ir1").value를 이용해서 처리한다.
	 try {
		 elClickedObj.form.submit();
	 } catch(e) {}
}

//textArea에 이미지 첨부
function pasteHTML(filepath){
    var sHTML = '<img src="C:\\dbrmsgh\\teamc2\\WebContent\\upload'+filepath+'">';
    oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
}

var length = $(".se2_inputarea").find("p").find("img").length;
console.log(length);

//var test = $(".se2_inputarea").find("p").find("img").val();
//console.log(test);

//확인 버튼 누르면 모달이 사라짐
document.getElementById("closebtn").onclick = function(){
	
	document.getElementById("modal").style.display="none";
	
}

$("ir1").find('img').each(function(){
	var src = $(this).attr('src');
	console.log(src);
});



</script>



</body>
</html>