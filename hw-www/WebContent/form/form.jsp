<%@ page contentType="text/html; charset=utf-8"%>

<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.JSONObject" %>

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
	
	private boolean checkReCaptcha(String reponse, String remoteip) {
		try {
			URL dest = new URL("https://www.google.com/recaptcha/api/siteverify");
			URLConnection conn = dest.openConnection();
			
			conn.setRequestProperty("accept", "*/*");  
	        conn.setRequestProperty("connection", "Keep-Alive");  

	        conn.setDoOutput(true);  
	        conn.setDoInput(true);  
	        
	        PrintWriter _out = new PrintWriter(conn.getOutputStream());;
	        _out.print("secret="+secret + "&response="+reponse + "&remoteip="+remoteip);  
	        _out.flush();
	        
			BufferedReader _in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String inputLine, rawJson = "";
			
			while ((inputLine = _in.readLine()) != null)
				rawJson += inputLine;
			_in.close();
			
			JSONObject obj = new JSONObject(rawJson);
			return obj.getBoolean("success");
		} catch (Exception e) {
			return false;
		}
		
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
	
	<link href="/form/css/form.css" rel="stylesheet"/>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<title>填寫資料 - 屍速客運 Inc.</title>
    
    <script type="text/javascript" src="/form/js/form.js"></script>

</head>
<body>

<%
	//驗證碼未通過時會用到的變數 用來回填欄位
	String user_id = "", email = "", phone = "", temp = "";
	boolean showForm = true;

	//條款同意確認
	if ((request.getParameter("user_id") == null) &&
		(null == (temp = request.getParameter("agreement"))) ||
		(!temp.equals("agree"))) {
			response.setHeader("refresh", "0;url=/");
			showForm = false;
		}

	String g_recaptcha_response = request.getParameter("g-recaptcha-response");
	if (g_recaptcha_response != null) {
		if (checkReCaptcha(g_recaptcha_response, request.getRemoteAddr())) {
			session.setAttribute("user_id", request.getParameter("user_id"));
			session.setAttribute("email", request.getParameter("email"));
			session.setAttribute("phone", request.getParameter("phone"));
			
			response.setHeader("refresh", "0;url=/?page=reservation");
			showForm = false;
		} else {
			jspToast("驗證碼未通過!");
			user_id = request.getParameter("user_id");
			email = request.getParameter("email");
			phone = request.getParameter("phone");
		}
	}
	
	// 若準備轉跳，則不要顯示內容，反之則顯示。
	if(showForm) { 
%>

<!-- jsp:include page="//header.jsp" / -->

<main class="animated fadeIn">
	<div id="form_main" class="card-panel hoverable">
	
		<div id="description" class="row">
			<div class="card grey darken-4">
				<div class="card-content white-text">
				  <span class="card-title"><i class="material-icons prefix">assignment_ind</i> 基本資料表</span>
				  <p>請確實填寫以下表格，請勿冒用他人之身分，身分證號碼將做為取票依據，信箱與手機為通知用途，請確保能夠收到通知。</p>
				</div>
			</div>
		</div>
	
		<form action="/?page=form" method="post">
		
				<div class="input-field col s6 tooltipped"  data-position="right" data-delay="350" data-tooltip="台灣身分證格式">
				  <i class="material-icons prefix">account_circle</i>
				  <input id="user_id" name="user_id" type="text" pattern="[a-zA-Z][12][0-9]{8}" class="validate" required length="10" value="<%= user_id %>" >
				  <label for="icon_prefix">身分證字號</label>
				</div>
				<div class="input-field col s6 tooltipped" data-position="right" data-delay="350" data-tooltip="例如：gg@domain.com" >
				  <i class="material-icons prefix">email</i>
				  <input id="email" name="email" type="email" class="validate" required length="64" value="<%= email %>" >
				  <label for="icon_telephone">信箱</label>
				</div>
				<div class="input-field col s6 tooltipped"  data-position="right" data-delay="350" data-tooltip="台灣手機號碼 僅限09開頭">
				  <i class="material-icons prefix">phone</i>
				  <input id="phone" name="phone" type="tel" pattern="09[0-9]{8}" class="validate" required length="32" value="<%= phone %>" >
				  <label for="icon_telephone">手機</label>
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

<jsp:include page="//footer.html" />
	
<script type="text/javascript" src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit&hl=<%= lang %>" async defer></script>

<% } %>

</body>
</html>