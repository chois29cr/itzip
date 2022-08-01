<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dto.*" %>    

<%@ page import="java.util.ArrayList" %>    
<link rel="stylesheet" type="text/css" href="../css/q_boardLayer.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<%
UserinfoVO user = (UserinfoVO)session.getAttribute("user"); 
String k = request.getParameter("k");
if(k == null) k = "";

String t = (String)request.getAttribute("t");
String pageno = (String)request.getAttribute("pageno");
int rpage = (int)request.getAttribute("rpage");

int total = (int)request.getAttribute("total"); 
int startno = (int)request.getAttribute("startno");
int endno = (int)request.getAttribute("endno");
int maxpageno = (int)request.getAttribute("maxpageno");
ArrayList<QreplyVO> qrList = (ArrayList<QreplyVO>)request.getAttribute("qrList");

String qno = request.getParameter("qno");
%>

<form id="viewFrm" name="viewFrm" method="post">
	<!-- 댓글 내용 테이블 -->
	<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
		<tr>
			<td id="rTotal">
				댓글 <%= total %><br><br>
				<hr width="99%" align="center"><br>
			</td>
		</tr>
	</table>
	
	<!-- 댓글 작성 폼 -->
	<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
		<tr>			
			<td>
			<input type="hidden" id="qnoHidden" name="qnoHidden" value="<%= qno %>">
			</td>
			<td width="120px">
			<%
			if (user == null){
			%>
			
			<img class="imgcircle" src="/teamc2/images/profile_image/profile1.png">
			
			<%
			}else {
			%>	
			<img class="imgcircle" src="<%= user.getFile() %>"> <%= user.getName() %>
			<%
			}
			%>
			</td>
			<td align="center"><input class="rebox" type="text" id="qre" name="qre" size="100%" placeholder="댓글을 입력하세요.">
			</td>
			<td align="right">
				<input class="buttonA" type="submit" value="등록" onclick="callSubmit(); return false;">
			</td>
		</tr>
	</table>
	
	<br>
	
	<!-- 댓글 수정 버튼 클릭 후 취소 누르고 원래대로 폼이 돌아올 때 사용되는 것  -->
	<table id="mReply" style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
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
			<td width="250px" align="right"> 
				<%
				if (user == null){
				%>
				<%
				}else {
				%>	
				<%
				if(user.getUno() == qr.getUno()){
				%>
				<input class="buttonC" type="button" value="수정" onclick="editTable(this);">
				<input class="buttonC" type="button" value="삭제" onclick="replyDelete(<%= qno %>,<%= qr.getQreno() %>);">
				<%
				}
				}
				%>
			</td>
		</tr>
		<tr>
			<td class="sfont" align="right" colspan="4">
				<%= qr.getQredate() %>
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
					<a class="page_nation" href="/teamc2/03qna/view.do?qno=<%= qno %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage - 1 %>&page=<%= pageno %>">이전</a>&nbsp;
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
						<a class="active" href="/teamc2/03qna/view.do?qno=<%= qno %>&k=<%= k %>&t=<%= t %>&rpage=<%= y %>&page=<%= pageno %>"><%= y %></a>&nbsp;<%
					}else {
					%>
						<a class="page_nation" href="/teamc2/03qna/view.do?qno=<%= qno %>&k=<%= k %>&t=<%= t %>&rpage=<%= y %>&page=<%= pageno %>"><%= y %></a>&nbsp;<%								
					}
				}
				
				if(rpage < maxpageno) {
				%>
					<a class="page_nation" href="/teamc2/03qna/view.do?qno=<%= qno %>&k=<%= k %>&t=<%= t %>&rpage=<%= rpage + 1 %>&page=<%= pageno %>">다음</a>
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
	
</form>
