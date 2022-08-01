<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dto.*" %>    
<%@include file="../include/header.jsp" %>
<%@ page import="java.util.ArrayList" %>    
<link rel="stylesheet" type="text/css" href="../css/q_boardLayer.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<%
String t = (String)request.getAttribute("t");
String pageno = (String)request.getAttribute("pageno");
int rpage = (int)request.getAttribute("rpage");
QnaVO qna = (QnaVO)request.getAttribute("view");
QnaVO pvo = (QnaVO)request.getAttribute("prev");
QnaVO nvo = (QnaVO)request.getAttribute("next");
String file = (String)request.getAttribute("file");
String qno = request.getParameter("qno");
String mode = request.getParameter("mode");

int total = (int)request.getAttribute("total"); 
int startno = (int)request.getAttribute("startno");
int endno = (int)request.getAttribute("endno");
int maxpageno = (int)request.getAttribute("maxpageno");
ArrayList<QreplyVO> qrList = (ArrayList<QreplyVO>)request.getAttribute("qrList");
%>
<style>
.link-icon { position: relative; display: inline-block; width: 40px;    font-size: 14px; font-weight: 500; color: #333; margin-right: 10px; padding-top: 50px; }
.link-icon.twitter { background-image: url(../images/icon/icon-twitter.png); background-repeat: no-repeat; }
.link-icon.facebook { background-image: url(../images/icon/icon-facebook.png); background-repeat: no-repeat; } 
.link-icon.kakao { background-image: url(../images/icon/icon-kakao.png); background-repeat: no-repeat; }

/* qView.jsp 로그인x일 때 알림 박스 */
.nonebox {
    border: 1px solid #E6E6E6;
    height:40px;
    width: 980px;
    background-color: #FBFBFB;
    padding:0 0 0 20px;
}

/* 해보자 */
.mainbody{
	border-radius: 10px;
	border-style: solid;
    border-top-width: thin;
    border-bottom-width: thin;
    border-left-width: thin;
    border-right-width: thin;
}
.tline{
	border-top: 2px solid #f3f3f3;
}
.title{
	border: 1px solid #f8f8f8; 
}
.qna_cate:hover{
	box-shadow: 0 -1px 16px rgb(0 0 0 / 20%);
}
</style>

<!-- 댓글이 null이 아닌지 검사하는 모달창 -->
<div id="modal">
	<div id="modalFrm">
	    <div class="modalCont" style="display: table-cell;" >
				<font id="checkData" name="checkdata"></font> 입력하세요. <br><br>
		        <button class="buttonB" type="button" id="closebtn">확인</button>	        	       
	    </div>   
	    <div class="modalBG"></div>
	</div>
</div>

<table class="mainbody" style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center" cellpadding="0" cellspacing="0" bordercolor="#f1f1f1">
	<tr>
		<td><br><br>
			<!-- 현재 카테고리 표시 영역 -->
			<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
				<tr>
					<td colspan="2" style="padding:5px;"><div height="30px"><a class="qna_cate" href="qna.jsp">Q&A</a></div></td>
				</tr>
			</table>
			<!-- 게시글 내용 폼 -->
			<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
				<%
				if (user == null){
				}else{
					if (user.getIsadmin().equals("Y")){
				%>
				<tr>
					<td colspan="2">
						<input type="hidden" id="ncheck" value="<%=qna.getNcheck()%>">
						<%
						if(qna.getNcheck().equals("Y")){
						%>
						<input class="buttonD" type="button" id="noticBtn" value="공지해제" onclick="notice();">
						<%
						}else{
						%>
						<input class="buttonD" type="button" id="noticBtn" value="공지등록" onclick="notice();">
						<%
						}
						%>
					</td>
				</tr>
				<%
					}else{
					}
				}
				%>
				<tr>
				<%
				if(qna.getNcheck().equals("Y")){
				%> 
					<td class="title" width="30px" height="70px" colspan="2">
						<h3><img src="/teamc2/images/star.png" width="25px" height="25px"><%= qna.getTitle() %></h3>
					</td>
				<%
				}else{
				%>	
					<td class="title" height="70px" colspan="2"><h3><%= qna.getTitle() %></h3></td>
				<%
				}
				%>
				</tr>
				<tr>
					<td width="100%" colspan="2">
						<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
							<tr>
								<td height="60px" width="60px" align="right" rowspan="2">
									<img class="imgcircle" src="<%= file %>" alt="<%=qna.getName()%>" title="<%=qna.getName()%>">
								</td>
								<td height="30px">
									<font size="2"><%= qna.getName() %></font>
								</td>
							</tr>
							<tr>
								<td height="30px" align="reft">
									<font size="2"><%= qna.getDate() %> &nbsp;&nbsp;&nbsp; hit <%= qna.getHit() %></font>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tline" style="line-height:130%; vertical-align: top; padding:10px 0 0 10px;" height="300px" colspan="2"> <%= qna.getBody() %> </td>
				</tr>
				<tr>
					<td align="right" colspan="2">
						<a id="btnTwitter" class="link-icon twitter" href="javascript:shareTwitter();"></a>&nbsp;&nbsp;
						<a id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook();"></a>&nbsp;&nbsp;
						<a id="btnKakao" class="link-icon kakao" href="javascript:shareKakao();"></a><br><br>
					</td>
				</tr>
				<tr>
					<td>		
						<input class="buttonD" type="button" value="목록으로" onclick="document.location='qna.jsp?k=<%= k %>&page=<%= pageno %>&t=<%= t %>';">
					</td>
					<td align="right">
						<%
						if (user == null){
						%>
						<%
						}else {
							if(user.getUno() == qna.getUno()) {
							%>
							<input class="buttonD" type="button" value="수정" onclick="document.location='qView.do?qno=<%= qno %>&k=<%= k %>&page=<%= pageno %>&t=<%= t %>'">&nbsp;&nbsp;
							<input class="buttonD" type="button" value="삭제" onclick="goDelete();">
						<%
							}
						}
						%>
						<a name="replay"></a>
					</td>
				</tr>
			</table>
			<br>			
			<form id="viewFrm" name="viewFrm" method="post">
				<!-- 댓글 내용 테이블 -->
				<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
					<tr>
						<td>
							댓글 <font color="#63A6DB">[<%= total %>]</font><br><br>
							<hr width="99%" align="center"><br>
						</td>
					</tr>
				</table>
				
				<!-- 댓글 작성 폼 -->
				<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
					<tr height="50px">			
						<td>
							<input type="hidden" id="qnoHidden" name="qnoHidden" value="<%= qno %>">
						</td>
						<%
						if (user != null){
						%>
						<td width="120px">
							<img class="imgcircle" src="<%= user.getFile() %>"> <%= user.getName() %>
						</td>
						<td>
							<input class="rebox" type="text" id="qre" name="qre" size="500px" placeholder="댓글을 입력하세요." maxlength="45" oninput="numberMaxLength(this);">
						</td>
						<td align="right">
							<input class="buttonD" type="button" value="등록" onclick="callSubmit();">
						</td>
						<%
						}else{
						%>
						<td class="nonebox"> 로그인 후 이용할 수 있습니다.</td>
						<%
						}
						%>
					</tr>
				</table>
			
				
				<!-- 댓글 수정 버튼 클릭 후 취소 누르고 원래대로 폼이 돌아올 때 사용되는 것  -->
				<table id="qReply" style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
					<%
					for(int i=0; i< qrList.size(); i++) {
						QreplyVO qr = qrList.get(i);
					%>
					<tr>
						<td>
							<input type="hidden" id="commentHidden" name="commentHidden" value="<%= qr.getQre() %>">
							<input type="hidden" id="qnoHidden" name="qnoHidden" value="<%= qno %>">
							<input type="hidden" id="qrenoHidden" name="qrenoHidden" value="<%= qr.getQreno() %>">
						</td>
					</tr>
					<tr> <!-- 댓글이 있으면 댓글 뿌림 -->
						<td width="50px"><img class="imgcircle" src="<%= qr.getFile() %>"></td>
						<td width="120px"> <%= qr.getQrename() %></td>
						<td> <%= qr.getQre() %></td>
						<td width="120px" align="right"> 
						<%
						if (user == null){ //로그인 안 한 사용자 -> 아무 작업 안 함 
						}else {
							if(user.getUno() == qr.getUno()){  //로그인 한 사용자 -> 댓글 작성자와 같다면
						%>
							<input class="buttonC" type="button" value="수정" onclick="editTable(this);">
							<input class="buttonC" type="button" value="삭제" onclick="replyDelete(<%= qno %>,<%= qr.getQreno() %>);">
							<%
							}
						}
						%>
						</td>
					</tr>
					<tr> <!--댓글 쓴 날짜 -->
						<td class="sfont" align="right" colspan="4"> <%= qr.getQredate() %> </td>		
					</tr>
					<%
					}
					%>
				</table>
					
				<br><br>
			 	<!-- 페이징 -->	
				<table style="margin-left: auto; margin-right: auto;" border="0" align="center" width="900px" hight="35px">		
					<tr>
						<td align="center">	
							<%		
							if(rpage > 1){
							%>
								<a class="page_nation" href="/teamc2/03qna/view.do?qno=<%= qno %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage - 1 %>&page=<%= pageno %>">이전</a>&nbsp;
							<%
							}else{
							%>
								<a class="page_nation" href="javascript:alert('첫 페이지입니다.');">이전</a>&nbsp;
							<%			
							}		
							for(int y=startno; y <= endno; y++){		
								//현재 페이지에 색깔 넣기
								if(y== rpage){
								%>
									<a class="active" href="/teamc2/03qna/view.do?qno=<%= qno %>&k=<%= k %>&t=<%= t %>&rpage=<%= y %>&page=<%= pageno %>"><%= y %></a>&nbsp;<%
								}else{
								%>
									<a class="page_nation" href="/teamc2/03qna/view.do?qno=<%= qno %>&k=<%= k %>&t=<%= t %>&rpage=<%= y %>&page=<%= pageno %>"><%= y %></a>&nbsp;<%								
								}
							}
							if(rpage < maxpageno){
							%>
								<a class="page_nation" href="/teamc2/03qna/view.do?qno=<%= qno %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage + 1 %>&page=<%= pageno %>">다음</a>
							<%
							}else{
							%>
								<a class="page_nation" href="javascript:alert('마지막 페이지입니다.');">다음</a>
							<%			
							}
							%>	
						</td>
					</tr>
				</table>
			</form>
		</td>
	</tr>
</table>
				

<br><br><br>

<!-- 이전 글, 다음 글 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td height="35px">
		<% if(pvo != null){
		%>
			이전글:: <a class="qnaTitle" href="view.do?qno=<%= pvo.getQno() %>&page=<%= pageno %>&k=<%= k %>&t=<%= t %>"><%= pvo.getTitle()%></a>
		<%
		}
		%>
			<br><br>
			<hr width="99%" align="center"><br>
		</td>
	</tr>
	<tr>
		<td height="35px">
		<%
		if(nvo != null) {
		%>
			다음글:: <a class="qnaTitle" href="view.do?qno=<%= nvo.getQno() %>&page=<%= pageno %>&k=<%= k %>&t=<%= t %>"><%= nvo.getTitle()%></a>
		<%
		}
		%>
			<br><br>
			<hr width="99%" align="center">
		</td>
	</tr>
</table>


<script>
//댓글 글자수 한줄 초과 입력을 막는다
function numberMaxLength(e){
	 if(e.value.length > e.maxLength){
         e.value = e.value.slice(0, e.maxLength);
     }
}

function notice(){
	var ncheck = $("#ncheck").val(); 
	var noticBtn = $("#noticBtn").val();
	console.log(ncheck);
	
	if(ncheck == "Y"){
		if(confirm("공지사항을 해제하시겠습니까?") != 1){
			return;		//아니오 눌렀을 때 아무것도 변경하지 않고 종료  ---> ncheck="Y"로 끝남
		}
		
		//예 눌렀을 때, ManagerController notice.do와 연결하여.. ncheck ="N"로 바꿈
		$.ajax({
			url: "/teamc2/manager/notice.do",
			type: "post",
			data: "qno=" + <%= qno %> +"&ncheck=" + ncheck,
			success: function(data){
				if (data == "N"){
					alert("공지사항이 해제되었습니다.");   // ----> ncheck="N"로 끝남
					//ncheck = "N";
					noticBtn = "공지사항 등록";
					document.location.href="view.do?qno=<%= qno %>&k=<%= k %>&t=<%= t %>&rpage=<%=rpage%>&page=<%= pageno %>";
				}
			}
		});
		return;
	}
	
	if(ncheck == "N"){
		if(confirm("공지사항으로 등록하시겠습니까??") != 1){
			return;		//아니오 눌렀을 때 아무것도 변경하지 않고 종료  ---> ncheck="N"로 끝남
		}
		
		//예 눌렀을 때, ManagerController notice.do와 연결하여.. ncheck ="Y"로 바꿈
		$.ajax({
			url: "/teamc2/manager/notice.do",
			type: "post",
			data: "qno=" + <%= qno %> +"&ncheck=" + ncheck,
			success: function(data){
				if (data == "Y"){
					alert("공지사항으로 등록되었습니다.");   // ----> ncheck="Y"로 끝남
					//ncheck = "Y";
					noticBtn = "공지사항 해제";
					document.location.href="view.do?qno=<%= qno %>&k=<%= k %>&t=<%= t %>&rpage=<%=rpage%>&page=<%= pageno %>";
				}
			}
		});
		return;
	}
}	


function goDelete(){
	if( confirm("정말로 글을 삭제하시겠습니까?") != 1){
		return false;		
	}
	document.location="delete.do?qno=<%= qno %>";
}

<!-- 모달창 관련 스크립트 -->
function callSubmit(){
	var qre = document.viewFrm.qre.value;
	if(qre==""){
		$("#checkData").text("댓글을 ");
		$("#modal").show();
		return false;
	}
	
	//댓글 등록 눌렀을 때 폼
	var url = '/teamc2/03qna/qWrite.do?qno=<%=qno%>&qre=';
	//console.log(url);
	
	$.ajax({
		url: url+ qre  ,
		type: "post",
		cache: "false",
		dataType: "json",
		success: function(data){
			console.log(data);
			document.location.href="view.do?qno=<%= qno %>&k=<%= k %>&t=<%= t %>&rpage=1&page=<%= pageno %>&mode=qna";
		}
	});	
}

//확인 버튼 누르면 모달이 사라짐
document.getElementById("closebtn").onclick = function(){
	document.getElementById("modal").style.display="none";
}


<!-- 댓글 기능 -->
var rpage = 1;
//document.getElementById("qrList").onload = function() { GetQrList(); }

//댓글 수정 눌렀을 때 폼    
function editTable(obj){
	var jqueryObj = $(obj);
	var tbody = jqueryObj.parent().parent().parent();
	var qno = $(obj).parent().parent().prev().children().children().next().val();   
	var qreno = $(obj).parent().parent().prev().children().children().next().next().val(); 

	var td = $(obj).parent().prev();
	var text = $(obj).parent().prev().text();  
	//console.log(tbody);
	//수정 창에서 코멘트 폼 변경
	td.html("<textarea class='rebox' align='center' id='commentModi' name='commentModi' maxlength='45' oninput='numberMaxLength(this);'>"+text+"</textarea>");
	
	//alert("글번호:"+ qno);
	//alert("댓글번호:"+qreno);
	
	//수정 창에서 버튼이 변경
	var button = $(obj).parent();
	
	//*********저장하기 고치기 *******
	button.html("<input class='buttonC' type='button' value='저장' onclick='replyModify(this);'>" +
				"<input class='buttonC' type='button' value='취소' onclick='replyView(this);'>");
}

//댓글 수정 ->  저장 -> 원래 폼 모양 : (수정, 삭제)버튼 있는 폼으로 
function replyModify(obj){
	
	//alert("댓글번호:"+qreno);
	var jqueryObj = $(obj);
	var tbody = jqueryObj.parent().parent().parent();
	var qno = $(obj).parent().parent().prev().children().children().next().val();   
	var qreno = $(obj).parent().parent().prev().children().children().next().next().val(); 
	var commentModi = $(obj).parent().prev().find("textarea").val();
	//alert("수정내용:"+commentModi);
	//alert("글번호:"+qno);
	//alert("댓글번호:"+qreno);
	
	if(commentModi==""){		
		$("#checkData").text("댓글을 ");
		$("#modal").show();
		return false;
	}
	var button = $(obj).parent();	
	
	$.ajax({
		url: "/teamc2/03qna/qModi.do?qno="+qno+"&qreno="+qreno+"&commentModi=" + commentModi ,
		type: "get",
		cache: "false",
		dataType: "html",
		success: function(data){
			$(obj).parent().prev().text(commentModi);
			button.html("<input class='buttonC' type='button' value='수정' onclick='editTable(this);'>" +
					 "<input class='buttonC' type='button' value='삭제' onclick='replyDelete("+qno+","+qreno+");'>");
		}
	});		
	
	console.log(qno);
	console.log(qreno);
}

//댓글 수정 -> 취소 눌렀을 때 다시 원래 폼으로 변경 
function replyView(obj){
	var jqueryObj = $(obj);
	var tbody = jqueryObj.parent().parent().parent();
	var td = $(obj).parent().prev();
	var text = $(obj).parent().prev().find("textarea").text();
	
	var qno = $(obj).parent().parent().prev().children().children().next().val();   
	var qreno = $(obj).parent().parent().prev().children().children().next().next().val(); 
	
	//alert("댓글수정취소글번호"+qno);
	td.html("<td rowpan='2'>" + text + "<br> </td>");
	
	var button = $(obj).parent();
	button.html("<input class='buttonC' type='button' value='수정' onclick='editTable(this);'>" +
				 "<input class='buttonC' type='button' value='삭제' onclick='replyDelete("+qno+","+qreno+");'>");

}

//댓글 삭제
function replyDelete(qno, qreno){	
	//alert("댓글삭제글번호"+qno);
	//alert(<%= rpage %>);	
	if( confirm("정말로 댓글을 삭제하시겠습니까?") != 1){
		return false;		
	}
	document.location.href = "/teamc2/03qna/qDelete.do?qno=" + qno + "&qreno=" + qreno +"&rpage=<%= rpage %>"+"&mode=qna";
}


//공유하기 기능
function shareTwitter() {
    var sendText = "잇집"; // 전달할 텍스트
    var sendUrl = "http://192.168.0.109:8080/teamc2/02class/classBoard.jsp/"; // 전달할 URL
    window.open("https://twitter.com/intent/tweet?text=" + sendText + "&url=" + sendUrl);
}

function shareFacebook() {
    var sendUrl = "http://192.168.0.109:8080/teamc2/02class/view.do/"; // 전달할 URL
    window.open("http://www.facebook.com/sharer/sharer.php?u=" + sendUrl);
}

function shareKakao() {
	// 사용할 앱의 JavaScript 키 설정
	Kakao.init('e7b35836bbfd7b332af72bcd6186fde1');
 
	// 카카오링크 버튼 생성
	Kakao.Link.createDefaultButton({
		container: '#btnKakao', // 카카오공유버튼ID
		objectType: 'feed',
		content: {
			title: "잇집", // 보여질 제목
			description: "잇집 입니다", // 보여질 설명
			imageUrl: "http://192.168.0.109:8080/teamc2/02class/view.do/", // 콘텐츠 URL
			link: {
				mobileWebUrl: "http://192.168.0.109:8080/teamc2/02class/view.do/",
				webUrl: "http://192.168.0.109:8080/teamc2/02class/view.do/"
			}
		}
	});
}


window.onload = function(){
	<%
	if(mode != null){
	%>
	document.location="#replay";
	<%
	}
	%>
}
</script>

<%@include file="../include/footer.jsp" %>
