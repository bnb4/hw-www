<%@ page contentType="text/html; charset=utf-8"%>
<%!
	String siteKey = "6LdshwoUAAAAAPx-AuciNpxXAC8kfFL7V7MMU7-N";
	String secret = "6LdshwoUAAAAADCxsmJ9a2OgG4sHJGB_GPlNEwsc";
	String lang = "zh-TW";
	String resp = "";
	
	public String jspAlert(String msg) {
	    return "<script type=\"text/javascript\">alert(\"" + msg + "\")</script>";
	}

	public String jspToast(String msg) {
		return "<script type=\"text/javascript\">Materialize.toast("+msg+", 3000, 'rounded');</script>";
	}
%>


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
	
	<link href="/feedback/css/feedback.css" rel="stylesheet"/>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<title>我要客訴 - 屍速客運 Inc.</title>

    <script type="text/javascript">
		var verifyCallback = function(response) {
			// 有送出確認
			document.getElementById("submit_btn").disabled = false;
			//alert(response);
		};
		var onloadCallback = function() {
			grecaptcha.render('recaptcha_element', {
			  'sitekey' : '<%=siteKey%>',
			  'callback' : verifyCallback,
			  'theme' : 'light'
			});
		  };
    </script>

</head>
<body>

<!-- jsp:include page="../header.jsp" /-->
<!-- createHeader('今天你敢客訴，小心身首異處。'); -->

<main class="animated fadeIn">
	<div id="form_main" class="card-panel hoverable">
	
		<div id="description" class="row">
			<div class="card grey darken-4">
				<div class="card-content white-text">
					<span class="card-title"><i class="material-icons prefix">comment</i> 我要客訴</span>
					<p>給我嘴巴放乾淨點，敢亂客訴，小心挑斷你手腳筋，讓你手在客運腳在大馬路；縱切你的嘟嘟好，分成八等分拿去餵豬。
					再給你一桶汽油、一支番仔火，乎恁兜火燒厝啦～送啦～</p>
				</div>
			</div>
		</div>
	
		<form action="thanks.php" method="post">
		
				<div class="input-field col s6 ">
					<i class="material-icons prefix">perm_identity</i>
					<input id="name" name="name" type="text"  class="validate">
					<label for="icon_prefix">姓名</label>
				</div>
				<div class="input-field col s6 tooltipped" data-position="right" data-delay="350" data-tooltip="例如：gg@domain.com" >
					<i class="material-icons prefix">email</i>
					<input id="email" name="email" type="email" class="validate" >
					<label for="icon_telephone">信箱</label>
				</div>
				<div class="input-field col s6 tooltipped"  data-position="right" data-delay="350" data-tooltip="台灣手機號碼 僅限09開頭">
					<i class="material-icons prefix">phone</i>
					<input id="phone" name="phone" type="tel" pattern="09[0-9]{8}" class="validate" >
					<label for="icon_telephone">手機</label>
				</div>
				<div class="input-field col s12">
					<i class="material-icons prefix">description</i>
					<textarea id="content" name="content" class="materialize-textarea" required length="128"></textarea>
					<label for="content">意見內容限128字</label>
				</div>


			<div class="row">
				<div class="col s12 m4 12"></div>
				
				<div class="col s12 m4 18">
					<div id="recaptcha_element"></div>
				</div>
			</div>

			<br />
			
			<div class="row">
				<div class="col s12">
					<button id="submit_btn" class="btn waves-effect waves-light tooltipped grey darken-4" type="submit" name="action" data-position="top" data-delay="50" data-tooltip="送出前請再確認一次" disabled>提交
					<i class="material-icons right">send</i>
					</button>
				</div>
			</div>

		</form>
	</div>
</main>	

<jsp:include page="/footer.html" />
	
<script type="text/javascript" src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit&hl=<%=lang %>" async defer></script>
</body>
</html>