<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dto.*" %>
<%@include file="../include/header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<link rel="stylesheet" type="text/css" href="../css/table_form.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/qna.css">
<%
String pageno = request.getParameter("page");
String t = request.getParameter("t");
String rpage = request.getParameter("rpage");
if(rpage == null) rpage = "1";
if(t == null) t = "1";
if(pageno == null) pageno="1";

ListDTO ldto = new ListDTO();
ArrayList<QnaVO> nList = ldto.nList();

ArrayList<QnaVO> qList = ldto.qList(Integer.parseInt(pageno), k, t);
ldto.setPerList(5);
%>

<style>
<!-- div css 파일로 빼면 적용이 안 됨 -->
#aBtnDiv{
	background-color:#ffffff;
	outline: 1px solid #E5E5E5;
	width:120px;
	height:35px;
	text-align:center;
}
.ntcDiv{
	margin:0px auto;
	border:1px solid #FFF5CC;
	background-color:#FFF5CC;
	border-radius:10%;
	box-shadow:insert 0 0 8px #deb13a;
}
.ntcTR:hover{
	background-color:#EAEAEA;
}
</style>

<!-- 현재 카테고리 표시 영역 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td colspan="2" style="padding:5px;"><h2><a href="qna.jsp">Q&A</a></h2></td>
	</tr>
	<tr>
		<td style="padding:5px;">잇집 회원들과 지식을 공유하세요!</td>
	</tr>
</table>
<br><br>

<!-- 검색 -->	
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center" >
	<tr>
		<td align="center">
			<form id="searchFrm" name="searchFrm" method="get" action="qna.jsp">
				<input class="searchboxm" type="text" size="80" id="k" name="k" value="<%= k %>" placeholder="검색하세요">
				<img class="imgBtn" src="/teamc2/images/search.png" width="35px" onclick="callSubmit();">
			</form>
		</td>
	</tr>
</table>
<br><br>

<!-- 게시물 정렬, 질문하기 버튼 -->    
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td>
			<select id= "t" name="t" onchange="javascript:orderChange(this)">
				<option value="1" <% if(t.equals("1")) out.print("selected"); %>>최신순</option>
				<option value="2" <% if(t.equals("2")) out.print("selected"); %>>오래된순</option>
				<option value="3" <% if(t.equals("3")) out.print("selected"); %>>조회수순</option>
			</select>
		</td>
		<td align="right">
			<div id="aBtnDiv">		
		<%
		if(user == null){
		%>	
			<a id="aBtn" onclick="check();"  style=" cursor:pointer; ">
				<font id="aColor">질문하기</font>
				<img width="30px" src="/teamc2/images/light1.png"/>
			</a>			
		<%
		}else{
		%>
			<a id="aBtn" onclick()=""href="qWrite.jsp?page=<%= pageno %>">
				<font id="aColor">질문하기</font>
				<img width="30px" src="/teamc2/images/light1.png"/>
			</a>
		<%
		}		
		%>
		</td>
	</tr>
</table>
<br><br>

<!-- 공지사항 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td style="padding:5px;">
			<img width="30px" src="/teamc2/images/light2.png"/> 공지사항
		</td>
	</tr>
	<tr>
		<td style="padding:5px;">활동 전 공지사항을 필독해주세요!</td>
	</tr>
</table>

<div style="width:1000px; align:center;" class="ntcDiv"> <!-- style 적용 위해 div 안에 넣음 -->
	<table style="margin-left: auto; margin-right: auto; border-collapse:collapse;" border="0" width="1000px" align="center">
		<%
		for(int i = 0 ; i < nList.size() ; i++){
			QnaVO notice = nList.get(i);
		%>
		<tr height="30px" class="ntcTR">
			<td width="50px">
				<a href="/teamc2/03qna/view.do?qno=<%= notice.getQno() %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage %>&page=<%= pageno %>">
				[공지]
				</a>
			</td>
			<td>
				<a href="/teamc2/03qna/view.do?qno=<%= notice.getQno() %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage %>&page=<%= pageno %>">
					<%= notice.getTitle() %>
				</a>
			</td>
			<td width="100px" align="right">
				<a href="/teamc2/03qna/view.do?qno=<%= notice.getQno() %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage %>&page=<%= pageno %>">
					hit <%= notice.getHit() %>
				</a>
			</td>
			<td width="120px" align="center">
				<a href="/teamc2/03qna/view.do?qno=<%= notice.getQno() %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage %>&page=<%= pageno %>">
				<%= notice.getDate() %>
				</a>
			</td>
		</tr>
		<%	
		}
		%>
	</table>
</div>

<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr><td class="line" width="100%"><br></td></tr>  <!-- 게시글 마다 구분선 -->
</table>

<!-- 글목록 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr> 
  		<td colspan="2" align="center">
  			<%
  			if(qList.size() == 0) {
  			%>
  			<table style="margin-left: auto; margin-right: auto;" border="0" width="100%" align="center">
  				<tr>
  					<td> <font color="#63A6DB">"<%= k %>"</font>의 검색결과 입니다.
  					</td>
  				</tr>
				<tr align="center">
					<td style="padding:100px 0 20px 0;">
						<img src="/teamc2/images/mypage/emptyFile.png" width="50px">
					</td>
				</tr>
				<tr align="center">
					<td style="padding:20px 0 100px 0;"> 검색 결과가 없습니다. </td>
				</tr>
			<table style="margin-left: auto; margin-right: auto;" border="0" width="100%" align="center">
  			<%
  			}
			for(int i=0; i< qList.size(); i++) {
				QnaVO qna = qList.get(i);
				System.out.println("get확인: ");
				
				//qno를 이용하여 게시물 작성자 프로필 사진을 목록에서 보여줌
				UserinfoDTO dto = new UserinfoDTO();
				String file = dto.getProfile("qna", "qno", qna.getQno());
				QreplyDTO qrdto = new QreplyDTO();
			%>					
				<tr>
					<td>
						<table style="margin-left: auto; margin-right: auto;" border="0" width="100%">
							<tr> <!-- 글 제목 -->
								<td colspan="4" height="45px">
									<a href="/teamc2/03qna/view.do?qno=<%= qna.getQno() %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage %>&page=<%= pageno %>">
									<font size="4" color="navy"><strong><%= qna.getTitle()%></strong></font>
									[<%= qrdto.getRcount(qna.getQno()) %>] <!-- 댓글수 --></a>
								</td>

							</tr>
							
							<tr> <!-- 글 내용 -->
								<td colspan="5" height="45px" style="vertical-align:top;">
									<a href="/teamc2/03qna/view.do?qno=<%= qna.getQno() %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage %>&page=<%= pageno %>">
									<font size="3" color="navy">									
									<%
									if(qna.getBody().length() > 30){
									%>
										<%= qna.getBody().substring(0, 30) %> ...
									<%
									}else{
									%>
										<%= qna.getBody() %>
									<%
									}
									%>
									</font></a>
								</td>
							</tr>
							<tr> <!-- 유저 정보 / 조회수, 날짜 -->
								<td width="800px">
									<img class="imgcircle" alt="프사<%= file %>" src="<%= file %>" height="30px" width="30px">
									<font size="3"><%= qna.getName() %></font>									
								</td>
									
								<td class="hitcell" width="100px" align="right">
									<font size="3"> hit <%= qna.getHit() %></font>
								</td>
								<td width="120px" align="center">
									<font size="3"><%= qna.getDate() %></font>
								</td>
							</tr>
							<tr><td class="line" colspan="3" width="100%"><br></td></tr>  <!-- 게시글 마다 구분선 -->
						</table>
					</td>
				</tr>
				<%
			}
			%>	
			</table>
  		
	  		<!-- 페이징 -->	
			<table style="margin-left: auto; margin-right: auto;" border="0" align="center" width="900px" hight="35px">
				<tr>
					<td align="center">	
						<%
						String kx = URLEncoder.encode(k,"utf-8");
						if( Integer.parseInt(pageno) > 1) {
						%>
							<a class="page_nation" href="qna.jsp?page=<%= Integer.parseInt(pageno) - 1 %>&k=<%= kx %>&t=<%= t %>">이전</a>&nbsp;
						<%
						}else {
						%>
							<a class="page_nation" href="javascript:alert('첫 페이지입니다.');">이전</a>&nbsp;
						<%			
						}
						ldto.getStartPageNo(1);
						
						ldto.getTotal(); //전체 게시물 갯수를 얻는다.
						
						System.out.println("total: "+ldto.getTotal());
						
						ldto.getMaxPageNo();
						ldto.getLastPageNo(Integer.parseInt(pageno));
						
						int startno = ldto.getStartPageNo(Integer.parseInt(pageno));
						int endno   = ldto.getLastPageNo(Integer.parseInt(pageno));
						
						for(int y=startno; y <= endno; y++) {
							
							//현재 페이지에 색깔 넣기
							if(y==Integer.parseInt(pageno)) {
							%>
								<a class="active" href="qna.jsp?page=<%= y %>&k=<%= kx %>&t=<%= t %>"><%= y %></a>&nbsp;<%
							}else {
							%>
								<a class="page_nation" href="qna.jsp?page=<%= y %>&k=<%= kx %>&t=<%= t %>"><%= y %></a>&nbsp;<%								
							}
						}
						
						if( Integer.parseInt(pageno) < ldto.getMaxPageNo()) {
						%>
							<a class="page_nation" href="qna.jsp?page=<%= Integer.parseInt(pageno) + 1 %>&k=<%= kx %>&t=<%= t %>">다음</a>
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


<script>

//a태그(질문하기 글자 or 전구 사진)에 hover시, 형관펜 and 전구 깜빡거림//
$(document).ready(function(){
	$("#aBtn").hover(function(){ 
		//console.log($(this).children("img"));
		$(this).children("font").css({background:'linear-gradient(180deg,rgba(255,255,255,0) 50%, #FFD0AE 50%)'});
		$(this).children("img").attr({src:'/teamc2/images/light2.png'}); //마우스 over
	}, function(){
		$(this).children("font").css({background: 'none'});
		$(this).children("img").attr({src:'/teamc2/images/light1.png'}); //마우스 leave
	});
});

function orderChange(obj){
	//alert($(obj).val());
	if($(obj).val() == "1"){ document.location="qna.jsp?t=1&k=<%= k %>"; }
	if($(obj).val() == "2"){ document.location="qna.jsp?t=2&k=<%= k %>"; }
	if($(obj).val() == "3"){ document.location="qna.jsp?t=3&k=<%= k %>"; }
}

function callSubmit(){
	var k = $("#k").val();
	document.location='qna.jsp?k='+ k ;	
}

function check(){
	if( confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?") != 1){
		return false;		
	}
	document.location="/teamc2/user/noneMembers.jsp";
}
</script>
<%@include file="../include/footer.jsp" %>