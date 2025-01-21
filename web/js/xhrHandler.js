//XHRHandler.js
//form == null --> get, form != null --> post

function XHRHandler( url,form,callBackSuc,callBackErr ){
	this.url    = url;
	this.form    = form;
	this.callBackSuc  = (callBackSuc)? callBackSuc : this.defaultSuccess;
	this.callBackErr  = (callBackErr)? callBackErr : this.defaultError;

	this.req   = null;
	this.method  = null;
	this.sPrams  = null;
	this.initXmlHttpRequest();
}

XHRHandler.prototype.initXmlHttpRequest = function(){
	if( window.XMLHttpRequest ){
		this.req = new XMLHttpRequest();
	}else if( window.ActiveXObject ){
		try{
			this.req = new ActiveXObject("Msxml2.XMLHTTP");
		}catch(e){
			this.req = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}

	if( this.form == null ){
		this.method = "POST";
	}else{
		this.method = "POST";

		var len = this.form.length;
		var sType = "";
		var sName = "";
		var sValue = "";
		for( var i=0; i<len; i++ ){
			sType = (this.form[i].type)?this.form[i].type:this.form[i].getAttribute("type");
			sName = (this.form[i].name)?this.form[i].name:this.form[i].getAttribute("name");
			
			if( !(sType=='hidden' || sType=='text'|| sType=='textarea'|| sType=='checkbox'|| sType=='radio'|| sType.indexOf('select')>-1) ) continue;
			
			if(sType.indexOf('select')>-1){
				sValue = (this.form[i].value)?this.form[i].value:this.form[i].options[this.form[i].selectedIndex].getAttribute("value");
			}else{
				sValue = (this.form[i].value)?this.form[i].value:this.form[i].getAttribute("value");
			}
			
			sValue = uriDataEncode(sValue);
			
			if( sName != null && sName != "" ){
				if( sType=="checkbox" || sType=="radio" ){
					if(!this.form[i].checked) continue;
				}
				
				if( this.sPrams == null ){
					this.sPrams = sName+"="+sValue;
				}else{
					this.sPrams += ("&"+sName+"="+sValue);
				}
			}
		}
	}
};

XHRHandler.prototype.defaultSuccess = function(){
	alert("XMLHttpRequest Success..");
};

XHRHandler.prototype.defaultError = function(){
	alert("XMLHttpRequest Error..");
};

XHRHandler.prototype.onReadyState = function(){
	var oReq = this.req;
	if( oReq.readyState == 4 ){
		if( oReq.status == 200 || oReq.status == 0 ){
			this.callBackSuc.call(this);
		}else{
			this.callBackErr.call(this);
		}
	}
};

XHRHandler.prototype.sendRequest = function(){
	if( this.req ){
		try{
			var handler = this;
			this.req.onreadystatechange = function(){
			handler.onReadyState.call(handler);
			}
			this.req.open(this.method,this.url,true);
			this.req.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			this.req.send(this.sPrams);
		}catch(e){
			this.callBackErr.call(this);
		}
	}
};

XHRHandler.prototype.sendRequestSync = function(){
	if( this.req ){
		try{
			var handler = this;
			this.req.onreadystatechange = function(){
			handler.onReadyState.call(handler);
			}
			this.req.open(this.method,this.url,false);
			this.req.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			this.req.send(this.sPrams);
		}catch(e){
			this.callBackErr.call(this);
		}
	}
};

function uriDataEncode(data) {
  if(data != null && data != "") {
       var encdata = '';
       var datas = data.split('&');
       for(i=0;i<datas.length;i++) {
        if(i==0)
         encdata = datas[i];
        else
         encdata += encodeURIComponent("&")+datas[i];
       }
       datas = encdata.split('%');
       for(i=0;i<datas.length;i++) {
        if(i==0)
         encdata = datas[i];
        else
         encdata += encodeURIComponent("%")+datas[i];
       }
       datas = encdata.split('+');
       for(i=0;i<datas.length;i++) {
        if(i==0)
         encdata = datas[i];
        else
         encdata += encodeURIComponent("+")+datas[i];
       }
  } else {
       encdata = "";
  }
  return encdata;
}