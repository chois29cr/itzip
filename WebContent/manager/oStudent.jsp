<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.*"%>
<%@page import="dto.*"%>

<%
ArrayList<StudentVO> sList = (ArrayList<StudentVO>)request.getAttribute("sList");

int startno = (int)request.getAttribute("startno");
int endno = (int)request.getAttribute("endno");
int maxpageno = (int)request.getAttribute("maxpageno");
int total = (int)request.getAttribute("total");
String pageno = (String)request.getAttribute("pageno");
String title = (String)request.getAttribute("title");
System.out.println("input타이틀: "+title);

ManagerDTO mdto = new ManagerDTO();
%>
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
</head>

<body>
<script>
function cAll(){
	if ($("#checkAll").is(':checked')) {
        $("input[type=checkbox]").prop("checked", true);
    } else {
        $("input[type=checkbox]").prop("checked", false);
    }
}


function doDelete(){
	
	//체크된 no,type 값을 저장한다
	var NoList = "";
	
	
	$("input:checkbox[name='no']").each(function()
	{
		
		if($(this).prop("checked") == true) 
		{
			//여러개 체크된 값이 여러개일 때 구분자(@)를 추가한다
			if(NoList != "")
			{
				NoList += "@";
			}
			
			// += : "NoList에 값들을 추가한다 
			NoList += $(this).val();
		}
	});	
	
	if(NoList == "")
	{
		alert("삭제 할 게시물을 선택하세요.");
		return;
	}
	if( confirm("정말로 삭제하시겠습니까?") != 1)
	{
		return false;		
	}
	document.location = "oDelete.do?no=" + NoList +"&page=<%= pageno %>";
}

</script>


<table style="margin-left: auto; margin-right: auto;" border="0" cellpadding="0" cellspacing="0" width="1200px" align="center">
	<tr>
		<td>
			<table border="0" width="100%">
				<tr>
					<td colspan="4" height="50px"><h3>관리자페이지</h3><br></td>
				</tr>
				<tr>
					<td colspan="4"><br></td>
				</tr>
				<tr>						
					<td width="25%" align="center"><a class="cur_pagenation" href="/teamc2/manager/oArticle.do?page=1">게시물관리</a></td>
					<td width="25%" align="center"><a class="cur_pagenation" href="/teamc2/manager/oReply.do?page=1">댓글관리</a></td>
					<td width="25%" align="center"><a class="cur_pagenation"  href="/teamc2/manager/oUser.do?page=1">회원관리</a></td>
					<td width="25%" align="center"><a class="cur_active" href="/teamc2/manager/oDaily.do?page=1">수강생관리</a></td>					 
				</tr>
			</table>
		</td>
	</tr>	
	<tr>
		<td>			
			<br><br><br>
			<!-- 게시물관리 목록 테이블 -->
			<table style="margin-left: auto; margin-right: auto;" border="0" class="boardtable" cellpadding="0" cellspacing="0" width="100%">
				<% 
				System.out.println("목록사이즈:"+sList.size());
				if(sList.size()==0){
					%>
					<tr style="background-color:#f4f4f4;">
					<td class="line" width="100px" height="40px" align="center">
						<input type="checkbox" id="checkAll" value="checkAll" onclick="javascript:cAll();">						
					</td>
					<td class="line" width="100px" align="center">
						번호
					</td>
					<td class="line" width="500px" align="center">
						회원닉네임
					</td>
					<td class="line" width="250px" align="center">
						연락처
					</td>
					<td class="line" width="250px" align="center">
						신청일
					</td>
				</tr>	
				<tr>
					<td colspan="5" align="center" height="40px">
						신청 회원이 없습니다. 
					</td>
				</tr>
					<%
				}else{
					
					
					%>
					<tr>
						<td height="40px" class="line" colspan="5" align="left">
							신청클래스: <strong><%= title %></strong>
						</td>	
					</tr>
					<tr style="background-color:#f4f4f4;">
						<td class="line" width="100px" height="40px" align="center">
							<input type="checkbox" id="checkAll" value="checkAll" onclick="javascript:cAll();">						
						</td>
						<td class="line" width="100px" align="center">
							번호
						</td>
						<td class="line" width="500px" align="center">
							회원닉네임
						</td>
						<td class="line" width="250px" align="center">
							연락처
						</td>
						<td class="line" width="250px" align="center">
							신청일
						</td>
					</tr>
					<%	
					for(int i=0; i< sList.size(); i++) {
						StudentVO vo = (StudentVO)sList.get(i);
						int seqno = total - ((Integer.parseInt(pageno) - 1) * 10);
					%>
					<tr>
						<td class="line" width="100px" height="40px" align="center">
							<input type="checkbox" id="no" name="no" value="" >						
						</td>
						<td class="line" width="100px" align="center">
							<%= seqno - i %>
						</td>
						<td class="line" width="500px" align="center">
							<%= vo.getName() %>
						</td>
						<td class="line" width="250px" align="center">
							<%= vo.getPhone() %>
						</td>
						<td class="line" width="250px" align="center">
							<%= vo.getDate() %>
						</td>
					</tr>
					<%
					}
				}
					%>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="right">
			<br><input type="button" class="buttonA" value="삭제" onclick="javascript:doDelete();">
		</td>
	</tr>
	<tr>
		<td align="center">	
			<%
			//String kx = URLEncoder.encode(k,"utf-8");
			if( Integer.parseInt(pageno) > 1) {
			%>
				<a class="page_nation" href="oReply.do?page=<%= Integer.parseInt(pageno) - 1 %>">이전</a>&nbsp;
			<%
			}else {
			%>
				<a class="page_nation" href="javascript:alert('첫 페이지입니다.');">이전</a>&nbsp;
			<%			
			}
			for(int y=startno; y <= endno; y++) {
				
				//현재 페이지에 색깔 넣기
				if(y==Integer.parseInt(pageno)) {
				%>
					<a class="active" href="oReply.do?page=<%= y %>"><%= y %></a>&nbsp;<%
				}else {
				%>
					<a class="page_nation" href="oReply.do?page=<%= y %>"><%= y %></a>&nbsp;<%								
				}
			}
			if( Integer.parseInt(pageno) < maxpageno) {
			%>
				<a class="page_nation" href="oReply.do?page=<%= Integer.parseInt(pageno) + 1 %>">다음</a>
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