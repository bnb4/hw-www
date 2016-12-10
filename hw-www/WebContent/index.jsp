<%@ page contentType="text/html; charset=utf-8"%>

<!DOCTYPE html>
<html>
	<head>
		<!--Import jQuery before materialize.js-->
		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<!-- Compiled and minified CSS -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">
		<!-- Compiled and minified JavaScript -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<link href="css/index.css" rel="stylesheet"/>
		<!-- Google reCaptcha API-->
		<script src='https://www.google.com/recaptcha/api.js'></script>
		
		<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css" />
		
		<meta charset='utf8' />
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<title>屍速客運 訂票系統</title>
	</head>

	<body>
		<!-- 上方標題-->
		<!-- jsp:include page="header.jsp"-->
			<!--jsp:param name="title" value="👍 事故發生率，業界最高 👍" /-->
		<!-- /jsp:include-->
		
		<!-- 主內容 -->

		<main class="animated fadeIn">
			<div id="main" class="card-panel hoverable">
				<div class="col s12 m7">
					<div class="card horizontal">
						<div class="card-image">
							<img id="bus" src="images/bus.jpg">
						</div>
						<div class="card-stacked">
							<div class="card-content">
								<h5><b>歡迎使用屍速客運訂票系統</b></h5>
								<p>寧可錯殺一百，也不放過一個乘客，敬請安心搭乘。</p>
							</div>
							<a id="search_btn" class="waves-effect waves-light btn right grey darken-4" href="/?page=inquiry"><i class="material-icons left">search</i>查詢已購票</a>
							<div class="card-action grey darken-4 center">
								<a class="white-text" style="font-size:18pt;" href="/?page=agreement">點選這裡前往屍速之旅</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
		
		
	</body>
	
	<jsp:include page="footer.html" />
</html>
