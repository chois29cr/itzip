<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="vo.*" %> 
   
<%
String k = (String)request.getAttribute("k");
String t = (String)request.getAttribute("t");
String pageno = (String)request.getAttribute("pageno");
int rpage = (int)request.getAttribute("rpage");
ArrayList<MyroomVO> addList = (ArrayList<MyroomVO>)request.getAttribute("addList");

ListDTO ldto = new ListDTO();


for(int i=0; i < addList.size(); i++){
	MyroomVO m = addList.get(i);
	
	MreplyDTO rdto = new MreplyDTO();
	int rTotal = rdto.getRcount(m.getNo());
	
	MrelikeDTO mdto = new MrelikeDTO();
	int mlTotal = mdto.getTotal(m.getNo());

	MattachVO ma = ldto.dImage(m.getNo());
	
	if(!k.equals("") && addList.size() == 0) {
	%>
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
	<%
	}	
	if(i % 3 == 0){
	%>
		<tr>
	<%
	}
		%>
			<td width="300px">
				<div class="img" >				
				<div class="parent">
					<a href="/teamc2/01myroom/view.do?no=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= pageno %>&rpage=<%= rpage %>">
						<img class="imglow" src="<%= ma.getMattach() %>" width="300px" height="300px" alt="[<%= m.getTexture() %>]<%= m.getTitle() %>" title="<%= m.getTitle() %>">
					</a>
				</div>
				<div class="content" style="width:100px">
				조회수 <%= m.getHit() %>
				</div>
				</div>
					<font size="3">
						<strong>[<%= m.getTexture() %>] 
						<%			
						if(m.getTitle().length() > 15){
						%>
							<%=m.getTitle().substring(0, 15) %>...
						<%
						}else{
						%>
							<%=m.getTitle() %>
						<%
						}					
						%>
						</strong>
					</font>
					<br>
					<font size="3"><%= m.getName() %></font>
					<br>
					<img src="/teamc2/images/likepick/heart.png" width="20px" height="20px">&nbsp;<%= mlTotal %> &nbsp;&nbsp;&nbsp;&nbsp; 댓글 <%= rTotal %> &nbsp;&nbsp;&nbsp;&nbsp; 
				</p>
				<br>
			</td>
			<%
	if(i % 3 == 2){
			%>
		</tr>
	<%
	}
}
	%>
	
<style>
  .img{
    position: relative; 
    width: 300px;                                                        
    height: 300px;
    background-size: cover;
 
  }

  .img .content{
     position: absolute;
     top:100%;
     right:100%;
     transform: translate(290px, -25px);                                                                   
     font-size:15;
     color: white;
     text-shadow: 1px 1px 1px gray; 
     z-index: 2;
     text-align: right;
  }
  
  p {
  	line-height: 170%; 
  }
  
/* Grow */
.imglow {
    display: inline-block;
    vertical-align: middle;
    transform: translateZ(0);
    box-shadow: 0 0 1px rgba(0, 0, 0, 0);
    backface-visibility: hidden;
    -moz-osx-font-smoothing: grayscale;
    transition-duration: 0.3s;
    transition-property: transform;
}

.parent {
	width: 300px; 
    height: 300px; 
    overflow: hidden;
}

.parent:hover {
    border:2px solid #6AAFE6;
}

.imglow:hover,
.imglow:focus,
.imglow:active {
    transform: scale(1.1);
}
</style>  