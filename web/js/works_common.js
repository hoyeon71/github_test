//works

var grid_vscroll = true;
var dlMap = new Map();
var in_select_type = {ODAT:'ODAT', STAT:'STAT', PREV:'PREV'};
var in_select_gb = {and:'AND', or:'OR'};
var out_select_type = {ODAT:'ODAT', STAT:'STAT', PREV:'PREV', NEXT:'NEXT', '****':'****'};
var out_select_gb = {add:'ADD', 'delete':'DELETE'}; 

function dlFrontView(id){
	$( "#"+id ).dialog("moveToTop");
}

function dlClose(id){
	$( "#"+id ).dialog().dialog("close");
}

function decodeHtmlEntities(encodedString) {
  return encodedString.replace(/&amp;/g, "&")
                     .replace(/&lt;/g, "<")
                     .replace(/&gt;/g, ">")
                     .replace(/&quot;/g, "\"")
                     .replace(/&apos;/g, "'");
}


function dlPopIframe01(id,nm,w,h,bResize,bMax,bRef){
	
	$("#" + id).dialog({
		title: nm
		,width: w+2
		,height: h+32
		,position: {my: "center center+"+(dlMap.size()*20)+"px"
					,at: "center center-50"
					,of:$(document)	
					}
		,resizable: bResize
		,maximize: bMax
		,maximizeFx: {easing: null, duration: 'normal'
						, complete: function( ) {
							setTimeout(function(){
								$('iframe').show();
								$("#" + id +' iframe').width('100%').height('100%').show();
							}, 300);
						}
						, start: function( ) {
							$('iframe').hide();
							$("#" + id +' iframe').hide();
						}
		}
        ,restoreFx:  {easing: null, duration: 'normal'
						, complete: function( ) {
							setTimeout(function(){
								$('iframe').show();
								$("#" + id +' iframe').width('100%').height('100%').show();
							}, 300);
						}
						, start: function( ) {
							$('iframe').hide();
							$("#" + id +' iframe').hide();
						}
		}
		,refresh: bRef
		,show :'fadeIn'
		,resizeStart: function( event, ui ) {
			//$(event.target).parent().css('position', 'fixed');
			//$(this).dialog('option','position',$(this).dialog( "option", "position" ));
			$('iframe').hide();
			$("#" + id +' iframe').hide();
		}
		,resizeStop: function( event, ui ) {
			//$(event.target).parent().css('position', 'fixed');
			//$(this).dialog('option','position',$(this).dialog( "option", "position" ));
			$('iframe').show();
			$("#" + id +' iframe').width('100%').height('100%').show();
		}
		,open : function( event, ui ) {
			$(event.target).parent().css('position', 'fixed');
			$("#" + id +' iframe').width('100%').height('100%');
		}
		,close : function( event, ui ) {
			$("#" + id +' iframe').attr('src','');
			dlMap.remove(id);
			
			$(this).dialog( "destroy" );
		}
		
		,dragStart: function( event, ui ) {
			//$(this).dialog('option','position',$(this).dialog( "option", "position" ));
			$('iframe').hide();
		}
		,dragStop: function( event, ui ) {
			$('iframe').show();
		}
	}).data("dialog").uiDialog.draggable('option', 'opacity', 0.7).draggable( "option", "containment", " body" );
	
	dlMap.put(id, 'init');
	$("#" + id +' iframe').load(function(){
		$(this).contents().find("body").unbind('click').click(function(){
			dlFrontView(id);
		});
	});
	
}

function dlPop01(id,nm,w,h,bResize){

	try {
		applyOverlay(); // 팝업이 열리기 전에 블러 효과 적용
	} catch(e) {
	}

	$("#" + id).dialog({
		title: nm
		,modal: false
		,width: w+2
		,height: h+32
		,position: "center"
		,resizable: bResize
		,show :'fadeIn'
		,close : function( event, ui ) {
			$(this).dialog("destroy");
			try {
				removeOverlay(); // 팝업이 닫힐 때 블러 효과 제거
			} catch(e) {}
		}
	});
}

function dlPop02(id,nm,w,h,bResize,closeFn){
	try {
		applyOverlay(); // 팝업이 열리기 전에 블러 효과 적용
	} catch(e) {
	}
	$("#" + id).dialog({
		title: nm
		,modal: false
		,width: w+2
		,height: h+32
		,position: "center"
		,resizable: bResize
		,show :'fadeIn'
		,beforeClose : closeFn
		,close : function( event, ui ) {
			$(this).dialog( "destroy" );
			try {
				removeOverlay(); // 팝업이 닫힐 때 블러 효과 제거
			} catch(e) {}
		}
	});
}

function dlPop03(id,nm,w,h,bResize){


	$("#" + id).dialog({
		title: nm
		,modal: false
		,width: w+2
		,height: h+32
		,position: "center"
		,resizable: bResize
		,show :'fadeIn'
		,close : function( event, ui ) {
			$(this).dialog("destroy");
		}
	});
}

function dlPopModal01(id,nm,w,h,bResize){
	$("#" + id).dialog({
		title: nm
		,modal: true
		,width: w+2
		,height: h+32
		,position: "center"
		,resizable: bResize
		,show :'fadeIn'
		
		,close : function( event, ui ) {
			$.unblockUI();
			$(this).dialog( "destroy" );
		}
	});
	
}

function dlPopModal02(id,nm,w,h,bResize,closeFn){
	$("#" + id).dialog({
		title: nm
		,modal: true
		,width: w+2
		,height: h+32
		,position: "center"
		,resizable: bResize
		,show :'fadeIn'
		,beforeClose : closeFn
		,close : function( event, ui ) {
			$(this).dialog( "destroy" );
		}
	});
}

function dpCal(id,df){
	$( "#"+id ).datepicker({
		changeYear: true
		,changeMonth: true
		,showMonthAfterYear : true
		,dateFormat: df
		,dayNames : ['일','월','화','수','목','금','토']
		,dayNamesMin : ['일','월','화','수','목','금','토']
		,dayNamesShort : ['일','월','화','수','목','금','토']
		,monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,showAnim :'fadeIn'
		,yearRange : 'c-5:c+1'
		,beforeShow: function(input, inst){
						if(navigator.appName == "Microsoft Internet Explorer"){
						}
						setTimeout(function(){
							$(".ui-datepicker").css("z-index", 99999999);
						}, 20); 
					}
		,close : function( event, ui ) {
			$(this).datepicker( "destroy" );
		}

	});
	$( "#"+id ).focus();
}

function dpCalMax(id,df,sMax){
	$( "#"+id ).datepicker({
		changeYear: true
		,changeMonth: true
		,showMonthAfterYear : true
		,dateFormat: df
		,dayNames : ['일','월','화','수','목','금','토']
		,dayNamesMin : ['일','월','화','수','목','금','토']
		,dayNamesShort : ['일','월','화','수','목','금','토']
		,monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,showAnim :'fadeIn'
		,yearRange : 'c-5:c+1'
		,maxDate : sMax
		,beforeShow: function(input, inst){
						if(navigator.appName == "Microsoft Internet Explorer"){
						}
						setTimeout(function(){
							$(".ui-datepicker").css("z-index", 99999999);
						}, 20); 
					}
		,close : function( event, ui ) {
			$(this).datepicker( "destroy" );
		}

	});
	$( "#"+id ).focus();
}

function dpCalMinMulti(id,df,count){
	$( "#"+id ).multiDatesPicker({
		changeYear : true
//		, maxPicks : 5
		,changeMonth : true
		,showMonthAfterYear : true
		,dateFormat : df
		,dayNames : ['일','월','화','수','목','금','토']
		,dayNamesMin : ['일','월','화','수','목','금','토']
		,dayNamesShort : ['일','월','화','수','목','금','토']
		,monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,showAnim :'fadeIn'
		,yearRange : 'c-5:c+1'
//		,minDate : sMin
		,beforeShow : function(input, inst){
						if(navigator.appName == "Microsoft Internet Explorer"){
						}
						setTimeout(function(){
							$(".ui-multiDatesPicker").css("z-index", 99999999);
						}, 20); 
					}
		,close : function( event, ui ) {
			$(this).multiDatesPicker( "destroy" );
		}
	});
	$( "#"+id ).focus();
	
	if(count < 2){
		$.datepicker._selectDateOverload = $.datepicker._selectDate;
		$.datepicker._selectDate = function(id, dateStr) {
			var target = $(id);
			var inst = this._getInst(target[0]);
			inst.inline = true;
			$.datepicker._selectDateOverload(id, dateStr);
			inst.inline = false;
			
			if (target[0].multiDatesPicker != null) {
				target[0].multiDatesPicker.changed = false;
			} else {	
				target.multiDatesPicker.changed = true;
			}
			this._updateDatepicker(inst);
			
			if (target[0].multiDatesPicker == undefined) {
				this._hideDatepicker();
				target[0].blur();
			}
		};
	}
}

function dpCalMin(id,df,sMin){
	$( "#"+id ).datepicker({
		changeYear: true
		,changeMonth: true
		,showMonthAfterYear : true
		,dateFormat: df
		,dayNames : ['일','월','화','수','목','금','토']
		,dayNamesMin : ['일','월','화','수','목','금','토']
		,dayNamesShort : ['일','월','화','수','목','금','토']
		,monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,showAnim :'fadeIn'
		,yearRange : 'c-5:c+1'
		,minDate : sMin
		,beforeShow: function(input, inst){
						if(navigator.appName == "Microsoft Internet Explorer"){
						}
						setTimeout(function(){
							$(".ui-datepicker").css("z-index", 99999999);
						}, 20); 
					}
		,close : function( event, ui ) {
			$(this).datepicker( "destroy" );
		}
	});
	$( "#"+id ).focus();
}


function dpCalMinMax(id,df,sMin,sMax){
	$( "#"+id ).datepicker({
		changeYear: true
		,changeMonth: true
		,showMonthAfterYear : true
		,dateFormat: df
		,dayNames : ['일','월','화','수','목','금','토']
		,dayNamesMin : ['일','월','화','수','목','금','토']
		,dayNamesShort : ['일','월','화','수','목','금','토']
		,monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,showAnim :'fadeIn'
		,yearRange : 'c-5:c+1'
		,minDate : sMin
		,maxDate : sMax
		,beforeShow: function(input, inst){
						if(navigator.appName == "Microsoft Internet Explorer"){
							
						}
						setTimeout(function(){
							$(".ui-datepicker").css("z-index", 99999999);
						}, 20); 
					}
		,close : function( event, ui ) {
			$(this).datepicker( "destroy" );
		}
	});
	$( "#"+id ).focus();
}

function destroyGrid(obj){
	if(obj == null) return false;
	
	var grid = $('#'+obj.id).data('grid');
	
	if(grid != null) grid.destroy();
	$('#'+obj.id).width(3000);
	$('#'+obj.id).data('gridObj',null);
	$('#'+obj.id).data('grid',null);
	$('#'+obj.id).data('dataView',null);
	$('#'+obj.id).empty();
	
}

function initGridCustom(grid,obj){
	
	if(obj.rowHeight!=null){
		grid.setOptions({rowHeight:obj.rowHeight});
	}
	if(obj.headerRowHeight!=null){
		grid.setOptions({headerRowHeight:obj.headerRowHeight});
	}
	if(obj.colspan!=null && obj.colspan.length>0){
		grid.setHeaderRowVisibility(true);
		grid.onHeaderRowCellRendered.subscribe(function(e, args) {
			$(args.node).empty();
			
			for(var i=0;i<obj.colspan.length;i++){
				var col_id = obj.colspan[i].id_s;
				var idx_s = grid.getColumnIndex(col_id);
				var idx_e = grid.getColumnIndex(obj.colspan[i].id_e);
				if(args.column.id==col_id){
					$("<div>").html(obj.colspan[i].name).appendTo(args.node);
					$(args.node).removeClass('r'+idx_s).addClass('r'+idx_e).css({'border-left':'none','border-top':'none'});
				}
			}
			if($(args.node).is(':empty')) $(args.node).remove();
	    });
	}
	
	if(obj.vscroll!=null && !obj.vscroll){
		grid.setOptions({vscroll:false});
	}
	
}
function setGridOptions(obj,v){
	var grid = $('#'+obj.id).data('grid');
	
	grid.setOptions(v);
}
function setGridNoData(obj){
	var dataView = $('#'+obj.id).data('dataView');
	if(dataView.getLength()==0){
		$('#'+obj.id+' .grid-canvas').html("<div style='padding:3px 0px 3px 10px;'>No Results Found.</div>");
	}
}
function gridCellRowNumFormatter(row,cell,value,columnDef,dataContext){
	return row+1;
}
function gridCellNoneFormatter(row,cell,value,columnDef,dataContext){
	return value;
}
function setGridSelectedRowsAll(obj){
	var dataView = $('#'+obj.id).data('dataView');
	var grid = $('#'+obj.id).data('grid');
	
	var rows = [];
	for(var i=0;i<dataView.getLength();i++){
		rows.push(i);
	}
	
	grid.setSelectedRows(rows);
}
function setGridSelectedRow(obj,idx){
	var dataView = $('#'+obj.id).data('dataView');
	var grid = $('#'+obj.id).data('grid');
	
	var rows = [];
	rows.push(idx);
	grid.setSelectedRows(rows);
}
function setGridRows(obj){
	var dataView = $('#'+obj.id).data('dataView');
	var grid = $('#'+obj.id).data('grid');
	
	if(obj.rows_org !=null ){
		var aTmp = new Array();
		for(var i=0;i<obj.rows.length;i++){
			aTmp.push($.extend(true,{},obj.rows[i]));
		}
		obj.rows_org = aTmp;
	}
	
	dataView.beginUpdate();
	dataView.setItems(obj.rows,'grid_idx');
	dataView.endUpdate();
	dataView.syncGridSelection(grid, true);		//sorting 시 선택된 row 위치 동기화
	
	grid.invalidate();
}
function setCellValue(obj,rowIdx,cellId,v){
	var dataView = $('#'+obj.id).data('dataView');
	var item = dataView.getItem(rowIdx);
	item[cellId]=v;
	
	dataView.updateItem(item['grid_idx'],item);
}
function setCellValueRowEnd(obj,rowIdx){
	var grid = $('#'+obj.id).data('grid');
	
	grid.invalidateRow(rowIdx);
	grid.render();
}
function setCellValueRowsEnd(obj){
	var grid = $('#'+obj.id).data('grid');
	
	grid.invalidateAllRows();
	grid.render();
}
function getGridRowIdx(obj,grid_idx){
	var dataView = $('#'+obj.id).data('dataView');
	return dataView.getIdxById(grid_idx);
}
function getCellValue(obj,rowIdx,cellId){
	var v = getCellHtml(obj,rowIdx,cellId);
	if(v==null) v='';
	v = $('<p>'+v+'</p>').text();
	return v;
}
function getCellHtml(obj,rowIdx,cellId){
	var dataView = $('#'+obj.id).data('dataView');
	var item = dataView.getItem(rowIdx);
	var v = item[cellId];
	return v;
}
function addGridRow(obj,row){
	var dataView = $('#'+obj.id).data('dataView');
	var grid = $('#'+obj.id).data('grid');
	
	dataView.addItem(row);
	
	grid.invalidateRow(dataView.getLength()-1);
	grid.updateRowCount();
	grid.render();
}
function delGridRow(obj,rowIdx){
	var dataView = $('#'+obj.id).data('dataView');
	var grid = $('#'+obj.id).data('grid');
	
	dataView.deleteItem(getCellValue(obj,rowIdx,'grid_idx'));
	
	grid.updateRowCount();
	grid.invalidateRowDel(rowIdx);
	grid.render();
}

function delGridRowNoInv(obj,rowIdx){
	var dataView = $('#'+obj.id).data('dataView');
	var grid = $('#'+obj.id).data('grid');
	
	dataView.deleteItem(getCellValue(obj,rowIdx,'grid_idx'));
	
	grid.updateRowCount();
	grid.invalidateRowDel(rowIdx);
	grid.render();
}
function setGridColNm(obj, col_id, nm){
	var grid = $('#'+obj.id).data('grid');
	grid.updateColumnHeader(col_id,nm);
}

function sortGrid(obj,idx,asc){
	var dataView = $('#'+obj.id).data('dataView');
	var grid = $('#'+obj.id).data('grid');
	
	dataView.fastSort(idx,asc);
	
	grid.invalidateAllRows();
	grid.render();
}

function clearGridSelected(obj){
	var grid = $('#'+obj.id).data('grid');
	
	grid.setSelectedRows([]);
    grid.resetActiveCell();
}

// SlickGrid의 데이터 클리어
function clearSlickGridData(obj){ 
	try{
		var grid = $('#'+obj.id).data('grid');
		var dataView = grid.getData();
		
		dataView.beginUpdate();
		dataView.setItems([]);
		dataView.endUpdate();
		
		grid.invalidate();
		grid.render();
	}catch(e){
//		grid.setData([]); 
	}
}

function viewGrid_color(obj,wrap,opt,auto){
	var options = {
		editable:false
		,autoEdit: false
		,enableCellNavigation:true
		,enableColumnReorder: false
		,explicitInitialization: true
		,enableTextSelectionOnCells:true
		,multiSelect:true
		,autoHeight: false
	};
	
	if(opt!=null) $.extend( true, options, opt );
	
	var dataView = new Slick.Data.DataView({ inlineFilters: true });
	var grid = new Slick.Grid("#"+obj.id, dataView, obj.colModel, options);
	grid.setSelectionModel(new Slick.RowSelectionModel());
	grid.registerPlugin(new Slick.AutoTooltips({enableForHeaderCells:true}));

	if(auto != '' && auto != null) {
		grid.registerPlugin(new Slick.AutoColumnSize());
	}
	
	grid.onKeyDown.subscribe(function (e, args) {
		if(e.which == 67 && e.ctrlKey){
			if( getDocumentTextSelection() == '' ){
				gridCopy(obj);
			}
		}
	});
	
	//dataView.onRowCountChanged.subscribe(function (e, args) {
	//grid.updateRowCount();
	//grid.render();
	//});
	//dataView.onRowsChanged.subscribe(function (e, args) {
	//	grid.invalidateRows(args.rows);
	//	grid.render();
	//});
	grid.onSort.subscribe(function (e, args) {
		//sortGrid(obj,args.sortCol.field,args.sortAsc);
		dataView.sort(
				function(a,b){
					var x = a[args.sortCol.field]+'';
					var y = b[args.sortCol.field]+'';
					
					x = x.replace(/,/g,'');
					y = y.replace(/,/g,'');
					
					x=(!isNaN(x)&&!isNaN(y))?parseFloat(x+'.0'):x;
					y=(!isNaN(x)&&!isNaN(y))?parseFloat(y+'.0'):y;
					
					return(x==y)?0:(x>y)?1:-1;
				}
				,args.sortAsc);
		grid.invalidateAllRows();
		grid.render();
		
	   	setTimeout(function() {
	        $('.grid-canvas').children('div').each(function(i) {
	            if (i < dataView.getLength()) {
	                var item = dataView.getItem(i);
	                if (item.changeColor) {
	                    $(this).css("background", item.changeColor);
	                }
	            }
	        });
	    }, 0);
	});
	
	initGridCustom(grid,obj);
	grid.init();
	$('#'+obj.id).data('gridObj',obj);
	$('#'+obj.id).data('grid',grid);
	
	$('#'+obj.id).data('dataView',dataView);
	setGridRows(obj);
	
	var resizeGrid = function(){
		resizeGrid_1(obj,wrap);
	};
	if(wrap!=null){
		$(window).unbind('resizestop',resizeGrid).bind('resizestop',resizeGrid);
		resizeGrid.call();
	}
	
	$('#'+obj.id).unbind('mousedown').bind('mousedown',function(e){
		if (e.ctrlKey || e.shiftKey) {
			var o = $(this);
			o.bind('selectstart',function(e){
				e.preventDefault();
			});
			setTimeout(function(){o.unbind('selectstart');},250);
		}
	});
	
	//console.log($('#'+obj.id).html());
}

function viewGrid_1(obj,wrap,opt,auto){
	var options = {
		editable:false
		,autoEdit: false
		,enableCellNavigation:true
		,enableColumnReorder: false
		,explicitInitialization: true
		,enableTextSelectionOnCells:true
		,multiSelect:true
		,autoHeight: false
	};
	
	if(opt!=null) $.extend( true, options, opt );
	
	var dataView = new Slick.Data.DataView({ inlineFilters: true });
	var grid = new Slick.Grid("#"+obj.id, dataView, obj.colModel, options);
	grid.setSelectionModel(new Slick.RowSelectionModel());
	grid.registerPlugin(new Slick.AutoTooltips({enableForHeaderCells:true}));

	if(auto != '' && auto != null) {
		grid.registerPlugin(new Slick.AutoColumnSize());
	}
	
	grid.onKeyDown.subscribe(function (e, args) {
		if(e.which == 67 && e.ctrlKey){
			if( getDocumentTextSelection() == '' ){
				gridCopy(obj);
			}
		}
	});
	
	//dataView.onRowCountChanged.subscribe(function (e, args) {
	//grid.updateRowCount();
	//grid.render();
	//});
	//dataView.onRowsChanged.subscribe(function (e, args) {
	//	grid.invalidateRows(args.rows);
	//	grid.render();
	//});
	grid.onSort.subscribe(function (e, args) {
		//sortGrid(obj,args.sortCol.field,args.sortAsc);
		dataView.sort(
				function(a,b){
					var x = a[args.sortCol.field]+'';
					var y = b[args.sortCol.field]+'';
					
					x = x.replace(/,/g,'');
					y = y.replace(/,/g,'');
					
					x=(!isNaN(x)&&!isNaN(y))?parseFloat(x+'.0'):x;
					y=(!isNaN(x)&&!isNaN(y))?parseFloat(y+'.0'):y;
					
					return(x==y)?0:(x>y)?1:-1;
				}
				,args.sortAsc);
		grid.invalidateAllRows();
		grid.render();
	});
	
	initGridCustom(grid,obj);
	grid.init();
	$('#'+obj.id).data('gridObj',obj);
	$('#'+obj.id).data('grid',grid);
	
	$('#'+obj.id).data('dataView',dataView);
	setGridRows(obj);
	
	var resizeGrid = function(){
		resizeGrid_1(obj,wrap);
	};
	if(wrap!=null){
		$(window).unbind('resizestop',resizeGrid).bind('resizestop',resizeGrid);
		resizeGrid.call();
	}
	
	$('#'+obj.id).unbind('mousedown').bind('mousedown',function(e){
		if (e.ctrlKey || e.shiftKey) {
			var o = $(this);
			o.bind('selectstart',function(e){
				e.preventDefault();
			});
			setTimeout(function(){o.unbind('selectstart');},250);
		}
	});
	
	//console.log($('#'+obj.id).html());
}

function viewGrid_2(obj,wrap,opt,auto){
	var options = {
		editable:true
		,autoEdit: false
		,enableCellNavigation:true
		,enableColumnReorder: false
		,explicitInitialization: true
		,enableTextSelectionOnCells:true
		,multiSelect:true
	};
	
	if(opt!=null) $.extend( true, options, opt );
	
	var dataView = new Slick.Data.DataView({ inlineFilters: true });
	var grid = new Slick.Grid("#"+obj.id, dataView, obj.colModel, options);
	grid.setSelectionModel(new Slick.RowSelectionModel());
	grid.registerPlugin(new Slick.AutoTooltips({enableForHeaderCells:true}));
	
	if(auto != '' && auto != null) {
		grid.registerPlugin(new Slick.AutoColumnSize());
	}
	
	grid.onKeyDown.subscribe(function (e, args) {
		if(e.which == 67 && e.ctrlKey){
			if( getDocumentTextSelection() == '' ){
				gridCopy(obj);
			}
		}
	});
	
	//dataView.onRowCountChanged.subscribe(function (e, args) {
	//grid.updateRowCount();
	//grid.render();
	//});
	//dataView.onRowsChanged.subscribe(function (e, args) {
	//	grid.invalidateRows(args.rows);
	//	grid.render();
	//});
	grid.onSort.subscribe(function (e, args) {
		//sortGrid(obj,args.sortCol.field,args.sortAsc);
		dataView.sort(
				function(a,b){
					var x = a[args.sortCol.field]+'';
					var y = b[args.sortCol.field]+'';
					
					x = x.replace(/,/g,'');
					y = y.replace(/,/g,'');
					
					x=(!isNaN(x)&&!isNaN(y))?parseFloat(x+'.0'):x;
					y=(!isNaN(x)&&!isNaN(y))?parseFloat(y+'.0'):y;
					
					return(x==y)?0:(x>y)?1:-1;
				}
				,args.sortAsc);
		grid.invalidateAllRows();
		grid.render();
	});
	
	initGridCustom(grid,obj);
	grid.init();
	$('#'+obj.id).data('gridObj',obj);
	$('#'+obj.id).data('grid',grid);
	
	$('#'+obj.id).data('dataView',dataView);
	setGridRows(obj);
	
	var resizeGrid = function(){
		resizeGrid_1(obj,wrap);
	};
	if(wrap!=null){
		$(window).unbind('resizestop',resizeGrid).bind('resizestop',resizeGrid);
		resizeGrid.call();
	}
	
	$('#'+obj.id).unbind('mousedown').bind('mousedown',function(e){
		if (e.ctrlKey || e.shiftKey) {
			var o = $(this);
			o.bind('selectstart',function(e){
				e.preventDefault();
			});
			setTimeout(function(){o.unbind('selectstart');},250);
		}
	});
	
	//console.log($('#'+obj.id).html());
}

function viewGrid_3(obj,wrap){
	var options = {
		editable:true
		,autoEdit: false
		,enableCellNavigation:true
		,enableColumnReorder: false
		,explicitInitialization: true
		,enableTextSelectionOnCells:true
		,multiSelect:true
	};
	
	var groupItemMetadataProvider = new Slick.Data.GroupItemMetadataProvider();
	var dataView = new Slick.Data.DataView({ 
			groupItemMetadataProvider: groupItemMetadataProvider,
			inlineFilters: true 
		});
	var grid = new Slick.Grid("#"+obj.id, dataView, obj.colModel, options);
	grid.setSelectionModel(new Slick.RowSelectionModel());
	grid.registerPlugin(new Slick.AutoTooltips({enableForHeaderCells:true}));
	
	grid.onKeyDown.subscribe(function (e, args) {
		if(e.which == 67 && e.ctrlKey){
			if( getDocumentTextSelection() == '' ){
				gridCopy(obj);
			}
		}
	});
	

    var headerMenuPlugin = new Slick.Plugins.HeaderMenu({});
    headerMenuPlugin.onCommand.subscribe(function(e, args) {
      alert("Comment: " + args.command);
    });
    grid.registerPlugin(headerMenuPlugin);
    
	//dataView.onRowCountChanged.subscribe(function (e, args) {
	//grid.updateRowCount();
	//grid.render();
	//});
	//dataView.onRowsChanged.subscribe(function (e, args) {
	//	grid.invalidateRows(args.rows);
	//	grid.render();
	//});
	grid.onSort.subscribe(function (e, args) {
		//sortGrid(obj,args.sortCol.field,args.sortAsc);
		dataView.sort(
				function(a,b){
					var x = a[args.sortCol.field]+'';
					var y = b[args.sortCol.field]+'';
					
					x = x.replace(/,/g,'');
					y = y.replace(/,/g,'');
					
					x=(!isNaN(x)&&!isNaN(y))?parseFloat(x+'.0'):x;
					y=(!isNaN(x)&&!isNaN(y))?parseFloat(y+'.0'):y;
					
					return(x==y)?0:(x>y)?1:-1;
				}
				,args.sortAsc);
		grid.invalidateAllRows();
		grid.render();
	});
	
	initGridCustom(grid,obj);
	grid.init();
	$('#'+obj.id).data('gridObj',obj);
	$('#'+obj.id).data('grid',grid);
	
	$('#'+obj.id).data('dataView',dataView);
	setGridRows(obj);
	
	var resizeGrid = function(){
		resizeGrid_1(obj,wrap);
	};
	if(wrap!=null){
		$(window).unbind('resizestop',resizeGrid).bind('resizestop',resizeGrid);
		resizeGrid.call();
	}
	
	$('#'+obj.id).unbind('mousedown').bind('mousedown',function(e){
		if (e.ctrlKey || e.shiftKey) {
			var o = $(this);
			o.bind('selectstart',function(e){
				e.preventDefault();
			});
			setTimeout(function(){o.unbind('selectstart');},250);
		}
	});
	
	//console.log($('#'+obj.id).html());
}

function viewGridChk_1(obj,wrap,opt,auto){
	var options = {
		editable:false
		,autoEdit: false
		,enableCellNavigation:true
		,enableColumnReorder: false
		,explicitInitialization: true
		,enableTextSelectionOnCells:true
		,multiSelect:false
	};
	
	if(opt!=null) $.extend( true, options, opt );
	
	var checkboxSelector = new Slick.CheckboxSelectColumn({
		cssClass: "cellCenter"
	});
	obj.colModel.unshift(checkboxSelector.getColumnDefinition());
	
	var dataView = new Slick.Data.DataView({ inlineFilters: true });
	var grid = new Slick.Grid("#"+obj.id, dataView, obj.colModel, options);
	grid.setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false}));
	grid.registerPlugin(new Slick.AutoTooltips({enableForHeaderCells:true}));
	grid.registerPlugin(checkboxSelector);
	
	if(auto != '' && auto != null) {
		grid.registerPlugin(new Slick.AutoColumnSize());
	}
	
	grid.onKeyDown.subscribe(function (e, args) {
		if(e.which == 67 && e.ctrlKey){
			if( getDocumentTextSelection() == '' ){
				gridCopy(obj);
			}
		}
	});
	
	//dataView.onRowCountChanged.subscribe(function (e, args) {
	//	grid.updateRowCount();
	//	grid.render();
	//});
	//dataView.onRowsChanged.subscribe(function (e, args) {
	//	grid.invalidateRows(args.rows);
	//	grid.render();
	//});
	grid.onSort.subscribe(function (e, args) {
		//sortGrid(obj,args.sortCol.field,args.sortAsc);
		dataView.sort(
				function(a,b){
					var x = a[args.sortCol.field]+'';
					var y = b[args.sortCol.field]+'';
					
					x = x.replace(/,/g,'');
					y = y.replace(/,/g,'');
					
					x=(!isNaN(x)&&!isNaN(y))?parseFloat(x+'.0'):x;
					y=(!isNaN(x)&&!isNaN(y))?parseFloat(y+'.0'):y;
					
					return(x==y)?0:(x>y)?1:-1;
				}
				,args.sortAsc);
		grid.invalidateAllRows();
		grid.render();
	});
	
	initGridCustom(grid,obj);
	grid.init();
	$('#'+obj.id).data('gridObj',obj);
	$('#'+obj.id).data('grid',grid);
	
	$('#'+obj.id).data('dataView',dataView);
	setGridRows(obj);
		
	var resizeGrid = function(){
		resizeGrid_1(obj,wrap);
	};
	if(wrap!=null){
		$(window).unbind('resizestop',resizeGrid).bind('resizestop',resizeGrid);
		resizeGrid.call();
	}
	
	$('#'+obj.id).unbind('mousedown').bind('mousedown',function(e){
		if (e.ctrlKey || e.shiftKey) {
			var o = $(this);
			o.bind('selectstart',function(e){
				e.preventDefault();
			});
			setTimeout(function(){o.unbind('selectstart');},250);
		}
	});
	
	
	//console.log($('#'+obj.id).html());	
}

function viewGridChk_2(obj,wrap,opt,auto){
	var options = {
		editable:true
		,autoEdit: false
		,enableCellNavigation:true
		,enableColumnReorder: false
		,explicitInitialization: true
		,enableTextSelectionOnCells:true
		,multiSelect:false
	};
	
	if(opt!=null) $.extend( true, options, opt );
	
	var checkboxSelector = new Slick.CheckboxSelectColumn({
		cssClass: "cellCenter"
	});
	obj.colModel.unshift(checkboxSelector.getColumnDefinition());
	
	var dataView = new Slick.Data.DataView({ inlineFilters: true });
	var grid = new Slick.Grid("#"+obj.id, dataView, obj.colModel, options);
	grid.setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false}));
	grid.registerPlugin(new Slick.AutoTooltips({enableForHeaderCells:true}));
	grid.registerPlugin(checkboxSelector);
	
	if(auto != '' && auto != null) {
		grid.registerPlugin(new Slick.AutoColumnSize());
	}
	
	grid.onKeyDown.subscribe(function (e, args) {
		if(e.which == 67 && e.ctrlKey){
			if( getDocumentTextSelection() == '' ){
				gridCopy(obj);
			}
		}
	});
	
	//dataView.onRowCountChanged.subscribe(function (e, args) {
	//	grid.updateRowCount();
	//	grid.render();
	//});
	//dataView.onRowsChanged.subscribe(function (e, args) {
	//	grid.invalidateRows(args.rows);
	//	grid.render();
	//});
	grid.onSort.subscribe(function (e, args) {
		//sortGrid(obj,args.sortCol.field,args.sortAsc);
		dataView.sort(
				function(a,b){
					var x = a[args.sortCol.field]+'';
					var y = b[args.sortCol.field]+'';
					
					x = x.replace(/,/g,'');
					y = y.replace(/,/g,'');
					
					x=(!isNaN(x)&&!isNaN(y))?parseFloat(x+'.0'):x;
					y=(!isNaN(x)&&!isNaN(y))?parseFloat(y+'.0'):y;
					
					return(x==y)?0:(x>y)?1:-1;
				}
				,args.sortAsc);
		grid.invalidateAllRows();
		grid.render();
	});
	
	initGridCustom(grid,obj);
	grid.init();
	$('#'+obj.id).data('gridObj',obj);
	$('#'+obj.id).data('grid',grid);
	
	$('#'+obj.id).data('dataView',dataView);
	setGridRows(obj);
		
	var resizeGrid = function(){
		resizeGrid_1(obj,wrap);
	};
	if(wrap!=null){
		$(window).unbind('resizestop',resizeGrid).bind('resizestop',resizeGrid);
		resizeGrid.call();
	}
	
	$('#'+obj.id).unbind('mousedown').bind('mousedown',function(e){
		if (e.ctrlKey || e.shiftKey) {
			var o = $(this);
			o.bind('selectstart',function(e){
				e.preventDefault();
			});
			setTimeout(function(){o.unbind('selectstart');},250);
		}
	});
	
	
	//console.log($('#'+obj.id).html());	
}

function viewGridChk_3(obj,wrap,opt,auto){
	var options = {
		editable:false
		,autoEdit: false
		,enableCellNavigation:true
		,enableColumnReorder: false
		,explicitInitialization: true
		,enableTextSelectionOnCells:true
		,multiSelect:true
	};

	if(opt!=null) $.extend( true, options, opt );

	var checkboxSelector = new Slick.CheckboxSelectColumn({
		cssClass: "cellCenter"
	});
	obj.colModel.unshift(checkboxSelector.getColumnDefinition());

	var dataView = new Slick.Data.DataView({ inlineFilters: true });
	var grid = new Slick.Grid("#"+obj.id, dataView, obj.colModel, options);
	grid.setSelectionModel(new Slick.RowSelectionModel());
	grid.registerPlugin(new Slick.AutoTooltips({enableForHeaderCells:true}));
	grid.registerPlugin(checkboxSelector);

	if(auto != '' && auto != null) {
		grid.registerPlugin(new Slick.AutoColumnSize());
	}

	grid.onKeyDown.subscribe(function (e, args) {
		if(e.which == 67 && e.ctrlKey){
			if( getDocumentTextSelection() == '' ){
				gridCopy(obj);
			}
		}
	});

	//dataView.onRowCountChanged.subscribe(function (e, args) {
	//	grid.updateRowCount();
	//	grid.render();
	//});
	//dataView.onRowsChanged.subscribe(function (e, args) {
	//	grid.invalidateRows(args.rows);
	//	grid.render();
	//});
	grid.onSort.subscribe(function (e, args) {
		//sortGrid(obj,args.sortCol.field,args.sortAsc);
		dataView.sort(
				function(a,b){
					var x = a[args.sortCol.field]+'';
					var y = b[args.sortCol.field]+'';

					x = x.replace(/,/g,'');
					y = y.replace(/,/g,'');

					x=(!isNaN(x)&&!isNaN(y))?parseFloat(x+'.0'):x;
					y=(!isNaN(x)&&!isNaN(y))?parseFloat(y+'.0'):y;

					return(x==y)?0:(x>y)?1:-1;
				}
				,args.sortAsc);
		grid.invalidateAllRows();
		grid.render();
	});

	initGridCustom(grid,obj);
	grid.init();
	$('#'+obj.id).data('gridObj',obj);
	$('#'+obj.id).data('grid',grid);

	$('#'+obj.id).data('dataView',dataView);
	setGridRows(obj);

	var resizeGrid = function(){
		resizeGrid_1(obj,wrap);
	};
	if(wrap!=null){
		$(window).unbind('resizestop',resizeGrid).bind('resizestop',resizeGrid);
		resizeGrid.call();
	}

	$('#'+obj.id).unbind('mousedown').bind('mousedown',function(e){
		if (e.ctrlKey || e.shiftKey) {
			var o = $(this);
			o.bind('selectstart',function(e){
				e.preventDefault();
			});
			setTimeout(function(){o.unbind('selectstart');},250);
		}
	});


	//console.log($('#'+obj.id).html());
}

function resizeGrid_1(obj,wrap){
	try{
		var hid = $('#'+obj.id).data('hid');
		if(hid!=null && hid=='Y') return false;
		
		var grid = $('#'+obj.id).data('grid');
		
		$('#'+obj.id).width(0).height(0).hide();
		setTimeout(function(){
			try{
				$('#'+obj.id).width($('#'+wrap).width()).height($('#'+wrap).height()).show();
				grid.resizeCanvas();
			}catch(e){}
		}, 450);
	
	}catch(e){}
}

function initIme(){
	$(".ime_disabled").unbind('keyup').keyup(function(e){
		var start = this.selectionStart;
        var end = this.selectionEnd;
        
		if(this.value!=getOnlyEng(this.value)) this.value = getOnlyEng(this.value);
		
		this.setSelectionRange(start, end);
	}).unbind('focusout').focusout(function(e){
		if(this.value!=getOnlyEng(this.value)) this.value = getOnlyEng(this.value);
	});
	$(".ime_disabled_u").unbind('keyup').keyup(function(e){
		var start = this.selectionStart;
        var end = this.selectionEnd;
		
		if(this.value!=getOnlyEng(this.value)) this.value = getOnlyEng(this.value);
		this.value = this.value.toUpperCase();
		
		this.setSelectionRange(start, end);
	}).unbind('focusout').focusout(function(e){
		if(this.value!=getOnlyEng(this.value)) this.value = getOnlyEng(this.value);
		this.value = this.value.toUpperCase();
	});
	$(".ime_disabled_num").unbind('keyup').keyup(function(e){
		var start = this.selectionStart;
        var end = this.selectionEnd;
		
		if(this.value!=getOnlyNum(this.value)) this.value = getOnlyNum(this.value);
		
		this.setSelectionRange(start, end);
	}).unbind('focusout').focusout(function(e){
		if(this.value!=getOnlyNum(this.value)) this.value = getOnlyNum(this.value);
	});
	$(".ime_readonly").attr("readonly",true).unbind('keydown').keydown(function(e){
		if(e.keyCode==8) e.preventDefault();
	});
}

function goInitPage(cPath,layout_gb){
	postHref(cPath+'/works.do?c=c00&layout_gb='+layout_gb,'_self');
}

function gridCopy(obj){
	
	var clipText = "";
	
	var grid = $('#'+obj.id).data('grid');
	
	var aSelRow = new Array;
	aSelRow = grid.getSelectedRows();
	
	if(aSelRow.length==0) return false;
	
	try{viewProgBar(true);}catch(e){}
	setTimeout(function(){
	
	var aColModel = new Array;
	aColModel = grid.getColumns();
	
	for (var i = 0; i < aSelRow.length; i++) {
		
		if(clipText!='') clipText += "\r\n";
		
		var rowText = '';
		for (var j = 0; j < aColModel.length; j++) {
			
			if(aColModel[j].id == '_checkbox_selector' ) continue;
			if(aColModel[j].cssClass !=null && aColModel[j].cssClass.indexOf('cellHid') > -1 ) continue;
			
			if(rowText!='') rowText += "\t";
			rowText += getCellValue(obj,aSelRow[i],aColModel[j].id);
			
		}
		clipText += rowText;
	}
	
	if (window.clipboardData) {
		window.clipboardData.clearData("Text");
		window.clipboardData.setData("Text", clipText);
	}else{
		window.prompt("Copy to clipboard: Ctrl+C, Enter",clipText);
	}
	
	try{viewProgBar(false);}catch(e){}
	},250);
}

function Select2Formatter(row, cell, value, columnDef, dataContext) {
  return columnDef.dataSource[value] || '-';
}
function Select2Editor(args) {
  var $input;
  var defaultValue;
  var scope = this;
  var calendarOpen = false;

  this.keyCaptureList = [ Slick.keyCode.UP, Slick.keyCode.DOWN, Slick.keyCode.ENTER ];

  this.init = function () {
      $input = $('<select></select>');
      $input.width(args.container.clientWidth + 3);
      PopulateSelect($input[0], args.column.dataSource, true);

      $input.appendTo(args.container);
      $input.focus().select();
		
      $input.select2({
          placeholder: '-',
			allowClear: true
      });
  };

  this.destroy = function () {
      $input.select2('destroy');
      $input.remove();
  };

  this.show = function () {
  };

  this.hide = function () {
      $input.select2('results_hide');
  };

  this.position = function (position) {
  };

  this.focus = function () {
      $input.select2('input_focus');
  };

  this.loadValue = function (item) {
      defaultValue = item[args.column.field];
      $input.val(defaultValue);
      $input[0].defaultValue = defaultValue;
      $input.trigger("change.select2");
  };

  this.serializeValue = function () {
      return $input.val();
  };

  this.applyValue = function (item, state) {
      item[args.column.field] = state;
  };

  this.isValueChanged = function () {
      return (!($input.val() == "" && defaultValue == null)) && ($input.val() != defaultValue);
  };

  this.validate = function () {
      return {
          valid: true,
          msg: null
      };
  };

  this.init();
}
	
$.fn.insertAtCaret = function(myValue) {
	return this.each(function() {
		var me = this;
		if (document.selection) { // IE
			me.focus();
			sel = document.selection.createRange();
			sel.text = myValue;
			me.focus();
		} else if (me.selectionStart || me.selectionStart == '0') { // Real browsers
			var startPos = me.selectionStart, endPos = me.selectionEnd, scrollTop = me.scrollTop;
			me.value = me.value.substring(0, startPos) + myValue + me.value.substring(endPos, me.value.length);
			me.focus();
			me.selectionStart = startPos + myValue.length;
			me.selectionEnd = startPos + myValue.length;
			me.scrollTop = scrollTop;
		} else {
			me.value += myValue;
			me.focus();
		}
	});
};
	

	function replaceAll(str, searchStr, replaceStr){
		return str.split(searchStr).join(replaceStr);
	}
	
	function popupCmLog(sContextPath, order_id){
		var frm = document.f_s;
		
		frm.order_id.value = order_id;
		//frm.odate.value = replaceAll(odate,"/","");
	
		openPopupCenter3("about:blank","popupCtmLog", 1000, 600);
		
		frm.action = sContextPath+"/mPopup.ez?c=ez006";
		frm.target = "popupCtmLog";
		frm.submit();
	}

	function popupSysoutTelnet(sContextPath, order_id, rerun_count, end_date, mem_name, node_id, job_name , flag, appl_type) {
		
		var frm = document.f_s;
	
		//파일명 관련 규칙 서버단으로 로직 이전(2020.07.14, 김수정)
		// ORDER_ID의 최대 자릿수는 6자리이므로 5자리라면 앞에 0을 넣어준다.
//		if ( order_id.length == 5 ) {
//			order_id 		= "0" + order_id;
//		}
		
		frm.total_rerun_count.value	= rerun_count;
	
		frm.order_id.value		= order_id;
//		frm.rerun_count.value 	= transNumberFormat(rerun_count, 5); //파일명 관련 규칙 서버단으로 로직 이전(2020.07.14, 김수정)
		frm.rerun_count.value 	= rerun_count;
		frm.end_date.value 		= end_date;
		frm.memname.value 		= mem_name;
		frm.node_id.value 		= node_id;
		frm.job_name.value 		= job_name;
		frm.flag.value          = flag;
		frm.appl_type.value     = appl_type;

		openPopupCenter3("about:blank","popupSysoutTelnet", 1200, 700);
	
		frm.action = sContextPath+"/mPopup.ez?c=ez007_local";
		
		
		frm.target = "popupSysoutTelnet";
		frm.submit();
	}

	function popupSysoutTelnet_down(sContextPath, order_id, rerun_count, end_date, mem_name, node_id, job_name , flag, appl_type) {

		var frm = document.f_s;

		//파일명 관련 규칙 서버단으로 로직 이전(2020.07.14, 김수정)
		// ORDER_ID의 최대 자릿수는 6자리이므로 5자리라면 앞에 0을 넣어준다.
	//		if ( order_id.length == 5 ) {
	//			order_id 		= "0" + order_id;
	//		}

		frm.total_rerun_count.value	= rerun_count;

		frm.order_id.value		= order_id;
	//		frm.rerun_count.value 	= transNumberFormat(rerun_count, 5); //파일명 관련 규칙 서버단으로 로직 이전(2020.07.14, 김수정)
		frm.rerun_count.value 	= rerun_count;
		frm.end_date.value 		= end_date;
		frm.memname.value 		= mem_name;
		frm.node_id.value 		= node_id;
		frm.job_name.value 		= job_name;
		frm.flag.value          = flag;
		frm.appl_type.value     = appl_type;

		frm.action = sContextPath+"/mPopup.ez?c=ez007_local_down2";
		frm.target = "prcFrame";
		frm.submit();

	}

	function popupCtmWhy(sContextPath, order_id){
		var frm = document.f_s;
		
		frm.order_id.value = order_id;
		
		openPopupCenter3("about:blank","popupCtmWhy", 1000, 600);
		
		frm.action = sContextPath+"/mPopup.ez?c=ez008&add_auth=no";
		frm.target = "popupCtmWhy";
		frm.submit();
	}
	
	function popupJobGraph_d3(sContextPath, odate, order_id, job_name, status, active_gb) {
		
		var frm = document.f_s;

		var graph_depth = 0;

		frm.odate.value 		= odate;
		frm.graph_depth.value 	= graph_depth;
		frm.order_id.value 		= order_id;
		frm.job_name.value 		= job_name;
		frm.status.value 		= status;
		frm.active_gb.value 	= active_gb;

		openPopupCenter3("about:blank","popupJobGraph_d3",1200, 900);
		
		frm.action = sContextPath+"/mPopup.ez?c=ez002_d3";
		frm.target = "popupJobGraph_d3";
		frm.submit();
	}
	
	function popupWaitDetail(sContextPath, odate, order_id, status) {
		var frm = document.f_s;

		frm.odate.value 		= odate;
		frm.order_id.value 		= order_id;
		frm.status.value 		= status;
		
		openPopupCenter1("about:blank","popupWaitDetail",500,500);
		
		frm.action = sContextPath+"/mPopup.ez?c=ez009";
		frm.target = "popupWaitDetail";
		frm.submit();
	}
	
	function popupWaitDetail(sContextPath, odate, order_id, status) {
		var frm = document.f_s;

		frm.odate.value 		= odate;
		frm.order_id.value 		= order_id;
		frm.status.value 		= status;
		
		openPopupCenter1("about:blank","popupWaitDetail",500,500);
		
		frm.action = sContextPath+"/mPopup.ez?c=ez009";
		frm.target = "popupWaitDetail";
		frm.submit();
	}
	
	function popupJobDetail(sContextPath, order_id, job){
		var frm = document.f_s;
		
		frm.order_id.value = order_id;
		frm.job.value = job;
		
		openPopupCenter1("about:blank","popupJobDetail",700,500);
		
		frm.action = sContextPath+"/mPopup.ez?c=ez004&gb=01";
		frm.target = "popupJobDetail";
		frm.submit();
	}
	
	function goUserSearch(btn, sel_line_cd){
		var sHtml2="<div id='dl_tmp3' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml2+="<form id='form3' name='form3' method='post' onsubmit='return false;'>";
		sHtml2+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml2+="<select name='ser_gubun' id='ser_gubun' style='height:21px;'>";
		sHtml2+="<option value='all'>전체</option>";
		sHtml2+="<option value='user_nm'>사용자명</option>";
		sHtml2+="<option value='user_id'>아이디</option>";
		sHtml2+="<option value='dept_nm'>부서명</option>";
		sHtml2+="</select>";
		sHtml2+="<input type='text' name='ser_user_nm' id='ser_user_nm' />&nbsp;&nbsp;<span id='btn_usersearch'>검색</span>";
		sHtml2+="<table style='width:100%;height:100%;border:none;'>";
		sHtml2+="<tr><td id='ly_g_tmp3' style='vertical-align:top;' >";
		sHtml2+="<div id='g_tmp3' class='ui-widget-header ui-corner-all'></div>";
		sHtml2+="</td></tr>";
		sHtml2+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml2+="<div align='right' class='btn_area_s'>";
		sHtml2+="<div id='ly_total_cnt3' style='padding-top:5px;float:left;'></div>";
		if(btn == '2') { // 유저관리 > 폴더권한복사 기능의 To 사용자 조회 버튼을 클릭했을 경우 노출(2024-09-05 김선중)
			sHtml2+="<span id='btn_user_select'>선택</span>";
		}
		sHtml2+="</div>";
		sHtml2+="</h5></td></tr></table>";
		
		sHtml2+="</td></tr></table>";
		
		sHtml2+="</form>";
		
		$('#dl_tmp3').remove();
		$('body').append(sHtml2);
		
		dlPop01('dl_tmp3',"사용자내역",400,295,false);
		
		var gridObj3 = {
			id : "g_tmp3"
			,colModel:[
				
				{formatter:gridCellNoneFormatter,field:'dept_nm',id:'dept_nm',name:'부서명',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'duty_nm',id:'duty_nm',name:'직책',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'user_nm',id:'user_nm',name:'사용자명',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'user_id',id:'user_id',name:'아이디',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				
		   		,{formatter:gridCellNoneFormatter,field:'user_cd',id:'user_cd',name:'user_cd',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
		};
		
		viewGrid_1(gridObj3,'ly_'+gridObj3.id);
		
		var ser_gubun = $("select[name='ser_gubun'] option:selected").val();
		var ser_user_nm = $("#ser_user_nm").val();
			
		getUserList(ser_gubun,ser_user_nm,btn, sel_line_cd); 
		
		
		setTimeout(function() {
			$("#ser_user_nm").focus();
		}, 100);
		
		$('#ser_user_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#ser_user_nm').val())!=''){				
				var ser_gubun = $("select[name='ser_gubun'] option:selected").val();	
				
				if($(this).val() == ""){
					alert("검색어를 입력해 주세요."); 
					setTimeout(function() {
						$("#ser_user_nm").focus();
					}, 100);
					return;
				}
				getUserList(ser_gubun,$(this).val(),btn, sel_line_cd);
			}
		});
		
		
		$("#btn_usersearch").button().unbind("click").click(function(){
			var ser_gubun = $("select[name='ser_gubun'] option:selected").val();
			var ser_user_nm = $("#ser_user_nm").val();
			
			if(ser_user_nm == ""){
				alert("검색어를 입력해 주세요.");
					setTimeout(function() {
						$("#ser_user_nm").focus();
					}, 100);
				return;
			}
			getUserList(ser_gubun,ser_user_nm,btn, sel_line_cd);
		});
		
		$("#btn_user_select").button().unbind("click").click(function(){
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj3.id).data('grid').getSelectedRows();
			console.log("aSelRow : " + aSelRow);
			
			if(aSelRow.length == 0){
				alert("폴더권한을 설정할 사용자를 선택해주세요.");
				return;
			}else if(aSelRow.length > 1){
				alert("사용자를 다중 조회할 경우 TO 폴더의 목록은 초기화됩니다.");
			}
			
			var arr_user_cd = "";
			var arr_user_nm = "";
			
			for (var i = 0; i < aSelRow.length; i++) {
				arr_user_cd += getCellValue(gridObj3,aSelRow[i],'user_cd');
				arr_user_nm += getCellValue(gridObj3,aSelRow[i],'user_nm');
				console.log(getCellValue(gridObj3,aSelRow[i],'user_nm'));
				if (i < aSelRow.length-1) {
					arr_user_cd += ",";
					arr_user_nm += ",";
				}
			}
			goUserSeqSelect(arr_user_cd, arr_user_nm, btn);
		});
	}

	//담당자 조회
	function getUserList(gubun, text, btn, sel_line_cd){
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt3').html('');
		
		var url = "";
		if(btn == 99){
			url = '/common.ez?c=cData&itemGb=userList&p_search_gubun='+gubun+'&p_search_text='+encodeURIComponent(text)+'&p_del_yn=N'+'&p_approval_gubun=Y';
		}else{
			url = '/common.ez?c=cData&itemGb=userList&p_search_gubun='+gubun+'&p_search_text='+encodeURIComponent(text)+'&p_del_yn=N';
		}

		var xhr = new XHRHandler( url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}

					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){

						var items = $(this).find('items');
						var rowsObj = new Array();

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								var dept_nm = $(this).find("DEPT_NM").text();
								var duty_nm = $(this).find("DUTY_NM").text();
								var user_nm = $(this).find("USER_NM").text();
								var user_cd = $(this).find("USER_CD").text();
								var user_id = $(this).find("USER_ID").text();

								rowsObj.push({'grid_idx':i+1
									,'dept_nm':dept_nm
									,'duty_nm':duty_nm
									,'user_nm':user_nm
									,'user_id':user_id
									,'CHOICE':"<div><a href=\"javascript:goUserSeqSelect('"+user_cd+"', '"+user_nm+"', '"+btn+"', '"+sel_line_cd+"');\" ><font color='red'>[선택]</font></a></div>"
									,'user_cd':user_cd
								});

							});

						}
						var obj = $("#g_tmp3").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);

						$('#ly_total_cnt3').html('[ TOTAL : '+items.attr('cnt')+' ]');
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );

		xhr.sendRequest();
		
		$("#approval_cd"+sel_line_cd).val("");      
		$("#approval_nm"+sel_line_cd).val("");
		
		$("#group_line_grp_cd"+sel_line_cd).val("");      
		$("#group_line_grp_nm"+sel_line_cd).val("");
	}

	//담당자그룹 조회
	function groupUserGroup(group_nm, arg, smsDefault, mailDefault){

		var url = '/common.ez?c=cData&itemGb=groupApprovalGroup&itemGubun=2&p_search_text='+encodeURIComponent(group_nm);

		var xhr = new XHRHandler(url, null
			,function(){
				var xmlDoc = this.req.responseXML;
				$(xmlDoc).find('doc').each(function(){

					var items = $(this).find('items');
					var aTags = new Array();

					if(items.attr('cnt')=='0'){
						alert("[관리자문의]담당자 그룹을 등록해주세요.");
					}else{
						items.find('item').each(function(i){
							aTags.push({value:$(this).find('GROUP_LINE_GRP_NM').text()
								,label:$(this).find('GROUP_LINE_GRP_NM').text()
								,group_line_grp_cd:$(this).find('GROUP_LINE_GRP_CD').text()
							});
						});
					}

					try{ $("#grp_nm_"+arg).autocomplete("destroy"); }catch(e){};

					$("#grp_nm_"+arg).autocomplete({
						minLength: 0
						,source: aTags
						,autoFocus: false
						,focus: function(event, ui) {

						}
						,select: function(event, ui) {
							$(this).val(ui.item.value);
							$("#grp_cd_"+arg).val(ui.item.group_line_grp_cd);

							$(this).data('sel_v',$(this).val());
							$(this).removeClass('input_complete').addClass('input_complete');
							
							if(smsDefault == "Y"){
								$("input:checkbox[name='grp_sms_" + arg + "']").prop("checked", true);
							}
							if(mailDefault == "Y"){
	    						$("input:checkbox[name='grp_mail_" + arg + "']").prop("checked", true);
							}
						}
						,disabled: false
						,create: function(event, ui) {
							$(this).autocomplete('search',$(this).val());
						}
						,close: function(event, ui) {
							$(this).autocomplete("destroy");
						}
						,open: function(){
							setTimeout(function () {
								$('.ui-autocomplete').css('z-index', 3000);
							}, 10);
						}

					}).data("autocomplete")._renderItem = function(ul, item) {
						return $("<li></li>" )
							.data("item.autocomplete", item)
							.append("<a>" + item.label + "</a>")
							.appendTo(ul);
					};

				});

			}
			, null );

		xhr.sendRequest();
	}
	
	//필수결재선설정 → 결재그룹 검색팝업
	function goGroupSearch(btn, sel_line_cd){
		
		var sHtml2="<div id='dl_tmp3' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml2+="<form id='form3' name='form3' method='post' onsubmit='return false;'>";
		sHtml2+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml2+="<select name='ser_gubun' id='ser_gubun' style='height:21px;'>";
		sHtml2+="<option value='GROUP_LINE_GRP_NM'>그룹명</option>";
		sHtml2+="</select>";
		sHtml2+="<input type='text' name='ser_user_nm' id='ser_user_nm' />&nbsp;&nbsp;<span id='btn_usersearch'>검색</span>";
		sHtml2+="<table style='width:100%;height:100%;border:none;'>";
		sHtml2+="<tr><td id='ly_g_tmp3' style='vertical-align:top;' >";
		sHtml2+="<div id='g_tmp3' class='ui-widget-header ui-corner-all'></div>";
		sHtml2+="</td></tr>";
		sHtml2+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml2+="<div align='right' class='btn_area_s'>";
		sHtml2+="<div id='ly_total_cnt3' style='padding-top:5px;float:left;'></div>";
		sHtml2+="</div>";
		sHtml2+="</h5></td></tr></table>";
		
		sHtml2+="</td></tr></table>";
		
		sHtml2+="</form>";
		
		$('#dl_tmp3').remove();
		$('body').append(sHtml2);
		
		dlPop01('dl_tmp3',"그룹결재선목록",400,295,false);
		
		var gridObj3 = {
			id : "g_tmp3"
			,colModel:[
				
				{formatter:gridCellNoneFormatter,field:'GROUP_LINE_GRP_NM',id:'GROUP_LINE_GRP_NM',name:'그룹명',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				
		   		,{formatter:gridCellNoneFormatter,field:'GROUP_LINE_GRP_CD',id:'GROUP_LINE_GRP_CD',name:'GROUP_LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
		};
		
		viewGrid_1(gridObj3,'ly_'+gridObj3.id);
		
		$("#ser_user_nm").focus();
		
		var ser_gubun = $("select[name='ser_gubun'] option:selected").val();
		var ser_user_nm = $("#ser_user_nm").val();
			
		getGroupList(ser_user_nm, sel_line_cd);
		
		$("#btn_usersearch").button().unbind("click").click(function(){
			var ser_gubun = $("select[name='ser_gubun'] option:selected").val();
			var ser_user_nm = $("#ser_user_nm").val();

			if(ser_user_nm == ""){
				alert("검색어를 입력해 주세요.");
				return;
			}
			
			getGroupList(ser_user_nm, sel_line_cd);
		});		
	}

	//소분류 팝업 폼
	function popScodeForm(mcode_nm){
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='common_form1' name='common_form1' method='post' onsubmit='return false;'>";		
		sHtml1+="<table style='width:100%;height:240px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:450px;text-align:right;'>";
		sHtml1+="소그룹명 : <input type='text' name='sub_scode_nm' id='sub_scode_nm' style='ime-mode:active;'/>&nbsp;&nbsp;<span id='btn_scode_search'>검색</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_10' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1',"소그룹검색",520,275,false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'소그룹명',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_DESC',id:'SCODE_DESC',name:'설명',width:270,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_ENG_NM',id:'SCODE_ENG_NM',name:'SCODE_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:true
		};
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		popScodeList(mcode_nm, '');
		
		$('#sub_scode_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#sub_scode_nm').val())!=''){
				
				if($(this).val() == ""){
					alert("검색어를 입력해 주세요.");
					return;
				}
				
				popScodeList(mcode_nm,$(this).val());
			}
		});
		
		
		$("#btn_scode_search").button().unbind("click").click(function(){
			var scode_nm = $("#common_form1").find("input[name='sub_scode_nm']").val();
			
			popScodeList(mcode_nm,scode_nm);
		});
		
	}
	
	function popScodeSearchForm(mcode_nm){
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='common_form1' name='common_form1' method='post' onsubmit='return false;'>";		
		sHtml1+="<table style='width:100%;height:240px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:450px;text-align:right;'>";
		sHtml1+="소그룹명 : <input type='text' name='sub_scode_nm' id='sub_scode_nm' style='ime-mode:active;'/>&nbsp;&nbsp;<span id='btn_scode_search'>검색</span><span id='btn_app_select'>선택</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_10' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1',"소그룹검색",520,275,false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'소그룹명',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_DESC',id:'SCODE_DESC',name:'설명',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_ENG_NM',id:'SCODE_ENG_NM',name:'SCODE_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:true
		};
		
		viewGridChk_1(gridObj,'ly_'+gridObj.id);
		popScodeList(mcode_nm, '');
		
		$('#sub_scode_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#sub_scode_nm').val())!=''){
				
				if($(this).val() == ""){
					alert("검색어를 입력해 주세요.");
					return;
				}
				
				popScodeList(mcode_nm,$(this).val());
			}
		});
		
		$("#btn_app_select").button().unbind("click").click(function(){
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
		
			var scode_nm = "";
			var scode_desc = "";
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){	
					scode_nm += "'"+getCellValue(gridObj, aSelRow[i], 'SCODE_NM')+"',";
					scode_desc += getCellValue(gridObj, aSelRow[i], 'SCODE_NM')+", ";
				}
				scode_nm = scode_nm.substring(0, scode_nm.length-1);
				scode_desc = scode_desc.substring(0, scode_desc.length-2);
				
				
				selectApplication3(scode_nm, scode_desc);
			}else{
				alert("검색하려는 대그룹을 선택해주세요.");
				return;
			}
		});
		$("#btn_scode_search").button().unbind("click").click(function(){
			var scode_nm = $("#common_form1").find("input[name='sub_scode_nm']").val();
			
			popScodeList(mcode_nm,scode_nm);
		});
		
	}
	
	//App 팝업 내역
	function popScodeList(mcode_nm,scode_nm){
		
		try{viewProgBar(true);}catch(e){}		
		$('#ly_total_cnt_10').html('');		
				
		var url = '/common.ez?c=cData&itemGb=sCodeList&host_eng_nm=1&mcode_nm='+encodeURIComponent(mcode_nm)+'&scode_nm='+encodeURIComponent(scode_nm);
						
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
												
						if(items.attr('cnt')=='0'){
							alert("검색된 내용이 없습니다.");		
							return;
						}else{
														
							items.find('item').each(function(i){						
							
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();	
								var scode_desc = $(this).find("SCODE_DESC").text();	
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();
																																																																
								rowsObj.push({
									'grid_idx':i+1							
									,'SCODE_CD': scode_cd
									,'SCODE_NM': scode_nm
									,'SCODE_ENG_NM': scode_eng_nm
									,'SCODE_DESC': scode_desc
									,'CHOICE':"<div><a href=\"javascript:selectScodeNm('"+scode_nm+"');\" ><font color='red'>[선택]</font></a></div>"
								});
								
							});						
						}
						
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt_10').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();		
	}
	
	function selectScodeNm(nm){
		
		$("#scode_nm").val(nm);	
		$("#f_s").find("input[name='p_scode_nm']").val('\''+nm+'\'');
		dlClose("dl_tmp1");		
	}
	
	function closeTab(){
		
		var cd = "99999";
		var tabId = 'tabs-'+cd;
		top.closeTab(tabId);
	}
	
	//Table 팝업 폼 - 사용자 폴더 권한
	function poeTabForm(select_table) {
		
		var post_val = $("#f_s").find("input[name='p_modify']").val();
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='common_form1' name='common_form1' method='post' onsubmit='return false;'>";		
		sHtml1+="<table style='width:100%;height:650px;border:none;'><tr><td style='vertical-align:top;height:100%;width:100%;text-align:right;'>";
		/*sHtml1+="<select name='tab_search_gubun' id='tab_search_gubun' style='height:21px;'>";
		sHtml1+="<option value='n'>일반</option>";
		sHtml1+="<option value='s'>스마트</option>";
		sHtml1+="</select>&nbsp;";*/
		sHtml1+="<select name='app_search_gubun' id='app_search_gubun' style='height:21px;'>";
		//sHtml1+="<option value='t'>전체검색</option>";
//		sHtml1+="<option value='h'>테이블명</option>";
//		sHtml1+="<option value='e'>테이블명(영어)</option>";
		sHtml1+="<option value='e'>폴더</option>";
//		sHtml1+="<option value='L4'>테이블명(일치)</option>";
		sHtml1+="</select>&nbsp;";
		sHtml1+="<input type='text' name='grp_nm' id='grp_nm' style='ime-mode:active;'/>&nbsp;&nbsp;<span id='btn_app_search' style='margin:3px 7px 3px 3px;'>검색</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:15px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
//		sHtml1+="<span id='btn_tabs_search'>선택</span>";
		sHtml1+="<div id='ly_total_cnt_10' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1', "폴더 검색", 770, 700, false);
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
//		   		,{formatter:gridCellNoneFormatter,field:'GRP_NM',id:'GRP_NM',name:'테이블명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
//		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'테이블명(영어)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'폴더',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:400,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'GRP_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'USER_DAILY',id:'USER_DAILY',name:'USER_DAILY',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll: true
		};

		viewGrid_1(gridObj,'ly_'+gridObj.id);
		
		$("#grp_nm").focus();
		popTabList2('', '', '', select_table);
		
		$('#grp_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#grp_nm').val())!=''){
				var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
				var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
				popTabList2($(this).val(), app_search_gubun, tab_search_gubun, '');
			}
		});
		
		$("#tab_search_gubun").change(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
			popTabList2(grp_nm, app_search_gubun, $(this).val(), '');
		});
		
		$("#btn_app_search").button().unbind("click").click(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
			var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
			
			popTabList2(grp_nm, app_search_gubun, tab_search_gubun, '');
		});
		
		$("#btn_tabs_search").button().unbind("click").click(function(){
			var selectedRows = $('#'+gridObj.id).data('grid').getSelectedRows();
			var rowsLength	= selectedRows.length;
			if (rowsLength == 0) {
				alert("검색할 테이블을 선택해주세요.");
				return;
			}

			if(select_table == "" && rowsLength == 1){
				var grp_eng_nm = getCellValue(gridObj,selectedRows[0],'GRP_ENG_NM');
				var grp_desc   = getCellValue(gridObj,selectedRows[0],'GRP_DESC');
				var user_daily = getCellValue(gridObj,selectedRows[0],'USER_DAILY');
				var grp_cd     = getCellValue(gridObj,selectedRows[0],'GRP_CD');
				selectTable(grp_eng_nm, grp_desc, user_daily, grp_cd);
			}else {
				var grp_eng_nm = "";
				
				for (var i = 0; i < rowsLength; i++) {
					if(grp_eng_nm == ""){
						grp_eng_nm += getCellValue(gridObj,selectedRows[i],'GRP_ENG_NM');
					}else{
						grp_eng_nm += "," + getCellValue(gridObj,selectedRows[i],'GRP_ENG_NM');
					}
				}
				selectTable(grp_eng_nm,'','','');
			}
		});
	}
	
	//검색조건용 Tab 팝업 폼
	function searchPoeTabForm(select_table){
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='common_form1' name='common_form1' method='post' onsubmit='return false;'>";		
		sHtml1+="<table style='width:100%;height:650px;border:none;'><tr><td style='vertical-align:top;height:100%;width:100%;text-align:right;'>";
		/*sHtml1+="<span id='btn_app_select' style='position:relative;right:485px;'>선택</span>";*/
		/*sHtml1+="<select name='tab_search_gubun' id='tab_search_gubun' style='height:21px;'>";
		sHtml1+="<option value='n'>일반</option>";
		sHtml1+="<option value='s'>스마트</option>";
		sHtml1+="</select>&nbsp;";*/
		sHtml1+="<select name='app_search_gubun' id='app_search_gubun' style='height:21px;'>";
		//sHtml1+="<option value='t'>전체검색</option>";
//		sHtml1+="<option value='h'>테이블명</option>"; 
		//sHtml1+="<option value='e'>테이블명(영어)</option>";
		sHtml1+="<option value='e'>폴더</option>";
//		sHtml1+="<option value='L4'>테이블명(일치)</option>";
		sHtml1+="</select>&nbsp;";
		sHtml1+="<input type='text' name='grp_nm' id='grp_nm' style='ime-mode:active;'/>&nbsp;&nbsp;<span id='btn_app_search' style='margin:3px 7px 3px 3px;'>검색</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<span id='btn_tabs_search' style='margin:3px 7px 3px 3px;'>선택</span>";
		sHtml1+="<div id='ly_total_cnt_10' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1', "폴더 검색", 770, 700, false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_NM',id:'GRP_NM',name:'테이블명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'테이블명(영어)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:400,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'GRP_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll: true
		};
		
		viewGridChk_1(gridObj,'ly_'+gridObj.id);
		
		$("#grp_nm").focus();
		popTabList('', '', '', select_table);
		
		$('#grp_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#grp_nm').val())!=''){
				var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
				var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
				popTabList($(this).val(), app_search_gubun, tab_search_gubun, '');
			}
		});
		
		
		$("#btn_app_search").button().unbind("click").click(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
			var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
			popTabList(grp_nm, app_search_gubun, tab_search_gubun, '');
		});
		

		$("#tab_search_gubun").change(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			popTabList(grp_nm, app_search_gubun, $(this).val(), '');
		});
		
		$("#btn_app_select").button().unbind("click").click(function(){

			var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
		
			var grp_eng_nm 	= "";
			var grp_desc 	= "";
			var field		= "";
			if(aSelRow.length>0){
				if(tab_search_gubun == 's') {
					field = "PARENT_TALBE";
				} else {
					field = "GRP_ENG_NM";
				}
				for(var i=0;i<aSelRow.length;i++){	
					grp_eng_nm += "'"+getCellValue(gridObj, aSelRow[i], field)+"',";
					grp_desc += getCellValue(gridObj, aSelRow[i], field)+", ";
				}
				grp_eng_nm = grp_eng_nm.substring(0, grp_eng_nm.length-1);
				grp_desc = grp_desc.substring(0, grp_desc.length-2);
				
				
				selectTable2(grp_eng_nm, grp_desc);
			}else{
				alert("검색하려는 테이블을 선택해주세요.");
				return;
			}
		});
		
		$("#btn_tabs_search").button().unbind("click").click(function(){
			var selectedRows = $('#'+gridObj.id).data('grid').getSelectedRows();
			var rowsLength	= selectedRows.length;
			if (rowsLength == 0) {
				alert("검색할 테이블을 선택해주세요.");
				return;
			}

			if(rowsLength == 1){
				var grp_eng_nm = getCellValue(gridObj,selectedRows[0],'GRP_ENG_NM');
				var grp_desc   = getCellValue(gridObj,selectedRows[0],'GRP_DESC');
				var user_daily = getCellValue(gridObj,selectedRows[0],'USER_DAILY');
				var grp_cd     = getCellValue(gridObj,selectedRows[0],'GRP_CD');
				var task_type  = getCellValue(gridObj,selectedRows[0],'TASK_TYPE');
				var table_id   = getCellValue(gridObj,selectedRows[0],'TABLE_ID');
				
				selectTable(grp_eng_nm, grp_desc, user_daily, grp_cd, task_type, table_id);
			}else {
				var grp_eng_nm = "";
				var task_type  = "";
				var table_id   = "";
				for (var i = 0; i < rowsLength; i++) {
					if(grp_eng_nm == ""){
						grp_eng_nm += getCellValue(gridObj,selectedRows[i],'GRP_ENG_NM');
						task_type  += getCellValue(gridObj,selectedRows[i],'TASK_TYPE');
						table_id   += getCellValue(gridObj,selectedRows[i],'TABLE_ID');
					}else{
						grp_eng_nm += "," + getCellValue(gridObj,selectedRows[i],'GRP_ENG_NM');
						task_type  += "," + getCellValue(gridObj,selectedRows[i],'TASK_TYPE');
						table_id   += "," + getCellValue(gridObj,selectedRows[i],'TABLE_ID');
					}
				}
				selectTable(grp_eng_nm,'','','', task_type, table_id);
			}

		});
		
	}
	
	// 수시작업 list 팝업에서 새로운 팝업을 띄울경우 창이 잘리는 현상 떄문에 구현.  
	function searchPoeTabForm2(select_table){
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='common_form1' name='common_form1' method='post' onsubmit='return false;'>";
		sHtml1+="<table style='width:100%;height:450px;border:none;'><tr><td style='vertical-align:top;height:100%;width:100%;text-align:right;'>";
		/*sHtml1+="<span id='btn_app_select' style='position:relative;right:485px;'>선택</span>";*/
		/*sHtml1+="<select name='tab_search_gubun' id='tab_search_gubun' style='height:21px;'>";
		sHtml1+="<option value='n'>일반</option>";
		sHtml1+="<option value='s'>스마트</option>";
		sHtml1+="</select>&nbsp;";*/
		sHtml1+="<select name='app_search_gubun' id='app_search_gubun' style='height:21px;'>";
		//sHtml1+="<option value='t'>전체검색</option>";
//		sHtml1+="<option value='h'>테이블명</option>"; 
		//sHtml1+="<option value='e'>테이블명(영어)</option>";
		sHtml1+="<option value='e'>폴더</option>";
//		sHtml1+="<option value='L4'>테이블명(일치)</option>";
		sHtml1+="</select>&nbsp;";
		sHtml1+="<input type='text' name='grp_nm' id='grp_nm' style='ime-mode:active;'/>&nbsp;&nbsp;<span id='btn_app_search' style='margin:3px 7px 3px 3px;'>검색</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<span id='btn_tabs_search' style='margin:3px 7px 3px 3px;'>선택</span>";
		sHtml1+="<div id='ly_total_cnt_10' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1', "폴더 검색", 670, 500, false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_NM',id:'GRP_NM',name:'테이블명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'테이블명(영어)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:400,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'GRP_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll: true
		};
		
		viewGridChk_1(gridObj,'ly_'+gridObj.id);
		
		$("#grp_nm").focus();
		popTabList('', '', '', select_table);
		
		$('#grp_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#grp_nm').val())!=''){
				var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
				var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
				popTabList($(this).val(), app_search_gubun, tab_search_gubun, '');
			}
		});
		
		
		$("#btn_app_search").button().unbind("click").click(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
			var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
			popTabList(grp_nm, app_search_gubun, tab_search_gubun, '');
		});
		

		$("#tab_search_gubun").change(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			popTabList(grp_nm, app_search_gubun, $(this).val(), '');
		});
		
		$("#btn_app_select").button().unbind("click").click(function(){

			var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
		
			var grp_eng_nm 	= "";
			var grp_desc 	= "";
			var field		= "";
			if(aSelRow.length>0){
				if(tab_search_gubun == 's') {
					field = "PARENT_TALBE";
				} else {
					field = "GRP_ENG_NM";
				}
				for(var i=0;i<aSelRow.length;i++){	
					grp_eng_nm += "'"+getCellValue(gridObj, aSelRow[i], field)+"',";
					grp_desc += getCellValue(gridObj, aSelRow[i], field)+", ";
				}
				grp_eng_nm = grp_eng_nm.substring(0, grp_eng_nm.length-1);
				grp_desc = grp_desc.substring(0, grp_desc.length-2);
				
				
				selectTable2(grp_eng_nm, grp_desc);
			}else{
				alert("검색하려는 테이블을 선택해주세요.");
				return;
			}
		});
		
		$("#btn_tabs_search").button().unbind("click").click(function(){
			var selectedRows = $('#'+gridObj.id).data('grid').getSelectedRows();
			var rowsLength	= selectedRows.length;
			
			if (rowsLength == 0) {
				alert("검색할 테이블을 선택해주세요.");
				return;
			}

			if(rowsLength == 1){
				var grp_eng_nm = getCellValue(gridObj,selectedRows[0],'GRP_ENG_NM');
				var grp_desc   = getCellValue(gridObj,selectedRows[0],'GRP_DESC');
				var user_daily = getCellValue(gridObj,selectedRows[0],'USER_DAILY');
				var grp_cd     = getCellValue(gridObj,selectedRows[0],'GRP_CD');
				selectTable(grp_eng_nm, grp_desc, user_daily, grp_cd);
			}else {
				var grp_eng_nm = "";
				for (var i = 0; i < rowsLength; i++) {
					if(grp_eng_nm == ""){
						grp_eng_nm += getCellValue(gridObj,selectedRows[i],'GRP_ENG_NM');
					}else{
						grp_eng_nm += "," + getCellValue(gridObj,selectedRows[i],'GRP_ENG_NM');
					}	
				}
				selectTable(grp_eng_nm,'','','');
			}

		});
	}
	
	// 수시작업 list 팝업에서 새로운 팝업을 띄울경우 창이 잘리는 현상 떄문에 구현.  
	function searchPoeTabForm3(select_table){
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='common_form1' name='common_form1' method='post' onsubmit='return false;'>";
		sHtml1+="<table style='width:100%;height:450px;border:none;'><tr><td style='vertical-align:top;height:100%;width:100%;text-align:right;'>";
		/*sHtml1+="<span id='btn_app_select' style='position:relative;right:485px;'>선택</span>";*/
		/*sHtml1+="<select name='tab_search_gubun' id='tab_search_gubun' style='height:21px;'>";
		sHtml1+="<option value='n'>일반</option>";
		sHtml1+="<option value='s'>스마트</option>";
		sHtml1+="</select>&nbsp;";*/
		sHtml1+="<select name='app_search_gubun' id='app_search_gubun' style='height:21px;'>";
		//sHtml1+="<option value='t'>전체검색</option>";
//		sHtml1+="<option value='h'>테이블명</option>"; 
		//sHtml1+="<option value='e'>테이블명(영어)</option>";
		sHtml1+="<option value='e'>폴더</option>";
//		sHtml1+="<option value='L4'>테이블명(일치)</option>";
		sHtml1+="</select>&nbsp;";
		sHtml1+="<input type='text' name='grp_nm' id='grp_nm' style='ime-mode:active;'/>&nbsp;&nbsp;<span id='btn_app_search' style='margin:3px 7px 3px 3px;'>검색</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<span id='btn_tabs_search' style='margin:3px 7px 3px 3px;'>선택</span>";
		sHtml1+="<div id='ly_total_cnt_10' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1', "폴더 검색", 670, 500, false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_NM',id:'GRP_NM',name:'테이블명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'테이블명(영어)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:400,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'GRP_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll: true
		};
		
		viewGridChk_1(gridObj,'ly_'+gridObj.id);
		
		$("#grp_nm").focus();
		popTabList('', '', '', select_table);
		
		$('#grp_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#grp_nm').val())!=''){
				var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
				var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
				popTabList($(this).val(), app_search_gubun, tab_search_gubun, '');
			}
		});
		
		
		$("#btn_app_search").button().unbind("click").click(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
			var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
			popTabList(grp_nm, app_search_gubun, tab_search_gubun, '');
		});
		

		$("#tab_search_gubun").change(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			popTabList(grp_nm, app_search_gubun, $(this).val(), '');
		});
		
		$("#btn_app_select").button().unbind("click").click(function(){

			var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
		
			var grp_eng_nm 	= "";
			var grp_desc 	= "";
			var field		= "";
			if(aSelRow.length>0){
				if(tab_search_gubun == 's') {
					field = "PARENT_TALBE";
				} else {
					field = "GRP_ENG_NM";
				}
				for(var i=0;i<aSelRow.length;i++){	
					grp_eng_nm += "'"+getCellValue(gridObj, aSelRow[i], field)+"',";
					grp_desc += getCellValue(gridObj, aSelRow[i], field)+", ";
				}
				grp_eng_nm = grp_eng_nm.substring(0, grp_eng_nm.length-1);
				grp_desc = grp_desc.substring(0, grp_desc.length-2);
				
				
				selectTable2(grp_eng_nm, grp_desc);
			}else{
				alert("검색하려는 테이블을 선택해주세요.");
				return;
			}
		});
		
		$("#btn_tabs_search").button().unbind("click").click(function(){
			var selectedRows = $('#'+gridObj.id).data('grid').getSelectedRows();
			var rowsLength	= selectedRows.length;
			
			if (rowsLength == 0) {
				alert("검색할 테이블을 선택해주세요.");
				return;
			}

			if(rowsLength == 1){
				var grp_eng_nm = getCellValue(gridObj,selectedRows[0],'GRP_ENG_NM');
				var grp_desc   = getCellValue(gridObj,selectedRows[0],'GRP_DESC');
				var user_daily = getCellValue(gridObj,selectedRows[0],'USER_DAILY');
				var grp_cd     = getCellValue(gridObj,selectedRows[0],'GRP_CD');
				selectTable2(grp_eng_nm, grp_desc, user_daily, grp_cd);
			}else {
				var grp_eng_nm = "";
				for (var i = 0; i < rowsLength; i++) {
					if(grp_eng_nm == ""){
						grp_eng_nm += getCellValue(gridObj,selectedRows[i],'GRP_ENG_NM');
					}else{
						grp_eng_nm += "," + getCellValue(gridObj,selectedRows[i],'GRP_ENG_NM');
					}	
				}
				selectTable2(grp_eng_nm,'','','');
			}

		});
	}
	
	//Table 내역
	function popTabList(grp_nm, gubun, field_gubun, select_table){
	
		try{viewProgBar(true);}catch(e){}		
		$('#ly_total_cnt_10').html('');		
		
		var data_center_items = $("select[name='data_center_items'] option:selected").val();
		if(data_center_items == null) {
			data_center_items = $("select[name='select_data_center_code'] option:selected").val();
		}

		var arr_dt = data_center_items.split(",");
		var data_center = arr_dt[0];
		
		var url = '';
		
		if(field_gubun == 's') {
			var gridObj = {
				id : "g_tmp1"
				,colModel:[
			   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'PARENT_TALBE',id:'PARENT_TALBE',name:'스마트폴더명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'JOBS_IN_GROUP',id:'JOBS_IN_GROUP',name:'작업 수',width:50,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'USER_DAILY',id:'USER_DAILY',name:'ORDER_METHOD',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'SYNC_MSG',id:'SYNC_MSG',name:'CHECKED_OUT_BY',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'SYNC_STATE',id:'SYNC_STATE',name:'SYNC_STATE',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'SYNC_MSG',id:'SYNC_MSG',name:'SYNC_MSG',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'LAST_UPLOAD',id:'LAST_UPLOAD',name:'LAST_UPLOAD',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			   	]
				
				,rows:[]
				,vscroll: true
			};
			
			viewGrid_1(gridObj,'ly_'+gridObj.id);
			if($("#f_s").find("input[name='data_center']").val() == null) {
				url = '/common.ez?c=cData&itemGb=sForderList&itemGubun=2&data_center=' + data_center_items;
			} else {
				url = '/common.ez?c=cData&itemGb=sForderList&itemGubun=2';
			}
			
		} else {
			var gridObj = {
				id : "g_tmp1"
				,colModel:[
			   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
//			   		,{formatter:gridCellNoneFormatter,field:'GRP_NM',id:'GRP_NM',name:'테이블명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
//			   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'테이블명(영어)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
					,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'폴더',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:350,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
//			   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		
			   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'GRP_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			   		,{formatter:gridCellNoneFormatter,field:'USER_DAILY',id:'USER_DAILY',name:'USER_DAILY',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
					,{formatter:gridCellNoneFormatter,field:'TASK_TYPE',id:'TASK_TYPE',name:'TASK_TYPE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
					,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			   	]
				,rows:[]
				,vscroll: true
			};
			
			viewGridChk_1(gridObj,'ly_'+gridObj.id);
			
			// 폴더 다중검색 (2024-02-19 김선중)
			// gridObj에 셋팅되는 시간때문에 setTimeout 적용
			setTimeout(function(){
				if(select_table != ""){
					var arr_select_table = select_table.split(","); // 조회할 테이블 이름
					var arr_table_index  = new Array(); // 조회되는 테이블의 인덱스 정보를 담는 배열
					
					for(var i = 0; i < arr_select_table.length; i++){
						for(var j = 0; j < gridObj.rows.length; j++){
							if( arr_select_table[i] == getCellValue(gridObj, j, "GRP_ENG_NM") ){
								arr_table_index.push(j);
								break;
							}
						}
					}
					
					$('#'+gridObj.id).data('grid').setSelectedRows(arr_table_index);
				}
			}, 100);
			
			
			$("#f_s").find("input[name='p_scode_cd']").val(data_center);
			$("#f_s").find("input[name='p_grp_depth']").val("1");
			$("#f_s").find("input[name='p_app_nm']").val(grp_nm);
			$("#f_s").find("input[name='p_app_search_gubun']").val(gubun);
			
			url = '/common.ez?c=cData&itemGb=searchAppGrpCodeList&itemGubun=2';
		}
		
		var xhr = new XHRHandler(url, f_s
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
												
						if(items.attr('cnt')=='0'){
							alert("검색된 내용이 없습니다.");		
							return;
						}else{
														
							items.find('item').each(function(i){						
								if(field_gubun == 's') {
									var parent_table 	= $(this).find("PARENT_TALBE").text();
									var user_daily 		= $(this).find("USER_DAILY").text();
									var used_by 		= $(this).find("USED_BY").text();
									var sync_state 		= $(this).find("SYNC_STATE").text();
									var sync_msg 		= $(this).find("SYNC_MSG").text();
									var last_upload 	= $(this).find("LAST_UPLOAD").text();
									var jobs_in_group 	= $(this).find("JOBS_IN_GROUP").text();
//									var doc_cd 			= $(this).find("DOC_CD").text();
//									var job_name 		= $(this).find("JOB_NAME").text();
//									var data_center		= $(this).find("DATA_CENTER").text();
//									var scode_cd		= data_center.split(",");
									rowsObj.push({
										'grid_idx'		: i+1
										,'PARENT_TALBE'	: parent_table
										,'USER_DAILY'	: user_daily
										,'USED_BY'		: used_by
										,'SYNC_STATE'	: sync_state
										,'SYNC_MSG'		: sync_msg
										,'LAST_UPLOAD'	: last_upload
										,'JOBS_IN_GROUP': jobs_in_group + '개'
										,'CHOICE':"<div><a href=\"javascript:selectTable('"+parent_table+"','4','"+user_daily+"');\" ><font color='red'>[선택]</font></a></div>"
									});
									
								} else {
									var grp_cd 				= $(this).find("GRP_CD").text();
									var grp_nm 				= $(this).find("GRP_NM").text();	
									var grp_desc 			= $(this).find("GRP_DESC").text();	
									var grp_eng_nm 			= $(this).find("GRP_ENG_NM").text();
									var user_daily 			= $(this).find("USER_DAILY").text();
									var work_group_name 	= $(this).find("WORK_GROUP_NAME").text();
									var task_type 			= $(this).find("TASK_TYPE").text();
									var table_id 			= $(this).find("TABLE_ID").text();
									
									var smart_folder = "";
									if ( task_type == "SMART Table" ) {
										smart_folder = "<img src='/imgs/smart_folder.png' style='vertical-align:middle;' width='20' height='20'> ";
									}
									
									rowsObj.push({
										'grid_idx':i+1							
										,'GRP_CD': grp_cd
										,'GRP_NM': grp_nm
										,'GRP_ENG_NM': smart_folder + grp_eng_nm
										,'GRP_DESC': grp_desc
										,'USER_DAILY': user_daily
										,'WORK_GROUP_NAME': work_group_name
										,'TASK_TYPE': task_type
										,'TABLE_ID': table_id
										//Application 조회시 grp_cd로 조회하도록 grp_cd 매개변수 추가. 기존 매개변수 변경하지 않음. (2020.08.24 김수정)
										,'CHOICE':"<div><a href=\"javascript:selectTable('"+grp_eng_nm+"','"+grp_desc+"','"+user_daily+"','"+grp_cd+"');\" ><font color='red'>[선택]</font></a></div>"
									});
								}
							});						
						}
						
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						clearGridSelected(obj);
						
						$('#ly_total_cnt_10').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();		
	}
	
	//Table 내역
	function popTabList2(grp_nm, gubun, field_gubun, select_table){
	
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_10').html('');		
		
		var data_center_items = $("select[name='data_center_items'] option:selected").val();
		if(data_center_items == null) {
			data_center_items = $("select[name='select_data_center_code'] option:selected").val();
			if(data_center_items == null) {
				data_center_items = $("#data_center_items").val();
			}
		}
		
		var post_val = $("#f_s").find("input[name='p_modify']").val();

		var arr_dt = data_center_items.split(",");
		   
		var data_center = arr_dt[0];
		var url = '';
		
		if(field_gubun == 's') {
			var gridObj = {
				id : "g_tmp1"
				,colModel:[
			   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'PARENT_TALBE',id:'PARENT_TALBE',name:'스마트폴더명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'JOBS_IN_GROUP',id:'JOBS_IN_GROUP',name:'작업 수',width:50,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'USER_DAILY',id:'USER_DAILY',name:'ORDER_METHOD',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'SYNC_MSG',id:'SYNC_MSG',name:'CHECKED_OUT_BY',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'SYNC_STATE',id:'SYNC_STATE',name:'SYNC_STATE',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'SYNC_MSG',id:'SYNC_MSG',name:'SYNC_MSG',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'LAST_UPLOAD',id:'LAST_UPLOAD',name:'LAST_UPLOAD',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			   	]
				
				,rows:[]
				,vscroll: true
			};
			 
			viewGrid_1(gridObj,'ly_'+gridObj.id);
			if($("#f_s").find("input[name='data_center']").val() == null) {
				url = '/common.ez?c=cData&itemGb=sForderList&itemGubun=2&data_center=' + data_center_items;
			} else {
				url = '/common.ez?c=cData&itemGb=sForderList&itemGubun=2';
			}
			
		} else {
			//개인정보 > 폴더 선택 시 폴더권한이 적용된 화면 + 체크박스 다중 선택
			if(post_val == "Y") {
				var gridObj = {
					id : "g_tmp1"
					,colModel:[
						{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
						,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'폴더',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
						,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:350,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}

						,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
						,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'GRP_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
						,{formatter:gridCellNoneFormatter,field:'USER_DAILY',id:'USER_DAILY',name:'USER_DAILY',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
					]
					,rows:[]
					,vscroll: true
				};

				viewGridChk_1(gridObj,'ly_'+gridObj.id);
				
				// 폴더 다중검색 (2024-02-19 김선중)
				// gridObj에 셋팅되는 시간때문에 setTimeout 적용
				setTimeout(function(){
					if(select_table != ""){
						var arr_select_table = select_table.split(","); // 조회할 테이블 이름
						var arr_table_index  = new Array(); // 조회되는 테이블의 인덱스 정보를 담는 배열
						for(var i = 0; i < arr_select_table.length; i++){
							for(var j = 0; j < gridObj.rows.length; j++){
								if( arr_select_table[i] == getCellValue(gridObj, j, "GRP_ENG_NM") ){
									arr_table_index.push(j);
									break;
								}
							}
						}
						$('#'+gridObj.id).data('grid').setSelectedRows(arr_table_index);
					}
				}, 100);

			}else{
				//유저 폴더권한 적용된 폴더 검색 화면
				var gridObj = {
					id : "g_tmp1"
					,colModel:[
						{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
						,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'폴더',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
						,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:300,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
						,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}

						,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
						,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'GRP_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
						,{formatter:gridCellNoneFormatter,field:'USER_DAILY',id:'USER_DAILY',name:'USER_DAILY',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
						,{formatter:gridCellNoneFormatter,field:'TASK_TYPE',id:'TASK_TYPE',name:'TASK_TYPE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
						,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
					]
					,rows:[]
					,vscroll: true
				};
				viewGrid_1(gridObj,'ly_'+gridObj.id);
			}
			
			$("#f_s").find("input[name='p_scode_cd']").val(data_center);
			$("#f_s").find("input[name='p_grp_depth']").val("1");
			$("#f_s").find("input[name='p_app_nm']").val(grp_nm);
			$("#f_s").find("input[name='p_app_search_gubun']").val(gubun);
			
			url = '/common.ez?c=cData&itemGb=appGrpCodeList2&itemGubun=2';
		}
		
		var xhr = new XHRHandler(url, f_s
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
												
						if(items.attr('cnt')=='0'){
							alert("검색된 내용이 없습니다.");		
							return;
						}else{
														
							items.find('item').each(function(i){						
								if(field_gubun == 's') {
									var parent_table 	= $(this).find("PARENT_TALBE").text();
									var user_daily 		= $(this).find("USER_DAILY").text();
									var used_by 		= $(this).find("USED_BY").text();
									var sync_state 		= $(this).find("SYNC_STATE").text();
									var sync_msg 		= $(this).find("SYNC_MSG").text();
									var last_upload 	= $(this).find("LAST_UPLOAD").text();
									var jobs_in_group 	= $(this).find("JOBS_IN_GROUP").text();
//									var doc_cd 			= $(this).find("DOC_CD").text();
//									var job_name 		= $(this).find("JOB_NAME").text();
//									var data_center		= $(this).find("DATA_CENTER").text();
//									var scode_cd		= data_center.split(",");
									rowsObj.push({
										'grid_idx'		: i+1
										,'PARENT_TALBE'	: parent_table
										,'USER_DAILY'	: user_daily
										,'USED_BY'		: used_by
										,'SYNC_STATE'	: sync_state
										,'SYNC_MSG'		: sync_msg
										,'LAST_UPLOAD'	: last_upload
										,'JOBS_IN_GROUP': jobs_in_group + '개'
										,'CHOICE':"<div><a href=\"javascript:selectTable('"+parent_table+"','4','"+user_daily+"');\" ><font color='red'>[선택]</font></a></div>"
									});
									
								} else { 
									var grp_cd 				= $(this).find("GRP_CD").text();
									var grp_nm 				= $(this).find("GRP_NM").text();	
									var grp_desc 			= $(this).find("GRP_DESC").text();	
									var grp_eng_nm 			= $(this).find("GRP_ENG_NM").text();
									var user_daily 			= $(this).find("USER_DAILY").text();
									var work_group_name 	= $(this).find("WORK_GROUP_NAME").text();
									var task_type 			= $(this).find("TASK_TYPE").text();
									var table_id 			= $(this).find("TABLE_ID").text();
									
									var smart_folder = "";
									if ( task_type == "SMART Table" ) {
										smart_folder = "<img src='/imgs/smart_folder.png' style='vertical-align:middle;' width='20' height='20'> ";
									}
									
									rowsObj.push({
										'grid_idx':i+1							
										,'GRP_CD': grp_cd
										,'GRP_NM': grp_nm
										,'GRP_ENG_NM': smart_folder + grp_eng_nm
										,'GRP_DESC': grp_desc
										,'USER_DAILY': user_daily
										,'WORK_GROUP_NAME': work_group_name
										//Application 조회시 grp_cd로 조회하도록 grp_cd 매개변수 추가. 기존 매개변수 변경하지 않음. (2020.08.24 김수정)
										,'CHOICE':"<div><a href=\"javascript:selectTable('"+grp_eng_nm+"','"+grp_desc+"','"+user_daily+"','"+grp_cd+"','"+task_type+"','"+table_id+"');\" ><font color='red'>[선택]</font></a></div>"
									});
								}
							});						
						}
						
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						clearGridSelected(obj);
						
						$('#ly_total_cnt_10').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();		
	}
	
	//App 팝업 폼
	function poeAppForm(){
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='common_form1' name='common_form1' method='post' onsubmit='return false;'>";		
		sHtml1+="<table style='width:100%;height:650px;border:none;'><tr><td style='vertical-align:top;height:100%;width:900px;text-align:right;'>";
		sHtml1+="<select name='app_search_gubun' id='app_search_gubun' style='height:21px;'>";
		sHtml1+="<option value='t'>전체검색</option>";
		sHtml1+="<option value='h'>어플리케이션(L3)</option>";
		sHtml1+="<option value='e'>코드(L1+L2_L3)</option>";
		sHtml1+="<option value='L4'>코드(L4)</option>";
		sHtml1+="</select>&nbsp;";
		sHtml1+="<input type='text' name='grp_nm' id='grp_nm' style='ime-mode:active;'/>&nbsp;&nbsp;<span id='btn_app_search'>검색</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_10' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1', "어플리케이션 검색", 900, 700, false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_NM',id:'GRP_NM',name:'어플리케이션(L3)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'코드(L1+L2_L3)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:400,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'GRP_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll: true
		};
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		
		$("#grp_nm").focus();
		popAppList('', '');
		
		$('#grp_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#grp_nm').val())!=''){
				var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
				popAppList($(this).val(), app_search_gubun);
			}
		});
		
		
		$("#btn_app_search").button().unbind("click").click(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
			
			popAppList(grp_nm, app_search_gubun);
		});
		
	}
	
	//검색조건용 App 팝업 폼
	function searchPoeAppForm(){
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='common_form1' name='common_form1' method='post' onsubmit='return false;'>";		
		sHtml1+="<table style='width:100%;height:650px;border:none;'><tr><td style='vertical-align:top;height:100%;width:900px;text-align:right;'>";
		/*sHtml1+="<span id='btn_app_select' style='position:relative;right:545px;'>선택</span>";*/
		sHtml1+="<select name='app_search_gubun' id='app_search_gubun' style='height:21px;'>";
		sHtml1+="<option value='t'>전체검색</option>";
		sHtml1+="<option value='h'>어플리케이션(L3)</option>";
		sHtml1+="<option value='e'>코드(L1+L2_L3)</option>";
		sHtml1+="<option value='L4'>코드(L4)</option>";
		sHtml1+="</select>&nbsp;";
		sHtml1+="<input type='text' name='grp_nm' id='grp_nm' style='ime-mode:active;'/>&nbsp;&nbsp;<span id='btn_app_search'>검색</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_10' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1', "어플리케이션 검색", 900, 700, false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_NM',id:'GRP_NM',name:'어플리케이션(L3)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'코드(L1+L2_L3)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:400,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'GRP_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll: true
		};
		
		viewGridChk_1(gridObj,'ly_'+gridObj.id);
		
		$("#grp_nm").focus();
		popAppList('', '');
		
		$('#grp_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#grp_nm').val())!=''){
				var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
				popAppList($(this).val(), app_search_gubun);
			}
		});
		
		
		$("#btn_app_search").button().unbind("click").click(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
			
			popAppList(grp_nm, app_search_gubun);
		});
		
		$("#btn_app_select").button().unbind("click").click(function(){
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
		
			var grp_eng_nm = "";
			var grp_desc = "";
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){	
					grp_eng_nm += "'"+getCellValue(gridObj, aSelRow[i], 'GRP_ENG_NM')+"',";
					grp_desc += getCellValue(gridObj, aSelRow[i], 'GRP_ENG_NM')+", ";
				}
				grp_eng_nm = grp_eng_nm.substring(0, grp_eng_nm.length-1);
				grp_desc = grp_desc.substring(0, grp_desc.length-2);
				
				
				selectApplication2(grp_eng_nm, grp_desc);
			}else{
				alert("검색하려는 어플리케이션을 선택해주세요.");
				return;
			}
		});
		
	}
	
	//App 팝업 내역
	function popAppList(grp_nm, gubun){
		
		try{viewProgBar(true);}catch(e){}		
		$('#ly_total_cnt_10').html('');		
		
		var data_center_items = $("select[name='data_center_items'] option:selected").val();
		var arr_dt = data_center_items.split(",");
		var data_center = arr_dt[0];
		
		$("#f_s").find("input[name='p_scode_cd']").val(data_center);
		$("#f_s").find("input[name='p_grp_depth']").val("1");
		$("#f_s").find("input[name='p_app_nm']").val(grp_nm);
		$("#f_s").find("input[name='p_app_search_gubun']").val(gubun);
		
		var url = '/common.ez?c=cData&itemGb=appGrpCodeList&itemGubun=2';
				
		var xhr = new XHRHandler(url, f_s
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
												
						if(items.attr('cnt')=='0'){
							alert("검색된 내용이 없습니다.");		
							return;
						}else{
														
							items.find('item').each(function(i){						
							
								var grp_cd = $(this).find("GRP_CD").text();
								var grp_nm = $(this).find("GRP_NM").text();	
								var grp_desc = $(this).find("GRP_DESC").text();	
								var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
																																																																
								rowsObj.push({
									'grid_idx':i+1							
									,'GRP_CD': grp_cd
									,'GRP_NM': grp_nm
									,'GRP_ENG_NM': grp_eng_nm
									,'GRP_DESC': grp_desc
									,'CHOICE':"<div><a href=\"javascript:selectApplication('"+grp_eng_nm+"','"+grp_desc+"');\" ><font color='red'>[선택]</font></a></div>"
								});
								
							});						
						}
						
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						clearGridSelected(obj);
						
						$('#ly_total_cnt_10').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();		
	}
	
	//선/후행 내역
	function popJobsList(search_text,gb){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_1').html('');
		
		var global_yn 			= "N";
		var data_center 		= $("#data_center").val();
		if(data_center == ''){
			data_center			= $("#v_data_center").val();
		} 	
		var application_of_def 	= $("#application").val();
		var group_name_of_def 	= $("#group_name").val();
				
		if(data_center == ''){
			alert("C-M 을 선택해 주세요.");
			return;
		}		
		
		/*if(search_text.length == 0){						
			if(application_of_def == ''){
				alert("어플리케이션을 선택해 주세요.");
				return;
			}
		}else{*/
			data_center = $("#v_data_center").val();						
			application_of_def = "";
			group_name_of_def = "";
			global_yn = "Y";
		//}
			
		$("#f_s").find("input[name='p_data_center']").val(data_center);
		$("#f_s").find("input[name='p_application']").val("");
		$("#f_s").find("input[name='p_group_name_of_def']").val(group_name_of_def);
		$("#f_s").find("input[name='p_search_gubun']").val("job_name");
		$("#f_s").find("input[name='p_search_text']").val(search_text);		
		
		var url = '/common.ez?c=cData&itemGb=popDefJobList&itemGubun=2';
		
		var xhr = new XHRHandler(url, f_s
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						var job_name0 = "<div class='gridInput_area'><input type='text' name='job_name0' id='job_name0' style='width:100%;ime-mode:disabled;' placeholder='직접입력' /></div>";
																		
						rowsObj.push({
							'grid_idx':''									
							,'APPLICATION': ''
							,'GROUP_NAME': ''
							,'JOB_NAME': job_name0								
							,'JOB_ID': ''
							,'TABLE_ID': ''	
							,'CHOICE':"<div><a href=\"javascript:goPreJobSelect('','"+gb+"','direct');\" ><font color='red'>[선택]</font></a></div>"
						});
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
															
								var application			= $(this).find("APPLICATION").text();
								var group_name 			= $(this).find("GROUP_NAME").text();
								var job_name 			= $(this).find("JOB_NAME").text();								
								var job_id 				= $(this).find("JOB_ID").text();
								var table_id 			= $(this).find("TABLE_ID").text();
								var mapper_data_center 	= $(this).find("MAPPER_DATA_CENTER").text();
								var set_job_name		= job_name;
								
								if ( mapper_data_center != $("#doc_data_center").val() ) {
									set_job_name = "GLOB-" + job_name;
								}
								
								rowsObj.push({
									'grid_idx':i+1									
									,'APPLICATION': application
									,'GROUP_NAME': group_name
									,'JOB_NAME': job_name									
									,'JOB_ID': job_id
									,'TABLE_ID': table_id	
									,'CHOICE':"<div><a href=\"javascript:goPreJobSelect('"+set_job_name+"','"+gb+"','');\" ><font color='red'>[선택]</font></a></div>"
								});
							});						
						}
						
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt_1').html('[ TOTAL : '+items.attr('cnt')+' ]');			
						
					});
										
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function byteCheck(id){
		var obj = $("#"+id);
		var codeByte = 0;
		
		for(var idx=0;idx<trim(obj.val()).length;idx++){
			var oneChar = escape(obj.val().charAt(idx));
			if(oneChar.length == 1){
				codeByte++;
			}else if(oneChar.indexOf("%u") != -1){
				codeByte += 2;
			}else if(oneChar.indexOf("%") != -1){
				codeByte++;
			}
		}
		
		return codeByte;		
	}
	
	function noSpaceBar(obj){
		var str_space = /\s/;
		if(str_space.exec(obj.value)){
			obj.value = obj.value.replace(' ','');
			return false;
		}
		changeCommand(obj);
	}
	//입력파라미터or프로그램명or프로그램위치 값이 변경될 경우 작업수행명령도 변경(작업 타입이 ctmfw일 경우)
	function changeCommand(arg){
		var task_type = $("select[name='task_type'] option:selected").val();
		if(task_type == "ctmfw" || task_type == "command"){
			var command = document.getElementById('mem_lib').value + document.getElementById('mem_name').value + " " + document.getElementById('input_param').value
			document.getElementById('command').value = command;
		}
	}
	//프로그램 위치 맨 마지막에 "/" 여부 체크하여 추가
	function fn_slash(arg){
		var strChk = $("input[name='mem_lib']").val();
		
		if(strChk.substr(-1) != "/" && strChk != ""){
			$("input[name='mem_lib']").val($("input[name='mem_lib']").val() + "/");
		}
		
		changeCommand(arg);
	}
	function checkIfName() {
		
		var command 	= $("#command").val();
		var mem_name 	= $("#mem_name").val();
		var if_name		= "";
		
		//eaibatch.sh
		//fepbatch.sh
		
		if ( mem_name == "eaibatch.sh" || mem_name == "fepbatch.sh" ) {
			
			if ( command.indexOf("-i ") > -1 ) {
				
				command = replaceAll(command, "  ", " ");			
				if_name = command.substring(command.indexOf("-i") + 3, command.length).split(" ")[0];			
				
				var url = '/common.ez?c=cData&itemGb=checkIfName&itemGubun=2&if_name='+if_name;
				
				var xhr = new XHRHandler(url, null
						,function(){
							var xmlDoc = this.req.responseXML;
							if(xmlDoc==null){
								try{viewProgBar(false);}catch(e){}
								alert('세션이 만료되었습니다 다시 로그인해 주세요');
								return false;
							}
							
							if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
								try{viewProgBar(false);}catch(e){}
								alert($(xmlDoc).find('msg_code').text());
								//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
								return false;
							}
							
							$(xmlDoc).find('doc').each(function(){
								
								var items 	= $(this).find('items');
								var rowsObj = new Array();
								
								var if_return = "";
								
								if(items.attr('cnt')=='0'){
									
								}else{
									
									items.find('item').each(function(i) {
									
										if_return = $(this).find("IF_RETURN").text();
										
										//in_cond_name 	+= "작업명:" + job_name + " 담당자:" + user_nm + "\n";
									});
								}
								
								//alert("if_return : " + if_return);
								
								var arr_if_return 	= if_return.split(":");
								var return_value	= arr_if_return[1].split(",")[0];
								var if_return		= "";
								
								//alert("return_value : " + return_value);
								
								// FEPB001BOKNSEND 인터페이스 아이디 예외 처리
								if ( if_name != "FEPB001BOKNSEND" ) {
								
									if ( return_value != "30" ) {
										
										if ( return_value == "00" ) {
											if_return = "미 존재 인터페이스입니다.";
										} else if ( return_value == "10" ) {
											if_return = "삭제 인터페이스입니다.";
										} else if ( return_value == "20" ) {
											if_return = "미 배포, 개발배포, 테스트배포 상태입니다.";
										}
									}								
								}
								
								$("#if_return").val(if_return);
							});
							try{viewProgBar(false);}catch(e){}
						}
				, null );
				
				xhr.sendRequest();
			}
		}
	}
	
	function jobUserInfo(job_name) {
		
		var frm = document.userFrm;
		
		openPopupCenter1("about:blank", "popupJobUserInfo", 900, 700);
		
		frm.target = "popupJobUserInfo";
		frm.action = "/tPopup.ez?c=ez046&job_name="+job_name;
		frm.submit();
	}
	
	function approvalUserInfo(sContextPath, user_cd, approvalGubun, line_gb, doc_cd, seq, approval_cd) {
		
		var frm = document.userFrm;
		
		if(approvalGubun != ""){
			approvalGubun = "Y";
		}else{
			approvalGubun = "N";
		}
		
		openPopupCenter1("about:blank", "popupApprovalUserInfo", 700, 700);
		
		frm.target = "popupApprovalUserInfo";
		frm.action = sContextPath+"/tPopup.ez?c=ez045&approvalUser_cd="+user_cd+"&approvalGubun="+approvalGubun+"&line_gb="+line_gb+"&doc_cd="+doc_cd+"&apprSeq="+seq+"&approval_cd_1="+approval_cd;
		frm.submit();
	}
	
	function dynamicApprovalUserInfo(sContextPath, user_cd, approvalGubun, line_gb, doc_cd, seq, approval_cd) {
		
		var frm = document.userFrm;
		
		if(approvalGubun != ""){
			approvalGubun = "Y";
		}else{
			approvalGubun = "N";
		}
		
		openPopupCenter1("about:blank", "popupApprovalUserInfo", 750, 700);
		
		frm.target = "popupApprovalUserInfo";
		frm.action = sContextPath+"/tPopup.ez?c=ez045_Dynamic&approvalUser_cd="+user_cd+"&approvalGubun="+approvalGubun+"&line_gb="+line_gb+"&doc_cd="+doc_cd+"&apprSeq="+seq+"&approval_cd_1="+approval_cd;
		frm.submit();
	}
	
	function dynamicApprovalUserInfo2(sContextPath, user_cd, approvalGubun, line_gb, doc_cd, seq, approval_cd, doc_group_id) {
		
		var frm = document.userFrm;
		
		if(approvalGubun != ""){
			approvalGubun = "Y";
		}else{
			approvalGubun = "N";
		}
		
		openPopupCenter1("about:blank", "popupApprovalUserInfo", 700, 700);
		
		frm.target = "popupApprovalUserInfo";
		frm.action = sContextPath+"/tPopup.ez?c=ez045_Dynamic&approvalUser_cd="+user_cd+"&approvalGubun="+approvalGubun+"&line_gb="+line_gb+"&doc_cd="+doc_cd+"&apprSeq="+seq+"&approval_cd_1="+approval_cd+"&doc_group_id="+doc_group_id;
		frm.submit();
	}
	
	function docUserInfo(doc_cd) {
		
		var frm = document.userFrm;
		
		openPopupCenter1("about:blank", "popupDocUserInfo", 700, 200); 
		
		frm.target = "popupDocUserInfo";
		frm.action = "/tPopup.ez?c=ez047&doc_cd="+doc_cd;
		frm.submit();
	}
	
	function goApprovalUserSearch(btn, s_user_cd){
		
		var sHtml2="<div id='dl_tmp3' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml2+="<form id='form3' name='form3' method='post' onsubmit='return false;'>";
		sHtml2+="<table style='width:100%;height:280px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml2+="<select name='ser_gubun' id='ser_gubun' style='height:28px;'>";
		sHtml2+="<option value='user_nm'>사용자명</option>";
		sHtml2+="<option value='user_id'>아이디</option>";
		sHtml2+="<option value='dept_nm'>부서명</option>";
		sHtml2+="</select>";
		sHtml2+="<input type='text' name='ser_user_nm' id='ser_user_nm' />&nbsp;&nbsp;<span id='btn_usersearch'>검색</span>";
		sHtml2+="<table style='width:100%;height:100%;border:none;'>";
		sHtml2+="<tr><td id='ly_g_tmp3' style='vertical-align:top;' >";
		sHtml2+="<div id='g_tmp3' class='ui-widget-header ui-corner-all'></div>";
		sHtml2+="</td></tr>";
		sHtml2+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml2+="<div align='right' class='btn_area_s'>";
		sHtml2+="<div id='ly_total_cnt3' style='padding-top:5px;float:left;'></div>";
		sHtml2+="</div>";
		sHtml2+="</h5></td></tr></table>";
		
		sHtml2+="</td></tr></table>";
		
		sHtml2+="</form>";
		
		$('#dl_tmp3').remove();
		$('body').append(sHtml2);
		
		dlPop01('dl_tmp3',"사용자내역",400,325,false);
		
		var gridObj3 = {
			id : "g_tmp3"
			,colModel:[
				
				{formatter:gridCellNoneFormatter,field:'dept_nm',id:'dept_nm',name:'부서명',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'duty_nm',id:'duty_nm',name:'직책',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'user_nm',id:'user_nm',name:'사용자명',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'user_id',id:'user_id',name:'아이디',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				
		   		,{formatter:gridCellNoneFormatter,field:'user_cd',id:'user_cd',name:'user_cd',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
		};
		
		viewGrid_1(gridObj3,'ly_'+gridObj3.id);
		
		$("#ser_user_nm").focus();
		
		$('#ser_user_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#ser_user_nm').val())!=''){				
				var ser_gubun = $("select[name='ser_gubun'] option:selected").val();	
				
				if($(this).val() == ""){
					alert("검색어를 입력해 주세요.");
					return;
				}
				getApprovalUserList(ser_gubun,$(this).val(),btn,s_user_cd);
			}
		});
		
		
		$("#btn_usersearch").button().unbind("click").click(function(){
			var ser_gubun = $("select[name='ser_gubun'] option:selected").val();
			var ser_user_nm = $("#ser_user_nm").val();
			
			if(ser_user_nm == ""){
				alert("검색어를 입력해 주세요.");
				return;
			}
			getApprovalUserList(ser_gubun,ser_user_nm,btn,s_user_cd);
		});
		
	}

	function getApprovalUserList(gubun, text, btn, s_user_cd){
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt3').html('');
//		var url = '/common.ez?c=cData&itemGb=userList&p_search_gubun='+gubun+'&p_search_text='+encodeURIComponent(text);
		var url = '/common.ez?c=cData&itemGb=userList&p_search_gubun='+gubun+'&p_search_text='+encodeURIComponent(text)+'&s_user_cd='+s_user_cd+'&popup=Y';
		
		var xhr = new XHRHandler( url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){
																
								var dept_nm = $(this).find("DEPT_NM").text();
								var duty_nm = $(this).find("DUTY_NM").text();
								var user_nm = $(this).find("USER_NM").text();
								var user_cd = $(this).find("USER_CD").text();
								var user_id = $(this).find("USER_ID").text();
								
								/*
								//결재문서의 결재자 변경시 본인은 조회불가하게 변경 2021.07.14 이상훈
								if(user_cd == s_user_cd){
									return true;
								} 		  */
								 
								rowsObj.push({'grid_idx':i+1
									,'dept_nm':dept_nm
									,'duty_nm':duty_nm
									,'user_nm':user_nm
									,'user_id':user_id
									,'CHOICE':"<div><a href=\"javascript:goApprovalUserSeqSelect('"+user_cd+"', '"+user_nm+"', '"+btn+"');\" ><font color='red'>[선택]</font></a></div>"
									,'user_cd':user_cd
								});
								
							});
							
						}
						var obj = $("#g_tmp3").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt3').html('[ TOTAL : '+items.attr('cnt')+' ]');
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}

	function goApprovalUserSeqSelect(cd, nm, btn){
		
		var frm1 = document.frm1;
		
		if(btn == "1"){			
			frm1.user_nm.value = nm;
			frm1.user_cd.value = cd;			
		}

		dlClose('dl_tmp3');
	}
	
	// Sr 팝업 폼
	function popupSrForm() { 
		
		var sHtml1="<div id='dl_sr_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='sr_form' name='sr_form' method='post' onsubmit='return false;'>";		
		sHtml1+="<table style='width:100%;height:650px;border:none;'><tr><td style='vertical-align:top;height:100%;width:900px;text-align:right;'>";
		sHtml1+="<select name='sr_search_gubun' id='sr_search_gubun' style='height:21px;'>";
		sHtml1+="<option value='sreq_code'>SR 번호</option>";
		sHtml1+="<option value='sreq_title'>프로젝트 제목</option>";
		sHtml1+="</select>&nbsp;";
		sHtml1+="<input type='text' name='sr_search_text' id='sr_search_text' style='ime-mode:active;'/>&nbsp;&nbsp;<span id='btn_sr_search'>검색</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_sr_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_sr_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_sr_total_cnt' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_sr_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_sr_tmp1', "SR 검색", 900, 700, false);
				
		var gridObj = {
			id : "g_sr_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
		   		,{formatter:gridCellNoneFormatter,field:'SREQ_CODE',id:'SREQ_CODE',name:'SR 번호',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'SREQ_TITLE',id:'SREQ_TITLE',name:'프로젝트 제목',width:400,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'PM_NM',id:'PM_NM',name:'PM',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'SREQ_PLANMH',id:'SREQ_PLANMH',name:'계획공수',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'SREQ_RESMH',id:'SREQ_RESMH',name:'실적공수',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}		   			
		   	]
			,rows:[]
			,vscroll: true
		};
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		
		$("#sr_search_text").focus();
		//popupSrList('', '');
		
		$('#sr_search_text').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#sr_search_text').val())!=''){
				var sr_search_gubun = $("select[name='sr_search_gubun'] option:selected").val();
				popupSrList($(this).val(), sr_search_gubun);
			}
		});
		
		
		$("#btn_sr_search").button().unbind("click").click(function() {
			
			var sr_search_text 		= $("#sr_form").find("input[name='sr_search_text']").val();
			var sr_search_gubun 	= $("select[name='sr_search_gubun'] option:selected").val();
			
			if ( sr_search_text == "" ) {
				alert("검색어를 입력해 주세요.");
				return;
			}
			
			popupSrList(sr_search_text, sr_search_gubun);
		});
	}
	
	// popupSrList 팝업
	function popupSrList(sr_search_text, sr_search_gubun) {
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_sr_total_cnt').html('');

		var url = '/common.ez?c=cData&itemGb=srList&itemGubun=2&sr_search_text='+encodeURIComponent(sr_search_text)+'&sr_search_gubun='+sr_search_gubun;
				
		var xhr = new XHRHandler(url, f_s
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
												
						if(items.attr('cnt')=='0'){
							alert("검색된 내용이 없습니다.");
							return;
						}else{
							
							items.find('item').each(function(i){
							
								var sreq_code 	= $(this).find("SREQ_CODE").text();
								var sreq_title 	= $(this).find("SREQ_TITLE").text();
								var pm_nm 		= $(this).find("PM_NM").text();
								var sreq_planmh = $(this).find("SREQ_PLANMH").text();
								var sreq_resmh 	= $(this).find("SREQ_RESMH").text();
																																																															
								rowsObj.push({
									'grid_idx':i+1							
									,'SREQ_CODE': sreq_code
									,'SREQ_TITLE': sreq_title
									,'PM_NM': pm_nm
									,'SREQ_PLANMH': sreq_planmh
									,'SREQ_RESMH': sreq_resmh
									,'CHOICE':"<div><a href=\"javascript:selectSrCode('"+sreq_code+"', '"+sreq_title+"', '"+pm_nm+"', '"+sreq_planmh+"');\" ><font color='red'>[선택]</font></a></div>"
								});
							});
						}
						
						var obj = $("#g_sr_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						clearGridSelected(obj);
						
						$('#ly_sr_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();		
	}
	
	function checkUserInfo() {
		
		var user_cd_1 	= $("#user_cd_1_0").val();
		var user_cd_2 	= $("#user_cd_2_0").val();
		var user_cd_3 	= $("#user_cd_3_0").val();
		var user_cd_4 	= $("#user_cd_4_0").val();
		var user_cd_5 	= $("#user_cd_5_0").val();
		var user_cd_6 	= $("#user_cd_6_0").val();
		var user_cd_7 	= $("#user_cd_7_0").val();
		var user_cd_8 	= $("#user_cd_8_0").val();
		var user_cd_9 	= $("#user_cd_9_0").val();
		var user_cd_10 	= $("#user_cd_10_0").val();
		var grp_cd_1 	= $("#grp_cd_1_0").val();
		var grp_cd_2 	= $("#grp_cd_2_0").val();
		
		var sms_1 		= $("input:checkbox[id='sms_1_0']").is(":checked");
		var sms_2 		= $("input:checkbox[id='sms_2_0']").is(":checked");
		var sms_3 		= $("input:checkbox[id='sms_3_0']").is(":checked");
		var sms_4 		= $("input:checkbox[id='sms_4_0']").is(":checked");
		var sms_5 		= $("input:checkbox[id='sms_5_0']").is(":checked");
		var sms_6 		= $("input:checkbox[id='sms_6_0']").is(":checked");
		var sms_7 		= $("input:checkbox[id='sms_7_0']").is(":checked");
		var sms_8 		= $("input:checkbox[id='sms_8_0']").is(":checked");
		var sms_9 		= $("input:checkbox[id='sms_9_0']").is(":checked");
		var sms_10 		= $("input:checkbox[id='sms_10_0']").is(":checked");
		var grp_sms_1 	= $("input:checkbox[id='grp_sms_1_0']").is(":checked");
		var grp_sms_2 	= $("input:checkbox[id='grp_sms_2_0']").is(":checked");
		
		var mail_1 		= $("input:checkbox[id='mail_1_0']").is(":checked");
		var mail_2 		= $("input:checkbox[id='mail_2_0']").is(":checked");
		var mail_3 		= $("input:checkbox[id='mail_3_0']").is(":checked");
		var mail_4 		= $("input:checkbox[id='mail_4_0']").is(":checked");
		var mail_5 		= $("input:checkbox[id='mail_5_0']").is(":checked");
		var mail_6 		= $("input:checkbox[id='mail_6_0']").is(":checked");
		var mail_7 		= $("input:checkbox[id='mail_7_0']").is(":checked");
		var mail_8 		= $("input:checkbox[id='mail_8_0']").is(":checked");
		var mail_9 		= $("input:checkbox[id='mail_9_0']").is(":checked");
		var mail_10 	= $("input:checkbox[id='mail_10_0']").is(":checked");
		var grp_mail_1 = $("input:checkbox[id='grp_mail_1_0']").is(":checked");
		var grp_mail_2 	= $("input:checkbox[id='grp_mail_2_0']").is(":checked");
		
		if ( user_cd_1 != "" ) {
			if ( sms_1 == false && mail_1 == false) {
				alert("[부가정보] 담당자1 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			}
		}
		if ( user_cd_2 != "" ) {
			if ( sms_2 == false && mail_2 == false) {
				alert("[부가정보] 담당자2 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			} 
		}
		if ( user_cd_3 != "" ) {
			if ( sms_3 == false && mail_3 == false) {
				alert("[부가정보] 담당자3 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			} 
		}
		if ( user_cd_4 != "" ) {
			if ( sms_4 == false && mail_4 == false) {
				alert("[부가정보] 담당자4 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			} 
		}
		if ( user_cd_5 != "" ) {
			if ( sms_5 == false && mail_5 == false) {
				alert("[부가정보] 담당자5 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			} 
		}
		if ( user_cd_6 != "" ) {
			if ( sms_6 == false && mail_6 == false) {
				alert("[부가정보] 담당자6 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			} 
		}
		if ( user_cd_7 != "" ) {
			if ( sms_7 == false && mail_7 == false) {
				alert("[부가정보] 담당자7 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			} 
		}
		if ( user_cd_8 != "" ) {
			if ( sms_8 == false && mail_8 == false) {
				alert("[부가정보] 담당자8 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			} 
		}
		if ( user_cd_9 != "" ) {
			if ( sms_9 == false && mail_9 == false) {
				alert("[부가정보] 담당자9 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			}
		}
		if ( user_cd_10 != "" ) {
			if ( sms_10 == false && mail_10 == false) {
				alert("[부가정보] 담당자10 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			}
		}
		if ( grp_cd_1 != "" ) {
			if ( grp_sms_1 == false && grp_mail_1 == false) {
				alert("[부가정보] 그룹1 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			}
		}

		if ( grp_cd_2 != "" ) {
			if ( grp_sms_2 == false && grp_mail_2 == false) {
				alert("[부가정보] 그룹2 항목에서 SMS, MAIL 중 한개는 필수 체크입니다.");
				document.getElementById('is_valid_flag').value = "false";
				return;
			}
		}
	}

	function checkSmartTableCnt() {
		
		var table_name = $("#table_name").val();

		var url = '/common.ez?c=cData&itemGb=checkSmartTableCnt&itemGubun=2&table_name='+table_name;
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					
					$(xmlDoc).find('doc').each(function(){
						
						var items 	= $(this).find('items');
						var rowsObj = new Array();
						
						var smart_cnt = "";
						
						if(items.attr('cnt')=='0'){
							
						}else{
							
							items.find('item').each(function(i) {
							
								total_cnt = $(this).find("TOTAL_CNT").text();
							});
						}
						
						$("#smart_cnt").val(total_cnt);
					});
					// try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();			
	}
	
	function fileDownProg(form ,frNm, action, target){
		try{viewProgBar(true);}catch(e){}
		
		var frm = form;
		frm.action = action;
		frm.target = target;
		
	  	$.fileDownload($("#"+frNm).prop('action'),{
      		httpMethod: "POST",
	   	 	data:jQuery("#"+frNm).serialize(),
	    	successCallback: function (url) {
	    		try{viewProgBar(false);}catch(e){}
	    	},
	    	failCallback: function(responesHtml, url){
	    		try{viewProgBar(false);}catch(e){}
	    	}
	    });
	}
	
	function showHint(obj, posObj) {
	    var elementId = $(obj).attr('id');
	
	    // X 버튼 생성 및 설정
	    var closeButton = document.createElement('img');
	    closeButton.src = '/images/sta2.png';
	    closeButton.id = elementId + '_btn_close_layer';
	    closeButton.style.cssText = 'width:16px; height:16px; vertical-align:middle; cursor:pointer; position:absolute; top:10px; right:10px;';
	
	    // 기존 버튼 제거 및 이벤트 제거
	    var existingBtn = document.getElementById(closeButton.id);
	    if (existingBtn) {
	        existingBtn.remove();
	    }
	
	    // 새로운 X 버튼 추가
	    obj.appendChild(closeButton);
	
	    // 이벤트 핸들러 설정
	    $('#' + closeButton.id).off('click').on('click', function(event) {
	        event.stopPropagation(); // 이벤트 버블링 중지
	        obj.style.display = 'none';
	    });
	
	    if (obj.style.display === 'block') {
	        obj.style.display = "none";
	    } else {
	        setPosition(obj, posObj);
	        obj.style.display = "block";
	    }
	
	    // 드래그 기능 추가
	    $(obj).off('mousedown').on('mousedown', function(event) {
	        event.stopPropagation(); // 드래그 이벤트 시작 시 클릭 이벤트 버블링 방지
	        handleDrag(obj, event);
	    });
	}
	
	function setPosition(obj, posObj) {
	    var posTop = posObj.getBoundingClientRect().top + window.scrollY - 100;
	    var posLeft = posObj.getBoundingClientRect().left + window.scrollX + 40;
	
	    var viewportHeight = window.innerHeight;
	    var viewportWidth = window.innerWidth;
	
	    posTop = Math.max(window.scrollY, posTop);
	    posTop = Math.min(window.scrollY + viewportHeight - obj.offsetHeight, posTop);
	
	    posLeft = Math.max(window.scrollX, posLeft);
	    posLeft = Math.min(window.scrollX + viewportWidth - obj.offsetWidth, posLeft);
	
	    obj.style.position = 'absolute';
	    obj.style.top = posTop + 'px';
	    obj.style.left = posLeft + 'px';
	}
	
	function handleDrag(obj, initialEvent) {
	    var shiftX = initialEvent.clientX - obj.getBoundingClientRect().left;
	    var shiftY = initialEvent.clientY - obj.getBoundingClientRect().top;
	
	    function moveAt(moveEvent) {
	        var newTop = moveEvent.pageY - shiftY;
	        var newLeft = moveEvent.pageX - shiftX;
	
	        var viewportHeight = window.innerHeight;
	        var viewportWidth = window.innerWidth;
	
	        newTop = Math.max(window.scrollY, newTop);
	        newTop = Math.min(window.scrollY + viewportHeight - obj.offsetHeight, newTop);
	
	        newLeft = Math.max(window.scrollX, newLeft);
	        newLeft = Math.min(window.scrollX + viewportWidth - obj.offsetWidth, newLeft);
	
	        obj.style.top = newTop + 'px';
	        obj.style.left = newLeft + 'px';
	    }
	
	    function onMouseMove(moveEvent) {
	        moveAt(moveEvent);
	    }
	
	    $(document).on('mousemove', onMouseMove);
	
	    $(document).on('mouseup', function() {
	        $(document).off('mousemove', onMouseMove);
	        $(document).off('mouseup');
	    });
	
	    obj.ondragstart = function() {
	        return false;
	    };
	}
	
	function goGroupMailSearch() {
		
		var sHtml2="<div id='dl_group_mail' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml2+="<form id='group_mail_form' name='group_mail_form' method='post' onsubmit='return false;'>";
		sHtml2+="<table style='width:100%;height:400px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml2+="<select name='ser_gubun' id='ser_gubun' style='height:21px;'>";
		sHtml2+="<option value='dlNm'>그룹메일 이름</option>";
		sHtml2+="<option value='mail'>그룹메일 주소</option>";
		sHtml2+="</select>";
		sHtml2+="&nbsp;";
		sHtml2+="<input type='text' name='ser_mail_group' id='ser_mail_group' />&nbsp;&nbsp;<span id='btn_group_mail_search'>검색</span>";
		sHtml2+="<table style='width:100%;height:100%;border:none;'>";
		sHtml2+="<tr><td id='ly_g_group_mail' style='vertical-align:top;' >";
		sHtml2+="<div id='g_group_mail' class='ui-widget-header ui-corner-all'></div>";
		sHtml2+="</td></tr>";
		sHtml2+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml2+="<div align='right' class='btn_area_s'>";
		sHtml2+="<div id='ly_group_mail_total_cnt' style='padding-top:5px;float:left;'></div>";
		sHtml2+="</div>";
		sHtml2+="</h5></td></tr></table>";
		
		sHtml2+="</td></tr></table>";
		
		sHtml2+="</form>";
		
		$('#dl_group_mail').remove();
		$('body').append(sHtml2);
		
		dlPop01('dl_group_mail', "그룹 메일 목록", 660, 400, false);
		
		var gridObj_group_mail = {
			id : "g_group_mail"
			,colModel:[
				
				{formatter:gridCellNoneFormatter,field:'dlcd',id:'dlcd',name:'그룹메일 아이디',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'dlnm',id:'dlnm',name:'그룹메일 이름',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'email',id:'email',name:'그룹메일 주소',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   	]
			,rows:[]
		};
		
		viewGrid_1(gridObj_group_mail,'ly_'+gridObj_group_mail.id);
		
		$("#ser_mail_group").focus();
		
		$('#ser_mail_group').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#ser_mail_group').val())!=''){				
				var ser_gubun = $("select[name='ser_gubun'] option:selected").val();	
				
				if ($(this).val() == "") {
					alert("검색어를 입력해 주세요.");
					return;
				}
				
				if ($(this).val() < 2) {
					alert("검색어는 2자 이상 입력해 주세요.");
					return;
				}
				
				getGroupMailList(ser_gubun,$(this).val());
			}
		});
		
		
		$("#btn_group_mail_search").button().unbind("click").click(function(){
			var ser_gubun = $("select[name='ser_gubun'] option:selected").val();
			var ser_mail_group = $("#ser_mail_group").val();
			
			if (ser_mail_group == "") {
				alert("검색어를 입력해 주세요.");
				return;
			}
			
			if (ser_mail_group.length < 2) {
				alert("검색어는 2자 이상 입력해 주세요.");
				return;
			}
			
			getGroupMailList(ser_gubun, ser_mail_group);
		});		
	}
	
	function getGroupMailList(gubun, text) {
		
		try{viewProgBar(true);}catch(e){}
		
		$('#ly_group_mail_total_cnt').html('');
		
		var url = '/common.ez?c=cData&itemGb=groupMailList&p_search_gubun='+gubun+'&p_search_text='+encodeURIComponent(text);
		
		var xhr = new XHRHandler( url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								var dlnm 	= $(this).find("DLNM").text();
								var email	= $(this).find("EMAIL").text();
								var dlcd 	= $(this).find("DLCD").text();
								
								rowsObj.push({'grid_idx':i+1
									,'dlnm':dlnm
									,'email':email
									,'dlcd':dlcd
									,'CHOICE':"<div><a href=\"javascript:document.getElementById('error_description').value='" + dlcd + "(" + email + ")';dlClose('dl_group_mail');\" ><font color='red'>[선택]</font></a></div>"
									,'user_cd':user_cd
								});
								
							});
							
						}
						var obj = $("#g_group_mail").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_group_mail_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	//grp_nm_f: 초기값 있음(objId에 selected 상태 필요시 사용), grp_cd: 코드 기반 검색, grp_nm: 이름 기반 검색
	function getAppGrpCodeList(objId, depth, grp_nm_f, grp_cd, grp_nm){
		
		try{viewProgBar(true);}catch(e){}
		
		var url = '/common.ez?c=cData&itemGb=appGrpCodeList&itemGubun=2&p_app_eng_nm='+encodeURIComponent(grp_nm)+'&p_grp_depth='+depth+'&p_grp_cd='+grp_cd;
		if (typeof grp_nm == 'undefined') {
			url = '/common.ez?c=cData&itemGb=appGrpCodeList&itemGubun=2&p_app_eng_nm=&p_grp_depth='+depth+'&p_grp_cd='+grp_cd;
		}
		
		var xhr = new XHRHandler(url, null ,function(){
			var xmlDoc = this.req.responseXML;
			if(xmlDoc==null){
				try{viewProgBar(false);}catch(e){}
				alert('세션이 만료되었습니다 다시 로그인해 주세요');
				return false;
			}
			if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
				try{viewProgBar(false);}catch(e){}
				alert($(xmlDoc).find('msg_code').text());
				return false;
			}
			$(xmlDoc).find('doc').each(function(){
				
				var items = $(this).find('items');
				var rowsObj = new Array();
				
				if(items.attr('cnt')=='0'){
					$("#"+objId+" option").remove();
					$("#"+objId).append("<option value=''>--선택--</option>");
				}else{
					$("#"+objId+" option").remove();
					$("#"+objId).append("<option value=''>--선택--</option>");
					
					items.find('item').each(function(i){			
					
						var grp_cd = $(this).find("GRP_CD").text();
						var grp_nm = $(this).find("GRP_NM").text();
						var grp_desc = $(this).find("GRP_DESC").text();
						var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
						var grp_info = grp_cd + "," + grp_eng_nm;
																																																						
						$("select[name='"+objId+"']").append("<option value='"+grp_info+"'>"+grp_eng_nm+"</option>");
						
						if (grp_nm_f == grp_eng_nm) { //초기값(grp_nm_f)이 있으면 select
							$("#"+objId).val(grp_info).prop("selected", true);
						}
					});
				}
				
			});
			try{viewProgBar(false);}catch(e){}
		}
		, null );
		
		xhr.sendRequestSync();
	}
	
	//필수결재선 코드 GET
	function getAdminLineGrpCd(flag, doc_gb, smart_gb){

		var admin_line_grp_cd = '';
		var post_val = 'N';

		var url = '/common.ez?c=cData&itemGb=adminApprovalLineCd&doc_gb='+doc_gb+'&post_approval_yn='+post_val;
		
		var xhr = new XHRHandler( url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();

						if(items.attr('cnt')=='0'){
							alert("[관리자 문의] 필수 결재선을 확인해 주세요.");
							dlClose('titleInput');
							return;
						}else{
							items.find('item').each(function(i){
								admin_line_grp_cd = $(this).find("ADMIN_LINE_GRP_CD").text();
							});

							setDynamicApproval(flag, admin_line_grp_cd, doc_gb, smart_gb);
						}
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequestSync();
		
	}
	
	function setDynamicApproval(flag, admin_line_grp_cd, doc_gb, smart_gb){

		var temp_flag = '';

		var odate 	= $("#odate").val();

		var sHtml2="<div id='dl_tmp3' class='popDynamicApproval' style='overflow:hidden;display:none;padding:0;'>";

			sHtml2+="<form id='form3' name='form3' method='post' onsubmit='return false;'>";
			sHtml2+="<input type='hidden' name='grp_cd' 	id='grp_cd'/>";
			sHtml2+="<input type='hidden' name='flag' 		id='flag'/>";

			sHtml2+="<table style='width:100%;height:360px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
			sHtml2+="<table style='width:100%;height:100%;border:none;'>";
			sHtml2+="<tr><td id='ly_g_tmp3' style='vertical-align:top;' >";
			sHtml2+="<div id='g_tmp3' class='ui-widget-header ui-corner-all'></div>";
			sHtml2+="</td></tr>";

			sHtml2+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
			sHtml2+="<div align='left' class='btn_area_s' style='padding-top:5px;background-color: rgb(214 222 234 / 40%);'>";
			sHtml2+="순차<input type='radio' id='chk_post_approval_yn' name='chk_post_approval_yn' value='N' checked='checked'/>";
			sHtml2+="후결<input type='radio' id='chk_post_approval_yn' name='chk_post_approval_yn' value='Y'/>";
			//요청서마다 필요한 파라미터가 달라 분기처리
			if(doc_gb == "05") {
				sHtml2+="&nbsp;&nbsp; 의뢰 사유 : ";
				sHtml2+="<input type='text' style='width:36%;height:21px;margin-right:10px' name='title_input' id='title_input'/>";
				sHtml2 += "<strong><span>HOLD : </span></strong>";
				sHtml2 += "<input type='checkbox' id='hold_05_check' name='hold_05_check' checked />&nbsp;&nbsp;";
				sHtml2 += "<strong><span>WAIT : </span></strong>";
				sHtml2 += "<input type='checkbox' id='wait_05_check' name='wait_05_check' />&nbsp;&nbsp;";
				sHtml2 += "&nbsp;<strong><span>반영예정일 : </span></strong>";
				sHtml2 += "<input type='text' name='c_odate3' id='c_odate3' value='" + odate + "' class='input datepick' style='width:65px; height:21px;' maxlength='8' />";
			}else if(doc_gb == "10"){
				sHtml2+="&nbsp;&nbsp; 오류 조치 : ";
				sHtml2+="<input type='text' style='width:60%;height:21px;margin-right:10px' name='title_input' id='title_input'/>";
			}else{
				sHtml2+="&nbsp;&nbsp; 의뢰 사유 : ";
				sHtml2+="<input type='text' style='width:60%;height:21px;margin-right:10px' name='title_input' id='title_input'/>";
			}
			
			sHtml2+="&nbsp;<span id='btn_dynamic_approval' style='float:right'>승인요청</span>";
	// 		sHtml2+="<span id='btn_close'>닫기</span></div>";
			sHtml2+="</div>";
			sHtml2+="</h5></td></tr>";
			sHtml2+="</table>";
			sHtml2+="</td></tr></table>";
			sHtml2+="</form></div>";
			
			$('#dl_tmp3').remove();
			$('body').append(sHtml2);
			
			if(doc_gb == "05") {
				dlPop01('dl_tmp3',"결재권 설정",850,370,false);
			}else{
				dlPop01('dl_tmp3',"결재권 설정",750,370,false);
			}			
			
			var gridObj3 = {
				id : "g_tmp3"
				,colModel:[		
					 {formatter:gridCellNoneFormatter,field:'approval_seq',id:'approval_seq',name:'결재순서',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
					,{formatter:gridCellNoneFormatter,field:'approval_user',id:'approval_user',name:'결재자',width:220,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'approval_grp',id:'approval_grp',name:'결재그룹',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'approval_type',id:'approval_type',name:'결재유형',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'approval_yn',id:'approval_yn',name:'결재',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'notice_yn',id:'notice_yn',name:'통보',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					
					,{formatter:gridCellNoneFormatter,field:'approval_user_cd',id:'approval_user_cd',name:'approval_user_cd',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
					,{formatter:gridCellNoneFormatter,field:'approval_user_id',id:'approval_user_id',name:'approval_user_id',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
					,{formatter:gridCellNoneFormatter,field:'group_line_grp_cd',id:'group_line_grp_cd',name:'group_line_grp_cd',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
					,{formatter:gridCellNoneFormatter,field:'group_member_cnt',id:'group_member_cnt',name:'group_member_cnt',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
					,{formatter:gridCellNoneFormatter,field:'group_nm',id:'group_nm',name:'group_nm',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			   	]
				,rows:[]
			};
			
			viewGrid_1(gridObj3,'ly_'+gridObj3.id);
			var grid = $('#' + gridObj3.id).data('grid'); 
			
			$("#title_input").focus();
			$("#btn_close_1").button().unbind("click").click(function(){
				dlClose('dl_tmp3');
			});

			//결재권 설정 -> 승인버튼
			$("#btn_dynamic_approval").button().unbind("click").click(function(){

				var title = $("#title_input").val();
				if (title.length < 1) {  
					alert("요청 사유를 입력하세요.");
					$("#title_input").focus();
					return;
				}

				$("#title").val(title);
				
				var isGRP_yn 				= "";
				var grp_approval_userList 	= "";
				var grp_alarm_userList 		= "";
				var noti_grp_line_cd_arr 	= ""; 
				var appr_grp_line_cd_arr 	= "";
				var group_line_grp_cd 		= "";
				
				var len = $("#g_tmp3").data('dataView').getLength();
				
				// 결재자 숫자만큼 반복
				for(var i=0;i<len;i++){
					
					var approval_yn 		= $("#approval_yn"+i).prop("checked");
					var approval_grp		= getCellValue(gridObj3,i,'approval_grp');
					var approval_user_cd	= getCellValue(gridObj3,i,'approval_user_cd');
					var group_line_grp_cd	= getCellValue(gridObj3,i,'group_line_grp_cd');
					var group_nm			= getCellValue(gridObj3,i,'group_nm');
					
					// 그룹결재선에 결재자가 비어있는지 확인
					if( approval_grp != '' && approval_user_cd == '') {
						alert("["+group_nm+"]그룹결재선을 확인해주세요");
						return;
					}

					// 결재 체크
					// 그룹결재이면서 체크되어 있음.
					if ( approval_yn && approval_grp != '') {
						if(i==0) grp_approval_userList += ",";
	 					grp_approval_userList += group_line_grp_cd + "-" + approval_user_cd + ",";
	 					
	 					if(appr_grp_line_cd_arr.length>0) appr_grp_line_cd_arr += ",";
						appr_grp_line_cd_arr += getCellValue(gridObj3,i,'group_line_grp_cd');
					}
					
					var notice_yn 			= $("#notice_yn"+i).prop("checked");
					var approval_grp		= getCellValue(gridObj3,i,'approval_grp');
					var approval_user_cd	= getCellValue(gridObj3,i,'approval_user_cd');
					var group_line_grp_cd	= getCellValue(gridObj3,i,'group_line_grp_cd');
					
					// 통보 체크
					// 그룹결재이면서 체크되어 있음.
					if ( notice_yn && approval_grp != '') {
						if(i==0) grp_alarm_userList += ",";
						grp_alarm_userList += group_line_grp_cd + "-" + approval_user_cd + ",";
						
						if(noti_grp_line_cd_arr.length>0) noti_grp_line_cd_arr += ",";
						noti_grp_line_cd_arr += getCellValue(gridObj3,i,'group_line_grp_cd');
					}
					
					var group_line_grp_nm	= getCellValue(gridObj3,i,'group_line_grp_nm');
					
					if ( group_line_grp_nm ) isGRP_yn = 'Y';
					
					group_line_grp_cd = getCellValue(gridObj3,i,'group_line_grp_cd');
				}
				
				if ( grp_approval_userList != "" ) grp_approval_userList = grp_approval_userList.substring(0, grp_approval_userList.length-1);
				if ( grp_alarm_userList != "" ) grp_alarm_userList = grp_alarm_userList.substring(0, grp_alarm_userList.length-1);
				
				// 결재자 숫자만큼 반복
				for(var j=0;j<len;j++){
					if(appr_grp_line_cd_arr.indexOf(getCellValue(gridObj3,j,'group_line_grp_cd')) == -1 || noti_grp_line_cd_arr.indexOf(getCellValue(gridObj3,j,'group_line_grp_cd')) == -1){
						alert('결재 그룹 구성원의 결재/통보는 최소 1명 이상 이어야 합니다.');
						return;
					}
				}

				var post_val = $("input[name='chk_post_approval_yn']:checked").val();

				if(post_val == 'N'){
					flag = 'draft';
				}else{
					flag = 'post_draft';
				}

				var title = $("#title_input").val();



				if (title.length < 1) {
					alert("요청 사유를 입력하세요.");
					return;
				}

				var c_odate3 = $("#c_odate3").val();
				var hold_yn = "";
				var wait_yn = "";

				if(doc_gb == "05"){
					if ( $('input[name="hold_05_check"]').is(":checked") ) {
						hold_yn = "Y";
					}else{
						hold_yn = "N";
					}
					
					if ( $('input[name="wait_05_check"]').is(":checked") ) {
						wait_yn = "Y";
					}else{
						wait_yn = "N";
					}
					
					if (c_odate3.length < 1) {
						alert("ODATE 값을 입력하세요.");
						return;
					}else{
						$("#order_date").val(c_odate3);
						$("#p_apply_date").val(c_odate3);
						$('input[name="hold_yn"]').val(hold_yn);
						$("#wait_yn").val(wait_yn);
					}

					if(!isValidDate(c_odate3)){
						alert("잘못된 날짜입니다.");
						return;
					}
				}
				
				// 스마트폴더 작업 오더 시 트리구조의 팝업창을 띄어준다.
				if(smart_gb == 'smart') {
					popSmartTreeView(flag, grp_approval_userList, grp_alarm_userList, title);
				}else{
					goPrc(flag, grp_approval_userList, grp_alarm_userList, title);
				}

			});
			
			$("input[name='chk_post_approval_yn']").change(function(){
				var post_val = $("input[name='chk_post_approval_yn']:checked").val();
				admin_line_grp_cd = getAdminLineGrpCd_2(doc_gb, post_val);

				if(post_val == 'N'){
					flag = 'draft';
				}else{
					flag = 'post_draft';
				}

				getApprovalLineList(flag, admin_line_grp_cd);
			});

			$("#c_odate3").addClass("ime_readonly").unbind('click').click(function(){

				var server_gb = "<%=strServerGb%>";
				var s_user_gb = "<%=S_USER_GB%>";
				dpCalMax(this.id,'yymmdd');
			});

			getApprovalLineList(flag, admin_line_grp_cd); 
	}
	
	function getApprovalLineList(flag, admin_line_grp_cd){

		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt4').html('');
		
		var url = '/common.ez?c=cData&itemGb=finalApprovalLineList&flag='+flag+'&admin_line_grp_cd='+admin_line_grp_cd;
		
		var xhr = new XHRHandler( url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						dlClose('dl_tmp3');
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
							alert('	[관리자 문의] 필수 결재선을 확인해 주세요.');
							dlClose('dl_tmp3');
							return;
						}else{
							items.find('item').each(function(i){
								var approval_seq = $(this).find("APPROVAL_SEQ").text();
								var group_line_user_cd = $(this).find("GROUP_LINE_USER_CD").text();
								var group_line_user_id = $(this).find("GROUP_LINE_USER_ID").text();
								var group_line_user_nm = $(this).find("GROUP_LINE_USER_NM").text();
								var group_line_duty_nm = $(this).find("GROUP_LINE_DUTY_NM").text();
								var group_line_dept_nm = $(this).find("GROUP_LINE_DEPT_NM").text();
								var group_line_grp_nm = $(this).find("GROUP_LINE_GRP_NM").text();
								var approval_type = $(this).find("APPROVAL_TYPE").text();
								var group_line_grp_cd = $(this).find("GROUP_LINE_GRP_CD").text();
								var group_member_cnt = $(this).find("GROUP_MEMBER_CNT").text();
								var approval_nm = $(this).find("APPROVAL_NM").text();
								var group_nm = $(this).find("GROUP_NM").text();
								
								var approval_yn = '';
								if(group_line_grp_nm){
									approval_yn = "<div class='gridInput_area'><input type='checkbox' id='approval_yn"+i+"' name='approval_yn"+i+"' checked disabled/></div>";
								}else{
									approval_yn = "<div class='gridInput_area'><input type='checkbox' id='approval_yn"+i+"' name='approval_yn"+i+"' checked disabled/></div>";
								}
								
								var notice_yn = '';
								if(group_line_grp_nm){
									notice_yn = "<div class='gridInput_area'><input type='checkbox' id='notice_yn"+i+"' name='notice_yn"+i+"' checked/></div>";
								}else{
									notice_yn = "<div class='gridInput_area'><input type='checkbox' id='notice_yn"+i+"' name='notice_yn"+i+"' checked disabled/></div>";
								}
								
								if(group_line_grp_nm && group_member_cnt == 1){
									notice_yn = "<div class='gridInput_area'><input type='checkbox' id='notice_yn"+i+"' name='notice_yn"+i+"' checked/></div>";
								}
								
								var approval_user_nm = '';
								if(!group_line_grp_cd && !approval_nm){
									approval_user_nm = '개인결재'
								} else if (!group_line_grp_cd){
									approval_user_nm = approval_nm;
								}
								
								rowsObj.push({
									 'grid_idx':i+1
									,'approval_seq':approval_seq
									,'approval_user': approval_user_nm
									,'approval_user_cd':group_line_user_cd 
									,'approval_user_id':group_line_user_id
									,'group_line_grp_cd':group_line_grp_cd
									,'approval_grp':group_line_grp_nm
									,'approval_type':approval_type
									,'approval_yn':approval_yn     
									,'notice_yn':notice_yn
									,'group_nm': group_nm
								}); 
							});
							
						}
						var obj = $("#g_tmp3").data('gridObj');
						var grid = $("#g_tmp3").data('grid');
						grid.setColumns(obj.colModel);
						obj.rows = rowsObj;
						setGridRows(obj);

						$('#ly_total_cnt4').html('[ TOTAL : '+items.attr('cnt')+' ]');
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	function chkForceOdate(obj, idx){
		var chkYn = $(obj).is(':checked');
		if(chkYn){
			$('#m_step_force-job_date'+idx).val('ODAT');
		}else{
			$('#m_step_force-job_date'+idx).val('');
		}
		
	}
	
	function isValidDate(dateString) {
	  // 8자리 숫자가 아니면 유효한 날짜가 아님
	  if (!/^\d{8}$/.test(dateString)) return false;
	
	  // yyyy, mm, dd 정보 추출
	  var year = parseInt(dateString.substring(0, 4));
	  var month = parseInt(dateString.substring(4, 6));
	  var day = parseInt(dateString.substring(6, 8));
	
	  // Date 객체 생성
	  var date = new Date(year, month - 1, day);
	
	  // 유효한 날짜인지 체크
	  return (
	    date.getFullYear() === year &&
	    date.getMonth() === month - 1 &&
	    date.getDate() === day
	  );
	}

	function fn_group_add(arg){
		var group_name = $("input[name='group_names']").val();

		$('#group_name').val(group_name);
	}

	function jobHistoryInfo(job_name, data_center) {
		
		var frm = document.userFrm;

		openPopupCenter1("about:blank", "popupJobHistoryInfo", 1000, 700);
		
		frm.target = "popupJobHistoryInfo";
		frm.action = "/tPopup.ez?c=ez048&job_name="+job_name+"&data_center="+data_center;
		frm.submit();
	}

	function resizeTabsSize(){
		if (window.parent) {
			var tabs = window.parent.document.getElementById('tabs');
			if (tabs) {
				var height = tabs.clientHeight-40;

				var tab_h = document.getElementById('tab_h');
				tab_h.style.height = height+'px';

				return height;
			}
		}
	}
	
	function getSubTableList(objId, table_id, eng_nm){
		try{viewProgBar(true);}catch(e){}
		
		var url = '/common.ez?c=cData&itemGb=subTableList&itemGubun=2&table_id='+table_id;
		
		var xhr = new XHRHandler(url, null ,function(){
			var xmlDoc = this.req.responseXML;
			if(xmlDoc==null){
				try{viewProgBar(false);}catch(e){}
				alert('세션이 만료되었습니다 다시 로그인해 주세요');
				return false;
			}
			if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
				try{viewProgBar(false);}catch(e){}
				alert($(xmlDoc).find('msg_code').text());
				return false;
			}
			$(xmlDoc).find('doc').each(function(){
				
				var items = $(this).find('items');
				var rowsObj = new Array();
				
				if(items.attr('cnt')=='0'){
					$("#"+objId+" option").remove();
					$("#"+objId).append("<option value=''>--선택--</option>");
				}else{
					$("#"+objId+" option").remove();
					$("#"+objId).append("<option value='search_all'>--선택--</option>");
					
					items.find('item').each(function(i){			
					
						var sub_table_nm   = $(this).find("SUB_TABLE_NM").text();
																																																						
						$("select[name='"+objId+"']").append("<option value='"+sub_table_nm+"'>"+sub_table_nm+"</option>");
						
					});
				}
				
			});
			try{viewProgBar(false);}catch(e){}
		}
		, null );
		
		xhr.sendRequestSync();
	}

	function popAdminTitleInput(flag, doc_gb, smart_gb){

		var odate 	= $("#odate").val();

		var sHtml1="<div id='popAdminTitleInput' class='popAdminTitleInput' style='overflow:hidden;display:none;padding:0;'>";
		 sHtml1+="<table style='width:100%;height:100%;border:none;'>";

		if(doc_gb == "10"){
			sHtml1+="<tr>";
			sHtml1+="<td style='width:80px;border:0px;'>";
			sHtml1+="<strong><span style='margin-left:20px;align-content: center;'>오류조치</span></strong>";
			sHtml1+="</td>";
			sHtml1+="<td style='text-align:left;border:0px;'>";
			sHtml1+="<input type='text' style='width:95%;height:21px' name='title_input2' id='title_input2' value = ''/>";
			sHtml1+="</td>";
			sHtml1+="</tr>";
		}

		if(doc_gb == "05"){
//			sHtml1+="<tr>";
//			sHtml1+="<td style='vertical-center; width:60%;border:0px;'>";
//			sHtml1+="<strong><span style='margin-left:30%;'>HOLD</span></strong>";
//			sHtml1+="<input style='position:absolute; zoom:1.2; margin: 0 0 0 3px;' type='checkbox' id='hold_check' name='hold_check' checked />";
//			sHtml1+="<strong><span style='margin-left:30%;'>WAIT</span></strong>";
//			sHtml1+="<input style='position:absolute; zoom:1.2; margin: 0 0 0 3px;' type='checkbox' id='wait_check' name='wait_check' />";
//			sHtml1+="</td>";
//			sHtml1+="<td style='vertical-center;width:40%;border:0px;'>";
//			sHtml1+="<strong><span>ODATE일괄변경 </span></strong>";
//			sHtml1+="<input type='text' name='c_odate2' id='c_odate2' value='"+odate+"' class='input datepick' style='width:75px; height:21px;' maxlength='8' />  ";
//			sHtml1+="</td>";
//			sHtml1+="</tr>";
//			sHtml1+="<tr>";
			
			sHtml1+="<tr>";
			sHtml1+="<td style='vertical-right;border:0px;width:50%;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			sHtml1+="<strong><span>HOLD</span></strong>";
			sHtml1+="<input type='checkbox' id='hold_05_admin_check' name='hold_05_admin_check' checked />&nbsp;&nbsp;";
			sHtml1+="<strong><span>WAIT</span></strong>";
			sHtml1+="<input type='checkbox' id='wait_05_admin_check' name='wait_05_admin_check' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			sHtml1+="<strong><span>반영 예정일 </span></strong>";
			sHtml1+="<input type='text' name='c_odate2' id='c_odate2' value='"+odate+"' class='input datepick' style='width:75px; height:21px;' maxlength='8' />  ";
			sHtml1+="</td>";
			sHtml1+="</tr>";
			sHtml1+="<tr>";
			
		}
		sHtml1+="<tr>";
		sHtml1+="<td style='vertical-center;border:0px;' colspan=2>";
		//sHtml1+="<div style='font-weight:bold;color:red;padding: 0 10px 0 10px;'>※ 수행요청 사유를 입력해야 수행 작업이 가능합니다.  ";
		if(flag == "draft_admin"){
			sHtml1+="<span id='btn_draft_admins' style='float:right;margin-right:10px;'>즉시결재</span></div>";
		}else{
			sHtml1+="<span id='btn_draft_admins' style='float:right;margin-right:10px;'>오류처리</span></div>";
		}
		sHtml1+="</td>";
		sHtml1+="</tr>";
		sHtml1+="</table>";
		sHtml1+="</div>";

		$('#popAdminTitleInput').remove();
		$('body').append(sHtml1);

// 		dlPopModal02('titleInput',"요청 사유",360,100,false);
		dlPop01('popAdminTitleInput',"요청 사유",390,100,false);

		$("#title_input2").focus();

		$("#btn_close").button().unbind("click").click(function(){
			dlClose('dl_tmp3');
		});

		$("#c_odate2").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMax(this.id,'yymmdd');
		});

		$("#btn_draft_admins").button().unbind("click").click(function(){
			var c_odate2 = $("#c_odate2").val();
			var title = "";

			if(doc_gb == "05"){
				var hold_yn = "";
				if ( $('input[name="hold_05_admin_check"]').is(":checked") ) {
					hold_yn = "Y";
				}else{
					hold_yn = "N";
				}
				
				var wait_yn = "";
				if ( $('input[name="wait_05_admin_check"]').is(":checked") ) {
					wait_yn = "Y";
				}else{
					wait_yn = "N";
				}
				
				if (c_odate2.length < 1) {
					alert("ODATE 값을 입력하세요.");
					return;
				}else{
					$("#order_date").val(c_odate2);
					$("#p_apply_date").val(c_odate2);
					$('input[name="hold_yn"]').val(hold_yn);
					$("#wait_yn").val(wait_yn);
				}
			}else if(doc_gb == "10"){
				title = $("#title_input2").val();
			}
			
			if(smart_gb == "smart") {
				popSmartTreeView(flag, '','', title);
			}else {
				goPrc(flag, '','', title);
			}

		});
	}

	//필수결재선 코드 GET_2
	function getAdminLineGrpCd_2(doc_gb, post_val){
	
		var admin_line_grp_cd = '';
	
		var url = '/common.ez?c=cData&itemGb=adminApprovalLineCd&doc_gb='+doc_gb+'&post_approval_yn='+post_val;
	
		var xhr = new XHRHandler( url, null
			,function(){
				var xmlDoc = this.req.responseXML;
				if(xmlDoc==null){
					try{viewProgBar(false);}catch(e){}
					alert('세션이 만료되었습니다 다시 로그인해 주세요');
					return false;
				}
	
				if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
					try{viewProgBar(false);}catch(e){}
					alert($(xmlDoc).find('msg_code').text());
					//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
					return false;
				}
				$(xmlDoc).find('doc').each(function(){
	
					var items = $(this).find('items');
					var rowsObj = new Array();
	
					if(items.attr('cnt')=='0'){
						alert("[관리자 문의] 필수 결재선을 확인해 주세요.");
						dlClose('titleInput');
						return;
					}else{
						items.find('item').each(function(i){
							admin_line_grp_cd = $(this).find("ADMIN_LINE_GRP_CD").text();
						});
					}
				});
				try{viewProgBar(false);}catch(e){}
			}
			, null );
	
		xhr.sendRequestSync();
	
		return admin_line_grp_cd;
	}
	
	function applyOverlay() {
	
		// 오버레이 추가
		var overlay = $('<div class="overlay"></div>');
		overlay.appendTo('#td_body');
	
		// 요소를 id로 찾기
		var element = document.getElementById('ly_body');
	
		// pointer-events 스타일 추가하기
		if (element) {
			element.style.pointerEvents = 'none';
		}
	}
	
	function removeOverlay() {
	
		// 오버레이 효과 제거
		$('#td_body .overlay').remove();
	
		// 요소를 id로 찾기
		var element = document.getElementById('ly_body');
	
		// pointer-events 스타일 추가하기
		if (element) {
			element.style.pointerEvents = '';
		}
	}


	// 스마트폴더 트리구조 UI 생성
	function renderTree(job_name, order_id, rba, grp_rba, check_box_yn){
		var container = "";
		
		// 스마트폴더 작업에는 gba(자기 자신)와 grp_gba(부모 gba)라는 속성이 존재
		// grp_gba 값을 통해 해당 작업의 부모폴더(스마트폴더, 서브폴더)를 알 수 있습니다. 
		
		// 스마트폴더의 grp_gba 값은 000000 고정
		if(document.getElementById("000000_ul") == null) {
			container = document.getElementById("smart_tree_grid");
			var ul = document.createElement('ul');
			ul.id = "000000_ul";
			ul.className = "tree_ul";
			ul.appendChild(createTreeList("New", "New", "New", "check"));

			container.appendChild(ul);
		}
		
		for(var i = 0; i < job_name.length; i++){
			var parent_ul = grp_rba[i] + "_ul";
			
			if( document.getElementById(parent_ul) == null ){ // 작업의 부모폴더 ul요소가 존재하지 않음
				container = document.getElementById(grp_rba[i]);
				// 작업의 부모폴더 ul요소 생성
				var ul = document.createElement('ul');
				ul.id = parent_ul;
				ul.className = "tree_ul";
				ul.appendChild(createTreeList(order_id[i], rba[i], job_name[i], check_box_yn[i]));
				
				container.appendChild(ul);
			}else if( document.getElementById(parent_ul) != null ){ // 작업의 부모폴더 ul요소가 존재
				container = document.getElementById(parent_ul);
				container.appendChild(createTreeList(order_id[i], rba[i], job_name[i], check_box_yn[i]));
			}
		}
	}
	
	
	function createTreeList(order_id, rba, text_content, check_yn) {
		// 부모폴더 ul 요소안에 li 생성
		var li = document.createElement('li');
		li.id = rba;
		li.textContent = text_content;
		li.className = "tree_li";
		
		if(check_yn == "check") {
			var checkbox = document.createElement("input");
			checkbox.type = "checkbox";
			checkbox.value = order_id;
			li.appendChild(checkbox);
		}
		
		return li;
	}
