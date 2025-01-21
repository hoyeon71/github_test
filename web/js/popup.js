//popup.js
//1:scrollbars=yes
//2:resizable=yes
//3:scrollbars=yes and resizable=yes

function openPopup(url,name,w,h,x,y) {
	var win=window.open(url,name,"left="+x+",top="+y+",width="+w+",height="+h+",toolbar=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0");
	//win.focus();
	//return win;
}
function openPopup1(url,name,w,h,x,y) {
	var win = window.open(url,name,"left="+x+",top="+y+",width="+w+",height="+h+",toolbar=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0");
	//win.focus();
	//return win;
}
function openPopup2(url,name,w,h,x,y) {
	var win=window.open(url,name,"left="+x+",top="+y+",width="+w+",height="+h+",toolbar=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=1");
	//win.focus();
	//return win;
}
function openPopup3(url,name,w,h,x,y) {
	var win=window.open(url,name,"left="+x+",top="+y+",width="+w+",height="+h+",toolbar=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1");
	//win.focus();
	//return win;
}

function openPopupCenter(url,name,w,h) {
	var x 	= (screen.width-w)/2;
	var y 	= (screen.height-h)/2;
	var win = window.open(url,name,"left="+x+",top="+y+",width="+w+",height="+h+",toolbar=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0");
	//win.focus();
	//return win;
}
function openPopupCenter1(url,name,w,h) {
	var x 	= (screen.width-w)/2;
	var y 	= (screen.height-h)/2;
	var win = window.open(url,name,"left="+x+",top="+y+",width="+w+",height="+h+",toolbar=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0");
	//win.focus();
	//return win;
}
function openPopupCenter2(url,name,w,h) {
	var x 	= (screen.width-w)/2;
	var y 	= (screen.height-h)/2;
	var win = window.open(url,name,"left="+x+",top="+y+",width="+w+",height="+h+",toolbar=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=1");
	//win.focus();
	//return win;
}
function openPopupCenter3(url,name,w,h) {
	var x 	= (screen.width-w)/2;
	var y 	= (screen.height-h)/2;
	var win = window.open(url,name,"left="+x+",top="+y+",width="+w+",height="+h+",toolbar=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1");
	//win.focus();
	//return win;
}
function openPopupCenter4(url,name,w,h) {
	var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : window.screenX;
    var dualScreenTop = window.screenTop != undefined ? window.screenTop : window.screenY;

    var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
    var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

    var systemZoom = width / window.screen.availWidth;
    var x = (width - w) / 2 / systemZoom + dualScreenLeft;
    var y = (height - h) / 2 / systemZoom + dualScreenTop;
	var win = window.open(url,name,"left="+x+",top="+y+",width="+w / systemZoom+",height="+h / systemZoom+",toolbar=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1");
	//win.focus();
	//return win;
}