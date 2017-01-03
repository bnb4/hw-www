<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="ticket.HeaderCreater" %>


<!DOCTYPE html>
<html>
	<head>
		<!--Import jQuery before materialize.js-->
		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.min.js"></script>

		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<!-- Compiled and minified CSS -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css">
		<!-- Compiled and minified JavaScript -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

		<link href="/reservation/css/reservation.css" rel="stylesheet"/>
		<script type="text/javascript" src="/reservation/js/reservation.js"></script>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
		<title>選擇車次</title>

	</head>
	<body>
	
	<%=HeaderCreater.createHeader("reservation") %>
	
		<main>
			<div id="main" class="card-panel hoverable">

				<div id="description" class="row">
					<div class="card grey darken-4">
						<div class="card-content white-text">
							<span class="card-title"><i class="material-icons prefix">description</i> 訂購車票</span>
							<p>1.購買車票加價出售或換取不正利益圖利者，按車票張數，處每張車票價格之一倍至十倍罰鍰。加價出售訂票或取票憑證圖利者，亦同。<br>2.以不正方法將虛偽資料或不正指令輸入電腦或其相關設備而購買車票、取得訂票或取票憑證者，得處新臺幣五萬元以上五十萬元以下罰鍰。</p>
						</div>
					</div>
				</div>
				<form id="info_form" action="#"  method="post">
					<div id="content_1" class="row">
						<div class="card">
							<div class="card-content">
								<span class="card-title"><i class="material-icons prefix">label_outline</i> Step1. 選擇路線與日期</span>
								<div class="row">
									<div class="input-field col s6 tooltipped"  data-position="bottom" data-delay="350" data-tooltip="請選擇您要搭乘的路線">
										<select name="route" id="route" onchange="getStation()" required class="validate">
											<option value="" disabled selected>請選擇路線</option>
											
										</select>
									</div>


									<div class="input-field col s6 tooltipped"  data-position="bottom" data-delay="350" data-tooltip="請選擇乘車日期">
										<i class="material-icons prefix">perm_contact_calendar</i>            
										<input type="date" name="date" id="date" class="datepicker" required class="validate" onchange="checkDate()">
									</div>
								</div>
							</div>
						</div>
					</div>

					<div id="content_2" class="row">
						<div class="card">
							<div class="card-content">
								<span class="card-title"><i class="material-icons prefix">label_outline</i> Step2. 選擇起終點</span>
								<div class="row">
									<div class="input-field col s6 tooltipped"  data-position="bottom" data-delay="350" data-tooltip="請選擇起點">
										<select name="start"  id="start" required class="validate" onchange="getDestination()">
											<option value="" disabled selected>請選擇起點</option>
										</select>
										<label for="start">起點</label>
									</div>
									<div class="input-field col s6 tooltipped"  data-position="bottom" data-delay="350" data-tooltip="請選擇終點">
										<select name="destination" id="destination" required class="validate">
											<option value="" disabled selected>請選擇終點</option>
										</select>
										<label for="destination">終點</label>
									</div>
								</div>
							</div>
						</div>
					</div>


					<div class="col s12 m6 13 center">
						<button id="submit_btn" type="submit" class="btn waves-effect waves-light grey darken-4" onclick="getCar()">查詢車次
							<i class="material-icons right">search</i>
						</button>
					</div>
				</form>

				<div id="content_4" class="row">
					<div class="card">
						<div class="card-content">
							<span class="card-title"><i class="material-icons prefix">label_outline</i> Step3. 選擇車次</span>
							<div class="row">
								<div class="input-field col s12" id="car_time">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>

		<div id="dialog" class="center" title="ㄏㄏ">
			<p>僅限訂購明天以後的車票喔喔喔喔喔<br>當日車票請臨櫃辦理</p>
		</div>
		
		<jsp:include page="/footer.html" />
		
	</body>
</html>