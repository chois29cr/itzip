<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.*"%>
<%@page import="dto.*"%>
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
<%
MypageDTO mdto = new MypageDTO();
ArrayList<StudentVO> sList = (ArrayList<StudentVO>)request.getAttribute("sList");
String t = (String)request.getAttribute("t");
int ipageno = (int)request.getAttribute("ipageno");
int startno = (int)request.getAttribute("startno");
int endno = (int)request.getAttribute("endno");
int maxpageno = (int)request.getAttribute("maxpageno");
int total = (int)request.getAttribute("total");
%>

<table style="margin-left: auto; margin-right: auto;" cellpadding="0" cellspacing="0" width="1000px" align="center">
	<tr>
		<td>
			<table border="0" width="100%">
				<tr>
					<td colspan="2" style="padding:5px;"><h3><a href="../mypage/mypageHome.do">마이페이지</a></h3></td>
				</tr>
				<tr>
					<td colspan="2" style="padding:5px;">
						<a href="../mypage/profileModi.jsp">내 정보</a> &nbsp;&nbsp;&nbsp;					
						<a href="../mypage/mypost.do">내 게시물</a> &nbsp;&nbsp;&nbsp;
						<a href="../mypage/myreply.do">내 댓글</a> &nbsp;&nbsp;&nbsp;
						<a href="../mypage/mylike.do">좋아요</a> &nbsp;&nbsp;&nbsp;
						<a href="../mypage/mypick.do">찜한 클래스</a> &nbsp;&nbsp;&nbsp;
						<a class="cur_active" href="../mypage/myclass.do">수강 내역</a> 
					</td>
				</tr>
			</table>
			<br><br>
		</td>
	</tr>
	<tr>
		<td>
			<div style="padding: 0 0 5px 0;">
				<font color="#63A6DB"><%= user.getName()%></font> 님이 수강신청한 클래스 내역입니다.
			</div>
			<div style="padding: 0 0 5px 0;">
				<font color="#63A6DB"><%= total %></font> 개의 결과가 조회되었습니다.
			</div>
		</td>
	</tr>	

	<tr>
		<td>
			<!-- 수강신청 한 클래스 -->
			<table border="0" class="innertable" width="100%">
				<tr class="tablecol">
					<td class="mytd" colspan="3">수강 내역</td>
				</tr>
				<tr>
					<td colspan="3"> <hr width="100%"> </td>   <!-- 구분선 -->
				</tr>
				<%
				if(sList.size()==0){
				%>
				<tr align="center" >
					<td style="padding:100px 0 20px 0;">
						<img src="/teamc2/images/mypage/noheart.png" width="50px">
					</td>
				</tr>
				<tr align="center">
					<td style="padding:20px 0 100px 0;"> 수강신청한 클래스가 없습니다. </td>
				</tr>
				<%
				}else{
				%>
				<tr class="tablecol">
					<td width="50px" align="center">NO</td>
					<td align="center">TITLE</td>
					<td width="150px" align="center">DATE</td>
				</tr>
				<tr>
					<td colspan="3"> <hr width="100%"> </td>   <!-- 구분선 -->
				</tr>
				<tr height="300px">
					<td colspan="3" class="mytd" style="vertical-align:top;">
						<table border="0" cellpadding="0" cellspacing="0" width="100%">					
						<%
						for(int i=0; i<sList.size(); i++){
							StudentVO s = sList.get(i);
							int seqno = (total - (ipageno - 1) * 10);
						%>
							<tr class="mypost">
								<td width="50px" align="center">
									<%= seqno - i %>
								</td>
								<td align="left" style="padding:0 0 0 10px;" onclick="location.href='../02class/view.do?cno=<%= s.getCno() %>&k=<%= k %>&t=<%= t %>&page=<%= ipageno %>&rpage=1'">
									<%= s.getTitle() %>
								</td>
								<td width="150px" onclick="location.href='../02class/view.do?cno=<%= s.getCno() %>&k=<%= k %>&t=<%= t %>&page=<%= ipageno %>&rapge=1'">
									<%= s.getDate() %>
								</td>			
							</tr>
							<%
						}
							%>
						</table>
					</td>
				</tr>
				<%
				}
				%>
			</table>
		</td>
	</tr>
	
	<!--페이징-->		
	<tr>
		<td colspan="3" align="center">	
			<%
			//String kx = URLEncoder.encode(k,"utf-8");
			if( ipageno > 1) {
			%>
				<a class="page_nation" href="myclass.do?page=<%= ipageno - 1 %>">이전</a>&nbsp;
			<%
			}else {
			%>
				<a class="page_nation" href="javascript:alert('첫 페이지입니다.');">이전</a>&nbsp;
			<%			
			}
	
			//현재 페이지에 색깔 넣기
			for(int y=startno; y <= endno; y++) {
				if(y==ipageno) {
			%>
					<a class="active" href="myclass.do?page=<%= y %>"><%= y %></a>&nbsp;
				<%
				}else {
				%>
					<a class="page_nation" href="myclass.do?page=<%= y %>"><%= y %></a>&nbsp;
				<%								
				}
			}
			
			if( ipageno < maxpageno){
			%>
				<a class="page_nation" href="myclass.do?page=<%= ipageno + 1 %>">다음</a>
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
<%@include file="../include/footer.jsp" %>