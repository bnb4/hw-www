<%@ page contentType="text/html; charset=utf-8"%>
<!-- ?php 

include '../src/autoload.php';
$secret = '6LdshwoUAAAAADCxsmJ9a2OgG4sHJGB_GPlNEwsc';

if(isset($_POST['g-recaptcha-response'])){

	$recaptcha = new \ReCaptcha\ReCaptcha($secret);

	// 將 recaptcha->verify 的值給 resp
	$resp = $recaptcha->verify($_POST['g-recaptcha-response'], $_SERVER['REMOTE_ADDR']);

    // 判斷 resp->isSuccess 是 true 或 false
    if($resp->isSuccess() != true){
	   header("Location:/");
    }
}

include '../db_connection.php';

if (!isset($_POST['content'])) {
	header("Location:/");
}


$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$content = $_POST['content'];

mysqli_query($con,"INSERT INTO suggestion (name,email,phone,content)VALUES('$name','$email','$phone','$content')");

if ($_POST['name']=="") {
	mysqli_query($con,"INSERT INTO log (type,content)VALUES('suggestion','無名氏的客訴已傳送')");
}
else{
	mysqli_query($con,"INSERT INTO log (type,content)VALUES('suggestion','$name 的客訴已傳送')");
}

?-->

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
		<link href="css/thanks.css" rel="stylesheet"/>
		<!-- Google reCaptcha API-->
		<script src='https://www.google.com/recaptcha/api.js'></script>
		
		
		<meta charset='utf8' />
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<title>不識大體 - 屍速客運 Inc.</title>
	</head>

	<body>
		<!-- 上方標題-->
		
		<?php include '../header.php';
		createHeader('<a>&#9760 &nbsp</a>你已經死了<a>&nbsp &#9760</a>');?>
		
		<!-- 主內容 -->

		<main>
			<div id="main" class="card-panel hoverable">
				<div class="col s12 m7">
					<div class="card">
						<div class="card-image"  align="center">
							<img id="warning" src="../images/warning.jpg">
						</div>
						<div class="card-stacked">
							<div class="card-content">
								<h5><b>你的意見不予回應</b></h5>
								<p>你以為客訴我們就有用嗎？太天真了。想用客訴這招對付我們屍速客運再練個一百年吧！</p>
								<p class="right">正在倒數 <span id="timing"></span> 秒回主頁面</p>
							</div>
							<div class="card-action grey darken-4 center">
								<a class="white-text" style="font-size:18pt;" href="https://ticket.gamahao.com">點選這裡返回屍速之旅</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>

	</body>
	<!--倒數計時-->
	<script src="timing.js"></script>
	<?php include '../footer.html'?>
	
</html>
