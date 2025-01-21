function getCookie(name) {
	var fromIdx = document.cookie.indexOf(name+'=');
	if (fromIdx != -1) {
		fromIdx += name.length + 1;
	
		var toIdx = document.cookie.indexOf(';', fromIdx);
		if (toIdx == -1) {
			toIdx = document.cookie.length;
		}
		return unescape( document.cookie.substring(fromIdx,toIdx) );
	}
}

function rmCookie(name) {
	var today = new Date();
	var expireDate = new Date(today.getTime() - 60*60*24*1000);
	document.cookie = name + "= " + "; expires=" + expireDate.toGMTString();
}

function setCookie(name,value,expiresTime){ //expiresTime(millisecond): ex)60*60*24*1000 - 1day
	var today = new Date();
	var expireDate = new Date(today.getTime() + expiresTime);
	document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expireDate.toGMTString();
}


