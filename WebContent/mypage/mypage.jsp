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
ArrayList<MypageVO> postlist = (ArrayList<MypageVO>)request.getAttribute("postlist");
ArrayList<MypageVO> replylist = (ArrayList<MypageVO>)request.getAttribute("replylist");

String t = (String)request.getAttribute("t");
int ipageno = (int)request.getAttribute("ipageno");
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
						<a href="../mypage/myclass.do">수강 내역</a>

					</td>
				</tr>
			</table>
			<br><br>
		</td>
	</tr>
	
	<tr>
		<td>
			<table border="0" cellpadding="0" cellspacing="0"  width="100%">
				<tr>
					<!-- 내 정보 박스 -->
					<td width="250px" style="vertical-align:top; padding:5px;">
						<table border="0" class="innertable" cellpadding="0" cellspacing="0" width="100%">
							<tr class="tablecol">
								<td class="mytd" colspan="2">
									<br><img class="profile" src="<%=user.getFile()%>">
								</td>
							</tr>
							<tr class="tablecol">
								<td class="mytd" colspan="2">
									<%= user.getName() %>
								</td>
							</tr>
							<tr class="tablecol">
								<td class="mytd" colspan="2">
									<input class="buttonA" type="button" value="회원정보 변경" onclick="location.href='profileModi.jsp'">
								</td>
							</tr>
							<tr class="tablecol">
								<td class="mytd" colspan="2" >
									<hr width="80%">
								</td>
							</tr>
							<tr class="tablecol">
								<td class="mytd">
									<a href="../mypage/mylike.do">
										<img class="imgcircle" src="/teamc2/images/likepick/heart.png">
									</a>
									<br>좋아요<br>
									<%= mdto.mycount(user.getUno(), "mrelike", "likecheck") %>
								</td>
								<td class="mytd">
									<a href="../mypage/mypick.do">
										<img class="imgcircle" src="/teamc2/images/likepick/class.png">
									</a>
									<br>클래스<br>
									<%= mdto.mycount(user.getUno(), "classpick", "pickcheck") %>
								</td>
							</tr>
							<tr class="tablecol">
								<td class="mytd" colspan="2"></td>
							</tr>
						</table>
					</td>
					
					<!-- 내 게시물, 내 댓글 박스 td -->
					<td style="vertical-align:top; padding:5px;">
					
						<!-- 내 게시물 -->
						<table border="0" class="innertable" width="100%">
							<tr class="tablecol">
								<td class="mytd" colspan="3">내 게시물</td>
							</tr>
							<tr>
								<td colspan="2"> <hr width="100%"> </td>   <!-- 구분선 -->
							</tr>
							<tr class="tablecol">
								<td align="center">TITLE</td>
								<td width="150px" align="center">DATE</td>
							</tr>						
							<tr>
								<td colspan="2"> <hr width="100%"> </td>   <!-- 구분선 -->
							</tr>
							

							<tr height="300px">
								<td colspan="2" class="mytd" style="vertical-align:top;">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" >
									<%
									if(postlist.size()==0){
									%>
										<tr>
											<td style="padding:20px;">
												<img src="/teamc2/images/mypage/emptyFile.png" width="50px">
											</td>
										</tr>
										<tr>
											<td> 작성한 게시글이 없습니다. </td>
										</tr>
									<%
									}
									//mypageVO 에서 -> 내가 쓴 글들 (마이룸, 큐앤에이) 불러오기
									for(int i=0; i < postlist.size() ; i++){
									MypageVO m = postlist.get(i);
										if(m.getType().equals("myroom")){
									%>
										<tr class="mypost" onclick="location.href='../01myroom/view.do?no=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= ipageno %>'">
											<td align="left" style="padding:0 0 0 10px;"><%=m.getTitle() %></td>
											<td width="150px"><%=m.getDate() %></td>			
										</tr>
										<%
										}
										if(m.getType().equals("qna")){
										%>
										<tr class="mypost" onclick="location.href='../03qna/view.do?qno=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= ipageno %>'">
											<td align="left" style="padding:0 0 0 10px;"><%=m.getTitle() %></td>
											<td width="150px"><%=m.getDate() %></td>			
										</tr>
										<%
										}
									}	
									%>										
									</table>
								</td>
							<tr>
								<td colspan="3" align="right">
									<a class="view_more" href="../mypage/mypost.do"> +more </a>
								</td>
							</tr>
						</table>
						
						<br><br><br>  <!-- 내 게시물, 내 댓글 구분 칸 -->
						
						<!-- 내 댓글 -->
						<table border="0" class="innertable" width="100%">
							<tr class="tablecol">
								<td class="mytd" colspan="3">내 댓글</td>
							</tr>
							<tr>
								<td colspan="2"> <hr width="100%"> </td>   <!-- 구분선 -->
							</tr>							
							<tr class="tablecol">
								<td align="center">COMMENT</td>
								<td width="150px" align="center">DATE</td>
							</tr>
							<tr>
								<td colspan="2"> <hr width="100%"> </td>   <!-- 구분선 -->
							</tr>
							
							
							<tr height="300px">
								<td colspan="2" class="mytd" style="vertical-align:top;">
									<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<%
									if(replylist.size()==0){
									%>
										<tr>
											<td style="padding:20px;">
												<img src="/teamc2/images/mypage/question.png" width="50px">
											</td>
										</tr>
										<tr>
											<td> 작성한 댓글이 없습니다. </td>
										</tr>
									<%
									}
									//mypageVO 에서 -> 내가 쓴 댓글 (마이룸, 큐앤에이, 클래스) 불러오기
									for(int i=0; i < replylist.size() ; i++){
										MypageVO m = replylist.get(i);
										if(m.getType().equals("mreply")){
									%>								
										<tr class="mypost" onclick="location.href='../01myroom/view.do?no=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= ipageno %>'">
											<td align="left" style="padding:0 0 0 10px;"><%=m.getTitle() %></td>
											<td width="150px"><%=m.getDate() %></td>			
										</tr>
									<%
										}
										if(m.getType().equals("creply")){
									%>
										<tr class="mypost" onclick="location.href='../02class/view.do?cno=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= ipageno %>'">
											<td align="left" style="padding:0 0 0 10px;"><%=m.getTitle() %></td>
											<td width="150px"><%=m.getDate() %></td>			
										</tr>
									<%
										}
										if(m.getType().equals("qreply")){
									%>
										<tr class="mypost" onclick="location.href='../03qna/view.do?qno=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= ipageno %>'">
											<td align="left" style="padding:0 0 0 10px;"><%=m.getTitle() %></td>
											<td width="150px"><%=m.getDate() %></td>			
										</tr>
									<%
										}
									}
									%>										
									</table>
								</td>
							</tr>
							
							<tr>
								<td colspan="3" align="right">
									<a class="view_more" href="../mypage/myreply.do"> +more </a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%@include file="../include/footer.jsp" %>