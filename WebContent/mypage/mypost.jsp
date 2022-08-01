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
ArrayList<MypageVO> mypostlist = (ArrayList<MypageVO>)request.getAttribute("mypostlist");
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
						<a class="cur_active" href="../mypage/mypost.do">내 게시물</a> &nbsp;&nbsp;&nbsp;
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
			<!-- 내 게시물 -->
			<table border="0" class="innertable" width="100%">
				<tr class="tablecol">
					<td class="mytd" colspan="3">내 게시물</td>
				</tr>
				
				<!-- 체크박스 하나라도 선택 시, 삭제 버튼 활성화 -->
				<tr>
					<td colspan="3" align="left">
						<input type="button" class="activeBtn" value="삭제" onclick="doDelete();">
					</td>
				</tr>
				
				<tr>
					<td colspan="3"> <hr width="100%"> </td>   <!-- 구분선 -->
				</tr>
				<tr class="tablecol">
					<td width="30px" align="center">
						<input type="checkbox" id="checkAll" value="checkAll" onclick="cAll();">
					</td>
					<td align="center">TITLE</td>
					<td width="150px" align="center">DATE</td>
				</tr>						
				<tr>
					<td colspan="3"> <hr width="100%"> </td>   <!-- 구분선 -->
				</tr>
				
				<tr height="300px">
					<td colspan="3" class="mytd" style="vertical-align:top;">
						<table border="0" cellpadding="0" cellspacing="0" width="100%" >
						<%
						if(mypostlist.size() == 0){
						%>
							<tr align="center">
								<td style="padding:100px 0 20px 0;">
									<img src="/teamc2/images/mypage/emptyFile.png" width="50px">
								</td>
							</tr>
							<tr align="center">
								<td style="padding:20px 0 100px 0;"> 작성한 게시물이 없습니다. </td>
							</tr>
						<%
						}
						//mypageVO 에서 -> 내가 쓴 글들 (마이룸, 큐앤에이) 불러오기
						for(int i=0; i < mypostlist.size() ; i++){
							MypageVO m = mypostlist.get(i);
							if(m.getType().equals("myroom")){
						%>
							<tr class="mypost">
								<td width="30px" align="center">
									<input type="checkbox" id="no" name="no" value="<%= m.getType() %>:<%= m.getNo() %>">
								</td>
								<td align="left" style="padding:0 0 0 10px;" onclick="location.href='../01myroom/view.do?no=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= ipageno %>'">
									<%=m.getTitle() %>
								</td>
								<td width="150px" onclick="location.href='../01myroom/view.do?no=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= ipageno %>'">
									<%=m.getDate() %>
								</td>			
							</tr>
						<%
							}
							if(m.getType().equals("qna")){
						%>
							<tr class="mypost">
								<td width="30px" align="center">
									<input type="checkbox" id="no" name="no" value="<%= m.getType() %>:<%= m.getNo() %>">
								</td>
								<td align="left" style="padding:0 0 0 10px;" onclick="location.href='../03qna/view.do?qno=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= ipageno %>'">
									<%=m.getTitle() %>
								</td>
								<td width="150px" onclick="location.href='../03qna/view.do?qno=<%= m.getNo() %>&k=<%= k %>&t=<%= t %>&page=<%= ipageno %>'">
									<%=m.getDate() %>
								</td>			
							</tr>
						<%
							}
						}
						%>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
				
	<!--페이징-->		
	<tr>
		<td align="center">	
			<%
			//String kx = URLEncoder.encode(k,"utf-8");
			if( ipageno > 1) {
			%>
				<a class="page_nation" href="mypost.do?page=<%= ipageno - 1 %>">이전</a>&nbsp;
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
					<a class="active" href="mypost.do?page=<%= y %>"><%= y %></a>&nbsp;
				<%
				}else {
				%>
					<a class="page_nation" href="mypost.do?page=<%= y %>"><%= y %></a>&nbsp;
				<%								
				}
			}
			
			if( ipageno < maxpageno){
			%>
				<a class="page_nation" href="mypost.do?page=<%= ipageno + 1 %>">다음</a>
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

<script>
function cAll(){
	if ($("#checkAll").is(':checked')) {
        $("input[type=checkbox]").prop("checked", true);
    } else {
        $("input[type=checkbox]").prop("checked", false);
    }
}

function doDelete(){
	var noList = "";	//체크된 no, type 값을 저장한다
	
	$("input:checkbox[name='no']").each(function(){
		if($(this).prop("checked") == true){
			//여러개 체크된 값이 여러개일 때 구분자(@)를 추가한다
			if(noList != ""){
				noList += "@";
			}
			
			// += : "NoList에 값들을 추가한다 
			noList += $(this).val();
		}
	});	
	
	if(noList == ""){
		alert("삭제 할 게시물을 선택하세요.");
		return;
	}
	if( confirm("정말로 삭제하시겠습니까?") != 1){
		return false;		
	}
	document.location = "pdelete.do?no=" + noList +"&page=<%= ipageno %>";	
}
</script>


<%@include file="../include/footer.jsp" %>