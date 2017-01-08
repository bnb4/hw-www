<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="ticket.HeaderCreater" %>
<%@ page import="database.DatabaseHelper" %>
<%@ page import="java.sql.*" %>

<!-- ?php 

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
<%
	//資料庫連線
	Connection con = DatabaseHelper.getConnection();
	
	//判斷是否填寫過
	if(request.getParameter("content")==null){
		response.setHeader("refresh", "0;url=/");
	}
	
	String name, email, phone, content;
	
	name = request.getParameter("name");
	email = request.getParameter("email");
	phone = request.getParameter("phone");
	content = request.getParameter("content");
	
	PreparedStatement stmt = con.prepareStatement("INSERT INTO suggestion (name,email,phone,content)VALUES( ? , ? , ? , ? )");
	
	stmt.setString(1, name);
	stmt.setString(2, email);
	stmt.setString(3, phone);
	stmt.setString(4, content);
	
	stmt.executeUpdate();
	
	PreparedStatement stmtLog;
	
	if(request.getParameter("name")==""){
		stmtLog = con.prepareStatement("INSERT INTO log (type,content)VALUES('suggestion','無名氏的客訴已傳送')");
		stmtLog.executeUpdate();
	}
	else{
		stmtLog = con.prepareStatement("INSERT INTO log (type,content)VALUES('suggestion', ? )");
		stmtLog.setString(1, name+"的客訴已傳送");
		stmtLog.executeUpdate();
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
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<link href="/feedback/css/thanks.css" rel="stylesheet"/>
		<!-- Google reCaptcha API-->
		<script src='https://www.google.com/recaptcha/api.js'></script>
		
		
		<meta charset='utf8' />
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<title>不識大體 - 屍速客運 Inc.</title>
	</head>

	<body>
		<!-- 上方標題-->
		<%=HeaderCreater.createHeader("<a>&#9760 &nbsp</a>你已經死了<a>&nbsp &#9760</a>") %>
		
		<!-- 主內容 -->
		<main>
			<div id="main" class="card-panel hoverable">
				<div class="col s12 m7">
					<div class="card">
						<div class="card-image"  align="center">
							<img id="warning" src="/images/warning.jpg">
						</div>
						<div class="card-stacked">
							<div class="card-content">
								<h5><b>你的意見不予回應</b></h5>
								<p>你以為客訴我們就有用嗎？太天真了。想用客訴這招對付我們屍速客運再練個一百年吧！</p>
								<p class="right">正在倒數 <span id="timing"></span> 秒回主頁面</p>
							</div>
							<div class="card-action grey darken-4 center">
								<a class="white-text" style="font-size:18pt;" href="http://ticket.jsp.gamahao.com">點選這裡返回屍速之旅</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>

	</body>
	<!--倒數計時-->
	<script src="/feedback/timing.js"></script>
	<jsp:include page="/footer.html" />
	
</html>
