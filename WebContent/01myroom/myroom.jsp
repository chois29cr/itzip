<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="vo.*"%>
<%@include file="../include/header.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>

<link rel="stylesheet" type="text/css" href="../css/q_boardLayer.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">

<%
String pageno = request.getParameter("page");
String t = request.getParameter("t");  
if(t == null) t = "1";
if(pageno == null) pageno="1";

%>

<style>
select {
width: 100px;
padding: .8em .5em;
border: 1px solid #CADBE9;
background: url('../images/arrow.jpg') no-repeat 95% 50%;
border-radius: 0px;
-webkit-appearance: none;
-moz-appearance: none;
appearance: none;
}
select:focus {outline:2px solid #6AAFE6;}
select::-ms-expand {
    display: none;
}
</style>

<script>
	function orderChange(obj){
		//alert($(obj).val());
		
		if($(obj).val() == "1"){
			document.location="myroom.jsp?t=1&k=<%= k %>";
		}
		if($(obj).val() == "2"){
			document.location="myroom.jsp?t=2&k=<%= k %>";
		}
		if($(obj).val() == "3"){
			document.location="myroom.jsp?t=3&k=<%= k %>";
		}
	}
	
</script>

<!-- 현재 카테고리 표시 영역 -->
<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td colspan="2" style="padding:5px;"><h2><a href="myroom.jsp">내방</a></h2></td>
	</tr>
	<tr>
		<td style="padding:5px;">혼자서도 잘해요! 금손들의 노하우</td>
	</tr>
</table>
<br><br>

<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td colspan="3" align="left">
			<select id= "t" name="t" onchange="javascript:orderChange(this)">
				<option value="1" <% if(t.equals("1")) out.print("selected"); %>>최신순</option>
				<option value="2" <% if(t.equals("2")) out.print("selected"); %>>오래된순</option>
				<option value="3" <% if(t.equals("3")) out.print("selected"); %>>관심사순</option>	
			</select>
			<br><br><br>
		</td>
		<td align="right">
		<%
		if (user == null) {
		%>	
			<input type="button" class="buttonA"  onclick="check();" value="내방 자랑하기">
		<%
		}else{
		%>
			<input type="button" class="buttonA" onclick="document.location='mWrite.jsp?page=<%= pageno %>'" value="내방 자랑하기">
		<%
		}	
		%>
		</td>
	</tr>
</table>

<div class="list" id="test">
	<table id="boardList" style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	</table>
</div>

<script>
/*
$("body").css("overflow-y","hidden");
$("#test").css("height","800px").css("overflow-y","auto");
var flagScroll = true;
$("#test").scroll(function(){
	console.log($("#test table").height()-$("#test").height());
	console.log($("#test").scrollTop());
	console.log($("#test").height());
	if($("#test").scrollTop()+10 > $("#test table").height()-$("#test").height()){
		if(flagScroll){
			console.log("당첨!");
			//당첨: 스크롤이 바닥에 도달하면 다음(페이지) 목록을 불러온다.
			GetBoardList();		
		}
	}
});

var flagScroll = true;
$("#test").scroll(function(){    
	consol.log($("#test").scrollTop());
	consol.log($(document).height() - $("#test").height());
    if ( $("#test").scrollTop() >= $(document).height() - $("#test").height() ){
        console.log('끝입니다!.');    
        if(flagScroll){ 
        	GetBoardList();	
        }
    }
});
*/

var pageno = 1;

$(window).scroll(function() {
    if ($(window).scrollTop() >= $(document).height() - $(window).height()) {
      console.log(++pageno);      
      GetBoardList();
    }
});

function GetBoardList()
{
	mydata = "page=" + pageno + "&k=<%= k %>&t=<%= t %>";
	$.ajax({
		//url:"mAdd.do", //요청경로 (좋아요 처리할 servlet경로)
		url:"mAdd.do", //요청경로 (좋아요 처리할 servlet경로)	
		type:"get", //method 타입
		data: mydata,
		success:function(data){ //처리 servlet에서 화면으로 찍어내는 데이터가 응답데이터 response.getWriter().write("data");
			//success에서는 빈하트 처리
			$("#boardList").append(data.trim());
		}		
	});		
}

$(document).ready(function(){	
	GetBoardList();		
}); 

function check(){
	if( confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?") != 1){
		return false;		
	}
	document.location="/teamc2/user/noneMembers.jsp";
}
</script>
</body>

</html>
