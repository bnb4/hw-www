$(document).ready(function() {
	$('select').material_select();
});

function getCar() { //取車次
	$start = $("#start").val();
	$destination = $("#destination").val();
	$date = $("#date").val();
	$("#car_time").html("");
	$('main').height("1050px");

	if ($start!=null && $destination!=null  && $date!='') {
		$.ajax({
			url:"http://ticket.jsp.gamahao.com/?service=getCar", 
			type:'GET',
			data: {route: $route, start: $start, destination: $destination, date: $date},
			dataType: 'json',
			success: function(car_time) {
				if (car_time.length == 0) {
					$("#car_time").append("<h4 class='center' style='color:#0066FF'><i class='large material-icons'>warning</i></br>Oops!&nbsp&nbsp沒有符合班次&nbsp&nbsp走路吧~</h4>");
					addHeight();
				}
				else {
					$("#car_time").append("<table class='striped centered'><thead><tr><th data-field='id'>車次</th><th data-field='start'>出發時間<br>"+$("#start option:selected").text()+"</th><th data-field='destination'>抵達時間<br>"+$("#destination option:selected").text()+"</th><th data-field='level'>車種</th><th data-field='price'>價格</th><th data-field='available_seats'>剩餘車位</th><th>訂票</th></tr></thead><tbody>");

					$.each(car_time, function(i) {

						$available_seats = 0;

						$.ajax({
							url:"http://ticket.jsp.gamahao.com/?service=getAvailableSeats", 
							async: false,
							type:'GET',
							data: {car_name: car_time[i].car_name, begin: $start, end: $destination, date: $date},
							   dataType: 'json',
							   success: function(seats) {
							$available_seats = seats.availableSeats.length;
						}
					});

					if ($available_seats<=0) {
						$available_seats = 0;
					}

					$("#car_time table tbody").append('<tr data-car_name='+car_time[i].car_name+'><td>'+car_time[i].car_name+'</td><td>'+car_time[i].start_time+'</td><td>'+car_time[i].arrival_time+'</td><td>'+car_time[i].name+'</td><td>'+car_time[i].price+'</td><td>'+$available_seats+'</td><td class="seats"></td></tr>');

					if ($available_seats>0) {
						$("#car_time table tbody tr[data-car_name="+car_time[i].car_name+"] .seats").append('<a class="waves-effect waves-light btn" href="get_ticket.php?start='+$start+'&end='+$destination+'&date='+$date+'&car_name='+car_time[i].car_name+'">訂票</a>');
					}

					else {
						$("#car_time table tbody tr[data-car_name="+car_time[i].car_name+"] .seats").append('<a class="waves-effect waves-light btn disabled">訂沙小</a>');
					}
				});

				$("#car_time").append('</tbody></table>');
				addHeight();
			}
		}
			   });
	}
}

function getStation() { //取起點
	$route = $("#route").val();

	$("#start").attr('disabled', false);

	$("#start").html('<option value="" disabled selected>請選擇起點</option>');
	$("#destination").html('<option value="" disabled selected>請選擇終點</option>');

	$('#start').material_select();
	$('#destination').material_select();

	if ($route!='') {
		$.ajax({
			url:"http://ticket.jsp.gamahao.com/?service=getStation", 
			type:'GET',
			data: {route: $route},
			dataType: 'json',
			success: function(json) {
				$.each(json, function(i) {
					$('#start').append($('<option />', { value:json[i].id, text:json[i].name }));
				});
				$('#start').material_select();
			}
		});
	}
}

function addHeight() {
	$('main').css( "height", $("#main").height()+95 );
	//$('main').height($("#main").height());
}

function getDestination() { //取終點
	$route = $("#route").val();
	$start = $("#start").val();

	$("#destination").attr('disabled', false);

	$("#destination").html('<option value="" disabled selected>請選擇終點</option>');
	$('#destination').material_select();

	if ($start!='') {

		$.ajax({
			url:"http://ticket.jsp.gamahao.com/?service=getDestination", 
			type:'GET',
			data: {route: $route, start: $start},
			dataType: 'json',
			success: function(json) {
				$.each(json, function(i) {
					$('#destination').append($('<option />', { value:json[i].id, text:json[i].name }));
				});
				$('#destination').material_select();
			}
		});
	}
}

$('#date').pickadate({
	selectMonths: true,
	selectYears: 15
});

$(document).on('submit','#info_form',function (e) {
	e.preventDefault();
	return false;
})

function checkDate() {
	$today = new Date().toJSON().slice(0,10);
	$date = $("#date").val();
	if ($date<=$today) {
		$("#date").val("");
		$( "#dialog" ).dialog();
	}
}