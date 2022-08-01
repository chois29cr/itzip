<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/q_boardLayer.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<%
String pageno = request.getParameter("page");
if(pageno == null) pageno="1";
//out.print("email"+user.getEmail());

//로그인이 안됐을 경우 
if (user == null){
	response.sendRedirect("/teamc2/user/noneMembers.jsp");
    return;
}
%>
<!-- 제목, 내용, 카테고리가 null이 아닌지 검사하는 모달창 -->
<div id="modal">
	<div id="modalFrm">
	    <div class="modalCont" style="display: table-cell;" >
				<font id="checkData"></font> <br><br>
		        <button class="buttonB" type="button" id="closebtn">확인</button>	        	       
	    </div>   
	    <div class="modalBG"></div>
	</div>
</div>


<!-- 현재 카테고리 표시 영역 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td colspan="2" style="padding:5px;"><h2><a href="qna.jsp">QnA</a></h2></td>
	</tr>
	<tr>
		<td style="padding:5px;">잇집 회원들과 지식을 공유하세요!</td>
	</tr>
</table>
<br><br>

<!-- 글쓰기 테이블 -->
<form id="qWriteFrm" name="qWriteFrm" method="post" action="/teamc2/03qna/write.do">
	<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
		<tr class="lablecell">
			<td class="labeltd">
				<input class="titlebox" type="text" id="title" name="title" placeholder="제목을 입력하세요." maxlength="33" oninput="numberMaxLength(this);">
			</td>
		</tr>
		<tr>
			<td>
				<hr>
			</td>	
		</tr>				
		<tr>
			<td class="labeltd">
				<textarea class="bodybox" id="body" name="body" placeholder="내용을 입력하세요."></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<hr><br>
			</td>	
		</tr>					
		<tr class="labelcell">
			<td colspan="2" align="center">
			<input class="buttonA" type="button" value="취소" onclick="goBoard();">
			<input class="buttonA" type="submit" value="등록" onclick="callSubmit(); return false;">
			</td>	
		</tr>
	</table>
</form>
<!-- 글쓰기 테이블 끝 -->


<script>
//제목 글자수 초과 입력을 막는다
function numberMaxLength(e){
	 if(e.value.length > e.maxLength){
         e.value = e.value.slice(0, e.maxLength);
     }
}

//취소 버튼
function goBoard(){
	if(confirm("지금까지 작성한 내용이 모두 지워집니다. 글 작성을 취소하시겠습니까?") != 1){
		return;
	}
	document.location.href="qna.jsp?k=<%= k %>&page=<%= pageno %>";
}

//등록 버튼
function callSubmit(){
	<!-- 모달창 관련 스크립트(제목,내용 필수입력한다.) :: 선언 영역 확인 :: -->
	var title = document.qWriteFrm.title.value;
	
	if(title==""){
		$("#checkData").text("제목을 입력하세요.");
		$("#modal").show();
		return false;
	}
	
	var body = document.qWriteFrm.body.value;
	if(body==""){
		$("#checkData").text("내용을 입력하세요.");
		$("#modal").show();
		return false;
	}
	
	if(confirm("이대로 글을 등록하시겠습니까?") != 1){
		return;
	}
	document.qWriteFrm.submit();  //카테고리, 타이틀, 내용이 다 채워지면, submit 버튼의 action의 링크로 간다.
}

//확인 버튼 누르면 모달이 사라짐
document.getElementById("closebtn").onclick = function(){
	document.getElementById("modal").style.display="none";
}
</script>

</body>
</html>