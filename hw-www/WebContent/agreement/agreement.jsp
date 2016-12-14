<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="ticket.HeaderCreater" %>

<!DOCTYPE html>
<html>
<head>

	<!--Import jQuery before materialize.js-->
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
	<!-- Compiled and minified CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">
	<!-- Compiled and minified JavaScript -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

	<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css" />
	
	<link href="/agreement/css/agreement.css" rel="stylesheet"/>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<title>使用條款 - 屍速客運 Inc.</title>
	
</head>
<body>

<%=HeaderCreater.createHeader("agreement") %>

<main class="animated fadeIn">
	<div id="main" class="card-panel hoverable">
	
		<div id="description" class="row">
			<div class="card grey darken-4">
				<div class="card-content white-text">
				  <span class="card-title"><i class="material-icons prefix">description</i> 使用條款</span>
				  <p>以下條約需要使用者的同意才可以存取本服務。</p>
				</div>
			</div>
		</div>
		
		<div id="content_1" class="row">
			<div class="card">
				<div class="card-content">
					<span class="card-title"><i class="material-icons prefix">label_outline</i> A. 系統條款</span>
					<ul class="collection">
					  <li class="collection-item">1. 本系統不負責保管資料(?!)，流出請別找我。</li>
					  <li class="collection-item">2. 使用本系統請小心使用，用壞要你賠。</li>
					  <li class="collection-item">3. 如果系統當機，請按下標題列的[X]，假的，你的眼睛業障重。</li>
					  <li class="collection-item">4. 畫面若顯示不正常，一定是你打開網頁的方式不對。</li>
					</ul>
				</div>
			</div>
		</div>
		
		<div id="content_2" class="row">
			<div class="card">
				<div class="card-content">
					<span class="card-title"><i class="material-icons prefix">label_outline</i> B. 服務條款</span>
					<ul class="collection">
					  <li class="collection-item">1. 有錢不一定買的到票。</li>
					  <li class="collection-item">2. 有票不一定上的了車。</li>
					  <li class="collection-item">3. 上了車不一定有座位。</li>
					  <li class="collection-item">4. 有座位不一定會發車。</li>
					</ul>
				</div>
			</div>
		</div>
		
		<form action="/?page=form" method="post">
			<div class="row">
				<div class="col s12 m6 13 center">
					<button id="submit_btn" class="btn waves-effect waves-light grey darken-4" type="submit" name="agreement" value="agree">我同意
					<i class="material-icons right">done</i>
					</button>
				</div>
				<div class="col s12 m6 13 center">
					<button id="disagree_btn" class="btn waves-effect waves-light grey darken-4" type="submit" formaction="/">我不同意
					<i class="material-icons right">not_interested</i>
					</button>
				</div>
			</div>

		</form>
	</div>
</main>

<jsp:include page="/footer.html" />

</body>
</html>