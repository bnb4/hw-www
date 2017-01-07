<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="ticket.HeaderCreater" %>
<%@ page import="database.DatabaseHelper" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
	//是否存在訂單
	boolean isExist = false;

	String car_name, date, start, end, seat_row, seat_column, start_time, arrival_time, price, line_name;
	
	SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-DD");
	String today = date_format.format(new java.util.Date());
%>
	
<%
    String user_id = request.getParameter("user_id");
    

    // 資料庫連線
    Connection con = DatabaseHelper.getConnection();

    //date_default_timezone_set('Asia/Taipei');

    // 儲存資料庫撈取資料
    String _begin, _end, _car_time, _line_id;
    
    try {
    	// 取得車子座位
	    PreparedStatement stmt = 
	    		con.prepareStatement("SELECT car_name, car_date, begin, end, seat_row, seat_column, price, car_time, line_name.name, line_name.line_id FROM ticket JOIN timetable USING (car_name) JOIN line_name ON timetable.route = line_name.line_id WHERE user_id = ? AND car_date > ? ORDER BY car_date ASC LIMIT 0,1;");
	    stmt.setString(1, user_id);
	    stmt.setString(2, today);
	    ResultSet rs = stmt.executeQuery();
	    
	    if (rs.next()) {

	    	// 有抓到資料
	    	car_name = rs.getString(1);
	    	date = rs.getString(2);
	    	_begin = rs.getString(3);
	    	_end = rs.getString(4);
	    	seat_row = rs.getString(5);
	    	seat_column = rs.getString(6);
	    	price = rs.getString(7);
	    	_car_time = rs.getString(8);
	    	line_name = rs.getString(9);
	    	_line_id = rs.getString(10);

	    	// 先行釋放之前占用的資源
	    	rs.close();
	    	stmt.close();
	    	
	    	// 抓取車站詳細資訊
	    	stmt = con.prepareStatement("SELECT beginT.name, endT.name, beginT.time, endT.time FROM line AS beginT JOIN line AS endT WHERE beginT.line_id = ? AND beginT.id = ? AND endT.line_id = ? AND endT.id = ?;");
		    stmt.setString(1, _line_id);
		    stmt.setString(2, _begin);
		    stmt.setString(3, _line_id);
		    stmt.setString(4, _end);
		    rs = stmt.executeQuery();

		    if (rs.next()) {
		    	isExist = true;
		    	
		    	// 儲存資料庫撈取資料
		    	int _begin_time, _end_time;
		    	
		    	start = rs.getString(1);
		    	end = rs.getString(2);
		    	_begin_time = rs.getInt(3);
		    	_end_time = rs.getInt(4); 
		    	
		    	SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
		    	SimpleDateFormat df_out = new SimpleDateFormat("HH:mm");
		    	java.util.Date d = df.parse(_car_time);
		    	
		    	Calendar _start_time = Calendar.getInstance();
		    	Calendar _arrival_time = Calendar.getInstance();
		    	_start_time.setTime(d);
		    	_arrival_time.setTime(d);
		    	
		    	_start_time.add(Calendar.SECOND, _begin_time * 60);
		    	_arrival_time.add(Calendar.SECOND, _end_time * 60);
		    	
		    	start_time = df_out.format(_start_time.getTime());
		    	arrival_time = df_out.format(_arrival_time.getTime());
		    	
		    } else {
		    	isExist = false;
		    }
	    	
	    } else {
	    	// 沒有抓到資料
	        isExist = false;
	    }
    
    	stmt.close();
    } catch (Exception e) {
		e.printStackTrace();
		//response.sendError(500, "讀取資料庫時發生錯誤!");
	} 
    //echo $car_name.';'.$date.';'.$start.';'.$end.';'.$seat_row.';'.$seat_column.';'.$start_time.';'.$arrival_time.';'.$price.';'.$line_name;
    
    // $isExist 是否有抓到資料
    // $car_name 車次
    // $date 日期
    // $start 出發站名
    // $end 到達站名
    // $seat_row 座位列
    // $seat_column 座位欄
    // $start_time 出發時間
    // $arrival_time 到達時間
    // $price 價格
    // $line_name 線路名稱
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
        
        <link href="/inquiry/css/inquire.css" rel="stylesheet"/>
		
		
		<meta charset='utf8' />
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<title>查詢結果 - 屍速客運 Inc.</title>
		
		<script>
			var isExist = <%= (isExist?"true":"false") %>;
		</script>
	</head>

	<body>
		<!-- 上方標題-->
		<%=HeaderCreater.createHeader("查到了啊不就好棒棒") %>
		
		<!-- 主內容 -->

		<main>
			<div id="main" class="card-panel hoverable animated fadeIn">
				<div class="col s12 m7">
					<div class="card grey lighten-2">
						<h1 class="center">查詢結果</h1>
						<div class="card-stacked">
							<div id="card_inside" class="row">
								<div id="details" class="card hoverable">
									<p><span id="date" class="left"><%= date %></span>
										<span id="car_name" class="right">車次<%= car_name %></span></p>
									<p id="station" class="center"><span id="schedule" ><%= start + " " + start_time %> ->
                                        <%= end + " " + arrival_time %></span></p>
										
									<p class="center"><span id="seat" class="left">座位：<%= seat_column + "排" + seat_row + "列" %></span>
										<span id="price" class="right">NT$ <%= price %></span></p>
									
									<p id="self_data" class="center"><span id="user_id" class="left">身分證：<%= user_id %></span></p>
										
									<span class="right">* 請在該班車一小時前取票完畢</span>
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
	
	<script>
			document.re
			if( isExist == false){
				document.getElementById("card_inside").innerHTML = '<h5 class="center">你沒有訂票阿~白痴<h5>';
			}
	</script>
</html>