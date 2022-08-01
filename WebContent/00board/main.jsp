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
ArrayList<MyroomVO> mlist = ldto.mList(Integer.parseInt(pageno), k, t, user);

ldto.setPerList(3);
ArrayList<ClassboardVO> clist = ldto.cList(Integer.parseInt(pageno), k, t);

MattachDTO adto = new MattachDTO(); 
DCattachDTO cadto = new DCattachDTO(); 

%>
<style>
.btn1 {
  position:absolute;
  top:450px;
  left:750px;
  z-index:10;
}
.btn2 {
  position:absolute;
  top:450px;
  left:870px;
  z-index:10;
}

.btncss{
	outline: none;
	border-radius: 25px;
	background-color:#644E41;
	color:#000000;
	border:none;
	text-align:center;
	width:100px;
	height:30px;	
	display:inline-block;
	cursor:pointer;
	margin:3px;
}

.btncss:hover{
	color:#FBE9D0;
}
</style>

<script>
$(document).ready(function() {
	var $grid = $('#myroom').imagesLoaded( function() {
		  $grid.masonry({
		      itemSelector: '.block',
		      fitwidth: true
		  });
	});
});

</script>

<!-- 메인 배너 이미지 슬라이드 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td height="550px;">
			<div class="slideshow-container banner">

				<div class="mySlides fade banner">
					<img class="slideimg" src="../images/main_banner/banner1.png" width="1000px;">
				    <button class="btn1 btncss" type="button" onclick="location.href='/teamc2/04brand/story.jsp'">잇집 이야기</button>
					<button class="btn2 btncss" type="button" onclick="location.href='/teamc2/01myroom/myroom.jsp'">랜선 집구경</button>
				</div>
				
				<div class="mySlides fade banner">
					<img class="slideimg" src="../images/main_banner/banner2.png" width="1000px;">
				    <button class="btn1 btncss" type="button" onclick="location.href='/teamc2/04brand/story.jsp'">잇집 이야기</button>
					<button class="btn2 btncss" type="button" onclick="href='/teamc2/01myroom/myroom.jsp'">랜선 집구경</button>
				</div>
				
				<div class="mySlides fade banner">
					<img class="slideimg" src="../images/main_banner/banner3.png" width="1000px;">
				    <button class="btn1 btncss" type="button" onclick="location.href='/teamc2/04brand/story.jsp'">잇집 이야기</button>
					<button class="btn2 btncss" type="button" onclick="href='/teamc2/01myroom/myroom.jsp'">랜선 집구경</button>
				</div>
			</div>
			
			<br>
		</td>
	<tr>
		<td>
			<div class="banner" style="text-align:center">
			 	<span class="dot"></span> 
			 	<span class="dot"></span> 
				<span class="dot"></span> 
			</div>
		</td>
	</tr>
</table>

<!-- 내방 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td><font size="5"> 내방 </font></td>
		<td align="right"><a class="view_more" href="../01myroom/myroom.jsp"> 더보기 </a></td>
	</tr>
	<tr>
		<td colspan="2"><hr></td>
	</tr>
	<tr>
		<td colspan="2">
			<div class="divMyroom" id="myroom">
				<%
				for(int i=0; i < mlist.size(); i++){
					MyroomVO m = mlist.get(i);
					MattachVO ma = ldto.dImage(m.getNo());			
				%>	
				<div class="block">
					<br><br>			
					<div class="blockimg" onclick="location.href='/teamc2/01myroom/view.do?no=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= pageno %>'" style="cursor:pointer;">
						<img src="<%= ma.getMattach() %>" alt="[<%= m.getTexture() %>] <%= m.getTitle() %>" title="<%= m.getTitle() %>">
					</div>
					<br><br>
					<font size="4">
					<%			
					if(m.getTitle().length() > 10){
					%>
					[<%= m.getTexture() %>] <%= m.getTitle().substring(0, 10) %>...
					<%
					}else{
					%>
						[<%= m.getTexture() %>] <%= m.getTitle() %>
					<%
					}					
					%>
					</font>
					<br><br><br>
				</div>
				<%
				}
			%>
			</div>
		</td>
	</tr>
</table>


<!--클래스 글 목록 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td><font size="5"> 클래스 </font></td>
		<td colspan="2" align="right"><a class="view_more" href="../02class/classBoard.jsp"> 더보기 </a></td>
	</tr>
	<tr>
		<td colspan="3"><hr><br></td>		
	</tr>
	<%
	
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
				<img src="<%= ca.getDcattach() %>" style="width:300px; height:300px;" alt="<%= c.getTitle() %>" title="<%= c.getTitle() %>">
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


<br><br><br><br><br>

<!-- 게시판 정보 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td colsplan="2"><font size="5"> Q&A </font></td>
		<td align="right"><a class="view_more" href="/teamc2/03qna/qna.jsp"> 더보기 </a></td>
	</tr>
	<tr>
		<td colspan="2"><hr></td>
	</tr>
</table>




<!--Q&A 글 목록 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<%
	for(int i=0; i< qlist.size(); i++){
		QnaVO qna = qlist.get(i);
		
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
	%>	
</table>

<script type="text/javascript">
	var slideIndex = 0;
	showSlides();

	function showSlides() {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("dot");
    for (i = 0; i < slides.length; i++) {
       slides[i].style.display = "none";  
    }
    slideIndex++;
    if (slideIndex > slides.length) {slideIndex = 1}    
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }
    slides[slideIndex-1].style.display = "block";  
    dots[slideIndex-1].className += " active";
    setTimeout(showSlides, 3000); // Change image every 2 seconds
	}
</script>

<%@include file="../include/footer.jsp" %>