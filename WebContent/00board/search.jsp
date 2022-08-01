<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/main.css">
<script src="../js/masonry.pkgd.js"></script>
<script src="https://unpkg.com/imagesloaded@4/imagesloaded.pkgd.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<%@page import="vo.*"%>
<%@page import="dto.*"%>

<%
String pageno = request.getParameter("page");
String t = request.getParameter("t");
if(t == null) t = "1";
if(pageno == null) pageno="1";

ListDTO ldto = new ListDTO();
ArrayList<QnaVO> qlist = ldto.qList(Integer.parseInt(pageno),k,t);
int qtotal = ldto.getTotal();
ArrayList<MyroomVO> mlist = ldto.mList(Integer.parseInt(pageno), k, t, user);
int mtotal = ldto.getTotal();
ldto.setPerList(6);
ArrayList<ClassboardVO> clist = ldto.cList(Integer.parseInt(pageno), k, t);
int ctotal = ldto.getTotal();

//MattachDTO adto = new MattachDTO(); 
DCattachDTO cadto = new DCattachDTO(); //클래스 자체 메소드에서 대표이미지를 불러오고 있어서 남겨둬야함

%>
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td>'<%= k %>'에 대한 통합검색 결과 <font color="#6AAFE6"><%= mtotal + qtotal + ctotal %></font></td>
	</tr>
</table>

<br><br><br>

<%
if(mlist.size() == 0 && clist.size() == 0 && qlist.size() == 0){
%>
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr align="center">
		<td style="padding:50px 0 20px 0;">
			<img src="/teamc2/images/mypage/emptyFile.png" width="50px">
		</td>
	</tr>
	<tr align="center">
		<td style="padding:20px 0 100px 0;"> 검색된 게시물이 없습니다. </td>
	</tr>
</table>
<%
}
%>

<!-- 내방 -->
<%
if(mlist.size() != 0){
%>
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td><font size="5"> 내방 </font><font color="#6AAFE6"><%= mtotal %></font></td>
		<td colspan="2" align="right"><a class="view_more" href="../01myroom/myroom.jsp?k=<%= k %>"> 더보기 </a></td>
	</tr>
	<tr>
		<td colspan="3"><hr></td>
	</tr>
<%
}
for(int i=0; i < mlist.size(); i++){
	MyroomVO m = mlist.get(i);
	MattachVO ma = ldto.dImage(m.getNo());		
	
	if(i % 3 == 0){
		%>
		<tr>
		<%
	}
	%>
			<td>
				<div class="divMyroom" id="myroom">
					<div class="block" >
						<br><br>
						<div class="blockimg" onclick="location.href='/teamc2/01myroom/view.do?no=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= pageno %>'" style="cursor:pointer;">
							<img src="<%= ma.getMattach() %>" alt="글번호:<%= ma.getNo() %>" width="250px" height="250px">
						</div>
						<br><br>
						<p>
							<font size="4">
							<%				
							if(m.getTitle().length() > 10){
							%>
							<%= m.getTitle().substring(0, 10) %>...
							<%
							}else{
							%>
								<%= m.getTitle() %>
							<%
							}
							%>
							</font>
							<br><br>
							
						</p>
						<br><br><br>
					</div>
				</div>
				<br><br><br>
			</td>
			<%	
	if(i % 3 == 2){
		%>
		</tr>
		<%
	}
}
%>
</table>

<!--클래스 글 목록 -->
<%
if(clist.size() != 0){
%>
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td><font size="5"> 클래스 </font><font color="#6AAFE6"><%= ctotal %></font></td>
		<td colspan="2" align="right"><a class="view_more" href="../02class/classBoard.jsp?k=<%= k %>"> 더보기 </a></td>
	</tr>
	<tr>
		<td colspan="3"><hr></td>
	</tr>
<%
}
	for(int i=0; i < clist.size(); i++){
		ClassboardVO c = clist.get(i);
		DCattachVO ca = cadto.dImage(c.getCno());	
		
		if(i % 3 == 0){
	%>
	<tr>
	<%
		}				
	%>	
		<td>					
			<a href="/teamc2/02class/view.do?cno=<%= c.getCno() %>&k=<%= k %>&t=<%= t %>&page=<%= pageno %>">
				<img src="<%= ca.getDcattach() %>" style="width:300px; height:300px;" alt="사진번호: <%= ca.getDcno() %> 글번호:<%= ca.getCno() %>">
			</a>		
			<br><br>
			<font size="4">
			<%			
			if(c.getTitle().length() > 20){
			%>
			<%= c.getTitle().substring(0, 20) %>...
			<%
			}else{
			%>
				<%= c.getTitle() %>
			<%
			}					
			%>
			</font>
			<br><br>
			<%
			if(c.getBody().length() > 10){
			%>
				<%= c.getBody().substring(0, 10) %>...
			<%
			}else{
			%>
				<%= c.getBody() %>
			<%
			}
			%>
			<br><br><br>
			<br><br><br><br><br>
			</td>
			<%
			if(i % 3 == 2){
			%>
	</tr>
	<%
			}
		}
	%>
</table>


<!--Q&A 글 목록 -->
<%
if(qlist.size() != 0){
%>
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td><font size="5"> Q&A </font><font color="#6AAFE6"><%= qtotal %></font></td>
		<td align="right"><a class="view_more" href="../03qna/qna.jsp?k=<%= k %>"> 더보기 </a></td>
	</tr>
	<tr>
		<td colspan="2"><hr></td>
	</tr>
	<%
	for(int i=0; i< qlist.size(); i++){
		QnaVO qna = qlist.get(i);
		
		//qno를 이용하여 게시물 작성자 프로필 사진을 목록에서 보여줌
		UserinfoDTO dto = new UserinfoDTO();
		String file = dto.getProfile("qna", "qno", qna.getQno());
		QreplyDTO qrdto = new QreplyDTO();		
	%>
	<tr>
		<td colspan="2">
			<table style="margin-left: auto; margin-right: auto;" border="0" width="100%">
				<tr> <!-- 글 제목 -->
					<td colspan="4" height="45px">
						<a href="/teamc2/03qna/view.do?qno=<%= qna.getQno() %>&k=<%= k %>&t=<%= t %>&rpage=1&page=<%= pageno %>">
						<font size="4" color="navy"><strong><%= qna.getTitle()%></strong></font>
						[<%= qrdto.getRcount(qna.getQno()) %>] <!-- 댓글수 --></a>
					</td>

				</tr>
				
				<tr> <!-- 글 내용 -->
					<td colspan="5" height="45px" style="vertical-align:top;">
						<a href="/teamc2/03qna/view.do?qno=<%= qna.getQno() %>&k=<%= k %>&t=<%= t %>&rpage=1&page=<%= pageno %>">
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
}
%>
</table>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<%@include file="../include/footer.jsp" %>