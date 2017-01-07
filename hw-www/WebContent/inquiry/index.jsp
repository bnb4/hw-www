<%@ page contentType="text/html; charset=utf-8"%>

<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="ticket.HeaderCreater" %>

<%!
	String siteKey = "6LdshwoUAAAAAPx-AuciNpxXAC8kfFL7V7MMU7-N";
	String secret = "6LdshwoUAAAAADCxsmJ9a2OgG4sHJGB_GPlNEwsc";
	String lang = "zh-TW";
	String resp = "";
	
	public String jspAlert(String msg) {
	    return "<script type=\"text/javascript\">alert(\"" + msg + "\")</script>";
	}

	public String jspToast(String msg) {
		return "<script type=\"text/javascript\">Materialize.toast(" + msg + ", 3000, 'rounded');</script>";
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
	
	<link href="/inquiry/css/index.css" rel="stylesheet"/>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<title>查詢訂票 - 屍速客運 Inc.</title>

    <script type="text/javascript">
		var verifyCallback = function(response) {
			// 有送出確認
			document.getElementById("submit_btn").disabled = false;
			//alert(response);
		};
		var onloadCallback = function() {
			grecaptcha.render('recaptcha_element', {
			  'sitekey' : '<%= siteKey %>',
			  'callback' : verifyCallback,
			  'theme' : 'light'
			});
		  };
    </script>

</head>
<body>

<%=HeaderCreater.createHeader("先動動你的大腦再來查啦") %>

<main class="animated fadeIn">
	<div id="form_main" class="card-panel hoverable">
	
		<div id="description" class="row">
			<div class="card grey darken-4">
				<div class="card-content white-text">
					<span class="card-title"><i class="material-icons prefix">search</i> 尋尋覓覓</span>
					<p>有沒有訂票都會忘記，你要不要吃銀杏；你以為在拍廣告喔？「好像有，又好像沒有。」</p>
				</div>
			</div>
		</div>
	
		<form action="/?page=inquiry_result" method="post">
		
				<div class="input-field col s6 tooltipped"  data-position="right" data-delay="350" data-tooltip="台灣身分證格式">
					<i class="material-icons prefix">account_circle</i>
					<input id="user_id" name="user_id" type="text" pattern="[a-zA-Z][12][0-9]{8}" class="validate" required length="10" >
					<label for="icon_prefix">身分證字號</label>
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
	
<script type="text/javascript" src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit&hl=<?php echo $lang; ?>" async defer></script>
</body>
</html>