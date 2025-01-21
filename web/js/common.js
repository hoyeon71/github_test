//common.js

//map
Map = function(){
	this.map = new Object();
};   

Map.prototype = {   
	put : function(key, value){   
		this.map[key] = value;
	},   
	get : function(key){   
		return this.map[key];
	},
	containsKey : function(key){    
		return key in this.map;
	},
	containsValue : function(value){    
		for(var prop in this.map){
			if(this.map[prop] == value) return true;
		}
		return false;
	},
	isEmpty : function(key){    
		return (this.size() == 0);
	},
	clear : function(){   
		for(var prop in this.map){
			delete this.map[prop];
		}
	},
	remove : function(key){    
		delete this.map[key];
	},
	keys : function(){   
		var keys = new Array();   
		for(var prop in this.map){   
			keys.push(prop);
		}   
		return keys;
	},
	values : function(){   
		var values = new Array();   
		for(var prop in this.map){   
			values.push(this.map[prop]);
		}   
		return values;
	},
	size : function(){
		var count = 0;
		for (var prop in this.map) {
		count++;
		}
		return count;
	}
};

function isNull(v1,v2){
	if(v1==null) return v2;
	else v1;
}

function toRound(v,n){
	return parseFloat(parseFloat(v).toFixed(n));
}

function getCurDate(){
	var s = '';
	
	var oDate = new Date();
	s = oDate.getFullYear();
	
	var m = oDate.getMonth()+1;
	if(m<10){
		s+=('0'+m);
	}else{
		s+=(''+m);
	}
	
	var d = oDate.getDate();
	if(d<10){
		s+=('0'+d);
	}else{
		s+=(''+d);
	}
	
	return s;
}

function sReplace(s,s1,s2){
	if(s==null){
		return '';
	}else{
		var re = new RegExp(s1,"g");
		return s.replace(re,s2);
	}
}
function escapeJson(s) {
	if(s==null){
		return '';
	}else{
		return s.replace(/[\b]/g, '\\b')
			    .replace(/[\f]/g, '\\f')
			    .replace(/[\n]/g, '\\n')
			    .replace(/[\r]/g, '\\r')
			    .replace(/[\t]/g, '\\t');
	}
}

function trim(str){
	var leftI = 0;
	var rightI = 0;
	for(var i = 0; i<str.length;i++){
		if(str.substring(i,i+1)==" "){
			leftI++;
		}else{
			break;
		}
	}
	str = str.substring(leftI,str.length);

	for(var j=str.length; j>0;j--){
		if(str.substring(j-1,j)==" "){
			rightI++;
		}else{
			break;
		}
	}
	str = str.substring(0,str.length - rightI);

	return str;
}

function addComma(obj) {

	var num_str = obj.value;
	num_str = num_str.replace(/,/gi, "");
	var result = "";

	var num_rep = Number(num_str);
	if(num_rep < 0 ){
		num_str=num_str.substring(1,num_str.length);
	}

	for(var i=0; i<num_str.length; i++) {
		var tmp = num_str.length-(i+1);

		if(i%3==0 && i!=0){
			result = "," + result;
		}
	    result = num_str.charAt(tmp) + result;
	}
	if(num_rep < 0 ){
		result = '-'+result;
	}
	obj.value = result;
}


function rmComma(obj) {
	var num_str = obj.value;
    obj.value = num_str.replace(/,/gi,"");
}

function getOnlyNum(sValue) {
	return (trim(sValue).replace(/[^0-9]/g, ""));
}

function getOnlyEng(v){
	var len = v.length;
	var s ='';
	
	for(var i=0; i<len; i++) {
		var sTmp = v.substring(i,i+1);
		
		if(2>(sTmp.length+(escape(sTmp)+"%u").match(/%u/g).length-1)){
			s+=sTmp;
		}
	}
	
	return s;
	
}

//0123456789
function isOnlyNum(sValue) {
	var reg = new RegExp("^([0-9]+)$", "gi");
	if ( !reg.test(sValue) ){
		return false;
	}
	return true;
}

//0123456789abcdefghijklmnopqrstuvwxyz
function isId(sValue,minLen){

	if( sValue.length < minLen) return false;

    var reg = new RegExp("^([a-z])+([0-9a-z]+)$", "g");
	if ( !reg.test(sValue) ){
		return false;
	}
	
    return true;
}

function isJobName(sValue,minLen){

	if( sValue.length < minLen) return false;

    var reg = new RegExp("[ㄱ-ㅎ|ㅏ-ㅣ|가-힣\\$\\\\/*?()]", "g");
	if ( reg.test(sValue) ){
		return false;
	}
	
    return true;
}

function isEmail(sValue){

	var sChk = sValue;

	var reg = new RegExp("^([\\w\\-]+)+(\\@)+([\\w\\-]+)+(\\.[a-zA-Z]{2,3})$", "gi");
	if ( !reg.test(sChk) ){
		reg = new RegExp("^([\\w\\-]+)+(\\@)+([\\w\\\-]+)+(\\.[a-zA-Z]{2})+(\\.[a-zA-Z]{2})$", "gi");
		if ( !reg.test(sChk) ){
			return false;
		}
	}
	return true;
}

function isPw(sValue){
	var sChk = sValue;

	if(sChk.length<8) return false;
	
	var chk_1 = sChk.search(/[a-zA-Z]/gi);
	var chk_2 = sChk.search(/[0-9]/gi);
	var chk_3 = sChk.search(/[!,@,#,$,%,^,&,*,?,_,~]/gi); 
	if(chk_1 < 0 || chk_2 < 0 || chk_3 < 0 ) return false;
	
	return true;
}

function isJobId(sValue){
	var sChk = sValue;

	var reg = new RegExp("^([a-zA-Z])+([0-9a-zA-Z,@,#,$,_]+)$", "g");
	if ( !reg.test(sChk) ){
		return false;
	}
	
	return true;
}

function getClickedObjectIndex( obj ){

	var iGetedIndex  		= 0;
	var objAll 				= document.getElementsByTagName("*");
	var len 		    	= objAll.length;
	var arrObj            	= new Array(len);
	for( var i=0;i<len;i++ ){
		arrObj[i]  = objAll[i];
	}
	for( i=0;i<len;i++ ){
		if( arrObj[i] == obj ) break;
		if( arrObj[i].name == obj.name ) ++iGetedIndex;
	}
	return iGetedIndex;
}


function getObjIdx( obj,nm ){

	var objs  	= document.getElementsByName(nm);
	
	var idx = 0;
	for(var i=0;i<objs.length;i++){
		if( objs[i] == obj ){
			idx = i;
			break;
		}
	}
	
	return idx;
}


function resizeIframe(obj){
	if(obj.contentDocument){
		obj.height = obj.contentDocument.body.scrollHeight;
	} else {
		obj.height = obj.contentWindow.document.body.scrollHeight;
	}
}

function isIExplorer(){
	return navigator.appName == "Microsoft Internet Explorer";
}

function isNetscape(){
	return navigator.appName == "Netscape";
}

function getFileKb(str){
	var kb = "";
	if( str != null && str != "" ){
		var idx = str.lastIndexOf(".");

		if( idx != -1 ){
			kb = str.substring(idx+1,str.length);
			kb = kb.toLowerCase();
		}
	}
	return kb;
}

function getFileName(str){
	var nm = "";
	if( str != null && str != "" ){
		var idx = str.lastIndexOf("\\");

		if( idx != -1 ){
			nm = str.substring(idx+1,str.length);
		}else{
			idx = str.lastIndexOf("/");
			if( idx != -1 ){
				nm = str.substring(idx+1,str.length);
			}
		}
	}
	return nm;
}

function getHostUrl(sUrl){
	var aHost = new Array();
	var vUrl = "";

	aHost = sUrl.split("//");
	vUrl = aHost[0]+"//"+aHost[1].substring(0,aHost[1].indexOf("/"));
	return vUrl;
}

function isNullInput(obj,msg){
	var sValue = "";
	
	try{
		sValue = ( (obj.val()!=null&&obj.val()!='')? trim(obj.val()):"" );
	}catch(e){
		sValue = ( (obj.value!='')? trim(obj.value):"" );
	}
	
	if( sValue != "" ) return false;

	alert(msg);
	try{obj.focus();}catch(e){}
	return true;
}

function isNullChecked(obj,msg){
	if( obj == null ) return false;

	if( obj.length > 1){
		var iChk = 0;
		for(var i=0; i<obj.length; i++){
			if( obj[i].checked ) iChk++;
		}
		if( iChk==0 ){
			alert(msg);
			try{obj[0].focus();}catch(e){}
			return true;
		}
	}else{
		if( !obj.checked ){
			alert(msg);
			try{obj.focus();}catch(e){}
			return true;
		}
	}


}

function moveLayer(obj,iTop){
	obj.style.top =  iTop + ( (document.body.scrollTop==0)?document.documentElement.scrollTop:document.body.scrollTop );
}

function setSelectMonth(year,objM,objD,idx) {

	var k = "";
	objM.length = 12+idx;
	for(var i=0; i < 12; i++){

		if( (i+1)<10 ){
			k = "0"+(i+1);
			objM[i+idx].value = k;
			objM[i+idx].text  = k;
		}else{
			objM[i+idx].value = (i+1);
			objM[i+idx].text  = (i+1);
		}
	}
	setSelectDay(year,objM.value,objD,0);
}

function setSelectDay(year,month,obj,idx) {

	var iYear  = parseInt(year,10);
	var iMonth = parseInt(month,10)-1;

	var last  = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30 ,31);
	if ((iYear%400==0 ) || (iYear%4==0 && iYear%100 != 0)) {
		last[1]=29;
	}

	var k = "";
	obj.length  = last[iMonth]+idx;
	for(var i=0; i < last[iMonth]; i++){
		if( (i+1)<10 ){
			k = "0"+(i+1);
			obj[i+idx].value = k;
			obj[i+idx].text  = k;
		}else{
			obj[i+idx].value = (i+1);
			obj[i+idx].text  = (i+1);
		}
	}
}

function setRssFeedLink(url,title){
	var oLink = top.document.getElementsByTagName("link");

	var sTmp = "";
	var sRel = "alternate";
	var obj = null;
	for( var i=0; oLink!=null && i<oLink.length; i++ ){
		if( oLink[i].getAttribute("rel") != null ){
			sTmp = oLink[i].getAttribute("rel");
			if( sRel == sTmp.toLowerCase() ) obj = oLink[i];
		}
	}

	if( obj != null ){
		obj.setAttribute("href",url);
		obj.setAttribute("title",title);
	}else{
		obj = top.document.createElement("link");
		obj.setAttribute("rel",sRel);
		obj.setAttribute("type","application/rss+xml");
		obj.setAttribute("href",url);
		obj.setAttribute("title",title);

		var oHead = top.document.getElementsByTagName("head")[0];
		oHead.appendChild(obj);
	}
}

function select2select(obj1, obj2) {
	var k = "";
	var tmpValue = obj1.value;
	obj1.length = 1;
	obj1.length = obj2.length;
	for(var i=0; i < obj2.length; i++){

		obj1[i].value = obj2[i].value;
		obj1[i].text  = obj2[i].text;
	}
	for(var i=0; i < obj1.length; i++){
		if( tmpValue!="" && tmpValue==obj1[i].value) obj1[i].selected = true;	
	}
	
	if(obj2.offsetWidth>0) obj1.style.width = obj2.offsetWidth;
}

function select2select_1(obj1, obj2) {
	var k = "";
	var tmpValue = obj1.value;
	obj1.length = 1;
	obj1.length = obj2.length;
	for(var i=0; i < obj2.length; i++){

		obj1[i].value = obj2[i].value;
		obj1[i].text  = obj2[i].text;
	}
	for(var i=0; i < obj1.length; i++){
		if( tmpValue!="" && tmpValue==obj1[i].value) obj1[i].selected = true;	
	}
}

function changeImg(obj,img_path){
	obj.src = img_path;
}

function displayLayer(id){
	var obj = document.getElementById(id);
	
	if( obj != null ){
		if( obj.style.display == "none"){
			obj.style.display = "inline";
		}else{
			obj.style.display = "none";
		}
	}
}

function rdoSelectedValue(obj){
	if( obj != null ){
		for(var i=0; i<obj.length; i++){
			if(obj[i].checked){
				return obj[i].value;
			}
		}
	}
	return '';
}

function setRadio(obj,v){
	if( obj != null ){
		for(var i=0; i<obj.length; i++){
			if(obj[i].value == v){
				obj[i].checked = true;
				return;
			}
		}
	}
	return '';
}

function setSelectedValue(obj,v){
	if( obj != null ){
		for(var i=0; i<obj.length; i++){
			if(obj[i].value == v){
				obj[i].selected = true;
				return;
			}
		}
	}
}

function setSelectedText(obj,t){
	if( obj != null ){
		for(var i=0; i<obj.length; i++){
			if(obj[i].text == t){
				obj[i].selected = true;
				return;
			}
		}
		try{obj[0].selected = true;}catch(e){}
	}
}

function setSelectedValue_1(obj,v,t){
	if( obj != null ){
		for(var i=0; i<obj.length; i++){
			if(obj[i].value == v){
				obj[i].selected = true;
				return;
			}
		}
		obj.length = obj.length+1;
		obj[obj.length-1].value = v;
		obj[obj.length-1].text  = t;
		obj[obj.length-1].selected = true;
	}
}

function getStringByteCnt(s){
	return(s.length+(escape(s)+"%u").match(/%u/g).length-1);
}

function getArrExtChar(){
	return new Array('※','☆','★','○','●','◎','◇','◆','□','■','△','▲','▽','▼','→','←','↑','↓','↔','◁','♪','◀','▷','▶','♤','♠','♡','♥','♧','♣','⊙','◈','▣','◐','◑','♨','☏','☎','☞','☜','㈜','℡','↗','↙','↖','↘','ψ');
	
}

function getDocumentTextSelection(){
	if(window.getSelection) return window.getSelection();
	else if(document.getSelection) return document.getSelection();
	else if(document.selection) return document.selection.createRange().text;
}

function postHref(url,target) { 
	
	if(document.getElementById('postHref')!=null) document.body.removeChild(document.getElementById('postHref')); 
	
	var f = document.createElement("FORM");
	
	f.setAttribute('method','post');
	f.setAttribute('target',target);
	f.setAttribute('action',url);
	f.setAttribute('id','postHref');
	f.setAttribute('enctype','multipart/form-data');
	
	document.body.appendChild(f);
	
	document.getElementById('postHref').submit();
	
} 

function goCommonError(sContextPath,target,msg_code){
	postHref(sContextPath+'/common.do?c=c00&a=works.common.error&msg_code='+msg_code,target);
}

function getDateOfWeekKor(date){
	var cal = new Date(parseInt(date.substring(0,4),10),parseInt(date.substring(4,6),10)-1,parseInt(date.substring(6,8),10));
	var aDayOfWeek=["일","월","화","수","목","금","토"];
		
	return aDayOfWeek[cal.getDay()];
 
}

function setSelectItemList(url){
	var frm = document.f_si;
	
	var xhr = new XHRHandler( url,frm
			,function(){
				var xmlDoc = this.req.responseXML;
					
				var obj = null;
					
				var oSelect = xmlDoc.getElementsByTagName('select')[0];
				
				obj = document.createElement("select");
				obj.setAttribute("id",oSelect.getAttribute('id'));
				obj.setAttribute("name",oSelect.getAttribute('name'));
				
				var oOption = xmlDoc.getElementsByTagName('option');
				for(var i=0;i<oOption.length;i++){
					if(oOption[i].firstChild==null) continue;
					
					var oTmp = document.createElement("option");
					oTmp.value = oOption[i].getAttribute('value');
					oTmp.text = oOption[i].firstChild.nodeValue;
						
					obj.options.add(oTmp);
				}
					
				if(null!=document.getElementById(obj.getAttribute('id'))) select2select(document.getElementById(obj.getAttribute('id')),obj);
				
			}
	,null );
	xhr.sendRequest();
}

function setSelectItemList_1(url,v){
	var frm = document.f_si;
	
	var xhr = new XHRHandler( url,frm
			,function(){
				var xmlDoc = this.req.responseXML;
					
				var obj = null;
					
				var oSelect = xmlDoc.getElementsByTagName('select')[0];
				
				obj = document.createElement("select");
				obj.setAttribute("id",oSelect.getAttribute('id'));
				obj.setAttribute("name",oSelect.getAttribute('name'));
				
				var oOption = xmlDoc.getElementsByTagName('option');
				for(var i=0;i<oOption.length;i++){
					if(oOption[i].firstChild==null) continue;
					
					var oTmp = document.createElement("option");
					oTmp.value = oOption[i].getAttribute('value');
					oTmp.text = oOption[i].firstChild.nodeValue;
						
					obj.options.add(oTmp);
				}
					
				if(null!=document.getElementById(obj.getAttribute('id'))){
					select2select(document.getElementById(obj.getAttribute('id')),obj);
					setSelectedValue(document.getElementById(obj.getAttribute('id')),v);
				}
				
			}
	,null );
	xhr.sendRequest();
}

//자릿수만큼 0으로 채우기.
function transNumberFormat(_date, num) {
	var zero = '';
	_date = _date.toString();

	if (_date.length < num) {
		for (i = 0; i < num - _date.length; i++)
		zero += '0';
	}
	
	return zero + _date;
}

//C-M 금칙 문자 체크.
function isValid_C_M() {

	var table_name 			= document.getElementById('table_name');
	var job_name 			= document.getElementById('job_name');
	var group_name 			= document.getElementById('group_name');
	var application 		= document.getElementById('application');
	var rerun_max 			= document.getElementById('rerun_max');
	var rerun_interval 		= document.getElementById('rerun_interval');
	var mem_lib 			= document.getElementById('mem_lib');
	var max_wait 			= document.getElementById('max_wait');
	var node_id 			= document.getElementById('node_id');
	var mem_name 			= document.getElementById('mem_name');
	var owner 				= document.getElementById('owner');
	var author 				= document.getElementById('author');
	var time_from 			= document.getElementById('time_from');
	var time_until 			= document.getElementById('time_until');
	var priority 			= document.getElementById('priority');
	var late_exec 			= document.getElementById('late_exec');

	if (table_name) {
		isValid_C_M_blank(table_name.value, "스케줄테이블");
		isValid_C_M_single(table_name.value, "스케줄테이블");
	}
	
	if (job_name) {
		isValid_C_M_blank(job_name.value, "JOB NAME");
		isValid_C_M_single(job_name.value, "JOB NAME");
	}
	
	if (group_name) {
		isValid_C_M_blank(group_name.value, "그룹명");
		isValid_C_M_single(group_name.value, "그룹명");
	}
	
	if (application) {
		isValid_C_M_blank(application.value, "어플리케이션");
		isValid_C_M_single(application.value, "어플리케이션");
	}
	
	if (rerun_max) {
		isValid_C_M_blank(rerun_max.value, "최대반복 횟수");
		isValid_C_M_single(rerun_max.value, "최대반복 횟수");
		isValid_C_M_character(rerun_max.value, "최대반복 횟수");
	}
	
	if (rerun_interval) {
		isValid_C_M_blank(rerun_interval.value, "반복 주기");
		isValid_C_M_single(rerun_interval.value, "반복 주기");
		isValid_C_M_character(rerun_interval.value, "반복 주기");
		isValid_C_M_max(rerun_interval.value, 64800, "반복 주기");
	}
	
	if (mem_lib) {
		isValid_C_M_blank(mem_lib.value, "파일경로");
	}
	
	if (max_wait) {
		isValid_C_M_blank(max_wait.value, "Max Wait");
		isValid_C_M_single(max_wait.value, "Max Wait");
		isValid_C_M_character(max_wait.value, "Max Wait");
	}
	
	if (node_id) {
		isValid_C_M_blank(node_id.value, "수행서버");
		isValid_C_M_single(node_id.value, "수행서버");
	}
	
	if (mem_name) {
		isValid_C_M_blank(mem_name.value, "파일이름");
		isValid_C_M_single(mem_name.value, "파일이름");
	}
	
	if (owner) {
		isValid_C_M_blank(owner.value, "계정명");
	}
	
	if (author) {
		isValid_C_M_blank(author.value, "담당자");
		isValid_C_M_single(author.value, "담당자");
	}
	
	if (late_exec) {
		isValid_C_M_blank(late_exec.value, "수행임계시간");
		isValid_C_M_single(late_exec.value, "수행임계시간");
		isValid_C_M_character(late_exec.value, "수행임계시간");
	}
	
	/*
	if (time_from) {
		isValid_C_M_blank(time_from.value, "시작 및 종료시간");
		isValid_C_M_single(time_from.value, "시작 및 종료시간");
		isValid_C_M_character(time_from.value, "시작 및 종료시간");
		isValidHHMI(time_from.value, "시작 및 종료시간");
		
	}
	
	if (time_until) {
		isValid_C_M_blank(time_until.value, "시작 및 종료시간");
		isValid_C_M_single(time_until.value, "시작 및 종료시간");
		isValidTimeUntilHHMI(time_until.value, "시작 및 종료시간");
	}
	*/
	
	if (priority) {
		isValid_C_M_blank(priority.value, "우선순위");
		isValid_C_M_single(priority.value, "우선순위");
	}

	obj = document.getElementsByName('m_in_condition_name');	
	if( obj!=null && obj.length>0 ){
		for( var i=0; i<obj.length; i++ ){
			if( trim(obj[i].value) != "" ){
				var sTmp = obj[i].value;
				
				if (sTmp) {
					isValid_C_M_blank(sTmp, "선행작업조건");
					isValid_C_M_single(sTmp, "선행작업조건");
				}
			}
		}
	}

	obj = document.getElementsByName('m_out_condition_name');	
	if( obj!=null && obj.length>0 ){
		for( var i=0; i<obj.length; i++ ){
			if( trim(obj[i].value) != "" ){
				var sTmp = obj[i].value;
				
				if (sTmp) {
					isValid_C_M_blank(sTmp, "후행작업조건");
					isValid_C_M_single(sTmp, "후행작업조건");
				}
			}
		}
	}
	
	obj = document.getElementsByName('m_var_name');
	if( obj!=null && obj.length>0 ){
		for( var i=0; i<obj.length; i++ ){
			if( trim(obj[i].value) != "" ){
				var sTmp = obj[i].value;					
				
				if (sTmp) {
					isValid_C_M_blank(sTmp, "Var Name");
					isValid_C_M_speacial(sTmp, "Var Name");
				}
			}
		}
	}
	
	obj = document.getElementsByName('m_quantitative_res_name');
	if( obj!=null && obj.length>0 ){
		for( var i=0; i<obj.length; i++ ){
			if( trim(obj[i].value) != "" ){
				var sTmp = obj[i].value;
				
				if (sTmp) {
					isValid_C_M_blank(sTmp, "Quantitative resources의 Name");					
				}
				
				var sTmp2 = document.getElementsByName('m_quantitative_required_usage')[i].value;
				
				if (sTmp2) {
					isValid_C_M_blank(sTmp2, "Quantitative resources의 Required Usage");
					isValid_C_M_character(sTmp2, "Quantitative resources의 Required Usage");		
					isValid_C_M_max(sTmp2, 9999, "Quantitative resources의 Required Usage");
				}
			}
		}
	}
	
	obj = document.getElementsByName('m_control_res_name');
	if( obj!=null && obj.length>0 ){
		for( var i=0; i<obj.length; i++ ){
			if( trim(obj[i].value) != "" ){
				var sTmp = obj[i].value;

				if (sTmp) {
					isValid_C_M_blank(sTmp, "Control resources의 Name");					
				}
			}
		}
	}
	
	obj = document.getElementsByName('m_postproc_when');
	if( obj!=null && obj.length>0 ){
		for( var i=0; i<obj.length; i++ ){
			if( trim(obj[i].value) != "" ){
				var sTmp = document.getElementsByName('m_postproc_to')[i].value;
				
				if (sTmp) {
					isValid_C_M_blank(sTmp, "PostProc의 To");		
					isValid_C_M_single(sTmp, "PostProc의 To");	
				}
			}
		}
	}
	
	/*obj = document.getElementsByName('m_step_opt');
	if( obj!=null && obj.length>0 ){
		for( var i=0; i<obj.length; i++ ){
			if( trim(obj[i].value) != "" ){
				
				var sTmp = "";
				
				var step_type = document.getElementsByName('m_step_type')[i].value;
				
				if( step_type=="Statement" ){
					sTmp += (","+document.getElementsByName('m_step_statement_stmt')[i].value);
					sTmp += (","+document.getElementsByName('m_step_statement_code')[i].value);
				}else if( step_type=="Set-Var" ){
					sTmp += (","+document.getElementsByName('m_step_set-var_name')[i].value);
					sTmp += (","+document.getElementsByName('m_step_set-var_value')[i].value);
				}else if( step_type=="Shout" ){
					sTmp += (","+document.getElementsByName('m_step_shout_to')[i].value);
					sTmp += (","+document.getElementsByName('m_step_shout_urgn')[i].value);
					sTmp += (","+document.getElementsByName('m_step_shout_msg')[i].value);
				}else if( step_type=="Force-Job" ){
					
					sTmp = document.getElementsByName('m_step_force-job_table')[i].value;
					
					if (sTmp) {
						isValid_C_M_blank(sTmp, "Step의 Force-Job");	
						isValid_C_M_single(sTmp, "Step의 Force-Job");	
					}
					
					sTmp = document.getElementsByName('m_step_force-job_job_name')[i].value;
					
					if (sTmp) {
						isValid_C_M_blank(sTmp, "Step의 Force-Job");	
						isValid_C_M_single(sTmp, "Step의 Force-Job");	
					}
					
				}else if( step_type=="Sysout" ){
					
					sTmp = document.getElementsByName('m_step_sysout_parm')[i].value;
					
					if (sTmp) {
						isValid_C_M_blank(sTmp, "Step의 Sysout");		
					}

				}else if( step_type=="Condition" ){
					sTmp += (","+document.getElementsByName('m_step_condition_name')[i].value);
					sTmp += (","+document.getElementsByName('m_step_condition_date')[i].value);
					sTmp += (","+document.getElementsByName('m_step_condition_sign')[i].value);
				}else if( step_type=="Mail" ){
					sTmp += (","+document.getElementsByName('m_step_mail_to')[i].value);
					sTmp += (","+document.getElementsByName('m_step_mail_cc')[i].value);
					sTmp += (","+document.getElementsByName('m_step_mail_subject')[i].value);
					sTmp += (","+document.getElementsByName('m_step_mail_urgn')[i].value);
					sTmp += (","+document.getElementsByName('m_step_mail_msg')[i].value);
				}
			}
		}
	}	*/
}

//C-M 공백 금지.
function isValid_C_M_blank(val, name) {
	
	var blank_pattern = /[\s]/g;
	
	if ( blank_pattern.test(val) == true ) {
		
		alert(name+"에 공백은 사용할 수 없습니다.");
		
		// 다음 로직을 수행하지 않기 위해.
		document.getElementById('is_valid_flag').value = "false";
	}	
}

//C-M Single quotation 금지.
function isValid_C_M_single(val, name) {
	
	var pattern = /[']/gi;
	
	if ( pattern.test(val) == true ) {
		
		alert(name+"에 홑따옴표(')는 사용할 수 없습니다.");

		// 다음 로직을 수행하지 않기 위해.
		document.getElementById('is_valid_flag').value = "false";
	}	
}

//C-M 특수문자 금지.
function isValid_C_M_speacial(val, name) {
	
	var pattern = /[~!@\#$%^&*\()\[\]\<>\{}|=+_'.?:;"-]/gi;
	
	if ( pattern.test(val) == true ) {
	
		//카카오페이 변수명 특수문자허용 2022.08.11 이상훈
		if(name == 'Var Name'){
		
		}else{
		alert(name+"에 특수문자는 사용할 수 없습니다.");
		
		// 다음 로직을 수행하지 않기 위해.
		
		document.getElementById('is_valid_flag').value = "false";
		}
		
	}	
}

//C-M 숫자만 사용.
function isValid_C_M_character(val, name) {
	
	var pattern = new RegExp("^([0-9]+)$", "gi");
	
	if ( val != "" ) {

		if ( !pattern.test(val) ) {
			
			alert(name+"에 문자는 사용할 수 없습니다.");
			
			// 다음 로직을 수행하지 않기 위해.
			document.getElementById('is_valid_flag').value = "false";
		}
	}
}

//C-M 숫자 최대값.
function isValid_C_M_max(val, max_val, name) {

	if ( val != "" ) {

		if ( val > max_val ) {
			
			alert(name+" 최대값은 " + max_val + "입니다.");
			
			// 다음 로직을 수행하지 않기 위해.
			document.getElementById('is_valid_flag').value = "false";
		}
	}
}

var cnt=0;
function chkAll(checked) {
	var chk = document.getElementsByName(checked);

	if (cnt==0) {
		for(i = 0; i < chk.length; i++) {
			if(chk.item(i).disabled) {
				chk.item(i).checked = "";
			}else {
				chk.item(i).checked ="checked";
			}
		}
		cnt++;
	}else {
		for(i = 0; i < chk.length; i++) chk.item(i).checked ="";
		cnt=0;
	}
}

//월 체크
function isValidMonth(mm) {
    var m = parseInt(mm,10);
    return (m >= 1 && m <= 12);
}

// 일 체크
function isValidDay(yyyy, mm, dd) {
    var m = parseInt(mm,10) - 1;
    var d = parseInt(dd,10);

    var end = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
    if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) {
        end[1] = 29;
    }

    return (d >= 1 && d <= end[m]);
}

// 날짜 체크 (yyyymmdd)
function isValidTime(time) {
    var year  = time.substring(0,4);
    var month = time.substring(4,6);
    var day   = time.substring(6,8);

    if (parseInt(year,10) >= 1900  && isValidMonth(month) &&
        isValidDay(year,month,day) ) {
        return true;
    }
    return false;
}

function isValidHHMI(val, name) {
	
	if ( val != "" && val.length != 4 ) {

    	alert(name + "의 형식은 숫자 4자리 입니다.");
		
		// 다음 로직을 수행하지 않기 위해.
		document.getElementById('is_valid_flag').value = "false";
    }
	
	if ( val != "" ) {
	
		if ( val.substring(0,2) < 24 && val.substring(2,4) < 60 ) {
		
		} else {
		
			alert(name + "의 형식은 HHMI 입니다.");
			
			// 다음 로직을 수행하지 않기 위해.
			document.getElementById('is_valid_flag').value = "false";
		}
	}
}

function isValidTimeUntilHHMI(val, name) {
	
	if ( val != "" && val != ">" &&val.length != 4 ) {

    	alert(name + "의 형식은 숫자 4자리 입니다.");
		
		// 다음 로직을 수행하지 않기 위해.
		document.getElementById('is_valid_flag').value = "false";
    }
	
	if ( val != "" && val != ">" ) {
	
		if ( val.substring(0,2) < 24 && val.substring(2,4) < 60 ) {
		
		} else {
		
			alert(name + "의 형식은 HHMI 입니다.");
			
			// 다음 로직을 수행하지 않기 위해.
			document.getElementById('is_valid_flag').value = "false";
		}
	}
}

function replaceAll(sValue, param1, param2) {
    return sValue.split(param1).join(param2);
}

function replaceHtmlStr(str) {
	str = replaceAll(str, "&lt;", "<");
	str = replaceAll(str, "&gt;", ">");
	str = replaceAll(str, "&quot;", "\"");
	str = replaceAll(str, "&apos;", "\'");
	str = replaceAll(str, "&amp;", "&");
	str = replaceAll(str, "<br>", "\n");
	return str;
}

function replaceStrHtml(str) {
	str = replaceAll(str, "<", "&lt;");
	str = replaceAll(str, ">", "&gt;");
	str = replaceAll(str, "\"", "&quot;");
	str = replaceAll(str, "\'", "&apos;");
	str = replaceAll(str, "\n", "<br>");
	return str;
}