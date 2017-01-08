<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="ticket.HeaderCreater" %>

<?php session_start();

?>

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
		<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css" />
        
        <link href="/result/css/fail.css" rel="stylesheet"/>
		
		<meta charset='utf8' />
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<title>失敗喪屍 - 屍速客運 Inc.</title>
	</head>

	<body>
		<!-- 上方標題-->
		<%=HeaderCreater.createHeader("<a>&#9760 &nbsp</a>真是太失敗了<a>&nbsp &#9760</a>") %>
				
		<!-- 主內容 -->

		<main>
			<div id="main" class="card-panel hoverable animated fadeIn">
				<div class="col s12 m7">
					<div class="card">
						<div class="card-image"  align="center">
							<img id="fail" src="../images/fail.png">
						</div>
						<div class="card-stacked">
							<div class="card-content">
								<h5><b>訂票失敗
									<?php
										if($_REQUEST['error']=='duplicate'){
											echo " - 已訂過該班車";
										}
										else if($_REQUEST['error']=='no_seat'){
											echo " - 沒有座位";
										}
										else{
											header("Location:/");
										}
									?>
								</b></h5>

								<p>真是太失敗了，這點小事也做不好，以後出社會怎麼辦？能不能磨練個百年再來用我們的系統啊？</p>
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
	
	<jsp:include page="/footer.html" />
	
</html>
<?php session_destroy();?>