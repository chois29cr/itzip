<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/q_boardLayer.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">

<%
QnaVO qna = (QnaVO)request.getAttribute("modi");
String qno = request.getParameter("qno");
String pageno = request.getParameter("page");
if(pageno == null) pageno="1";
//out.print("email"+user.getEmail());
%>
<script>
	//TO DO: 취소버튼 클릭시 Q&A 원래 목록으로 돌아가게끔 경로 설정할 것  
	function GoQview()
	{
		document.location="view.do?qno=<%= qno %>" 
	}
</script>

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


<!-- 현재 카테고리 표시 영역 -->
<div class="category">Q&A</div>
<br>

<!-- 글수정 테이블 -->
<form id="qModifyFrm" name="qModifyFrm" method="post" action="/teamc2/03qna/modify.do">
	<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
		<tr class="lablecell">
			<td class="labeltd">
				<input type="hidden" name="qno" value="<%= qno %>">
				<input class="titlebox" type="text" id="title" name="title" placeholder="제목을 입력하세요." value="<%= qna.getTitle() %>" maxlength="33" oninput="numberMaxLength(this);">
			</td>
		</tr>
		<tr>
			<td>
				<hr>
			</td>	
		</tr>				
		<tr>
			<td class="labeltd">
				<textarea class="bodybox" id="body" name="body" placeholder="내용을 입력하세요."><%= qna.getBody() %></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<hr><br>
			</td>	
		</tr>					
		<tr class="labelcell">
			<td colspan="2" align="center">
			<input class="buttonA" type="button" value="취소" onclick="javascript:GoQview();">
			<input class="buttonA" type="submit" value="등록" onclick="javascript:callSubmit(); return false;">
			</td>	
		</tr>
	</table>
</form>
<!-- 글쓰기 테이블 끝 -->

<!-- 모달창 관련 스크립트(제목,내용 필수입력한다.) :: 선언 영역 확인 :: -->
<script>

//제목 글자수 초과 입력을 막는다
function numberMaxLength(e){
	
	 if(e.value.length > e.maxLength){
         e.value = e.value.slice(0, e.maxLength);
     }
}

function callSubmit(){

	var title = document.qModifyFrm.title.value;
	if(title==""){
		$("#checkData").text("제목을 ");
		$("#modal").show();
		return false;
	}
	
	var body = document.qModifyFrm.body.value;
	if(body==""){
		$("#checkData").text("내용을 ");
		$("#modal").show();
		return false;
	}
	
	document.qModifyFrm.submit();  //카테고리, 타이틀, 내용이 다 채워지면, submit 버튼의 action의 링크로 간다.
}

//확인 버튼 누르면 모달이 사라짐
document.getElementById("closebtn").onclick = function(){
	document.getElementById("modal").style.display="none";
}
</script>

</body>
</html>