<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!-- Site info -->
	<title>DreamPing</title>
	<meta name="description" content="끔꿔왔던 캠핑의 모든것 드림핑">
	<meta name="author" content="hongpang">
	<meta name="designer" content="hongpang / lifegoesondesign">
	<meta name="dcterms.rightsHolder" content="더드림핑">
	<meta name="keywords" content="드림핑 카바나 카라반 글램핑 서핑 플로라이더 수상레저">
	
	<!-- Icons -->
	<link rel="shortcut icon" href="ico/favicon.ico">
	<link rel="apple-touch-icon-precomposed" href="ico/apple-touch-icon.png">
	<meta property="og:image" content="ico/thumbnail.png"/>
	
	<!-- Main Scripts -->
	<script src="js/jquery-1.10.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	<!-- Style -->
	<link rel="stylesheet" href="css/bootstrap.css?ver=2">
	<link rel="stylesheet" href="css/bootstrap-theme.css">
	<link rel="stylesheet" href="css/custom.css?ver=2">
	
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- google map api -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC77RaVRaZvkNrzi60j_-ls2R7jJP49VFc"></script>
    <script>
    	function initialize(){
    		var Y_point = 37.6529829;
    		var X_point = 127.3679587;
    		var zoomLevel = 16;
    		var markerTitle = "드림핑";
    		var markerMaxWidth = 300;
    		var contentString = '<div><h2>드림핑</h2><p>플로라이더와 빈티지 카라반 카바나가 있는 꿈의 캠핑!</p></div>';
    		var myLatlng = new google.maps.LatLng(Y_point, X_point);
    		var mapOptions = {
    				zoom: zoomLevel,
    				center: myLatlng,
    				mapTypeId: google.maps.MapTypeId.ROADMAP
    		}
    		var map = new google.maps.Map(document.getElementById('map_view'), mapOptions);
    		var marker = new google.maps.Marker({myLatlng, map, markerTitle});
    		var infowindow = new google.maps.InfoWindow(contentString, markerMaxWidth);
    		google.maps.event.addListener(marker, 'clcik', function(){
    			infowindow.open(map.marker);
    		});
    		
    	}
    </script>
</head>
<body onload="initialize()">
	<nav class="navbar navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="glyphicon-bar"></span>
					<span class="glyphicon-bar"></span>
					<span class="glyphicon-bar"></span>
				</button>
				
				<!-- LOGO -->
				<h1><a class="navbar-brand" href="#"><img src="img/headerLogo.png"></a></h1>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="navbar-nav pull-right">
					<li><a href="#">FLOWRIDER CAFE</a></li>
					<li><a href="#">VINTAGE CARAVAN</a></li>
					<li><a href="#">VINTAGE CABANA</a></li>
					<li><a href="#">M&M WaterLeisure</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">RESERVATION<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="#">예약하기</a>
							<li><a href="#">예약확인</a>
						</ul>
					</li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">COMMUNITY<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="#">공지사항</a>
							<li><a href="#">갤러리</a>
							<li><a href="#">Q&A</a>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="jumbotron">
		<div class="container">
			<p><br><br><br><br><br><br><br><br><br><br><br><br></p>
		</div>
	</div><!-- /#jumbotron -->
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4">
				<img src="img/flowrider.png">
			</div>
			<div class="col-md-8">
				<img src="img/camping.png">
			</div>
			<div class="col-md-5">
				<img src="img/glamping.png">
			</div>
			<div class="col-md-7">
				<img src="img/flowriderhouse.png"  style="padding:250px 250px 0;">
			</div>
			<div class="col-md-5">
				<img src="img/caravan.png" style="padding:250px 0;">
			</div>
			<div class="col-md-7">
				<img src="img/urbancamping.png">
			</div>
			<div class="col-md-5">
				<img src="img/event.png">
			</div>
			<div class="col-md-7">
				<img src="img/cafe.png">
			</div>
		</div>
		<div class="middleLine">
		</div>
		<div style="clear: both;"></div>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-9">
				<h3 style="font-weight: 600;">MAP<span style="color: #f29b5c3;">_</span></h3>
				<h4 style="font-weight: 600;">경기도 남양주시 화도읍 금남리 123</h4>
				<br>
			</div>
			<div style="clear: both;"></div>
			<div class="col-md-12">
				<div id="map_view" style="width:100%; height:500px;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-9">
				<h5 style="font-weight: 600;">Home | 이용약관 | 개인정보 취급방침</h5>
			</div>
		</div>
		<br>
		<footer>
			<div class="row">
				<div class="col-md-3" style="display: inline-block;text-align: center;">
					<img src="img/footerLogo.png" style="text-align:center; padding:50px;">
					<p>&copy; 2017 <span style="color: #f83600;">DREAMPING</span>, All Right Reserved</p>
				</div>
				<div class="col-md-2">
					<h4>INFORMATION</h4><br>
					<p>상호명 : 더드림핑</p>
					<p>대표자명 : 맹정환</p>
					<p>주소 : 경기도 남양주시 화도읍 금남리 123</p>
					<p>대표전화 : 1500-0000</p>
					<p>현장전화 : 000.0000.0000</p>
					<br><br>
				</div>
				<div class="col-md-2">
					<h4>LICENCE</h4><br>
					<p>사업자등록번호 : 000-00-000000</p>
					<p>통신판매신고번호 : </p>
					<p>e-mail : dreamping@gmail.com</p>
					<p>개인정보보호정책 책임자 : 맹정환</p>
					<br><br>
				</div>
				<div class="col-md-2">
					<h4>BANK INFO</h4><br>
					<p>은행명 : XX은행</p>
					<p>계좌번호 : </p>
					<p>예금주 : (주)더드림핑</p>
					<br><br>
				</div>
				<div class="col-md-3">
					<h4>Instagram</h4><br>
				</div>
			</div>
		</footer>
	</div><!-- /container -->
</body>
</html>