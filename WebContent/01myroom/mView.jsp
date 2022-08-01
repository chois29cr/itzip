<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dto.*" %>    
<%@include file="../include/header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/q_boardLayer.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">

<%
String t = (String)request.getAttribute("t");
String pageno = (String)request.getAttribute("pageno");
int rpage = (int)request.getAttribute("rpage");
MyroomVO m = (MyroomVO)request.getAttribute("view");
MyroomVO nvo = (MyroomVO)request.getAttribute("next");
MyroomVO pvo = (MyroomVO)request.getAttribute("prev");
String file = (String)request.getAttribute("file");
String no = request.getParameter("no");
String mode = request.getParameter("mode");
int total = (int)request.getAttribute("total"); 
int startno = (int)request.getAttribute("startno");
int endno = (int)request.getAttribute("endno");
int maxpageno = (int)request.getAttribute("maxpageno");
ArrayList<MreplyVO> mrList = (ArrayList<MreplyVO>)request.getAttribute("mrList");
int mlTotal = (int)request.getAttribute("mlTotal");
String likecheck = (String)request.getAttribute("likecheck");
%>    


<style>
/*mWrite.jsp에서 사진 업로드 시, 썸네일 최대 사이즈 */
img{
	max-width:900px;
}
.himg{
	background-color: white;
}
.link-icon { position: relative; display: inline-block; width: 40px;    font-size: 14px; font-weight: 500; color: #333; margin-right: 10px; padding-top: 50px; }
.link-icon.twitter { background-image: url(../images/icon/icon-twitter.png); background-repeat: no-repeat; }
.link-icon.facebook { background-image: url(../images/icon/icon-facebook.png); background-repeat: no-repeat; } 
.link-icon.kakao { background-image: url(../images/icon/icon-kakao.png); background-repeat: no-repeat; }
.title{
	box-shadow: 1px 1px 1px 1px #f7f7f7;
	border: 1px solid #f8f8f8; 
	padding: 0px 0px 0px 30px;
}
.bimg {
	border: 1px solid #f8f8f8;
	box-shadow: 1px 1px 1px 1px #f9f9f9;
}
#box {
    height:20px;
    width:210px;
    background:#fff;
    cursor:pointer;
}
.hidden {
	height:0px;
	visibility: hidden;
	dbox-shadow: 0 -1px 16px rgb(0 0 0 / 20%);
    border-radius: 10px;
}
.hidden.open {
	height:45px;
	visibility: visible;
	dbox-shadow: 0 -1px 16px rgb(0 0 0 / 20%);
    border-radius: 10px;
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
	line-height:130%;
}
.qna_cate:hover{
	box-shadow: 0 -1px 16px rgb(0 0 0 / 20%);
}

/* mView.jsp 로그인x일 때 알림 박스 */
.nonebox {
    border: 1px solid #E6E6E6;
    height:40px;
    width: 980px;
    background-color: #FBFBFB;
    padding:0 0 0 20px;
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
					<td colspan="2" style="padding:5px;"><div height="30px"><a class="qna_cate" href="myroom.jsp">내방</a></div></td>
				</tr>
			</table>
			<!-- 게시글 내용 폼 -->
			<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
				<tr>
					<td class="title" height="70px">
						<h3><%= m.getTitle() %></h3>
					</td>
				</tr>
			</table>
			<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
				<tr>
					<td height="60px" width="60px" align="right" rowspan="2">
						<img class="imgcircle" src="<%= file %>" alt="<%=m.getName()%>" title="<%=m.getName()%>">
					</td>
					<td height="30px">
						<font size="2"><%= m.getName() %></font>
					</td>
				</tr>
				<tr>
					<td height="30px" align="reft">
						<font size="2"><%= m.getDate() %> &nbsp;&nbsp;&nbsp; hit <%= m.getHit() %></font>
					</td>
				</tr>
			</table>
			<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
				<tr>
					<td class="tline" valign="top" height="300px" style="padding:10px 0 0 10px;">
						<%= m.getBody() %>
					</td>
				</tr>
			</table><br><br>
			<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
				<tr>
					<td>
					<%
					if (user == null){
					%>
						<button type="button" id="btnLike" class="btnLike">		
			 				<img class="himg" id="like_img" alt="btnimgs" src="/teamc2/images/likepick/empty_heart.png" width="20px" height="20px">
			 			</button>
			 		<%
						}else{
							if (likecheck.equals("Y")){ 
								%>
								<button type="button" id="btnLike" class="btnLike" onclick="javascript:unLike(this)">		
						 		<img id="like_img" alt="y" src="/teamc2/images/likepick/heart.png" width="20px" height="20px"> 
						 		</button>
						 		<%
							}else if(likecheck.equals("N")){ 
						 		%>
						 		<button type="button" id="btnUnLike" class="btnLike" onclick="javascript:Like(this)">		
						 		<img class="himg" id="like_img" alt="n" src="/teamc2/images/likepick/empty_heart.png" width="20px" height="20px"> 
						 		</button>
						 		<%
							}else if(likecheck.equals("")){ 
								%>
						 		<button type="button" id="btnLike1" class="btnLike" onclick="javascript:wLike(this)">		
						 		<img class="himg" id="like_img" alt="null" src="/teamc2/images/likepick/empty_heart.png" width="20px" height="20px"> 
						 		</button>
						 		<%
							}
						}
			 		%> 	 
			 		<%= mlTotal %>	
					</td>
					<td align="right">
						<a id="btnTwitter" class="link-icon twitter" href="javascript:shareTwitter();"></a>&nbsp;&nbsp;
						<a id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook();"></a>&nbsp;&nbsp;
						<a id="btnKakao" class="link-icon kakao" href="javascript:shareKakao();"></a>
						<a name="replay"></a>
					</td>
				</tr>
			</table>
			<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
				<tr>
					<td>
						<input class="buttonD" type="button" value="목록으로" onclick="document.location='myroom.jsp?k=<%= k %>&t=<%= t %>';">
					</td>
					<td align="right">
						<%
						if (user == null){
						%>
						<%
						}else {
							if(user.getUno() == m.getUno()) {
							%>
							<input class="buttonD" type="button" value="수정" onclick="javascript:document.location='mView.do?no=<%= no %>'"> &nbsp;&nbsp;
							<input class="buttonD" type="button" value="삭제" onclick="javascript:document.location='delete.do?no=<%= no %>'">
							<%
							}
						}
						%>
					</td>
				</tr>
			</table>
			<br><br>
			
			<!-- 댓글 내용 테이블 -->
			<form id="viewFrm" name="viewFrm" method="post">
				<table id="mReply" style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
					<tr>
						<td colspan="5">
							댓글 <span id="rTotal"> <%= total %> </span> <br><br>
							<hr width="99%" align="center"><br>
						</td>
					</tr>
				</table>
			
				<!-- 댓글 작성 폼 -->
				<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
					<tr height="50px">			
						<td>
							<input type="hidden" id="noHidden" name="noHidden" value="<%= no %>">
						</td>
						<%
						if (user != null){
						%>
						<td width="120px">
							<img class="imgcircle" src="<%= user.getFile() %>"> <%= user.getName() %>
						</td>
						<td>
							<input class="rebox" type="text" id="mre" name="mre" size="500px" placeholder="댓글을 입력하세요." maxlength="45" oninput="numberMaxLength(this);">
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
								
				<br>
				
				<table id="mReply" style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
					<%
					for(int i=0; i< mrList.size(); i++)
					{
						MreplyVO mr = (MreplyVO)mrList.get(i);
					%>
					<tr>
						<td>
							<input type="hidden" name="commentHidden" value="<%= mr.getMre() %>">
							<input type="hidden" name="noHidden" value="<%= no %>">
							<input type="hidden" id="mrenoHidden" name="mrenoHidden" value="<%= mr.getMreno() %>">
						</td>
					</tr>
					<tr>
						<td width="50px"><img class="imgcircle" src="<%= mr.getFile() %> " alt="<%= mr.getMrename() %>" title="<%= mr.getMrename() %>"></td>
						<td width="120px"> <%= mr.getMrename() %> </td>
						<td> <%= mr.getMre() %> </td>
						<td width="120px" align="right"> 
							<%
							if (user == null){				
							}else {
								if(user.getUno() == mr.getUno()) {
							%>
								<input class="buttonC" type="button" value="수정" onclick="javascript:editTable(this);">
								<input class="buttonC" type="button" value="삭제" onclick='javascript:replyDelete(<%= no %>,<%= mr.getMreno() %>);'>
							<%
								}
							}
							%>
						</td>
					</tr>
					<tr>
						<td class="sfont" colspan="4" align="right">
							<%= mr.getMredate() %>
						</td>		
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
							if(rpage > 1) {
							%>
								<a class="page_nation" href="/teamc2/01myroom/view.do?no=<%= no %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage - 1 %>&page=<%= pageno %>">이전</a>&nbsp;
							<%
							}else {
							%>
								<a class="page_nation" href="javascript:alert('첫 페이지입니다.');">이전</a>&nbsp;
							<%			
							}		
							for(int y=startno; y <= endno; y++) {
								
								//현재 페이지에 색깔 넣기
								if(y== rpage) {
								%>
									<a class="active" href="/teamc2/01myroom/view.do?no=<%= no %>&k=<%= k %>&t=<%= t %>&rpage=<%= y %>&page=<%= pageno %>"><%= y %></a>&nbsp;<%
								}else {
								%>
									<a class="page_nation" href="/teamc2/01myroom/view.do?no=<%= no %>&k=<%= k %>&t=<%= t %>&rpage=<%= y %>&page=<%= pageno %>"><%= y %></a>&nbsp;<%								
								}
							}
							
							if(rpage < maxpageno) {
							%>
								<a class="page_nation" href="/teamc2/01myroom/view.do?no=<%= no %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage + 1 %>&page=<%= pageno %>">다음</a>
							<%
							}else {
							%>
								<a class="page_nation" href="javascript:alert('마지막 페이지입니다.');">다음</a>
							<%			
							}
							%>	
						</td>
					</tr>
				</table>	
			</td>
		</tr>
</table>
</form>

<br><br><br>
<br><br><br>
<br><br><br>

<!-- 이전 글, 다음 글 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td height="35px">
		<% if(pvo != null) { %>
			이전글 :: <a class="qnaTitle" href="/teamc2/01myroom/view.do?no=<%= pvo.getNo() %>"> <%= pvo.getTitle() %></a>
		<%
		} 
		%><br><br>
			<hr width="99%" align="center"><br>
		</td>
	</tr>
	<tr>
		<td height="35px">
		<% if(nvo != null) { %>
			다음글 :: <a class="qnaTitle" href="/teamc2/01myroom/view.do?no=<%= nvo.getNo() %>"><%= nvo.getTitle()%></a>
		<%
		}
		%><br><br>
			<hr width="99%" align="center">
		</td>
	</tr>
</table>


<!-- 모달창 관련 스크립트 -->
<script>
function callSubmit(){
	
	var mre = document.viewFrm.mre.value;
	if(mre==""){
		$("#checkData").text("댓글을 ");
		$("#modal").show();
		return false;		
	}	
	
	//댓글 등록 눌렀을 때 폼
	$.ajax({
		url: "/teamc2/01myroom/mWrite.do?no=<%=no%>&mre="+ mre  ,
		type: "post",
		cache: "false",
		dataType: "json",
		success: function(data)
		{
			//alert("성공");
			console.log(data);
			document.location.href="view.do?no=<%= no %>&k=<%= k %>&t=<%= t %>&rpage=1&page=<%= pageno %>&mode=myroom";
		}
	});
	
	
}
//확인 버튼 누르면 모달이 사라짐
document.getElementById("closebtn").onclick = function(){
	document.getElementById("modal").style.display="none";
}
</script>

<!-- 댓글 기능 -->
<script>
//댓글 한줄 초과 입력을 막는다
function numberMaxLength(e){
	if(e.value.length > e.maxLength){
    	e.value = e.value.slice(0, e.maxLength);
	}    
}        
        
//댓글 수정 눌렀을 때 폼    
function editTable(obj)
{
	var jqueryObj = $(obj);
	var tbody = jqueryObj.parent().parent().parent();
	var no   = $(obj).parent().parent().prev().children().children().next().val();   
	var mreno = $(obj).parent().parent().prev().children().children().next().next().val(); 
	
	//alert("글번호:"+ no);
	//alert("댓글번호:"+mreno);
	
	var td = $(obj).parent().prev();
	var text = $(obj).parent().prev().text();  
	//console.log(tbody);
	//수정 창에서 코멘트 폼 변경
	td.html("<textarea class='rebox' align='center' id='commentModi' name='commentModi' maxlength='45' oninput='numberMaxLength(this);'>"+text+"</textarea>");
	
	
	
	//수정 창에서 버튼이 변경
	var button = $(obj).parent();
	
	//*********저장하기 고치기 *******
	button.html("<input class='buttonC' type='button' value='저장' onclick='javascript:replyModify(this);'>" +
				"<input class='buttonC' type='button' value='취소' onclick='javascript:replyView(this);'>");
}
//댓글 수정 ->  저장 -> 원래 폼 모양 : (수정, 삭제)버튼 있는 폼으로 
function replyModify(obj){
	
	//alert("댓글번호:"+mreno);
	var jqueryObj = $(obj);
	var tbody = jqueryObj.parent().parent().parent();
	var no = $(obj).parent().parent().prev().children().children().next().val();   
	var mreno = $(obj).parent().parent().prev().children().children().next().next().val(); 
	var commentModi = $(obj).parent().prev().find("textarea").val();
	//alert("수정내용:"+commentModi);
	//alert("글번호:"+no);
	//alert("댓글번호:"+mreno);
	
	if(commentModi==""){
		$("#checkData").text("댓글을 ");
		$("#modal").show();
		return false;
	}
	
	var button = $(obj).parent();
	
	$.ajax({
		url: "/teamc2/01myroom/mModi.do?no="+no+"&mreno="+mreno+"&commentModi=" + commentModi ,
		type: "get",
		cache: "false",
		dataType: "html",
		success: function(data)
		{
			$(obj).parent().prev().text(commentModi);
			button.html("<input class='buttonC' type='button' value='수정' onclick='javascript:editTable(this);'>" +
					 "<input class='buttonC' type='button' value='삭제' onclick='javascript:replyDelete("+no+","+mreno+");'>");
		}
	});		
	
	console.log(no);
	console.log(mreno);
}
//댓글 수정 -> 취소 눌렀을 때 다시 원래 폼으로 변경 
function replyView(obj){
	var jqueryObj = $(obj);
	var tbody = jqueryObj.parent().parent().parent();
	var td = $(obj).parent().prev();
	var text = $(obj).parent().prev().find("textarea").text();
	
	var no = $(obj).parent().parent().prev().children().children().next().val();   
	var mreno = $(obj).parent().parent().prev().children().children().next().next().val(); 
	console.log(mreno);
	
	//alert("댓글수정취소글번호"+qno);
	td.html("<td rowpan='2'>" + text + "<br> </td>");
	
	var button = $(obj).parent();
	button.html("<input class='buttonC' type='button' value='수정' onclick='javascript:editTable(this);'>" +
				 "<input class='buttonC' type='button' value='삭제' onclick='javascript:replyDelete("+no+","+mreno+");'>");
}
//댓글 삭제
function replyDelete(no, mreno){	
	//alert("댓글삭제글번호"+qno);
	//alert(mreno);	
	if( confirm("정말로 댓글을 삭제하시겠습니까?") != 1)
	{
		return false;		
	}
	document.location.href = "/teamc2/01myroom/mDelete.do?no=" + no + "&mreno=" + mreno +"&rpage=<%= rpage %>"+"&mode=myroom";
}
//focus
window.onload = function()
{
	<%
	if(mode != null)
	{
		%>document.location="#replay";<%
	}
	%>
}
function unLike(obj){
	alert("좋아요가 해제되었습니다.");
	//ajax 이용해서 체크 해제 로직구현
	$.ajax({
		url:"unlike.do?no=<%=no%>", //요청경로 (좋아요 처리할 servlet경로)
		type:"get", //method 타입
		data: 
			{ 	mlTotal: "${mlTotal}",
				likecheck: "${likecheck}"
			},
			//servlet으로 보낼 data 문자열 파라미터 형식, 객체타입 {key:"",key:""}
		success:function(data){ //처리 servlet에서 화면으로 찍어내는 데이터가 응답데이터 response.getWriter().write("data");
			//success에서는 빈하트 처리
			var td = $(obj).parent();
			
			td.html("<button type='button' id='btnUnLike' class='btnLike'; onclick='javascript:Like(this)'>"+
					"<img class='himg' id='like_img' alt='n' src='../images/likepick/empty_heart.png' width='20px' height='20px'>"+
					"</button> "+data);
		}		
	});	
}
function Like(obj){
	alert("좋아요를 눌렀습니다.");
	//ajax 이용해서 다시 체크 로직구현
	$.ajax({
		url:"like.do?no=<%=no%>", //요청경로 (좋아요 처리할 servlet경로)
		type:"get", //method 타입
		data: 
			{ 	mlTotal: "${mlTotal}",
				likecheck: "${likecheck}"
			},
			//servlet으로 보낼 data 문자열 파라미터 형식, 객체타입 {key:"",key:""}
		success:function(data){ //처리 servlet에서 화면으로 찍어내는 데이터가 응답데이터 response.getWriter().write("data");
			//success에서는 빈하트 처리
			var td = $(obj).parent();
			//console.log(mlTotal);
			td.html("<button type='button' id='btnLike' class='btnLike'; onclick='javascript:unLike(this)'>"+
					"<img id='like_img' alt='y' src='../images/likepick/heart.png' width='20px' height='20px'>"+
					"</button> "+data);
		}		
	});	
}
function wLike(obj){
	alert("좋아요를 눌렀습니다.");
	//ajax 이용해서 처음 체크 로직구현
	$.ajax({
		url:"wlike.do?no=<%=no%>", //요청경로 (좋아요 처리할 servlet경로)
		type:"get", //method 타입
		data: 
			{ 	mlTotal: "${mlTotal}",
				likecheck: "${likecheck}"
			},
			//servlet으로 보낼 data 문자열 파라미터 형식, 객체타입 {key:"",key:""}
		success:function(data){ //처리 servlet에서 화면으로 찍어내는 데이터가 응답데이터 response.getWriter().write("data");
			//success에서는 빈하트 처리
			var td = $(obj).parent();			
			
			td.html("<button type='button' id='btnLike' class='btnLike'; onclick='javascript:unLike(this)'>"+
					"<img id='like_img' alt='n' src='../images/likepick/heart.png' width='20px' height='20px'>"+
					"</button> " +data);
		}		
	});	
}
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
$(document).ready(function() {
    $('#box').click(function() {
        $(this).find(".hidden").toggleClass('open');
    });
});
</script>

<%@include file="../include/footer.jsp" %>