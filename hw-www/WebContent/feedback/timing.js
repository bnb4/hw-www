var init = 31;
function count() {
	if(init!=0){
		init-=1;
		document.getElementById("timing").innerHTML = init;
		setTimeout("count()",1000);
	}
	else{
		window.location.href = 'https://ticket.gamahao.com';
	}
	
}
window.onload=count();
