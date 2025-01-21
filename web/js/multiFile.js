/* ----- ex -------------
sTmp = "<div style='padding:5px;'>";
		sTmp += "<div id='layerInputFiles' >";
		sTmp += "<div id='layerInputFile1' >";
		sTmp += "<input type='file' name='attach_files' onchange='attachFile(this);' style='width:100%;' >";
		sTmp += "</div>";
		sTmp += "</div>";
		sTmp += "<div style='background-color:#cde6ff;margin-top:3px;padding:5px;' >";
		sTmp += "<div style='text-align:right;padding-right:2px;' >[최대 100M]</div>";
		sTmp += "<div id='layerDisplayFiles' >No files..</div>";
		sTmp += "</div>";
		sTmp += "</div>";
---------ex------------*/

var fileLayerId = 1;

function attachFile(obj) {
	$(obj).parent().css({'width':'0px','height':'0px','overflow':'hidden'});
	
	var inputFileName = obj.name;
	var inputFileValue = obj.value;

	addFile(inputFileName,inputFileValue);
}

function addFile(inputFileName,inputFileValue) {
	fileLayerId++;

	var displayFile = "<div id='layerDisplayFile"+fileLayerId+"'><div>"+getFileName(inputFileValue)+" <span onclick=\"removeFile("+fileLayerId+",'"+inputFileName+"');\" style='color:red;cursor:pointer;'>[del]</span></div></div>";

	var inputFileCnt = document.getElementsByName(inputFileName).length;
	if( inputFileCnt > 1 ){
		document.getElementById("layerDisplayFiles").innerHTML += displayFile;
	}else{
		document.getElementById("layerDisplayFiles").innerHTML = displayFile;
	}

	var obj = document.createElement("div");
	obj.setAttribute("id","layerInputFile"+fileLayerId);
	obj.innerHTML = "<input type='file' name='"+inputFileName+"' onchange='attachFile(this);' style='width:100%;' />";
	document.getElementById("layerInputFiles").appendChild(obj);

}

function removeFile(id,inputFileName) {
	document.getElementById("layerDisplayFile"+id).innerHTML = "";
	document.getElementById("layerInputFile"+(id-1)).innerHTML = "";

	if( document.getElementsByName(inputFileName) == null ){
		document.getElementById("layerDisplayFiles").innerHTML = "No files..";
		document.getElementById("layerInputFile1").innerHTML = "<input type='file' name='"+inputFileName+"' onchange='attachFile(this);' style='width:100%;' />";
	}else{
		var inputFileCnt = document.getElementsByName(inputFileName).length;
		if( inputFileCnt == 1 )	document.getElementById("layerDisplayFiles").innerHTML = "No files..";
	}

}
