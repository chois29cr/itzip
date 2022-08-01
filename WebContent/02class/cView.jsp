<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dto.*" %>    
<%@include file="../include/header.jsp" %>
<%@ page import="java.util.ArrayList" %>    
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/classBoard.css">
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<%
String t = (String)request.getAttribute("t");
String pageno = (String)request.getAttribute("pageno");
int rpage = (int)request.getAttribute("rpage");

ClassboardVO c = (ClassboardVO)request.getAttribute("view");
ClassboardVO nvo = (ClassboardVO)request.getAttribute("next");
ClassboardVO pvo = (ClassboardVO)request.getAttribute("prev");
String file = (String)request.getAttribute("file");
String cno = request.getParameter("cno");
String mode = request.getParameter("mode");

int total = (int)request.getAttribute("total"); 
int startno = (int)request.getAttribute("startno");
int endno = (int)request.getAttribute("endno");
int maxpageno = (int)request.getAttribute("maxpageno");
ArrayList<CreplyVO> crList = (ArrayList<CreplyVO>)request.getAttribute("crList");

int plTotal = (int)request.getAttribute("plTotal");
String pickcheck = (String)request.getAttribute("pickcheck");


DCattachDTO da = new DCattachDTO();
DCattachVO dv = da.dImage(Integer.parseInt(cno));
%>
    
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
			<!-- 게시글 내용 폼 -->
			<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
				<tr>
					<td>
						<div height="30px"><a class="class_cate" href="../02class/classBoard.jsp">클래스</a></div>
						<br>
					</td>
					<td align="right">
					<%
						if (user == null){
					%>
					<button type="button" id="btnPick" class="btnPick">		
			 		<img id="pick_img" alt="btnimgs" src="../images/classpick/empty_star.png" width="30px" height="30px"> 
			 		</button>
			 		<%
						}else{
							if (pickcheck.equals("Y")){
								%>
								<button type="button" id="btnPick" class="btnPick" onclick="javascript:unPick(this)">		
						 		<img id="pick_img" alt="y" src="../images/classpick/star.png" width="30px" height="30px"> 
						 		</button>
						 		<%
							}else if(pickcheck.equals("N")){
						 		%>
						 		<button type="button" id="btnUnPick" class="btnPick" onclick="javascript:Pick(this)">		
						 		<img id="pick_img" alt="n" src="../images/classpick/empty_star.png" width="30px" height="30px"> 
						 		</button>
						 		<%
							}else if(pickcheck.equals("")){
								%>
						 		<button type="button" id="btnPick1" class="btnPick" onclick="javascript:wPick(this)">		
						 		<img id="pick_img" alt="null" src="../images/classpick/empty_star.png" width="30px" height="30px"> 
						 		</button>
						 		<%
							}
						}
			 		%> 	 
					</td>
				</tr>
				<tr>
					<td class="title" height="70px" colspan="2">
						<h3><%= c.getTitle() %></h3>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
							<tr>
								<td height="60px" width="60px" align="right" rowspan="2">
									<img class="imgcircle" src="<%= file %>" alt="<%=c.getName()%>" title="<%=c.getName()%>">
								</td>
								<td height="30px">
									<font size="2"><%= c.getName() %></font>
								</td>
							</tr>
							<tr>
								<td height="30px" align="reft">
									<font size="2"><%= c.getDate() %> &nbsp;&nbsp;&nbsp; hit <%= c.getHit() %></font>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="bimg" align="center" colspan="2"><br><br>
						<div class="iparent">
							<img class="imglow" src="<%= dv.getDcattach() %>" width="500px" alt="글번호:<%= dv.getCno() %>" title="<%= c.getTitle() %>">
						</div>
						
					</td>
				</tr>
				<tr>
					<td height="50px" colspan="2">
					</td>
				</tr>
			</table>			
			<form id="viewFrm" name="viewFrm" method="post">
				<!-- 댓글 내용 테이블 -->
				<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
					<tr>
						<td>
							후기 <font color="#63A6DB">[<%= total %>]</font><br><br>
							<hr width="99%" align="center"><br>
						</td>
					</tr>
				</table>
				
				<!-- 댓글 작성 폼 -->
				<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
					<tr>			
						<td>  <!-- value cno request: no 확인하기 -->
							<input type="hidden" id="cnoHidden" name="cnoHidden" value="<%= cno %>">
						</td>
						<%
						if (user != null){
						%>
						<td width="120px">
							<img class="imgcircle" src="<%= user.getFile() %>"> <%= user.getName() %>
						</td>
						<td>
							<input class="rebox" type="text" id="cre" name="cre" size="100%" placeholder="후기를 입력하세요." maxlength="45" oninput="numberMaxLength(this);">
						</td>
						<td align="right">
							<input class="buttonD" type="button" value="등록" onclick="callSubmit(); return false;">
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
			        for(int i=0; i< crList.size(); i++) {
			            CreplyVO cr = crList.get(i);
					%>
					<tr>
						<td>
							<input type="hidden" id="commentHidden" name="commentHidden" value="<%= cr.getCre() %>">
							<input type="hidden" id="cnoHidden" name="cnoHidden" value="<%= cno %>">
							<input type="hidden" id="crenoHidden" name="crenoHidden" value="<%= cr.getCreno() %>">
						</td>
					</tr>
					<tr> <!-- 댓글이 있으면 댓글 뿌림 -->
						<td width="50px"><img class="imgcircle" src="<%= cr.getFile() %>"></td>
						<td width="120px"> <%= cr.getCrename() %></td>
						<td> <%= cr.getCre() %></td>
						<td width="120px" align="right"> 
						<%
						if (user == null){ //로그인 안 한 사용자 -> 아무 작업 안 함 
						}else {
							if(user.getUno() == cr.getUno()){  //로그인 한 사용자 -> 댓글 작성자와 같다면
						%>
							<input class="buttonC" type="button" value="수정" onclick="editTable(this);">
							<input class="buttonC" type="button" value="삭제" onclick="replyDelete(<%= cno %>,<%= cr.getCreno() %>);">
						<%
						}
					}
						%>
						</td>
					</tr>
					<tr> <!--댓글 쓴 날짜 -->
						<td class="sfont" align="right" colspan="4"> <%= cr.getCredate() %> </td>		
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
								<a class="page_nation" href="/teamc2/02class/view.do?cno=<%= cno %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage - 1 %>&page=<%= pageno %>">이전</a>&nbsp;
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
									<a class="active" href="/teamc2/02class/view.do?cno=<%= cno %>&k=<%= k %>&t=<%= t %>&rpage=<%= y %>&page=<%= pageno %>"><%= y %></a>&nbsp;<%
								}else{
								%>
									<a class="page_nation" href="/teamc2/02class/view.do?cno=<%= cno %>&k=<%= k %>&t=<%= t %>&rpage=<%= y %>&page=<%= pageno %>"><%= y %></a>&nbsp;<%								
								}
							}
							if(rpage < maxpageno){
							%>
								<a class="page_nation" href="/teamc2/02class/view.do?cno=<%= cno %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage + 1 %>&page=<%= pageno %>">다음</a>
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
				<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
					<tr>
						<td class="line" width="100%"><br></td>
					</tr>
					<tr>
						<td class="cbody">
							<%= c.getBody() %>
						</td>
					</tr>
				</table>	
				
			</form>
			
			<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
				<tr>
					<td align="left">
						<%
						if(user==null){
						}else{
							
							if(user.getUno() == c.getUno()) {
								%>
								<input class="buttonD" type="button" value="수정" onclick="document.location='cView.do?cno=<%= cno %>'">&nbsp;&nbsp;
								<input class="buttonD" type="button" value="삭제" onclick="document.location='delete.do?cno=<%= cno %>'">
								<%
							}
						}	
						%>
					</td>
					<td align="right">
				        <a id="btnTwitter" class="link-icon twitter" href="javascript:shareTwitter();"></a>&nbsp;&nbsp;
						<a id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook();"></a>&nbsp;&nbsp;
						<a id="btnKakao" class="link-icon kakao" href="javascript:shareKakao();"></a><br><br>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<!-- 피드백 -->
						<table style="margin-left: auto; margin-right: auto;" border="0" width="100%">
							<tr>
								<td>
									<font size="5"><strong>FeedBack</strong></font>
								</td>
							</tr>
							<tr>
								<td>
								<%
								if (user == null){
								%>
								<div class="feed">
									<%
									if( c.getFeed() == null ){
									%>
										등록된 피드백이 없습니다.
									<%
									}else {
									%>
										<%= c.getFeed() %>
									<%
									}
									%>
								</div>
								<%
								}else {
										
									if( c.getUno() == user.getUno() ){
										
									ClassboardDTO cdto = new ClassboardDTO();
									ClassboardVO cf = cdto.check(cno, Integer.toString(user.getUno()));
										
										if( cf.getFeed() == null ){
										
										%>
										<form action="/teamc2/02class/feed.do">
											<input type="hidden" id="noHidden" name="noHidden" value="<%= cno %>">
											<textarea class="feed" name="feed" id="feed" rows="" cols=""></textarea><br><br>
											<p align="right"><input class="buttonB" type="submit" value="등록"></p>
										</form>
										<%
												
										}else{
										%>
										<form action="/teamc2/02class/feed.do">
											<input type="hidden" id="noHidden" name="noHidden" value="<%= cno %>">
											<textarea class="feed" name="feed" id="feed" rows="" cols=""><%= cf.getFeed() %></textarea><br><br>
											<p align="right"><input class="buttonB" type="submit" value="등록"></p>
										</form>
										<%	
										}
									}else {
										
									ClassboardDTO cdto = new ClassboardDTO();
									ClassboardVO cf = cdto.check(cno, Integer.toString(c.getUno()));
										
										if( cf.getFeed() == null ){
			
										%>
										<div class="feed">등록된 피드백이 없습니다.</div>
										<%
										}else{
										%>
										<div class="feed"><%= c.getFeed() %></div>
										<%	
										}
									}
								}
								%>
								</td>
							</tr>
						</table>
					</td>
				</tr>	
			</table>
			<br><br><br>
			<table style="margin-left: auto; margin-right: auto;" border="0" width="900px" align="center">
				<tr>
					<td colspan="2" class="bclass" align="center">
						지금 신청하시면 재료비까지 무료!!
					</td>
				</tr>
				<tr>
					<td colspan="2" height="100px">
						<table style="margin-left: auto; margin-right: auto;" border="0" width="100%" align="center">
							<tr>
								<td colspan="6" width="100px" height="50px">
									<Strong>클래스 정보</Strong>
								</td>
								<td rowspan="2" align="right">
									<%
									if (user == null){
									%>
									
									<input class="buttonD" type="button" value="수강하기" onclick="document.location='../user/login.jsp';">
									
									<%
									}else {
										StudentDTO sdto = new StudentDTO();
										StudentVO s = sdto.check(cno, Integer.toString(user.getUno()));
										
										if( s != null ){
										
											if( Integer.toString(s.getSno()) != null ) {
									%>
											<input class="buttonD" type="button" value="수강완료된 항목">
									<%
											}
										}else{
									%>
										<input class="buttonD" type="button" value="수강하기" onclick="document.location='classing.jsp?cno=<%= cno %>';">
									<%	
										}
									}
									%>
								</td>
							</tr>
							<tr>
								<td width="100px">
									클래스 방법
								</td>
								<td width="100px">
									<font size="2" color="#878787">현장강의</font>
								</td>
								<td width="100px">
									클래스 신청
								</td>
								<td width="100px">
									<font size="2" color="#878787">바로신청가능</font>
								</td>
								<td width="100px">
									클래스 일시
								</td>
								<td width="150px">
									<font size="2" color="#878787">인원충족후 일정 통보</font>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tline" height="60px" colspan="2">
						<font size="5"><strong>수강취소 문의</strong></font>
					</td>
				</tr>
				<tr>
					<td>
						부득이하게 수강을 취소하시는 분은 잇집 고객센터로 연락 바랍니다.<br><br><br><br>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br><br>
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td>
			<input class="buttonD" type="button" value="목록으로" onclick="document.location='classBoard.jsp?page=<%= pageno %>'"><br><br>
		</td>
	</tr>
</table>

<!-- 이전 글, 다음 글 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td class="tline" height="50px">이전글 :: 
		<% if(pvo != null) { %>
			<a class="qnaTitle" href="/teamc2/02class/view.do?cno=<%= pvo.getCno() %>"> <%= pvo.getTitle()%></a>
		<%
		} 
		%><br><br>
		</td>
	</tr>
	<tr>
		<td class="tline" height="50px">다음글 :: 
		<% if(nvo != null) { %>
			<a class="qnaTitle" href="/teamc2/02class/view.do?cno=<%= nvo.getCno() %>"><%= nvo.getTitle()%></a>
		<%
		}
		%><br><br>
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

<!-- 모달창 관련 스크립트 -->
function callSubmit(){
	
	var cre = document.viewFrm.cre.value;
	if(cre==""){
		$("#checkData").text("후기를 ");
		$("#modal").show();
		return false;
	}	
	//댓글 등록 눌렀을 때 폼
	$.ajax({
		url: "/teamc2/02class/cWrite.do?cno=<%=cno%>&cre="+ cre  ,
		type: "post",
		cache: "false",
		dataType: "json",
		success: function(data)
		{
			//alert("성공");
			console.log(data);
			document.location.href="view.do?cno=<%= cno %>&k=<%= k %>&t=<%= t %>&rpage=1&page=<%= pageno %>&mode=class";

		}
	});
}

//확인 버튼 누르면 모달이 사라짐
document.getElementById("closebtn").onclick = function(){
document.getElementById("modal").style.display="none";
}


<!-- 댓글 기능 -->
//댓글 수정 눌렀을 때 폼    
function editTable(obj)
{
	var jqueryObj = $(obj);
	var tbody = jqueryObj.parent().parent().parent();
	var no   = $(obj).parent().parent().prev().children().children().next().val();   
	var mreno = $(obj).parent().parent().prev().children().children().next().next().val(); 
	var td = $(obj).parent().prev();
	var text = $(obj).parent().prev().text();  

	td.html("<textarea class='rebox' align='center' id='commentModi' name='commentModi' maxlength='45' oninput='numberMaxLength(this);'>"+text+"</textarea>");
	
	
	
	//수정 창에서 버튼이 변경
	var button = $(obj).parent();
	
	//*********저장하기 고치기 *******
	button.html("<input class='buttonC' type='button' value='저장' onclick='replyModify(this);'>" +
				"<input class='buttonC' type='button' value='취소' onclick='replyView(this);'>");
}

//댓글 수정 ->  저장 -> 원래 폼 모양 : (수정, 삭제)버튼 있는 폼으로 
function replyModify(obj){
	
	//alert("댓글번호:"+mreno);
	var jqueryObj = $(obj);
	var tbody = jqueryObj.parent().parent().parent();
	var cno = $(obj).parent().parent().prev().children().children().next().val();   
	var creno = $(obj).parent().parent().prev().children().children().next().next().val(); 
	var commentModi = $(obj).parent().prev().find("textarea").val();
	//alert("수정내용:"+commentModi);
	//alert("글번호:"+no);
	//alert("댓글번호:"+mreno);
	
	var button = $(obj).parent();
	

	$.ajax({
		url: "/teamc2/02class/cModi.do?cno="+cno+"&creno="+creno+"&commentModi=" + commentModi ,
		type: "get",
		cache: "false",
		dataType: "html",
		success: function(data)
		{

			$(obj).parent().prev().html(commentModi);
			button.html("<input class='buttonC' type='button' value='수정' onclick='editTable(this);'>" +
					 "<input class='buttonC' type='button' value='삭제' onclick='replyDelete("+cno+","+creno+");'>");

		}

	});		
	
	console.log(cno);
	console.log(creno);
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

//댓글 수정 -> 취소 눌렀을 때 다시 원래 폼으로 변경 
function replyView(obj){
	var jqueryObj = $(obj);
	var tbody = jqueryObj.parent().parent().parent();
	var td = $(obj).parent().prev();
	var text = $(obj).parent().prev().find("textarea").text();
	
	var no = $(obj).parent().parent().prev().children().children().next().val();   
	var mreno = $(obj).parent().parent().prev().children().children().next().next().val(); 
	
	//alert("댓글수정취소글번호"+qno);
	td.html("<td rowpan='2'>" + text + "<br> </td>");
	

	var button = $(obj).parent();
	button.html("<input class='buttonC' type='button' value='수정' onclick='editTable(this);'>" +
				 "<input class='buttonC' type='button' value='삭제' onclick='replyDelete("+cno+","+creno+");'>");

}

//댓글 삭제
function replyDelete(cno, creno){
	if(confirm("정말로 후기를 삭제하시겠습니까?") != 1){
		return false;		
	}
	document.location = "/teamc2/02class/cDelete.do?cno=" + cno + "&creno=" + creno;
}


function unPick(obj){
	alert("찜목록에서 해제되었습니다.");
	//ajax 이용해서 체크 해제 로직구현
	$.ajax({
		url:"unpick.do?cno=<%=cno%>", //요청경로 (찜 처리할 servlet경로)
		type:"get", //method 타입
		data: 
			{ 	plTotal: "${plTotal}",
				pickcheck: "${pickcheck}"
			},
			//servlet으로 보낼 data 문자열 파라미터 형식, 객체타입 {key:"",key:""}
		success:function(data){ //처리 servlet에서 화면으로 찍어내는 데이터가 응답데이터 response.getWriter().write("data");
			//success에서는 빈하트 처리
			var td = $(obj).parent();
			
			td.html("<button type='button' id='btnUnPick' class='btnPick'; onclick='javascript:Pick(this)'>"+
					"<img id='pick_img' alt='n' src='../images/classpick/empty_star.png' width='30px' height='30px'>"+
					"</button>");
		}		
	});	
}

function Pick(obj){
	alert("찜목록에 등록되었습니다.");
	//ajax 이용해서 다시 체크 로직구현
	$.ajax({
		url:"pick.do?cno=<%=cno%>", //요청경로 (찜 처리할 servlet경로)
		type:"get", //method 타입
		data: 
			{ 	plTotal: "${plTotal}",
				pickcheck: "${pickcheck}"
			},
			//servlet으로 보낼 data 문자열 파라미터 형식, 객체타입 {key:"",key:""}
		success:function(data){ //처리 servlet에서 화면으로 찍어내는 데이터가 응답데이터 response.getWriter().write("data");
			//success에서는 빈하트 처리
			var td = $(obj).parent();
			//console.log(mlTotal);
			td.html("<button type='button' id='btnPick' class='btnPick'; onclick='javascript:unPick(this)'>"+
					"<img id='pick_img' alt='y' src='../images/classpick/star.png' width='30px' height='30px'>"+
					"</button>");
		}		
	});	
}

function wPick(obj){
	alert("찜목록에 등록되었습니다.");
	//ajax 이용해서 처음 체크 로직구현
	$.ajax({
		url:"wpick.do?cno=<%=cno%>", //요청경로 (좋아요 처리할 servlet경로)
		type:"get", //method 타입
		data: 
			{ 	plTotal: "${plTotal}",
				pickcheck: "${pickcheck}"
			},
			//servlet으로 보낼 data 문자열 파라미터 형식, 객체타입 {key:"",key:""}
		success:function(data){ //처리 servlet에서 화면으로 찍어내는 데이터가 응답데이터 response.getWriter().write("data");
			//success에서는 빈하트 처리
			var td = $(obj).parent();			
			
			td.html("<button type='button' id='btnPick' class='btnPick'; onclick='javascript:unPick(this)'>"+
					"<img id='pick_img' alt='n' src='../images/classpick/star.png' width='30px' height='30px'>"+
					"</button>");
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
</script>
<script type="text/javascript" src="https://rawcdn.githack.com/mburakerman/prognroll/0feda211643153bce2c69de32ea1b39cdc64ffbe/src/prognroll.js"></script> 
<script type="text/javascript"> 
//스크롤 레이아웃
$(function() { $("body").prognroll( {height:20, color:"white"} ); 
$(".bar").append( "<div class='bar-container' id='bar-container'><img src='../images/icon/scroll.png'/> </div>");
$(".content").prognroll({ custom:true }); });

window.addEventListener('scroll', () => { let scrollLocation = parseInt(document.documentElement.scrollTop); 
// 현재 스크롤바 위치 
let fullHeight = parseInt(document.body.scrollHeight); 
// 전체 높이(margin 포함 x) 
let repeat = 5; 
// 얼마나 빠르게 회전할지 
let degree = parseInt((scrollLocation)/fullHeight * 360) * repeat; 
let _deg = degree + 'deg'; 
$('#bar-container').css('transform','rotate('+ _deg +')'); })

$(document).ready(function() {
    $('#box').click(function() {
        $(this).find(".hidden").toggleClass('open');
    });
});
</script>
<%@include file="../include/footer.jsp" %>