<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyAHjxcfoOEe4DievbA8ShZZyajiTXP--Ak" ></script> 
<style> 
#map_ma {width:100%; height:400px; clear:both; border:solid 1px red;} 

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
	width: 500px; 
    height: 200px; 
    overflow: hidden;
}

.parent:hover {
    border:none;
}

.imglow:hover,
.imglow:focus,
.imglow:active {
    transform: scale(1.1);
}	
</style>

<table style="margin-left: auto; margin-right: auto;" border="0" width="1000px" align="center">
	<tr>
		<td>
			<img alt="" src="../images/brand/brand.jpg" width="1000px" >
		</td>
	</tr>
	<tr>
		<td>
			<br><br>
			<table style="margin-left: auto; margin-right: auto;" border="0" width="100%">
				<tr>
					<td height="100px" align="center">
						<font size="2">teamc2</font>
					</td>
				</tr>
				<tr>
					<td height="100px" align="center">
						<font size="5">[ 소셜 커뮤니티 잇집 ]</font>
					</td>
				</tr>
				<tr>
					<td height="100px" align="center">
						<Strong>"안녕하세요. TeamC입니다."</Strong>
					</td>
				</tr>
				<tr>
					<td height="100px" align="center">
						<font size="2" color="#878787">
							"집은 자기 자신의 안식처(Heaven)입니다.<br>
							저희 TeamC에서는 이러한 자기만의 공간을<br>
							단지 쉬는 곳 뿐만 아니라 본인의 개성이 들어가<br>
							Unique한 인테리어들을 공유하고 자랑할 수 있는<br>
							자리를 마련하고 싶었습니다."<br>
						</font>
					</td>
				</tr>
				<tr>
					<td align="center"><br>
						<table>
							<tr>
								<td>
									<img alt="" src="../images/brand/brand1.jpg" height="150px" >
								</td>
								<td>
									<img alt="" src="../images/brand/brand2.png" height="150px" >
								</td>
								<td>
									<img alt="" src="../images/brand/brand3.jpg" height="150px" >
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="150px">
					</td>
				</tr>
				<tr>
					<td height="100px" align="center">
						<font size="5">[ 저희가 만든 잇집이 아닙니다. ]</font>
					</td>
				</tr>
				<tr>
					<td align="center">
						<img alt="" src="../images/brand/brand4.jpg"  height="200px">
					</td>
				</tr>
				<tr>
					<td align="center">
						<br><br>
						<font size="2" color="#878787">
						셀프 인테리어에 관심 있는 사람들의 커뮤니티를 만들어 <br>
						인테리어에 대한 지식을 공유하고 또 지역의 일일 클래스 <br> 
						강의를 연결하여 개인과 지역 사회의 유대감을 기를 수 있습니다. <br>
						</font>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr height="300px">
		<td>
		</td>
	</tr>
	<tr>
		<td>
			찾아오시는길..
		</td>
	</tr>
	<tr>
		<td>
			<div id="map_ma"></div>
		</td>
	</tr>
	<tr>
		<td height="200px">
		</td>
	</tr>
</table>
<script type="text/javascript"> 
	$(document).ready(function() { 
		var myLatlng = new google.maps.LatLng(35.84034225106295, 127.13243088294897); // 위치값 위도 경도 
	var Y_point = 35.84025527752009; 	// Y 좌표 
	var X_point = 127.13248452712745;   // X 좌표 
	var zoomLevel = 18; 		// 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼 
	var markerTitle = "전주시";// 현재 위치 마커에 마우스를 오버을때 나타나는 정보 
	var markerMaxWidth = 300;  	// 마커를 클릭했을때 나타나는 말풍선의 최대 크기 
	// 말풍선 내용 
	var contentString = '<div>' + '<h2>잇집</h2>'+ '<p>안녕하세요. 잇집입니다.</p>' + '</div>'; 
	var myLatlng = new google.maps.LatLng(Y_point, X_point); 
	var mapOptions = { zoom: zoomLevel, center: myLatlng, mapTypeId: google.maps.MapTypeId.ROADMAP } 
	var map = new google.maps.Map(document.getElementById('map_ma'), mapOptions); 
	var marker = new google.maps.Marker({ position: myLatlng, map: map, title: markerTitle }); 
	var infowindow = new google.maps.InfoWindow( { content: contentString, maxWizzzdth: markerMaxWidth } ); google.maps.event.addListener(marker, 'click', function() { infowindow.open(map, marker); }); }); 
</script>


<%@include file="../include/footer.jsp" %>