var verifyCallback = function(response) {
	// 有送出確認
	document.getElementById("submit_btn").disabled = false;
};

var onloadCallback = function() {
	grecaptcha.render('recaptcha_element', {
				'sitekey' : '6LdshwoUAAAAAPx-AuciNpxXAC8kfFL7V7MMU7-N',
			  'callback' : verifyCallback,
			  'theme' : 'light'
	});
};
