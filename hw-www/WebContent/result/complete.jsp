<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="ticket.HeaderCreater" %>

<!-- ?php session_start(); 
	if (!isset($_SESSION['date'])) {
		header("Location:/");
	}
? -->

<%
	/*if(session.getAttribute("date")==null){
		response.sendRedirect("/index.jsp");
	}*/
		
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
		<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css" />
        
        <link href="/result/css/complete.css" rel="stylesheet"/>
		
		
		<meta charset='utf8' />
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<title>成功訂票 - 屍速客運 Inc.</title>
	</head>

	<body>
		<!-- 上方標題-->
		<%=HeaderCreater.createHeader("成功了不就好棒棒") %>
				
		<!-- 主內容 -->

		<main>
			<div id="main" class="card-panel hoverable animated fadeIn">
				<div class="col s12 m7">
					<div class="card grey lighten-2">
						<div class="card-image"  align="center">
							<img id="complete" src="/images/complete.png">
						</div>
						<div class="card-stacked">
							<div id="card_inside" class="row">
								<div id="details" class="card hoverable">
									<p><span id="date" class="left"><% out.print(session.getAttribute("date")); %></span>
										<span id="car_name" class="right">車次<% out.print(session.getAttribute("car_name")); %></span></p>
									<p id="station" class="center"><span id="schedule" ><% out.print(session.getAttribute("start") + " " + session.getAttribute("start_time") + " -> " + session.getAttribute("end") + " " + session.getAttribute("arrival_time")); %></span></p>
									<p class="center"><span id="seat" class="left">座位：<% out.print(session.getAttribute("seat_column") + "排" + session.getAttribute("seat_row") + "列"); %></span>
										<span id="price" class="right">NT$ <% out.print(session.getAttribute("price")); %></span></p>
									<p id="self_data" class="center"><span id="user_id" class="left">身分證：<% out.print(session.getAttribute("user_id")); %></span>
										<span id="phone" class="center">電話：<% out.print(session.getAttribute("phone")); %></span>
										<span id="email" class="right">Email：<% out.print(session.getAttribute("email")); %></span></p>
									<span>* 請在該班車一小時前取票完畢</span>
								</div>
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
	
	<jsp:include page="/footer.html" />
	
</html>
<% session.invalidate(); %>
<!-- ?php session_destroy();? -->