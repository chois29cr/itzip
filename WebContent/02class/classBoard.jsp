<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<%@ page import="vo.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>

<link rel="stylesheet" type="text/css" href="../css/table_form.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/classBoard.css">

<%
String pageno = request.getParameter("page");
if(pageno == null) pageno="1";
String t = request.getParameter("t");
if(t == null) t = "1";

ListDTO ldto = new ListDTO();
ldto.setPerList(16);
ArrayList<ClassboardVO> cList = ldto.cList(Integer.parseInt(pageno), k, t);

DCattachDTO cadto = new DCattachDTO();

if (user == null) {
}else {
	ArrayList<ClassboardVO> pn = ldto.pList(Integer.toString(user.getUno()));
	
	if (pn == null) {		
	}else {
	%>	
	<table border="0" class="jjimTable" border="0">
		<tr>
			<td align="center" width="120px">
				<img id="pick_img" alt="n" src="../images/classpick/empty_star.png" width="20px" height="20px">찜목록
			</td>
		<tr>
		<%
		for(int i=0; i<pn.size(); i++){
			
			ClassboardVO c = new ClassboardVO();
			c = pn.get(i);
			String title = c.getTitle();
			
			if(title.length() >5){						
				title  = "<span title='"+title+"'>" + title.substring(0,10);
				title += "<font color=#ffffff>...</font></span>";
			}
		%>
		<tr>
			<td class="jjim" align="left">
				<a href="/teamc2/02class/view.do?cno=<%= c.getCno() %>&k=<%= k %>&t=<%= t %>&page=<%= pageno %>"><font size="1">●</font><font size="2"><%= title %></font></a>
			</td>
		<tr>
		<%
			}
		%>
	</table>
	<%
	}
}
%>

<!-- 현재 카테고리 표시 영역 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td colspan="2" style="padding:5px;"><h2><a href="classBoard.jsp">클래스</a></h2></td>
	</tr>
	<tr>
		<td style="padding:5px;">요즘 사람들은 이런 즐거움을 찾고있어요!</td>
	</tr>
</table>
<br><br>

<!-- 검색 -->	
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center" >	
	<tr>
		<td align="center">
			<form id="searchFrmC" name="searchFrmC" method="get" action="classBoard.jsp">
				<input class="searchboxm" type="text" size="80" id="k" name="k" value="<%= k %>" placeholder="검색하세요">					
			 	<img class="imgBtn" src="/teamc2/images/search.png" width="35px" onclick="javascript:callSubmit(this);"> 
			</form>
		</td>
	</tr>
</table>

<br><br>

<!-- 게시물 리스트 -->    
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
		<%
			if (user != null) {
				if ( user.getIsadmin().equals("Y") ) {
		%>	
						<input class="buttonA" type="button" value="클래스등록하기" onclick="document.location='cWrite.jsp?page=<%= pageno %>';">
				<%
				}
		
			}
				%>
		</td>
	</tr>

<% 
if(!k.equals("")) {
	%>
	<tr>
		<td><br><br> <font color="#63A6DB">"<%= k %>"</font>의 검색결과 입니다.
		</td>
	</tr>
  		  		
<% 
}
if(cList.size() == 0) {
	%>
	<tr align="center">
		<td colspan="3" style="padding:100px 0 20px 0;">
			<img src="/teamc2/images/mypage/emptyFile.png" width="50px">
		</td>
	</tr>
	<tr align="center">
		<td style="padding:20px 0 100px 0;"> 검색 결과가 없습니다. </td>
	</tr>

<%
}
%>

	<tr> 
  		<td colspan="2" align="center">
  		<br><br><br>
<%  		
			for(int i=0; i < cList.size(); i++) {
				
				ClassboardVO c = cList.get(i);
				String title = c.getTitle();
				DCattachVO ca = cadto.dImage(c.getCno());
				
					
				if(title.length() >15){						
					title  = "<span title='"+title+"'>" + title.substring(0,15);
					title += "<font color=#000000>...</font></span>";
				}
%>
			<div style="width:250px; float: left;">
				<table style="margin-left: auto; margin-right: auto;" border="0" width="200px" align="center">
					<tr>
						<td>
							<table style="margin-left: auto; margin-right: auto;" border="0" width="100%">
								<tr>
									<td>
										<div class="parent">
											<a class="jc" href="/teamc2/02class/view.do?cno=<%= c.getCno() %>&k=<%= k %>&t=<%= t %>&page=<%= pageno %>">
											<img class="imglow" src="<%= ca.getDcattach() %>" width="200px" height="200px" alt="<%= c.getTitle() %>" title="<%= c.getTitle() %>"></a>
										</div>
									</td>									
								</tr>
								<tr>
									<td height="30px" ><a class="jc" href="/teamc2/02class/view.do?cno=<%= c.getCno() %>&k=<%= k %>&t=<%= t %>&page=<%= pageno %>">
										<strong><%= title %></strong></a>
									</td>
								</tr>
							</table>
							<table style="margin-left: auto; margin-right: auto;" border="0" width="100%" align="center">
								<tr>
									<td class="hitcell" width="50px" align="left"><font size="3">hit <%= c.getHit() %></font></td>
									<td width="100px" align="right"><font size="3"><%= c.getDate() %></font></td>
								</tr>
								<tr><td colspan="2" class="line" width="100%"><br></td></tr>  <!-- 글마다 구분선 -->
							</table>
						</td>
					</tr>
				</table>
			</div>	
			<%
				
			}
			%>
			
	  		<!-- 페이징 -->	
			<table style="margin-left: auto; margin-right: auto;" border="0" align="center" width="1000px" height="35px">		
				<tr>
					<td align="center">	
						<%
						String kx = URLEncoder.encode(k,"utf-8");
						
						if( Integer.parseInt(pageno) > 1) {
						%>
							<a class="page_nation" href="classBoard.jsp?page=<%= Integer.parseInt(pageno) - 1 %>&k=<%= kx %>&t=<%= t %>">이전</a>&nbsp;
						<%
						}else {
						%>
							<a class="page_nation" href="javascript:alert('첫 페이지입니다.');">이전</a>&nbsp;
						<%			
						}
						ldto.getStartPageNo(1);
						
						ldto.getTotal(); //전체 게시물 갯수를 얻는다.
						
						System.out.println("클래스 total: "+ldto.getTotal());
						
						ldto.getMaxPageNo();
						ldto.getLastPageNo(Integer.parseInt(pageno));
						
						int startno = ldto.getStartPageNo(Integer.parseInt(pageno));
						int endno   = ldto.getLastPageNo(Integer.parseInt(pageno));
						
						for(int y=startno; y <= endno; y++) {
							
							//현재 페이지에 색깔 넣기
							if(y==Integer.parseInt(pageno)) {
							%>
								<a class="active" href="classBoard.jsp?page=<%= y %>&k=<%= kx %>&t=<%= t %>"><%= y %></a>&nbsp;<%
							}else {
							%>
								<a class="page_nation" href="classBoard.jsp?page=<%= y %>&k=<%= kx %>&t=<%= t %>"><%= y %></a>&nbsp;<%								
							}
						}
						
						if( Integer.parseInt(pageno) < ldto.getMaxPageNo()) {
						%>
							<a class="page_nation" href="classBoard.jsp?page=<%= Integer.parseInt(pageno) + 1 %>&k=<%= kx %>&t=<%= t %>">다음</a>
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
function orderChange(obj){
	//alert($(obj).val());
	
	if($(obj).val() == "1"){
		document.location="classBoard.jsp?t=1&k=<%= k %>";
	}
	if($(obj).val() == "2"){
		document.location="classBoard.jsp?t=2&k=<%= k %>";
	}
	if($(obj).val() == "3"){
		document.location="classBoard.jsp?t=3&k=<%= k %>";
	}
}
function callSubmit(obj){
	var k = $(obj).prev().val();
	console.log(k);
	document.getElementById("searchFrmC").submit();
}

</script>

<%@include file="../include/footer.jsp" %>